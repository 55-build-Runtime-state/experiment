// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'package:genlatte/src/role.dart';
library;

import 'dart:async';

import 'package:genlatte/src/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

final _log = Logger('AppRouter');

/// [GoRouter] wrapper with logging and redirection logic.
class AppRouter {
  /// Instantiates a new [AppRouter].
  AppRouter({required this.authBloc}) {
    redirection = GoRouterRedirector();

    router = GoRouter(
      routes: AppRoutes.routes,
      initialLocation: AppRoutes.initialRoute.path,
      redirect: (context, GoRouterState state) {
        lastRouteState = RouteState.fromGoRouterState(state);
        final redirection = _redirect(authBloc.state);
        if (redirection != null) {
          lastRouteState = RouteState(
            uri: Uri.parse(redirection),
          );
          return redirection;
        }
        return null;
      },
    );

    authBloc.stream.listen((authState) {
      _log.finest(
        'AuthState changed: User.uid: ${authState.user?.uid} :: '
        'Role: ${authState.role}',
      );

      // Prevent race condition: If GoRouter hasn't parsed the initial URL yet,
      // do not fire programmatic redirects. The above GoRouter.redirect
      // callback will handle the initial routing pass using authBloc.state.
      if (lastRouteState == null) {
        _log.fine(
          'GoRouter not yet initialized. Deferring to initial redirect.',
        );
        return;
      }

      final redirection = _redirect(authState);
      if (redirection != null) {
        lastRouteState = RouteState(
          uri: Uri.parse(redirection),
        );
        router.go(redirection);
      }
    });
  }

  /// {@macro AuthBloc}
  final AuthBloc authBloc;

  /// [GoRouter] instance.
  late final GoRouter router;

  /// Ye who keeps users from wandering off into the woods.
  late final GoRouterRedirector redirection;

  /// Cache of the last known [RouteState].
  RouteState? lastRouteState;

  final _redirections = StreamController<String?>.broadcast();

  /// Emits redirection decisions
  @visibleForTesting
  Stream<String?> get allRedirects => _redirections.stream;

  String? _redirect(AuthState authState) {
    final redirect = redirection.redirect(
      routeState:
          lastRouteState ?? //
          RouteState.fromRoute(AppRoutes.initialRoute),
      authState: authState,
    );
    _redirections.add(redirect);
    return redirect;
  }

  /// Redirects the user to the options editing screen.
  void toOptions() => router.go('/moderator/options');

  /// Redirects the user to the printers editing screen. If the user is not a
  /// moderator, they will immediately bounce back to their own homepage.
  void toMachines() => router.go('/moderator/machines');
}
