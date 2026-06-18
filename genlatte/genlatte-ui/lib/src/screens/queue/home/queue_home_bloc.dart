// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:data_layer/data_layer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genlatte/src/data/data.dart';
import 'package:genlatte/src/data/shared_preferences_repository.dart';
import 'package:genlatte/src/screens/queue/home/queue_settings.dart';
import 'package:genlatte/src/screens/queue/util/metadata_describe.dart';
import 'package:genlatte_data/models.dart';
import 'package:hashlib/hashlib.dart';
import 'package:logging/logging.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

part 'queue_home_bloc.freezed.dart';

final _logger = Logger('QueueHomeBloc');

typedef _Emit = Emitter<QueueHomeState>;

/// A page of orders.
final class OrderPage {
  /// Creates a new [OrderPage].
  const OrderPage(this.orders);

  /// The orders to show on this page.
  final List<Latte?> orders;
}

/// {@template QueueHomeBloc}
/// {@endtemplate}
class QueueHomeBloc extends Bloc<QueueHomeEvent, QueueHomeState> {
  /// {@macro QueueHomeBloc}
  QueueHomeBloc({
    required this.metadataRepository,
    required this.ordersRepository,
    required this.sharedPrefsRepository,
    @visibleForTesting QueueSettingsState? initialSettings,
  }) : super(
         QueueHomeState(
           settings:
               initialSettings ??
               QueueSettingsState.load(sharedPrefsRepository),
         ),
       ) {
    on<QueueHomeEvent>(
      (event, _Emit emit) => switch (event) {
        OrdersUpdated() => _updateOrdersFromRepository(event, emit),
        SetPageUpdatePeriod() => _saveNewPageUpdatePeriod(event, emit),
        SetRecency() => _saveNewRecencySetting(event, emit),
        SetShard() => _saveNewShardSetting(event, emit),
        SetTargetRowHeight() => _emitNewTargetRowHeight(event, emit),
        SetTopSettings() => _saveNewTopSetting(event, emit),
        SlotsCounted() => _saveNewSlotsCount(event, emit),
        RefreshPages() => _emitUpdatedPages(event, emit),
      },
    );

    _logger.info(
      'Creating a new $QueueHomeBloc '
      'with shard ${state.settings} and $metadataRepository',
    );

    _ordersStreamSub = metadataRepository
        .watchList(
          details: RequestDetails.read(
            // TODO(filiph): Maybe provide sharding information?
            filter: const LatteOrderMetadataBoardQueue(),
          ),
        )
        .listen(
          (metadata) => add(OrdersUpdated(metadata)),
          onError: (Object e) => _logger.severe('Error when listening: $e', e),
        );
  }

  /// Orders that were submitted way too long ago and never completed
  /// should not be shown.
  static const Duration _abandonedOrderAgeThreshold = Duration(days: 2);

  /// A set of orders (deduplicated on `id`, see [_createOrdersSet])
  /// that have been shown so far.
  ///
  /// This intentionally keeps orders that are no longer in the repository
  /// because we might still need their data to fade them away.
  HashSet<Latte> _allOrders = _createOrdersSet(const []);

  /// The provided orders repository.
  final LatteOrdersRepository ordersRepository;

  /// The provided metadata repository.
  final Repository<LatteOrderMetadata> metadataRepository;

  /// The provided shared preferences repository.
  final SharedPreferencesRepository sharedPrefsRepository;

  late final StreamSubscription<List<LatteOrderMetadata>> _ordersStreamSub;

  @override
  Future<void> close() async {
    _ordersStreamSub.cancel().ignore();
    return super.close();
  }

  int _compareOrders(Latte a, Latte b) {
    // First, sort by "status progress" (e.g., completed orders go before
    // in-progress ones).
    int roughPriority(Latte latte) => switch (latte.metadata.status) {
      LatteOrderStatus.configuring => 100,
      LatteOrderStatus.submitted => 10,
      LatteOrderStatus.validated => 1,
      LatteOrderStatus.inProgress => -1,
      LatteOrderStatus.completed => -10,
      LatteOrderStatus.archived => -100,
    };

    final aPriority = roughPriority(a);
    final bPriority = roughPriority(b);
    if (aPriority < bPriority) return -1;
    if (aPriority > bPriority) return 1;

    final aSubmitted = a.metadata.orderSubmittedTime ?? DateTime(1970);
    final bSubmitted = b.metadata.orderSubmittedTime ?? DateTime(1970);
    return aSubmitted.compareTo(bSubmitted);
  }

