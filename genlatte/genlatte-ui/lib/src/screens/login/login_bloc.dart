// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'login_bloc.freezed.dart';

final _log = Logger('LoginBloc');

typedef _Emit = Emitter<LoginState>;

/// {@template LoginBloc}
/// {@endtemplate}
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  /// {@macro LoginBloc}
  LoginBloc(this._authService) : super(LoginState.initial()) {
    on<LoginEvent>(
      (event, _Emit emit) => switch (event) {
        LoginUserEvent() => _onLoginUser(event, emit),
      },
    );
  }
  final FirebaseAuth _authService;

  Future<void> _onLoginUser(LoginUserEvent event, _Emit emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _authService.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
    } on FirebaseAuthException catch (e) {
      _log.severe(
        'Failed to sign in with FirebaseAuthException: $e :: ${e.message}',
      );
      emit(state.copyWith(errorMessage: e.message, isLoading: false));
    } on Exception catch (e) {
      _log.severe('Failed to sign in with Exception: $e');
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}

/// Actions that can be taken on the Login page.
@Freezed()
sealed class LoginEvent with _$LoginEvent {
  /// Submitting an email and password.
  const factory LoginEvent.login({
    required String email,
    required String password,
  }) = LoginUserEvent;
}

/// {@template LoginState}
/// Complete representation of the Login page's state.
/// {@endtemplate
@Freezed()
sealed class LoginState with _$LoginState {
  /// {@macro LoginState}
  const factory LoginState({
    String? email,
    String? password,
    String? errorMessage,
    @Default(false) bool isLoading,
  }) = _LoginState;
  const LoginState._();

  /// Starter state fed to the [LoginBloc].
  factory LoginState.initial() => const LoginState();
}
