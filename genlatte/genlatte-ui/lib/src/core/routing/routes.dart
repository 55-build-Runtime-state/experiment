// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte/src/role.dart';
import 'package:genlatte/src/screens/barista/barista.dart';
import 'package:genlatte/src/screens/kiosk/kiosk.dart';
import 'package:genlatte/src/screens/login/login.dart';
import 'package:genlatte/src/screens/moderator/moderator.dart';
import 'package:genlatte/src/screens/queue/queue.dart';
import 'package:genlatte/src/screens/recent_orders/recent_orders.dart';
import 'package:go_router/go_router.dart';

/// {@template AppRoutes}
/// Container for all possible routes. One version of this must exist per user
/// [Role].
/// {@endtemplate}
class AppRoutes {
  /// Login route.
  static final loginRoute = GoRoute(
    path: '/login',
    name: 'login',
    builder: (context, state) => const LoginScreen(),
  );

  /// Barista home route.
  static final baristaHomeRoute = GoRoute(
    path: '/barista',
    name: 'baristaHome',
    builder: (context, state) => const BaristaHomeScreen(),
  );

  /// Moderator subscreen to manage printers.
  static final moderatorPrintersRoute = GoRoute(
    path: '/machines',
    name: 'machines',
    builder: (context, state) => const MachinesScreen(),
  );

  /// Moderator subscreen to manage options.
  static final moderatorOptionsRoute = GoRoute(
    path: '/options',
    name: 'options',
    builder: (context, state) => const OptionsScreen(),
  );

  /// Moderator home route.
  static final moderatorHomeRoute = GoRoute(
    path: '/moderator',
    name: 'moderatorHome',
    builder: (context, state) => const ModeratorHomeScreen(),
    routes: [
      moderatorPrintersRoute,
      moderatorOptionsRoute,
    ],
  );

  /// Kiosk home route.
  static final kioskHomeRoute = GoRoute(
    path: '/kiosk',
    name: 'kioskHome',
    builder: (context, state) => const KioskHomeScreen(),
  );

  /// Queue home route.
  static final queueRoute = GoRoute(
    path: '/queue',
    name: 'queue',
    builder: (context, state) => const QueueHomeScreen(),
  );

  /// Recent orders home route.
  static final recentOrdersRoute = GoRoute(
    path: '/recentOrders',
    name: 'recentOrders',
    builder: (context, state) => const RecentOrdersHomeScreen(),
  );

  /// Starting route passed to [GoRouter].
  static final GoRoute initialRoute = loginRoute;

  /// All available routes.
  static final List<GoRoute> routes = [
    loginRoute,
    baristaHomeRoute,
    moderatorHomeRoute,
    kioskHomeRoute,
    queueRoute,
    recentOrdersRoute,
  ];
}
