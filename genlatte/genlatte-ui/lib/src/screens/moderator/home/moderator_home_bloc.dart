// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:data_layer/data_layer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genlatte/src/data/data.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';

part 'moderator_home_bloc.freezed.dart';

final _logger = Logger('ModeratorHomeBloc');

typedef _Emit = Emitter<ModeratorHomeState>;

/// {@template ModeratorHomeBloc}
/// Bloc for the Moderator home page.
/// {@endtemplate}
class ModeratorHomeBloc extends Bloc<ModeratorHomeEvent, ModeratorHomeState> {
  /// {@macro ModeratorHomeBloc}
  ModeratorHomeBloc() : super(ModeratorHomeState.initial()) {
    on<ModeratorHomeEvent>(
      (event, _Emit emit) => switch (event) {
        NewBaristas() => _onNewBaristas(event, emit),
        NewModerateQueueOrders() => _onNewModerateQueueOrders(event, emit),
        ApproveNameAndImage() => _onApproveNameAndImage(event, emit),
        RejectNameApproveImage() => _onRejectNameApproveImage(event, emit),
        ApproveNameRejectImage() => _onApproveNameRejectImage(event, emit),
        RejectNameAndImage() => _onRejectNameAndImage(event, emit),
        CompleteOrder() => _onCompleteOrder(event, emit),
      },
    );

    _baristasRepository = GetIt.I<Repository<Barista>>();
    _metadataRepository = GetIt.I<Repository<LatteOrderMetadata>>();
    _ordersRepository = GetIt.I<LatteOrdersRepository>();

    _moderateStreamSub = _metadataRepository
        .watchList(
          details: RequestDetails.read(
            filter: const LatteOrderMetadataModerationQueue(),
          ),
        )
        .listen((metadata) => add(NewModerateQueueOrders(metadata)));

    _baristaStreamSub = _baristasRepository.watchList().listen(
      (baristas) => add(NewBaristas(baristas)),
    );
  }

  late final Repository<Barista> _baristasRepository;
  late final LatteOrdersRepository _ordersRepository;
  late final Repository<LatteOrderMetadata> _metadataRepository;

  late final StreamSubscription<List<LatteOrderMetadata>> _moderateStreamSub;
  late final StreamSubscription<List<Barista>> _baristaStreamSub;

  Future<void> _onNewModerateQueueOrders(
    NewModerateQueueOrders event,
    _Emit emit,
  ) async {
    _logger.fine(
      'New moderation queue: ${event.metadatas.map<String>((m) => m.id!)}',
    );

    List<Latte> lattes;
    try {
      lattes = await _ordersRepository.toLattes(event.metadatas);
    } on DataException catch (e) {
      _logger.severe(e.message);
      return;
    }

    final moderationLattes = <Latte>[];
    final brewLattes = <Latte>[];

    for (final latte in lattes) {
      if (latte.metadata.status == LatteOrderStatus.submitted) {
        moderationLattes.add(latte);
      } else {
        brewLattes.add(latte);
      }
    }

    emit(
      state.copyWith(
        moderationQueue: [
          // Older orders appear first
          ...moderationLattes..sort(
            (a, b) => a.metadata.orderSubmittedTime!.compareTo(
              b.metadata.orderSubmittedTime!,
            ),
          ),
          // Older orders appear first
          ...brewLattes..sort(
            (a, b) => a.metadata.orderSubmittedTime!.compareTo(
              b.metadata.orderSubmittedTime!,
            ),
          ),
        ],
      ),
    );
  }

  void _onNewBaristas(NewBaristas event, _Emit emit) {
    _logger.fine('New baristas queue: ${event.baristas}');
    emit(state.copyWith(baristas: event.baristas.toIdsMap()));
  }

  Future<void> _onApproveNameAndImage(
    ApproveNameAndImage event,
    _Emit emit,
  ) => _moderateOrder(
    orderId: event.orderId,
    isNameApproved: true,
    isImageApproved: true,
  );

  Future<void> _onRejectNameApproveImage(
    RejectNameApproveImage event,
    _Emit emit,
  ) => _moderateOrder(
    orderId: event.orderId,
    isNameApproved: false,
    isImageApproved: true,
  );

  Future<void> _onApproveNameRejectImage(
    ApproveNameRejectImage event,
    _Emit emit,
  ) => _moderateOrder(
    orderId: event.orderId,
    isNameApproved: true,
    isImageApproved: false,
  );