  void _emitNewTargetRowHeight(SetTargetRowHeight event, _Emit emit) {
    _logger.info('_emitNewTargetRowHeight: $event');
    if (event.height < 1) {
      _logger.warning('Invalid row height: ${event.height}');
      return;
    }

    final newSettings = state.settings.copyWith(
      targetRowHeight: event.height,
    );
    _persistSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
  }

  void _emitUpdatedPages(RefreshPages event, _Emit emit) {
    _logger.info('_emitUpdatedPages');

    final slotCount = state.uiSlotCapacity;
    if (slotCount == 0) {
      _logger.info('new pages requested but there is no slot capacity');
      return;
    }

    var noOrdersInAnyShard = true;
    final now = DateTime.now();
    final shardValidOrders = _allOrders.where((latte) {
      final submittedTime = latte.metadata.orderSubmittedTime;
      if (submittedTime != null &&
          now.difference(submittedTime) > _abandonedOrderAgeThreshold) {
        // Latte order is way too old.
        return false;
      }

      final completionTime = latte.metadata.completionTime;
      if (completionTime != null &&
          now.difference(completionTime) > state.settings.maxShowAge) {
        // Latte is stale.
        return false;
      }

      noOrdersInAnyShard = false;

      if (!_doesOrderBelongToShard(
        latte,
        shardNumber: state.settings.shardNumber,
        shardsTotal: state.settings.shardTotal,
      )) {
        // Latte order doesn't belong here.
        return false;
      }

      return true;
    }).toList()..sort(_compareOrders);

    final List<Latte> ordersToShow;
    if (state.settings.isTopScreen) {
      // Only the first N orders are on the top screen.
      ordersToShow = shardValidOrders
          .take(state.settings.topOrdersCount)
          .toList();
    } else {
      // Only the orders N+1 and beyond are on other screens.
      ordersToShow = shardValidOrders
          .skip(state.settings.topOrdersCount)
          .toList();
    }

    final pages = <OrderPage>[];
    for (var offset = 0; offset < ordersToShow.length; offset += slotCount) {
      pages.add(
        OrderPage(
          List.generate(
            slotCount,
            (index) => ordersToShow.optGet(offset + index),
          ),
        ),
      );
    }

    _logger.fine(
      () =>
          'RequestNewPages orders: '
          '${ordersToShow.map((o) => o.metadata.describe()).join(', ')}',
    );

    emit(
      state.copyWith(shownPages: pages, noOrdersInAnyShard: noOrdersInAnyShard),
    );
  }

  void _persistSettings(QueueSettingsState settings) {
    sharedPrefsRepository
        .setString(
          QueueSettingsState.sharedPrefsKey,
          jsonEncode(settings.toJson()),
        )
        .ignore();
  }

  FutureOr<void> _saveNewPageUpdatePeriod(
    SetPageUpdatePeriod event,
    _Emit emit,
  ) {
    _logger.info('_saveNewPageUpdatePeriod: $event');

    final newSettings = state.settings.copyWith(
      pageUpdatePeriod: event.pageUpdatePeriod,
    );
    _persistSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
    add(const RefreshPages());
  }

  FutureOr<void> _saveNewRecencySetting(SetRecency event, _Emit emit) {
    _logger.info('_saveNewRecencySetting: $event');

    final newSettings = state.settings.copyWith(
      maxRecentAge: event.maxRecentAge,
      maxShowAge: event.maxShowAge,
    );
    _persistSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
    add(const RefreshPages());
  }

  void _saveNewShardSetting(SetShard event, _Emit emit) {
    _logger.info(
      '_saveNewShardSetting: ${event.shardNumber} of ${event.shardTotal}',
    );
    if (event.shardTotal < 1) {
      _logger.warning('Invalid $event: shard total cannot be below 1');
      return;
    }
    if (event.shardNumber < 1) {
      _logger.warning('Invalid $event: shard number cannot be below 1');
      return;
    }
    if (event.shardNumber > event.shardTotal) {
      _logger.warning(
        'Invalid $event: shard number cannot be above shard total',
      );
      return;
    }

    final newSettings = state.settings.copyWith(
      shardNumber: event.shardNumber,
      shardTotal: event.shardTotal,
    );
    _persistSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
    add(const RefreshPages());
  }

