// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/animation.dart' show Curves;
import 'package:flutter/widgets.dart' show Offset, Size;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'latte_position.freezed.dart';

/// A latte position represented entirely in absolute pixel coordinates.
@freezed
abstract class AbsoluteLattePosition with _$AbsoluteLattePosition {
  /// Creates a new [AbsoluteLattePosition].
  const factory AbsoluteLattePosition({
    /// Unique identifier to track collision pairs.
    required String id,

    /// The center of the latte image.
    required Offset center,

    /// The angle of this Latte's movement in radians.
    required double direction,

    /// The radius of the latte image as a percentage of the most constraine
    /// dimension of the available space. A value of 1.0 would indicate a latte
    /// that fills the entire available space.
    required double radius,

    /// The angle of the squish effect.
    required double? squishAngle,

    /// The speed of this latte's movement.
    required double speed,

    /// The last time this latte was involved in a collision.
    DateTime? lastCollisionAt,

    /// The ID of the last object this collided with.
    String? lastCollidedWith,
  }) = _AbsoluteLattePosition;

  const AbsoluteLattePosition._();

  /// The mass of this latte, used for physics calculations.
  double get mass => radius * radius;

  /// Flattens an [AbsoluteLattePosition] into a relative values format, using
  /// the current screen dimensions for this frame.
  LattePosition toRelative(Size layoutSize) {
    final relCx = center.dx / layoutSize.width;
    final relCy = center.dy / layoutSize.height;

    final vx = speed * cos(direction);
    final vy = speed * sin(direction);

    final relVx = vx / layoutSize.width;
    final relVy = vy / layoutSize.height;
    final relSpeed = sqrt(relVx * relVx + relVy * relVy);
    final relDir = atan2(relVy, relVx);

    return LattePosition(
      id: id,
      center: Offset(relCx, relCy),
      radius: radius / layoutSize.shortestSide,
      direction: relDir,
      rawSpeed: relSpeed,
      squishAngle: squishAngle,
      lastCollisionAt: lastCollisionAt,
      lastCollidedWith: lastCollidedWith,
    );
  }
}

/// Represents the position of a latte image on the screen.
@freezed
abstract class LattePosition with _$LattePosition {
  /// Creates a new [LattePosition].
  const factory LattePosition({
    /// Unique identifier to track collision pairs.
    required String id,

    /// The center of the latte image.
    required Offset center,

    /// The angle of this Latte's movement in radians.
    required double direction,

    /// Size of the latte image as a percentage of the most constrained
    /// dimension of the available space. A value of 1.0 would indicate a latte.
    required double radius,

    /// The angle of the squish effect.
    required double? squishAngle,

    /// The raw speed as calculated off of the last collision. If this is
    /// greater than [defaultSpeed], then friction will slow the latte down
    /// until it returns to [defaultSpeed]
    @Default(LattePosition.defaultSpeed) double rawSpeed,

    /// The last time this latte was involved in a collision. This is used to
    /// calculate friction to slow down a circle's velocity.
    DateTime? lastCollisionAt,

    /// The ID of the last object this collided with to prevent rapid duplicate
    /// collisions.
    String? lastCollidedWith,
  }) = _LattePosition;

  const LattePosition._();

  //  : rawSpeed = speed,
  //      mass = ;

  /// The speed at which each ball wants to move.
  static const defaultSpeed = 0.0002;

  /// Mass of the latte image, used for physics calculations.
  double get mass => radius * radius;

  static const Duration _decelerationDuration = Duration(seconds: 3);

  /// The speed of this Latte's movement.
  double get speed {
    if (rawSpeed <= defaultSpeed) {
      return rawSpeed;
    }

    final timeSinceLastCollision = lastCollisionAt == null
        ? Duration.zero
        : DateTime.now().difference(lastCollisionAt!);

    if (lastCollisionAt == null ||
        timeSinceLastCollision >= _decelerationDuration) {
      return rawSpeed;
    }
    return defaultSpeed +
        ((rawSpeed - defaultSpeed) *
            Curves.easeOut.transform(
              timeSinceLastCollision.inMicroseconds /
                  _decelerationDuration.inMicroseconds,
            ));
  }

  /// Converts a [LattePosition] into a format of absolute pixel values, using
  /// the current screen dimensions for this frame.
  AbsoluteLattePosition toAbsolute(Size layoutSize) {
    final absRadius = radius * layoutSize.shortestSide;

    final vx = speed * cos(direction) * layoutSize.width;
    final vy = speed * sin(direction) * layoutSize.height;

    final absSpeed = sqrt(vx * vx + vy * vy);
    final absDir = atan2(vy, vx);

    return AbsoluteLattePosition(
      id: id,
      center: Offset(
        center.dx * layoutSize.width,
        center.dy * layoutSize.height,
      ),
      direction: absDir,
      radius: absRadius,
      squishAngle: squishAngle,
      speed: absSpeed,
      lastCollisionAt: lastCollisionAt,
      lastCollidedWith: lastCollidedWith,
    );
  }
}