  Future<void> _onRejectNameAndImage(
    RejectNameAndImage event,
    _Emit emit,
  ) => _moderateOrder(
    orderId: event.orderId,
    isNameApproved: false,
    isImageApproved: false,
  );

  Future<void> _moderateOrder({
    required String orderId,
    required bool isNameApproved,
    required bool isImageApproved,
  }) async {
    final latte = state.moderationQueue.firstWhereOrNull(
      (l) => l.order.id == orderId,
    );

    if (latte == null) {
      _logger.warning(
        'Could not find latte for order id $orderId. '
        'Maybe another barista moderated it at the same time?',
      );
      return;
    }

    final metadata = latte.metadata.copyWith(
      isNameApproved: isNameApproved,
      isImageApproved: isImageApproved,
      status: .validated,
    );

    // No need to capture the returned metadata, since it will get picked up
    // by our open `watch` streams.
    await _metadataRepository.setItem(metadata);
  }

  Future<void> _onCompleteOrder(CompleteOrder event, _Emit emit) async {
    final latte = state.moderationQueue.firstWhereOrNull(
      (l) => l.order.id == event.orderId,
    );

    if (latte == null) {
      _logger.warning(
        'Could not find latte for order id ${event.orderId}. '
        'Maybe another moderator or barista completed it at the same time?',
      );
      return;
    }

    /// Optimistic update to immediately remove the order from the UI.
    emit(
      state.copyWith(
        moderationQueue: state.moderationQueue
            .where((l) => l.order.id != event.orderId)
            .toList(),
      ),
    );

    await _ordersRepository.completeOrder(
      orderId: latte.order.id!,
      // Since moderators don't have a "persona" and thus don't have a
      // Barista record, we'll just use a special string to indicate that
      // a moderator completed the order.
      baristaId: 'moderator',
    );
  }

  @override
  Future<void> close() {
    _moderateStreamSub.cancel().ignore();
    _baristaStreamSub.cancel().ignore();
    return super.close();
  }
}

/// Actions that can be taken on the ModeratorHome page.
@Freezed()
sealed class ModeratorHomeEvent with _$ModeratorHomeEvent {
  /// A new list of Baristas has arrived from the server.
  const factory ModeratorHomeEvent.newBaristas(List<Barista> baristas) =
      NewBaristas;

  /// A new list of ready-to-moderate orders has arrived from the server.
  const factory ModeratorHomeEvent.newModerateQueueOrders(
    List<LatteOrderMetadata> metadatas,
  ) = NewModerateQueueOrders;

  /// The barista has approved both the name and image for an order.
  const factory ModeratorHomeEvent.approveNameAndImage(String orderId) =
      ApproveNameAndImage;

  // /// The barista has rejected the name for an order.
  const factory ModeratorHomeEvent.rejectNameApproveImage(String orderId) =
      RejectNameApproveImage;

  // /// The barista has rejected the name for an order.
  const factory ModeratorHomeEvent.approveNameRejectImage(String orderId) =
      ApproveNameRejectImage;

  // /// The barista has rejected both the name and image for an order.
  const factory ModeratorHomeEvent.rejectNameAndImage(String orderId) =
      RejectNameAndImage;

  /// The moderator has completed an order.
  const factory ModeratorHomeEvent.completeOrder(String orderId) = CompleteOrder;
}

/// {@template ModeratorHomeState}
/// Complete representation of the ModeratorHome page's state.
/// {@endtemplate
@Freezed()
sealed class ModeratorHomeState with _$ModeratorHomeState {
  /// {@macro ModeratorHomeState}
  const factory ModeratorHomeState({
    required List<Latte> moderationQueue,
    @Default({}) Map<String, Barista> baristas,
  }) = _ModeratorHomeState;
  const ModeratorHomeState._();

  /// Starter state fed to the [ModeratorHomeBloc].
  factory ModeratorHomeState.initial({
    List<Latte>? moderationQueue,
  }) => ModeratorHomeState(
    moderationQueue: moderationQueue ?? [],
  );
}

extension _MyList<E> on List<E> {
  /// Returns the first matching element, or null if there are no matches.`
  E? firstWhereOrNull(bool Function(E element) test, {E? Function()? orElse}) {
    for (final E element in this) {
      if (test(element)) return element;
    }
    if (orElse != null) return orElse();
    return null;
  }
}