  void _saveNewSlotsCount(SlotsCounted event, _Emit emit) {
    _logger.info('_saveNewSlotsCount: $event');
    if (event.slotCount == state.uiSlotCapacity) return;
    _logger.info('New slot count: ${event.slotCount}');
    emit(state.copyWith(uiSlotCapacity: event.slotCount));
    if (event.slotCount > 0) {
      add(const RefreshPages());
    }
  }

  void _saveNewTopSetting(SetTopSettings event, _Emit emit) {
    _logger.info(
      '_saveNewTopSetting: isTopScreen=${event.isTopScreen}, '
      'topOrdersCount=${event.topOrdersCount}',
    );
    if (event.topOrdersCount < 0) {
      _logger.warning('Invalid $event: top orders count cannot be negative');
      return;
    }

    final newSettings = state.settings.copyWith(
      isTopScreen: event.isTopScreen,
      topOrdersCount: event.topOrdersCount,
    );
    _persistSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
    add(const RefreshPages());
  }

  Future<void> _updateOrdersFromRepository(
    OrdersUpdated event,
    _Emit emit,
  ) async {
    _logger.fine(
      '_updateOrdersFromRepository: '
      '${event.metadatas.map((m) => m.describe())}',
    );

    List<Latte> lattes;
    try {
      lattes = await ordersRepository.toLattes(event.metadatas);
    } on DataException catch (e) {
      _logger.severe(e.message);
      return;
    }

    for (final latte in lattes) {
      assert(
        latte.metadata.status != .configuring,
        'Got an order that is still configuring: $latte',
      );
    }

    _allOrders = _createOrdersSet(
      // Note the order is important here. We want to keep the old orders around
      // but updated orders have precedence.
      lattes.followedBy(_allOrders),
    );

    add(const RefreshPages());
  }

  static HashSet<Latte> _createOrdersSet(Iterable<Latte> contents) => HashSet(
    equals: (a, b) => a.metadata.id! == b.metadata.id!,
    hashCode: (latte) => latte.metadata.id!.hashCode,
  )..addAll(contents);

  /// ## Sharding strategy
  ///
  /// The queue app can be running at more than one display at a time. We need a
  /// strategy to decide which order goes on which screen. Let's call this
  /// "sharding".
  ///
  /// Constraints:
  ///
  /// - Sharding must work even if there's only one screen. At that point, all
  ///   orders must show on that screen.
  /// - Sharding should work without the need for the running apps to
  ///   synchronize. One display does not need to know about the other.
  /// - Both displays should have a comparable number of orders to display. It
  ///   shouldn't be usual to see many orders on one screen and no orders on the
  ///   others, for example.
  /// - When situations arise during an event, it should be possible to adapt on
  ///   the spot. For example, if one display goes down, it shouldn't require
  ///   touching the database (change order metadata) to make the other
  ///   display(s) take over responsibilities. Similarly, if a display is added
  ///   on day 2 of event, no need to touch the database.
  ///
  /// Alternatives considered:
  ///
  /// - A continuous flow of orders from one display to the other. A single
  ///   list. This would require synchronization of the devices. It would be
  ///   common to have empty displays (except the first one). It would be gnarly
  ///   to figure out what happens when the alotted number of screens is not
  ///   enough to show all orders (how do we rotate something like this?).
  /// - Have one screen for "serving now", and the second for all orders.
  ///   Doesn't solve for more than two displays. Doesn't scale down as easily
  ///   to one display.
  /// - Server-driven sharding. Saves on traffic to clients but is much less
  ///   nimble, and requires more code.
  ///
  /// Solution:
  ///
  /// - For the sake of simplicity, let's assume there are two devices, Left
  ///   Display and Right Display.
  /// - This means that `shardsTotal == 2`. We assume different shard numbers to
  ///   the displays, so Left Display can be `shardNumber == 1` and Right
  ///   Display can be `shardNumber == 2`.
  /// - The Queue app has a "setup" overlay that lets us change the shards total
  ///   and the current display's shard number at runtime.
  /// - Let's assume we're on Right Display, shard number is 2 (of 2).
  /// - A new list of orders comes in from the Server.
  /// - For each order to be displayed:
  ///   - We take its `id` --> a String like `cskAU2zymqpk0qOCRQb9`)
  ///   - We get a hash of the string --> a number like `4846121616`
  ///   - We modulo the hash by the number of shards --> a remainder like `0`
  ///   - We compare the remainder with the shard number (minus 1) --> `0 != 1`
  ///   - If the remainder doesn't equal the shard number, the order is not for
  ///     this screen
  /// - The rest of the code just ignores the existence of the other orders. It
  ///   can decide to paginate the orders if it needs to, while the other screen
  ///   can decide not to paginate because it has fewer orders, and so on.
  ///
  /// There are some important details to consider:
  ///
  /// - The hashing function must have a reasonably uniform distribution. That's
  ///   why I switched from using `String.hashCode`, which sometimes had way too
  ///   many hits for one shard and way too few for the other. After switching
  ///   to `pkg:hashlib`, it's much better. Though it's still _possible_ to have
  ///   very uneven distribution between shards, it's much less likely.
  /// - The model for `LatteOrder` suggests that `id` can be `null`, at which
  ///   point I'm not sure what to do. I assume this is pretty much guaranteed
  ///   to never happen (at least for orders seen by the client),
  ///   so we just show such order on all shards to be safe (and log a warning).
  static bool _doesOrderBelongToShard(
    Latte latte, {
    required int shardNumber,
    required int shardsTotal,
  }) {
    assert(shardsTotal > 0, 'Must have at least one shard');
    assert(shardNumber > 0, 'Shard number must be at least 1');
    assert(
      shardNumber <= shardsTotal,
      'Shard number must never be higher than total number of shards',
    );
    if (shardsTotal == 1) {
      return true;
    }
    final id = latte.order.id;
    if (id == null) {
      _logger.warning('Order has null id: $latte');
      // It's probably safer to show a latte than to hide it.
      return true;
    } else {
      // Instead of String.hashCode, which returns clustered hashes
      // (meaning that one shard can easily get many more orders
      // than all other shards),
      // this `pkg:hashlib` function returns a more uniform distribution
      // while still being very fast (it's not cryptographic).
      final hash = xxh32code(id);
      final modulo = hash % shardsTotal;
      return modulo == (shardNumber - 1);
    }
  }
}

