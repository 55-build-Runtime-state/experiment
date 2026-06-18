// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// @docImport 'package:genlatte/src/core/routing/router.dart';
library;

/// Roles that users can have in the app. The given role determines which
/// [AppRouter] is instantiated which in turn completely determines what app
/// experience is provided to the user.
enum Role {
  /// Users who manage the queue and approve / reject user submissions.
  barista,

  /// Users who can approve / reject user submissions.
  moderator,

  /// Users who just need some caffeine.
  kiosk,

  /// Read-only "users" who display the queue of upcoming and in-progress drinks
  queueObserver,

  /// Read-only "users" who show floating bubbles of recent drinks for selfies
  /// and other hi-jinks.
  recentOrdersObserver;

  /// True if this role is [.barista].
  bool get isBarista => this == .barista;

  /// True if this role is [.moderator].
  bool get isModerator => this == .moderator;

  /// True if this role is [.kiosk].
  bool get isKiosk => this == .kiosk;

  /// True if this role is [.queueObserver].
  bool get isQueueObserver => this == .queueObserver;

  /// True if this role is [.recentOrdersObserver].
  bool get isRecentOrdersObserver => this == .recentOrdersObserver;
}
