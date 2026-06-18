// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/animation.dart';

/// Fancy double extensions.
extension FancyDouble on double {
  /// Rounds this double to the given number of decimal places.
  ///
  /// Maybe there's a better way to do this, but if so, I haven't found it.
  double roundTo(int decimalPlaces) =>
      double.parse(toStringAsFixed(decimalPlaces));

  /// Divides [range] into a fixed number of [phases] and returns which phase
  /// this double fits into.
  ///
  /// For usage, see `extensions_test.dart`.
  /// Companion method to [progressThroughPhase].
  int phaseWithinRange(
    int phases,
    double range, {
    double? spacePerPhase,
    Curve curve = Curves.linear,
  }) {
    // Subtract 1 from `phases` because it is an `arr.length` situation,
    // but we are returning an index.
    if (this >= range) return phases - 1;
    spacePerPhase ??= range / phases;
    return (this / spacePerPhase).toInt();
  }

  /// Returns this double's progress through its given phase within a range.
  ///
  /// Usage:
  /// ```dart
  ///  0.05.progressThroughPhase(10, 1) => 0.5
  ///  0.1.progressThroughPhase(10, 1) => 1.0
  ///  0.15.progressThroughPhase(10, 1) => 0.5
  ///  0.16.progressThroughPhase(10, 1) => 0.6
  ///  0.26.progressThroughPhase(10, 1) => 0.6
  /// ```
  ///
  /// Companion method to [phaseWithinRange].
  ///
  /// If [phase] is provided, it will be used instead of calling
  /// [phaseWithinRange]. Use this when your calling code also needed to know
  /// the specific phase number and so already called [phaseWithinRange].
  double progressThroughPhase(
    int phases,
    double range, {
    int? phase,
    Curve curve = Curves.linear,
  }) {
    final spacePerPhase = range / phases;
    final calculatedPhase =
        phase ??
        phaseWithinRange(
          phases,
          range,
          spacePerPhase: spacePerPhase,
        );
    return curve.transform(
      ((this - (spacePerPhase * calculatedPhase)) / spacePerPhase).clamp(0, 1),
    );
  }
}
