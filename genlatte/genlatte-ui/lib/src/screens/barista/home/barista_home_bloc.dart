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
import 'package:uuid/uuid.dart';

part 'barista_home_bloc.freezed.dart';

final _logger = Logger('BaristaHomeBloc');

typedef _Emit = Emitter<BaristaHomeState>;

/// {@template BaristaHomeBloc}
/// Bloc for the Barista Home screen.
/// {@endtemplate}
class BaristaHomeBloc extends Bloc<BaristaHomeEvent, BaristaHomeState> {
  /// {@macro BaristaHomeBloc}
  BaristaHomeBloc() : super(BaristaHomeState.initial()) {
    on<BaristaHomeEvent>(
      (event, _Emit emit) => switch (event) {
        NewBrewQueueOrders() => _onNewBrewQueueOrders(event, emit),
        NewBaristas() => _onNewBaristas(event, emit),
        BaristaSignIn() => _onBaristaSignIn(event, emit),
        BaristaSignOut() => _onBaristaSignOut(event, emit),
        ClaimOrder() => _onClaimOrder(event, emit),
        CompleteOrder() => _onCompleteOrder(event, emit),
        ReprintOrder() => _onReprintOrder(event, emit),
        NewMachineList() => _onNewMachineList(event, emit),
        SelectedMachineDisappeared() => _onSelectedMachineDisappeared(
          event,
          emit,
        ),
        SelectedMachine() => _onSelectedMachine(event, emit),
      },
    );

    _metadataRepository = GetIt.I<Repository<LatteOrderMetadata>>();
    _ordersRepository = GetIt.I<LatteOrdersRepository>();

    _brewStreamSub = _metadataRepository
        .watchList(
          details: RequestDetails.read(
            filter: const LatteOrderMetadataBrewQueue(),
          ),
        )
        .listen((metadata) => add(NewBrewQueueOrders(metadata)));

    _baristasRepository = GetIt.I<Repository<Barista>>();

    _baristaStreamSub = _baristasRepository.watchList().listen(
      (baristas) => add(NewBaristas(baristas)),
    );

    _baristasRepository
        .getItems(
          details: RequestDetails(
            filter: ActiveBaristaFilter(),
            requestType: .local,
          ),
        )
        .then(
          (baristas) {
            if (baristas.length == 1) {
              add(BaristaSignIn(baristas.first));
            }
          },
        )
        .ignore();

    _machinesRepository = GetIt.I<Repository<Machine>>();

    _machinesStreamSub = _machinesRepository
        .watchList(
          details: RequestDetails.read(
            filter: const ActiveMachinesFilter(),
          ),
        )
        .listen(
          (machines) => add(NewMachineList(machines)),
        );
  }

  late final Repository<Machine> _machinesRepository;
  late final StreamSubscription<List<Machine>> _machinesStreamSub;

  late final Repository<Barista> _baristasRepository;
  late final LatteOrdersRepository _ordersRepository;
  late final Repository<LatteOrderMetadata> _metadataRepository;

  late final StreamSubscription<List<LatteOrderMetadata>> _brewStreamSub;
  late final StreamSubscription<List<Barista>> _baristaStreamSub;

  Future<void> _onNewBrewQueueOrders(
    NewBrewQueueOrders event,
    _Emit emit,
  ) async {
    _logger.fine(
      'New brew queue: ${event.metadatas.map<String>((m) => m.id!)}',
    );

    List<Latte> lattes;
    try {
      lattes = await _ordersRepository.toLattes(event.metadatas);
    } on DataException catch (e) {
      _logger.severe(e.message);
      return;
    }

    emit(
      state.copyWith(
        brewQueue: lattes
          // Older orders appear first
          ..sort(
            (a, b) => a.metadata.orderSubmittedTime!.compareTo(
              b.metadata.orderSubmittedTime!,
            ),
          ),
      ),
    );
  }

  void _onNewBaristas(NewBaristas event, _Emit emit) {
    _logger.fine(
      'New baristas queue: ${event.baristas} :: '
      'currentBarista: [${state.currentBarista}]',
    );
    emit(state.copyWith(baristas: event.baristas.toIdsMap()));
  }

