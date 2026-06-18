// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'package:genlatte/src/role.dart';
library;

import 'package:genlatte/src/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

final _log = Logger('Redirection');

/// Type alias for route parameters.
typedef Params = Map<String, String>;

/// {@template GoRouterRedirector}
/// Validates that the user's current location within the app is allowed by
/// their authentication state and other details like app health.
/// {@endtemplate}
class GoRouterRedirector {
  /// Singleton constructor.
  factory GoRouterRedirector() => const GoRouterRedirector._(
    <Redirector>[
      AnonymousUsersToLogin(),
      AuthenticatedUsersAwayFromLogin(),
      NonBaristaAwayFromBaristaHome(),
      NonKioskAwayFromKioskHome(),
      NonQueueObserverAwayFromQueue(),
      NonRecentOrdersObserverAwayFromRecentOrders(),
      NonModeratorObserverAwayFromModeration(),
      NonModeratorsAwayFromPrinters(),
    ],
    <String>[
      // globalMaintenanceRoute.path
      // globalForceUpgradeRoute.path
    ],
  );

  const GoRouterRedirector._(this._redirects, this._doNotLeave);

  final List<Redirector> _redirects;

  /// Forced dead-end paths that, once routed to, cannot be routed away from by
  /// any other redirect rules; but instead, only by the undoing of the
  /// conditions that led to redirecting here in the first place.
  final List<String> _doNotLeave;

  /// Compares the current [RouteState] against the [AuthState] and returns a
  /// string to navigate to if required. Returns null if the current
  /// [RouteState] and [AuthState] are compatible.
  String? redirect({
    required RouteState routeState,
    required AuthState authState,
  }) {
    _log.finest(
      'Considering redirect for "${routeState.path}" with user '
      '${authState.user?.uid} and role ${authState.role}',
    );
    if (_doNotLeave.contains(routeState.path)) {
      _log.finest(
        'Not navigating away from ${routeState.path} for DO NOT LEAVE',
      );
      return null;
    }
    final current = Uri(
      path: routeState.path,
      queryParameters:
          routeState
              .uri
              .queryParameters
              .isNotEmpty //
          ? routeState.uri.queryParameters
          : null,
    );
    for (final redirect in _redirects) {
      if (redirect.predicate(routeState, authState)) {
        final newRouteState = redirect.getNewRouteState(routeState, authState);
        final uriString = newRouteState.uri.toString();

        if (uriString == current.toString()) {
          _log.warning(
            '$redirect attempted to redirect to itself at $uriString. '
            'This should have been caught earlier!',
          );
          continue;
        }

        _log.finer('$redirect redirecting from $current to $uriString');
        return uriString;
      } else {
        _log.finest(
          '$redirect declined to redirect away from ${routeState.path}',
        );
      }
    }
    _log.finer('Not redirecting away from ${routeState.path}');
    return null;
  }
}

/// {@template RouteState}
/// Simplified representation of the user's location within the app. Exists to
/// contain an individual routing solution from leaking its logic all across
/// the app's codebase.
/// {@endtemplate}
class RouteState {
  /// Instantiates a new [RouteState].
  const RouteState({
    required this.uri,
    this.route,
  });

  /// Converts a [GoRouterState] object into the values the rest of our app will
  /// care about.
  factory RouteState.fromGoRouterState(GoRouterState state) {
    assert(
      state.fullPath != null,
      'Unexpectedly had null [GoRouterState.fullPath]',
    );
    return RouteState(
      uri: state.uri,
      route: state.topRoute,
    );
  }

  /// Builds a GoRouterState value from a given route.
  /// Useful for the initial route.
  factory RouteState.fromRoute(GoRoute route, {Params? pathParameters}) {
    String path = route.path;
    if (pathParameters != null) {
      for (final key in pathParameters.keys) {
        path = path.replaceAll(':$key', pathParameters[key]!);
      }
    }
    return RouteState(
      uri: Uri(path: path),
      route: route,
    );
  }

  /// Fully formed URI of the route.
  final Uri uri;

  /// The [GoRoute] that matches the current URI.
  final GoRoute? route;

  /// Path of the route.
  String get path => uri.path;

  @override
  String toString() => 'RouteState(uri: $uri, route.path: ${route?.path})';
}

/// Individual utility within a [GoRouterRedirector] to enforce a single rule.
abstract class Redirector {
  /// Const constructor.
  const Redirector();

  /// Determines whether this redirection should take place.
  bool predicate(RouteState routeState, AuthState authState);

  /// Returns the desired [Uri] to send the user based on current app state.
  RouteState getNewRouteState(RouteState routeState, AuthState authState);

  @override
  String toString() => '$runtimeType()';
}

