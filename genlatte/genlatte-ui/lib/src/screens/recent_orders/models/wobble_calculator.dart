// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte/src/core/utils/utils.dart';

/// Calculates the strength of a wobble at a given time.
class WobbleCalculator {
  /// Creates a new [WobbleCalculator].
  const WobbleCalculator({
    required this.wobblesPerContact,
  });

  /// Number of phases of wobble to animate through during contact.
  ///
  /// A value of 1 should result in the circle squishing once and then
  /// returning to normal. A value of 2 should result in the circle squishing
  /// in the initial direction, swinging back into a perpendicular squish of
  /// reduced amplitude, then resetting to normal. A value of 3 should result
  /// in an initial squish, perpendicular squish at a reduced amplitude, then
  /// original squish again at yet another reduced amplitude, before settling
  /// back to normal.
  ///
  /// Etc etc.
  final int wobblesPerContact;

  /// Calculates the strength of a wobble at a given time.
  Wobble getWobble(double t) {
    final phase = t.phaseWithinRange(wobblesPerContact, 1);
    final progressThroughPhase = t.progressThroughPhase(
      wobblesPerContact,
      1,
      phase: phase,
    );

    // Each slot should imply a dampening of the strength.
    final dampener = 1 - (phase / (wobblesPerContact + 1));

    late double strength;
    // Odd slots are moving in the direction of the squish and so move from
    // strength 0 to 1 for the first 50%, then back from 1 to 0.
    if (progressThroughPhase < 0.5) {
      strength = progressThroughPhase * 2 * dampener;
    } else {
      strength = (1 - progressThroughPhase) * 2 * dampener;
    }

    return Wobble(
      strength: strength,
      isPerpendicular: phase.isEven,
    );
  }
}

/// Defines the direction and strength the wobble of a widget's squish effect
/// after colliding with another object.
class Wobble {
  /// Creates a new [Wobble].
  Wobble({
    required this.strength,
    required this.isPerpendicular,
  });

  /// The strength of the wobble, ranging from 0 to 1.
  final double strength;

  /// Whether the wobble is perpendicular to the initial squish.
  final bool isPerpendicular;

  @override
  String toString() =>
      'Wobble(strength: $strength: '
      'isPerpendicular: $isPerpendicular)';
}