  Future<void> _onBaristaSignIn(BaristaSignIn event, _Emit emit) async {
    final allBaristas = await _baristasRepository.getItems(
      details: RequestDetails.read(requestType: .allLocal),
    );

    Barista? signedInBarista;
    for (final barista in allBaristas) {
      if (barista.username == event.barista.username &&
          barista.persona == event.barista.persona) {
        _logger.fine('Logging in user as existing barista: $barista');
        signedInBarista = barista;
        break;
      }
    }
    if (signedInBarista == null) {
      final savedBarista = await _baristasRepository.setItem(event.barista);
      if (savedBarista == null) {
        _logger.severe(
          'Failed to save barista ${event.barista}. Received null from '
          '[setItem].',
        );
        return;
      }
      signedInBarista = savedBarista;
    }
    emit(state.copyWith(currentBarista: signedInBarista));

    /// Cache this locally, which will write it to Hive but not bother
    /// sending the payload to Firestore.
    await _baristasRepository.setItems(
      [signedInBarista],
      RequestDetails(
        filter: ActiveBaristaFilter(),
        requestType: .local,
      ),
    );
  }

  Future<void> _onBaristaSignOut(BaristaSignOut event, _Emit emit) async {
    // Remove the active Barista from the local cache.
    await _baristasRepository.delete(
      state.currentBarista!.id!,
      RequestDetails(
        filter: ActiveBaristaFilter(),
        requestType: .local,
      ),
    );
    emit(state.copyWith(currentBarista: null));
  }

  Future<void> _onClaimOrder(ClaimOrder event, _Emit emit) async {
    if (state.selectedMachine == null) {
      return emit(
        state.copyWith(
          error: MachinesError.machineDisconnected(),
          selectedMachine: null,
        ),
      );
    }

    final latte = state.brewQueue.firstWhereOrNull(
      (l) => l.order.id == event.orderId,
    );

    if (latte == null) {
      _logger.warning(
        'Could not find latte for order id ${event.orderId}. '
        'Maybe another barista claimed it at the same time?',
      );
      return;
    }

    final metadata = latte.metadata.copyWith(
      baristaId: state.currentBarista?.id,
      status: .inProgress,
    );

    final imageUrlToPrint = latte.metadata.isImageApproved == false
        ? 'https://firebasestorage.googleapis.com/v0/b/gcdemos-26-int-dd-latteart.firebasestorage.app/o/latteImages%2FfallbackImage%2Ficon_flutter.png?alt=media&token=06a3ac7e-7929-4507-8105-9eddb4445892'
        : latte.metadata.imageUrl!;

    // No need to capture the returned metadata, since it will get picked up
    // by our open `watch` streams.
    await _metadataRepository.setItem(metadata);

    await _ordersRepository.sendToPrinters(
      imagePath: imageUrlToPrint,
      machineName: state.selectedMachine!.name,
    );
  }

  Future<void> _onCompleteOrder(CompleteOrder event, _Emit emit) async {
    final latte = state.brewQueue.firstWhereOrNull(
      (l) => l.order.id == event.orderId,
    );

    if (latte == null) {
      _logger.warning(
        'Could not find latte for order id ${event.orderId}. '
        'Maybe another barista completed it at the same time?',
      );
      return;
    }

    /// Optimistic update to immediately remove the order from the UI.
    emit(
      state.copyWith(
        brewQueue: state.brewQueue
            .where((l) => l.order.id != event.orderId)
            .toList(),
      ),
    );

    await _ordersRepository.completeOrder(
      orderId: latte.order.id!,
      baristaId: state.currentBarista!.id!,
    );
  }

  Future<void> _onReprintOrder(ReprintOrder event, _Emit emit) async {
    if (state.selectedMachine == null) {
      return emit(
        state.copyWith(
          error: MachinesError.machineDisconnected(),
          selectedMachine: null,
        ),
      );
    }

    final latte = state.brewQueue.firstWhereOrNull(
      (l) => l.order.id == event.orderId,
    );

    if (latte == null) {
      _logger.warning(
        'Could not find latte for order id ${event.orderId}. '
        'Maybe another barista completed it at the same time?',
      );
      return;
    }

    final imageUrlToPrint = latte.metadata.isImageApproved == false
        ? 'https://firebasestorage.googleapis.com/v0/b/gcdemos-26-int-dd-latteart.firebasestorage.app/o/latteImages%2FfallbackImage%2Ficon_flutter.png?alt=media&token=06a3ac7e-7929-4507-8105-9eddb4445892'
        : latte.metadata.imageUrl!;

    await _ordersRepository.sendToPrinters(
      imagePath: imageUrlToPrint,
      machineName: state.selectedMachine!.name,
    );
  }