/// Actions that can be taken on the QueueHome page.
@Freezed()
sealed class QueueHomeEvent with _$QueueHomeEvent {
  /// This event is generated when the set of orders is updated in the
  /// repository (typically in Firebase).
  const factory QueueHomeEvent.ordersUpdated(
    List<LatteOrderMetadata> metadatas,
  ) = OrdersUpdated;

  /// Request for new pages, immediately.
  const factory QueueHomeEvent.refreshPages() = RefreshPages;

  /// Sets up a new custom page update period.
  const factory QueueHomeEvent.setPageUpdatePeriod(Duration pageUpdatePeriod) =
      SetPageUpdatePeriod;

  /// Sets up new recency thresholds.
  const factory QueueHomeEvent.setRecency(
    Duration maxRecentAge,
    Duration maxShowAge,
  ) = SetRecency;

  /// Sets up new sharding settings.
  const factory QueueHomeEvent.setShard(int shardNumber, int shardTotal) =
      SetShard;

  /// Sets up a new target row height.
  const factory QueueHomeEvent.setTargetRowHeight(double height) =
      SetTargetRowHeight;

  /// Sets up top settings.
  const factory QueueHomeEvent.setTopSettings({
    required bool isTopScreen,
    required int topOrdersCount,
  }) = SetTopSettings;

  /// Event sent by the view to inform the bloc about available space.
  const factory QueueHomeEvent.slotsCounted(
    int slotCount,
  ) = SlotsCounted;
}

/// {@template QueueHomeState}
/// Complete representation of the QueueHome page's state.
/// {@endtemplate
@Freezed()
sealed class QueueHomeState with _$QueueHomeState {
  /// {@macro QueueHomeState}
  const factory QueueHomeState({
    /// The setup of the queue. Persisted.
    required QueueSettingsState settings,

    /// The number of orders that the UI can show at a time. Depends on screen
    /// configuration, and informs how many orders will be in each [OrderPage].
    @Default(0) int uiSlotCapacity,

    /// The orders to show. Will be split into pages by [uiSlotCapacity].
    @Default([]) List<OrderPage> shownPages,

    /// When this is true, we know that no orders are currently in the pipeline.
    /// This is different from simply no orders being available
    /// for _this shard_. The UI can show a message or a "screen saver".
    @Default(false) bool noOrdersInAnyShard,
  }) = _QueueHomeState;

  const QueueHomeState._();
}