/// {@template AnonymousUsersToLogin}
/// Sends anonymous users to the login screen.
/// {@endtemplate}
class AnonymousUsersToLogin extends Redirector {
  /// {@macro AnonymousUsersToLogin}
  const AnonymousUsersToLogin();
  @override
  bool predicate(
    RouteState routeState,
    AuthState authState,
  ) =>
      routeState.path != AppRoutes.loginRoute.path &&
      (authState.user == null || authState.role == null);

  @override
  RouteState getNewRouteState(
    RouteState routeState,
    AuthState authState,
  ) => RouteState(
    uri: Uri(
      path: AppRoutes.loginRoute.path,
      // Save the destination as a query parameter.
      queryParameters: {'continue': routeState.uri.toString()},
    ),
    route: AppRoutes.loginRoute,
  );
}

/// {@template AuthenticatedUsersAwayFromLogin}
/// Sends authenticated users away from the login screen.
/// {@endtemplate}
class AuthenticatedUsersAwayFromLogin extends Redirector {
  /// {@macro AuthenticatedUsersAwayFromLogin}
  const AuthenticatedUsersAwayFromLogin();
  @override
  bool predicate(
    RouteState routeState,
    AuthState authState,
  ) =>
      routeState.path == AppRoutes.loginRoute.path &&
      authState.user != null &&
      authState.role != null;

  @override
  RouteState getNewRouteState(
    RouteState routeState,
    AuthState authState,
  ) {
    final continueUrl = routeState.uri.queryParameters['continue'];
    if (continueUrl != null) {
      final uri = Uri.tryParse(continueUrl);
      if (uri != null && uri.path != AppRoutes.loginRoute.path) {
        _log.info('Continue parameter found, continuing to $uri');
        return RouteState(uri: uri);
      }
    }

    return RouteState.fromRoute(
      switch (authState.role) {
        null => throw Exception('Programmatic error in redirection system'),
        .barista => AppRoutes.baristaHomeRoute,
        .moderator => AppRoutes.moderatorHomeRoute,
        .kiosk => AppRoutes.kioskHomeRoute,
        .queueObserver => AppRoutes.queueRoute,
        .recentOrdersObserver => AppRoutes.recentOrdersRoute,
      },
    );
  }
}

/// {@template NonBaristaAwayFromBaristaHome}
/// Sends non-barista users away from the barista home screen. This locks down
/// the barista home screen to only baristas and prevents, for example, kiosk
/// users from guessing URLs and performing Barista-only actions.
/// {@endtemplate}
class NonBaristaAwayFromBaristaHome extends Redirector {
  /// {@macro NonBaristaAwayFromBaristaHome}
  const NonBaristaAwayFromBaristaHome();
  @override
  bool predicate(
    RouteState routeState,
    AuthState authState,
  ) =>
      routeState.path == AppRoutes.baristaHomeRoute.path &&
      authState.role != .barista;

  @override
  RouteState getNewRouteState(
    RouteState routeState,
    AuthState authState,
  ) => RouteState.fromRoute(
    switch (authState.role) {
      null => AppRoutes.loginRoute,
      .barista => throw Exception(
        'Programmatic error in redirection system. Barista user should not '
        'have passed predicate for NonBaristaAwayFromBaristaHome',
      ),
      .moderator => AppRoutes.moderatorHomeRoute,
      .kiosk => AppRoutes.kioskHomeRoute,
      .queueObserver => AppRoutes.queueRoute,
      .recentOrdersObserver => AppRoutes.recentOrdersRoute,
    },
  );
}

/// {@template NonKioskAwayFromKioskHome}
/// Sends non-kiosk users away from the kiosk home screen. This locks down
/// the kiosk home screen to only kiosks and prevents, for example, the Recent
/// Orders Observer from guessing URLs and performing Kiosk-only actions.
/// {@endtemplate}
class NonKioskAwayFromKioskHome extends Redirector {
  /// {@macro NonKioskAwayFromKioskHome}
  const NonKioskAwayFromKioskHome();
  @override
  bool predicate(
    RouteState routeState,
    AuthState authState,
  ) =>
      routeState.path == AppRoutes.kioskHomeRoute.path &&
      authState.role != .kiosk;

  @override
  RouteState getNewRouteState(
    RouteState routeState,
    AuthState authState,
  ) => RouteState.fromRoute(
    switch (authState.role) {
      null => AppRoutes.loginRoute,
      .barista => AppRoutes.baristaHomeRoute,
      .moderator => AppRoutes.moderatorHomeRoute,
      .kiosk => throw Exception(
        'Programmatic error in redirection system. Kiosk user should not '
        'have passed predicate for NonKioskAwayFromKioskHome',
      ),
      .queueObserver => AppRoutes.queueRoute,
      .recentOrdersObserver => AppRoutes.recentOrdersRoute,
    },
  );
}