  void _onNewMachineList(NewMachineList event, _Emit emit) {
    final machinesIdMap = event.machines.toIdsMap();
    final selectedMachine = state.selectedMachine;
    if (selectedMachine != null &&
        !machinesIdMap.containsKey(selectedMachine.id)) {
      add(const SelectedMachineDisappeared());
    }
    emit(state.copyWith(machines: event.machines));
  }

  void _onSelectedMachineDisappeared(
    SelectedMachineDisappeared event,
    _Emit emit,
  ) {
    emit(
      state.copyWith(
        error: MachinesError.machineDisconnected(),
        selectedMachine: null,
      ),
    );
  }

  void _onSelectedMachine(SelectedMachine event, _Emit emit) {
    emit(state.copyWith(selectedMachine: event.machine, error: null));
  }

  @override
  Future<void> close() {
    _brewStreamSub.cancel().ignore();
    _baristaStreamSub.cancel().ignore();
    _machinesStreamSub.cancel().ignore();
    return super.close();
  }
}

/// Actions that can be taken on the BaristaHome page.
@Freezed()
sealed class BaristaHomeEvent with _$BaristaHomeEvent {
  /// A new list of ready-to-brew orders has arrived from the server.
  const factory BaristaHomeEvent.newBrewQueueOrders(
    List<LatteOrderMetadata> metadatas,
  ) = NewBrewQueueOrders;

  /// A new list of ready-to-brew orders has arrived from the server.
  const factory BaristaHomeEvent.newMachinesList(
    List<Machine> machines,
  ) = NewMachineList;

  /// The previously selected machine is no longer available.
  const factory BaristaHomeEvent.selectedMachineDisappeared() =
      SelectedMachineDisappeared;

  /// The barista has selected a new machine.
  const factory BaristaHomeEvent.selectedMachine(Machine machine) =
      SelectedMachine;

  /// A new list of Baristas has arrived from the server.
  const factory BaristaHomeEvent.newBaristas(List<Barista> baristas) =
      NewBaristas;

  /// A new barista has signed in and selected their persona.
  const factory BaristaHomeEvent.baristaSignIn(Barista barista) = BaristaSignIn;

  /// A barista has ended their shift.
  const factory BaristaHomeEvent.baristaSignOut() = BaristaSignOut;

  /// The barista has claimed an order.
  const factory BaristaHomeEvent.claimOrder(String orderId) = ClaimOrder;

  /// The barista has completed an order.
  const factory BaristaHomeEvent.completeOrder(String orderId) = CompleteOrder;

  /// The barista has requested to reprint an order.
  const factory BaristaHomeEvent.reprintOrder(String orderId) = ReprintOrder;
}

/// {@template BaristaHomeState}
/// Complete representation of the BaristaHome page's state.
/// {@endtemplate
@Freezed()
sealed class BaristaHomeState with _$BaristaHomeState {
  /// {@macro BaristaHomeState}
  const factory BaristaHomeState({
    required List<Latte> brewQueue,
    Barista? currentBarista,
    @Default({}) Map<String, Barista> baristas,
    @Default([]) List<Machine> machines,
    Machine? selectedMachine,
    MachinesError? error,
  }) = _BaristaHomeState;
  const BaristaHomeState._();

  /// Starter state fed to the [BaristaHomeBloc].
  factory BaristaHomeState.initial({List<Latte>? brewQueue}) =>
      BaristaHomeState(brewQueue: brewQueue ?? []);
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

/// Error to show a Barista regarding their printer. The Uuid is just for
/// deduplication so the UI doesn't spam the same toast over and over.
class MachinesError {
  /// Instantiates a [MachinesError].
  factory MachinesError.machineDisconnected() => MachinesError._(
    'The selected machine is no longer available. '
    'Please choose another one.',
    .machineDisconnected,
    const Uuid().v4(),
  );

  MachinesError._(this.message, this.code, this.uuid);

  /// The message to show the barista.
  final String message;

  /// The code associated with the error.
  final ErrorCode code;

  /// Id for deduplication purposes in the widget tree.
  final String uuid;
}

/// Codes to identify the type of error. The UI uses this to know concretely
/// what action a Barista needs to take to rectify the error.
enum ErrorCode {
  /// The Barista's previously-connected machine is no longer available.
  machineDisconnected,
}