/// Two circles that have collided.
class Collision {
  /// Creates a new [Collision].
  Collision(this.c1, this.c2);

  /// The first circle.
  final AbsoluteLattePosition c1;

  /// The second circle.
  final AbsoluteLattePosition c2;

  /// Resolve this collision.
  CollisionResult resolve() {
    // 1. Calculate the normal vector (line connecting centers in pixel space)
    final dx = c2.center.dx - c1.center.dx;
    final dy = c2.center.dy - c1.center.dy;

    // Calculate the angles of the normal line
    final c1SquishAngle = atan2(dy, dx);
    final c2SquishAngle = atan2(-dy, -dx); // Exact opposite direction

    final distance = sqrt(dx * dx + dy * dy);

    // Prevent division by zero if centers perfectly overlap
    if (distance == 0) {
      return CollisionResult(
        c1.speed,
        c1.direction,
        c2.speed,
        c2.direction,
        SquishData(c1SquishAngle, 0),
        SquishData(c2SquishAngle, 0),
      );
    }

    // Unit normal vector
    final nx = dx / distance;
    final ny = dy / distance;

    // Unit tangent vector (perpendicular to normal)
    final tx = -ny;
    final ty = nx;

    // 2. Convert speed and direction to purely Pixel velocity vectors
    final c1Vx = c1.speed * cos(c1.direction);
    final c1Vy = c1.speed * sin(c1.direction);
    final c2Vx = c2.speed * cos(c2.direction);
    final c2Vy = c2.speed * sin(c2.direction);

    // 3. Project velocities onto normal and tangent vectors (Dot Product)
    final c1Vn = c1Vx * nx + c1Vy * ny;
    final c1Vt = c1Vx * tx + c1Vy * ty;
    final c2Vn = c2Vx * nx + c2Vy * ny;
    final c2Vt = c2Vx * tx + c2Vy * ty;

    final relativeNormalVelocity = c1Vn - c2Vn;
    final impactForce = relativeNormalVelocity.abs();

    final c1Squish = SquishData(c1SquishAngle, impactForce);
    final c2Squish = SquishData(c2SquishAngle, impactForce);

    // 4. Resolve the 1D collision along the normal vector
    final m1 = c1.mass;
    final m2 = c2.mass;

    final c1VnAfter = (c1Vn * (m1 - m2) + 2 * m2 * c2Vn) / (m1 + m2);
    final c2VnAfter = (c2Vn * (m2 - m1) + 2 * m1 * c1Vn) / (m1 + m2);

    // Tangential velocities do not change (c1_vt_after = c1_vt)

    // 5. Convert the scalar normal and tangential velocities back into Pixel
    // vectors.
    // Vector = (Normal_Scalar * Normal_Vector) + (Tangent_Scalar *
    // Tangent_Vector)
    final c1VxAfter = (c1VnAfter * nx) + (c1Vt * tx);
    final c1VyAfter = (c1VnAfter * ny) + (c1Vt * ty);

    final c2VxAfter = (c2VnAfter * nx) + (c2Vt * tx);
    final c2VyAfter = (c2VnAfter * ny) + (c2Vt * ty);

    // 6. Convert Pixel X/Y back to Speed and Direction (Polar)
    final c1SpeedAfter = sqrt(c1VxAfter * c1VxAfter + c1VyAfter * c1VyAfter);
    final c1DirAfter = atan2(c1VyAfter, c1VxAfter);

    final c2SpeedAfter = sqrt(c2VxAfter * c2VxAfter + c2VyAfter * c2VyAfter);
    final c2DirAfter = atan2(c2VyAfter, c2VxAfter);

    return CollisionResult(
      c1SpeedAfter,
      c1DirAfter,
      c2SpeedAfter,
      c2DirAfter,
      c1Squish,
      c2Squish,
    );
  }
}

/// The result of a collision.
class CollisionResult {
  /// Creates a new [CollisionResult].
  CollisionResult(
    this.latte1Speed,
    this.latte1Direction,
    this.latte2Speed,
    this.latte2Direction,
    this.latte1Squish,
    this.latte2Squish,
  );

  /// The speed of the first circle.
  final double latte1Speed;

  /// The direction of the first circle in radians.
  final double latte1Direction;

  /// The speed of the second circle.
  final double latte2Speed;

  /// The direction of the second circle in radians.
  final double latte2Direction;

  /// The squish data for the first circle.
  final SquishData latte1Squish;

  /// The squish data for the second circle.
  final SquishData latte2Squish;
}

/// Holds the data for a squish effect.
class SquishData {
  /// Creates a new [SquishData].
  SquishData(this.direction, this.intensity);

  /// The direction of the squish effect in radians.
  final double direction;

  /// The intensity of the squish effect, representing the force of impact.
  final double intensity;
}

/// Extension to add copyWith to Offset.
extension CopyableOffset on Offset {
  /// Creates a copy of this [Offset].
  Offset copyWith({
    double? dx,
    double? dy,
  }) {
    return Offset(dx ?? this.dx, dy ?? this.dy);
  }
}
