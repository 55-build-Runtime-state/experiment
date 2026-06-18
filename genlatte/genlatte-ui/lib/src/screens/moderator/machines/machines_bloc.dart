// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:data_layer/data_layer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';

part 'machines_bloc.freezed.dart';

typedef _Emit = Emitter<MachinesState>;

/// {@template MachinesBloc}
/// State manager for the Machines CRUD page.
/// {@endtemplate}
class MachinesBloc extends Bloc<MachinesEvent, MachinesState> {
  /// {@macro MachinesBloc}
  MachinesBloc() : super(MachinesState.initial()) {
    on<MachinesEvent>(
      (event, _Emit emit) => switch (event) {
        NewMachines() => _onNewMachines(event, emit),
        ToggleMachineStatus() => _onToggleMachineStatus(event, emit),
        CreateMachine() => _onCreateMachine(event, emit),
        DeleteMachine() => _onDeleteMachine(event, emit),
      },
    );

    _machinesRepository = GetIt.I<Repository<Machine>>();

    _machinesStreamSub = _machinesRepository.watchList().listen(
      (machines) => add(NewMachines(machines)),
    );
  }

  late final Repository<Machine> _machinesRepository;

  late final StreamSubscription<List<Machine>> _machinesStreamSub;

  void _onNewMachines(NewMachines event, _Emit emit) =>
      emit(state.copyWith(machines: event.machines));

  Future<void> _onToggleMachineStatus(
    ToggleMachineStatus event,
    _Emit emit,
  ) async {
    await _machinesRepository.setItem(
      event.machine.copyWith(isActive: !event.machine.isActive),
    );
  }

  Future<void> _onCreateMachine(CreateMachine event, _Emit emit) async =>
      // Ids are set by the physical printers, so the Moderators must supply
      // those instead of letting Firestore set typical document Ids.
      // Therefore, we must use `forceInsert: true`.
      _machinesRepository.setItem(
        event.machine,
        RequestDetails.write(forceInsert: true),
      );

  Future<void> _onDeleteMachine(DeleteMachine event, _Emit emit) async =>
      _machinesRepository.delete(event.id);

  @override
  Future<void> close() {
    _machinesStreamSub.cancel().ignore();
    return super.close();
  }
}

/// Actions that can be taken on the Machines page.
@Freezed()
sealed class MachinesEvent with _$MachinesEvent {
  /// A new list of machines has arrived from the server.
  const factory MachinesEvent.newMachines(List<Machine> machines) = NewMachines;

  /// Toggles the active status of the given machine.
  const factory MachinesEvent.toggleMachineStatus(
    Machine machine,
  ) = ToggleMachineStatus;

  /// Creates a new machine with the given properties.
  const factory MachinesEvent.createMachine(Machine machine) = CreateMachine;

  /// Deletes the machine with the given id.
  const factory MachinesEvent.deleteMachine(String id) = DeleteMachine;
}

/// {@template MachinesState}
/// Complete representation of the Machines page's state.
/// {@endtemplate
@Freezed()
sealed class MachinesState with _$MachinesState {
  /// {@macro MachinesState}
  const factory MachinesState({
    /// All machines available on the server.
    @Default([]) List<Machine> machines,
  }) = _MachinesState;
  const MachinesState._();

  /// Starter state fed to the [MachinesBloc].
  factory MachinesState.initial() => const MachinesState();
}
