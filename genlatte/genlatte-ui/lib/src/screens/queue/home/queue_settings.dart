// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:genlatte/src/data/shared_preferences_repository.dart';
import 'package:logging/logging.dart';

part 'queue_settings.freezed.dart';
part 'queue_settings.g.dart';

@Freezed()
sealed class QueueSettingsState with _$QueueSettingsState {
  /// {@macro QueueSettings}
  const factory QueueSettingsState({
    /// If set to `true`, this screen will only show the first page and will
    /// never paginate.
    ///
    /// If set to `false`, this screen works normally except it ignores
    /// the first [topOrdersCount] of orders.
    @Default(false) bool isTopScreen,

    /// Asks the screen to ignore the first N orders (because, presumably,
    /// they are shown on the top screen (see [isTopScreen]).
    @Default(0) int topOrdersCount,

    /// The shard number of this device.
    @Default(1) int shardNumber,

    /// The total number of shards in play.
    @Default(1) int shardTotal,

    /// The maximum age of a completed order, after which the order will not
    /// be shown anymore.
    @Default(Duration(minutes: 15)) Duration maxShowAge,

    /// The duration for which an order is considered "recent". The UI may
    /// choose to highlight such orders.
    @Default(Duration(minutes: 5)) Duration maxRecentAge,

    /// The duration between updates of the UI.
    @Default(Duration(seconds: 5)) Duration pageUpdatePeriod,

    /// A scaling factor for order rows. Can be customized in order to achieve
    /// more or less dense displays (for example, when the display is farther
    /// away from the customers than expected).
    @Default(100) double targetRowHeight,
  }) = _QueueSettingsState;

  factory QueueSettingsState.fromJson(Map<String, Object?> json) =>
      _$QueueSettingsStateFromJson(json);

  const QueueSettingsState._();

  static final Logger _logger = Logger('$QueueSettingsState');

  static const String sharedPrefsKey = 'queue_settings';

  static QueueSettingsState load(SharedPreferencesRepository repo) {
    final jsonString = repo.getString(sharedPrefsKey);
    if (jsonString != null) {
      try {
        return QueueSettingsState.fromJson(
          jsonDecode(jsonString) as Map<String, dynamic>,
        );
      } catch (e, s) {
        _logger.warning('Failed to load settings', e, s);
      }
    }
    return const QueueSettingsState();
  }
}
