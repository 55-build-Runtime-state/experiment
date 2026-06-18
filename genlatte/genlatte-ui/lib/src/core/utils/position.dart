// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// A class that represents the position of a widget in a 2D space.
class Position {
  /// Creates a new [Position] instance.
  const Position({
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.width,
    this.height,
    this.rotation,
    this.transform,
    this.transformAlignment,
  });

  /// The distance from the top of the parent widget to the top of this widget.
  final double? top;

  /// The distance from the bottom of the parent widget to the bottom of this
  /// widget.
  final double? bottom;

  /// The distance from the left of the parent widget to the left of this
  /// widget.
  final double? left;

  /// The distance from the right of the parent widget to the right of this
  /// widget.
  final double? right;

  /// The width of this widget.
  final double? width;

  /// The height of this widget.
  final double? height;

  /// The rotation of this widget.
  final double? rotation;

  /// The transform of this widget.
  final Matrix4? transform;

  /// The alignment of the transform.
  final Alignment? transformAlignment;

  /// Creates a new [Position] instance with the same values as this instance,
  /// but with the given values replaced.
  Position copyWith({
    double? top,
    double? bottom,
    double? left,
    double? right,
    double? width,
    double? height,
    double? rotation,
    Matrix4? transform,
    Alignment? transformAlignment,
  }) => Position(
    top: top ?? this.top,
    bottom: bottom ?? this.bottom,
    left: left ?? this.left,
    right: right ?? this.right,
    width: width ?? this.width,
    height: height ?? this.height,
    rotation: rotation ?? this.rotation,
    transform: transform ?? this.transform,
    transformAlignment: transformAlignment ?? this.transformAlignment,
  );

  /// Creates a new [Position] instance shifted in the various directions.
  Position shift({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) => Position(
    top: top != null ? (this.top ?? 0) + top : this.top,
    bottom: bottom != null ? (this.bottom ?? 0) + bottom : this.bottom,
    left: left != null ? (this.left ?? 0) + left : this.left,
    right: right != null ? (this.right ?? 0) + right : this.right,
    width: width,
    height: height,
    rotation: rotation,
    transform: transform,
    transformAlignment: transformAlignment,
  );

  /// Converts this [Position] to an [AnimatedPositioned] widget.
  AnimatedPositioned toAnimatedWidget({
    required Widget child,
    Key? key,
    Curve? curve,
    Duration? duration,
  }) {
    // ignore: no_leading_underscores_for_local_identifiers
    Widget _child = child;
    if (rotation != null) {
      _child = Transform.rotate(
        angle: rotation!,
        child: _child,
      );
    }
    return AnimatedPositioned(
      duration: duration ?? const Duration(milliseconds: 100),
      curve: curve ?? Curves.easeOut,
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      width: width,
      height: height,
      key: key,
      child: child,
    );
  }

  /// Converts this [Position] to a [Positioned] widget.
  Positioned toWidget({required Widget child, Key? key}) {
    // ignore: no_leading_underscores_for_local_identifiers
    Widget _child = child;
    if (transform != null) {
      _child = Transform(
        transform: transform!,
        alignment: transformAlignment ?? Alignment.topLeft,
        child: _child,
      );
    }
    if (rotation != null) {
      _child = Transform.rotate(
        angle: rotation!,
        child: _child,
      );
    }
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      width: width,
      height: height,
      key: key,
      child: _child,
    );
  }

  /// Converts this [Position] to a [BoxConstraints] widget.
  BoxConstraints toBoxConstraints() => BoxConstraints.tightFor(
    height: height,
    width: width,
  );

  /// Converts this [Position] to an [Offset] widget.
  Offset toOffset() => Offset(
    height != null ? -height! : 0,
    width != null ? width! : 0,
  );

  @override
  String toString() =>
      'Position(left: $left, top: $top, right: $right, bottom: $bottom, '
      'width: $width, height: $height, rotation: $rotation, transform: '
      '$transform, transformAlignment: $transformAlignment)';
}
