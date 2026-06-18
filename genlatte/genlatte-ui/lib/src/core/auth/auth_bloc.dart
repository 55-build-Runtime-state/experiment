// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genlatte/src/role.dart';
import 'package:logging/logging.dart';

part 'auth_bloc.freezed.dart';

final _log = Logger('AuthBloc');

typedef _Emit = Emitter<AuthState>;

/// {@template AuthBloc}
/// Provider of application wide authentication state.
/// {@endtemplate}
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// {@macro AuthBloc}
  AuthBloc(this._authService) : super(AuthState.initial()) {
    on<AuthEvent>(
      (event, _Emit emit) => switch (event) {
        NewUserEvent() => _onNewUserEvent(event, emit),
        LoggedOutEvent() => _onLoggedOutEvent(event, emit),
      },
    );

    // Listen to authentication changes
    _authSub = _authService.authStateChanges().listen(_onAuthChanges);
  }
  final FirebaseAuth _authService;
  late final StreamSubscription<User?> _authSub;

  Future<void> _onAuthChanges(User? user) async {
    if (user != null) {
      final role = await getCurrentUserClaims(user);
      if (role == null) {
        _log.warning('Signing out User ${user.uid} for having no role');
        await _authService.signOut();
        add(const LoggedOutEvent());
        return;
      }
      add(NewUserEvent(user, role));
    } else {
      add(const LoggedOutEvent());
    }
  }

  /// Fetches the user's current claims from Firebase.
  Future<Role?> getCurrentUserClaims(User user) async {
    try {
      // Force a token refresh to ensure claims are current
      final IdTokenResult idTokenResult = await user.getIdTokenResult();

      // Access the claims map
      final Map<String, dynamic>? claims = idTokenResult.claims;

      if (claims == null) {
        _log.severe('User ${user.uid} logged in without claims.');
        return null;
      }

      if (claims['barista'] == true) {
        return .barista;
      } else if (claims['kiosk'] == true) {
        return .kiosk;
      } else if (claims['queue'] == true) {
        return .queueObserver;
      } else if (claims['recent'] == true) {
        return .recentOrdersObserver;
      } else if (claims['moderator'] == true) {
        return .moderator;
      }

      _log.severe('User ${user.uid} logged in with invalid role :: $claims');
      return null;
    } on FirebaseAuthException catch (e) {
      _log.severe('Error fetching ID token result: ${e.message}');
      return null;
    }
  }

  void _onNewUserEvent(NewUserEvent event, _Emit emit) =>
      emit(state.copyWith(user: event.user, role: event.role));

  Future<void> _onLoggedOutEvent(LoggedOutEvent event, _Emit emit) async {
    emit(state.copyWith(user: null, role: null));
  }

  @override
  Future<void> close() async {
    unawaited(_authSub.cancel());
    await super.close();
  }
}

/// Actions that can be taken on the auth page.
@Freezed()
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.newUser(User user, Role role) = NewUserEvent;
  const factory AuthEvent.loggedOut() = LoggedOutEvent;
}

/// {@template AuthState}
/// Complete representation of the auth page's state.
/// {@endtemplate
@Freezed()
sealed class AuthState with _$AuthState {
  /// {@macro AuthState}
  const factory AuthState({
    User? user,
    Role? role,
  }) = _AuthState;
  const AuthState._();

  /// Starter state fed to the [AuthBloc].
  factory AuthState.initial() => const AuthState();
}