/// {@template NonQueueObserverAwayFromQueue}
/// Sends non-queue observer users away from the queue screen. This locks down
/// the queue screen to only queue observers and prevents... actually not much
/// in this situation since the queue observers will be elevated monitors no one
/// can easily access to hijack. But, still. Here we are.
/// {@endtemplate}
class NonQueueObserverAwayFromQueue extends Redirector {
  /// {@macro NonQueueObserverAwayFromQueue}
  const NonQueueObserverAwayFromQueue();
  @override
  bool predicate(
    RouteState routeState,
    AuthState authState,
  ) =>
      routeState.path == AppRoutes.queueRoute.path &&
      authState.role != .queueObserver;

  @override
  RouteState getNewRouteState(
    RouteState routeState,
    AuthState authState,
  ) => RouteState.fromRoute(
    switch (authState.role) {
      null => AppRoutes.loginRoute,
      .barista => AppRoutes.baristaHomeRoute,
      .moderator => AppRoutes.moderatorHomeRoute,
      .kiosk => AppRoutes.kioskHomeRoute,
      .queueObserver => throw Exception(
        'Programmatic error in redirection system. Queue observer user should '
        'not have passed predicate for NonQueueObserverAwayFromQueue',
      ),
      .recentOrdersObserver => AppRoutes.recentOrdersRoute,
    },
  );
}

/// {@template NonRecentOrdersObserverAwayFromRecentOrders}
/// Sends non-recent orders observer users away from the recent orders screen.
/// This locks down the recent orders screen to only recent orders observers
/// and prevents someone from hijacking said screen to view any of the other
/// homescreens.
/// {@endtemplate}
class NonRecentOrdersObserverAwayFromRecentOrders extends Redirector {
  /// {@macro NonRecentOrdersObserverAwayFromRecentOrders}
  const NonRecentOrdersObserverAwayFromRecentOrders();
  @override
  bool predicate(
    RouteState routeState,
    AuthState authState,
  ) =>
      routeState.path == AppRoutes.recentOrdersRoute.path &&
      authState.role != .recentOrdersObserver;

  @override
  RouteState getNewRouteState(
    RouteState routeState,
    AuthState authState,
  ) => RouteState.fromRoute(
    switch (authState.role) {
      null => AppRoutes.loginRoute,
      .barista => AppRoutes.baristaHomeRoute,
      .moderator => AppRoutes.moderatorHomeRoute,
      .kiosk => AppRoutes.kioskHomeRoute,
      .queueObserver => AppRoutes.queueRoute,
      .recentOrdersObserver => throw Exception(
        'Programmatic error in redirection system. Recent orders observer '
        'user should not have passed predicate for '
        'NonRecentOrdersObserverAwayFromRecentOrders',
      ),
    },
  );
}

/// {@template NonModeratorObserverAwayFromModeration}
/// Sends non-moderator users away from the moderation screen.
/// This locks down the moderation screen to only moderators and prevents
/// someone from hijacking said screen to view any of the other homescreens.
/// {@endtemplate}
class NonModeratorObserverAwayFromModeration extends Redirector {
  /// {@macro NonModeratorObserverAwayFromModeration}
  const NonModeratorObserverAwayFromModeration();
  @override
  bool predicate(
    RouteState routeState,
    AuthState authState,
  ) =>
      routeState.path == AppRoutes.moderatorHomeRoute.path &&
      authState.role != .moderator;

  @override
  RouteState getNewRouteState(
    RouteState routeState,
    AuthState authState,
  ) => RouteState.fromRoute(
    switch (authState.role) {
      null => AppRoutes.loginRoute,
      .barista => AppRoutes.baristaHomeRoute,
      .moderator => throw Exception(
        'Programmatic error in redirection system. Moderator user should not '
        'have passed predicate for NonModeratorObserverAwayFromModeration',
      ),
      .kiosk => AppRoutes.kioskHomeRoute,
      .queueObserver => AppRoutes.queueRoute,
      .recentOrdersObserver => AppRoutes.recentOrdersRoute,
    },
  );
}

/// Shews non-moderators away from the printers editing view.
class NonModeratorsAwayFromPrinters extends Redirector {
  /// {@macro NonModeratorsAwayFromPrinters}
  const NonModeratorsAwayFromPrinters();
  @override
  bool predicate(
    RouteState routeState,
    AuthState authState,
  ) =>
      routeState.path == AppRoutes.moderatorPrintersRoute.path &&
      authState.role != .moderator;

  @override
  RouteState getNewRouteState(
    RouteState routeState,
    AuthState authState,
  ) => RouteState.fromRoute(
    switch (authState.role) {
      null => AppRoutes.loginRoute,
      .barista => AppRoutes.baristaHomeRoute,
      .moderator => throw Exception(
        'Programmatic error in redirection system. Moderator user should not '
        'have passed predicate for NonModeratorObserverAwayFromPrinters',
      ),
      .kiosk => AppRoutes.kioskHomeRoute,
      .queueObserver => AppRoutes.queueRoute,
      .recentOrdersObserver => AppRoutes.recentOrdersRoute,
    },
  );
}
