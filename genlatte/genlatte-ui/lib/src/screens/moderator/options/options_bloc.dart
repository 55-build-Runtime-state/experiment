// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:data_layer/data_layer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genlatte_data/models.dart';
import 'package:get_it/get_it.dart';

part 'options_bloc.freezed.dart';

typedef _Emit = Emitter<OptionsState>;

/// {@template OptionsBloc}
/// State manager for the Options CRUD page.
/// {@endtemplate}
class OptionsBloc extends Bloc<OptionsEvent, OptionsState> {
  /// {@macro OptionsBloc}
  OptionsBloc() : super(OptionsState.initial()) {
    on<OptionsEvent>(
      (event, _Emit emit) => switch (event) {
        NewOptions() => _onNewOptions(event, emit),
        CreateOption() => _onCreateOption(event, emit),
        ToggleOptionStatus() => _onToggleOptionStatus(event, emit),
        DeleteOption() => _onDeleteOption(event, emit),
      },
    );

    _optionsRepository = GetIt.I<Repository<LatteOptions>>();

    _optionsStreamSub = _optionsRepository.watchList().listen((options) {
      add(NewOptions(options));
    });
  }

  late final Repository<LatteOptions> _optionsRepository;
  late final StreamSubscription<List<LatteOptions>> _optionsStreamSub;

  void _onNewOptions(NewOptions event, _Emit emit) =>
      emit(state.copyWith(options: event.options));

  Future<void> _onCreateOption(CreateOption event, _Emit emit) async {
    final newValues = [...event.parent.values, LatteOption(name: event.name)];
    await _optionsRepository.setItem(
      event.parent.copyWith(values: newValues),
    );
  }

  Future<void> _onToggleOptionStatus(
    ToggleOptionStatus event,
    _Emit emit,
  ) async {
    final newValues = List<LatteOption>.from(event.parent.values);
    final index = newValues.indexOf(event.option);
    if (index != -1) {
      newValues[index] = event.option.copyWith(
        isAvailable: !event.option.isAvailable,
      );
      await _optionsRepository.setItem(
        event.parent.copyWith(values: newValues),
      );
    }
  }

  Future<void> _onDeleteOption(DeleteOption event, _Emit emit) async {
    final newValues = List<LatteOption>.from(event.parent.values)
      ..remove(event.option);
    await _optionsRepository.setItem(
      event.parent.copyWith(values: newValues),
    );
  }

  @override
  Future<void> close() {
    _optionsStreamSub.cancel().ignore();
    return super.close();
  }
}

/// Actions that can be taken on the Options page.
@Freezed()
sealed class OptionsEvent with _$OptionsEvent {
  /// A new list of options has arrived from the server.
  const factory OptionsEvent.newOptions(List<LatteOptions> options) =
      NewOptions;

  /// Creates a new [LatteOption] within the given [LatteOptions].
  const factory OptionsEvent.createOption(
    LatteOptions parent,
    String name,
  ) = CreateOption;

  /// Toggles the active status of the given option.
  const factory OptionsEvent.toggleOptionStatus(
    LatteOptions parent,
    LatteOption option,
  ) = ToggleOptionStatus;

  /// Deletes the given [LatteOption] from the given [LatteOptions].
  const factory OptionsEvent.deleteOption(
    LatteOptions parent,
    LatteOption option,
  ) = DeleteOption;
}

/// {@template OptionsState}
/// Complete representation of the Options page's state.
/// {@endtemplate
@Freezed()
sealed class OptionsState with _$OptionsState {
  /// {@macro OptionsState}
  const factory OptionsState({
    /// All options available on the server.
    @Default([]) List<LatteOptions> options,
  }) = _OptionsState;
  const OptionsState._();

  /// Starter state fed to the [OptionsBloc].
  factory OptionsState.initial() => const OptionsState();
}
