// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/widgets.dart';

/// Responsive layout information about the available space. Primarily derived
/// from [BoxConstraints].
class LayoutInformation {
  /// Instantiates a [LayoutInformation].
  const LayoutInformation._(this.constraints);

  /// Builds a [LayoutInformation] from the given [BoxConstraints].
  factory LayoutInformation.fromBoxConstraints(BoxConstraints constraints) =>
      LayoutInformation._(constraints);

  /// The constraints of the available space.
  final BoxConstraints constraints;

  /// Horizontal pixels of the available space.
  double get width => constraints.maxWidth;

  /// Vertical pixels of the available space.
  double get height => constraints.maxHeight;

  /// The smaller of the width and height.
  double get constrainingDimension => min(width, height);

  /// The larger of the width and height.
  double get unconstrainingDimension => max(width, height);

  /// The size of the available space.
  Size get size => Size(width, height);

  /// The aspect ratio of the available space.
  double get aspectRatio => width / height;

  /// Returns the most constraining scale for a given ideal size.
  double constrainedScale(Size idealSize) => min(
    width / idealSize.width,
    height / idealSize.height,
  );

  /// Returns the least constraining scale for a given ideal size.
  double unconstrainedScale(Size idealSize) => max(
    width / idealSize.width,
    height / idealSize.height,
  );

  /// Aspect ratio category of this layout.
  LayoutOrientation get orientation => width == height
      ? .square
      : width > height
      ? .landscape
      : .portrait;
}

/// The orientation of a Cartesian object.
enum LayoutOrientation {
  /// Taller than wide.
  portrait(),

  /// Wider than tall.
  landscape,

  /// Same height and width.
  square;

  /// True if this orientation is landscape.
  bool get isLandscape => this == .landscape;

  /// True if this orientation is portrait.
  bool get isPortrait => this == .portrait;

  /// True if this orientation is square.
  bool get isSquare => this == .square;

  /// Returns the desired Flex [Axis] for this orientation. e.g., if we are in a
  /// landscape orientation, we want to lay out our children horizontally.
  Axis get axis => this == .landscape ? .horizontal : .vertical;
}

/// {@template AcceptableAspectRatios}
/// Range of allowed aspect ratios.
///
/// $1 is optional and represents the lowest (tallest) acceptable aspect ratio.
/// $2 is the ideal aspect ratio which will be selected if possible.
/// $3 is optional and represents the highest (widest) acceptable aspect ratio.
/// {@endtemplate}
typedef AcceptableAspectRatios = (double?, double?, double?);

/// A widget that sizes itself based on the available space and the
/// range of acceptable aspect ratios.
class ResponsiveSizedBox extends StatelessWidget {
  /// Instantiates a [ResponsiveSizedBox].
  factory ResponsiveSizedBox({
    required AcceptableAspectRatios aspectRatioClamp,
    required Widget child,
    Alignment? alignment = .center,
    Size? maxSize,
    Key? key,
  }) => ResponsiveSizedBox._(
    alignment: alignment,
    aspectRatioClamp: aspectRatioClamp,
    maxSize: maxSize,
    key: key,
    child: child,
  );

  /// Builder pattern for [ResponsiveSizedBox].
  factory ResponsiveSizedBox.builder({
    required AcceptableAspectRatios aspectRatioClamp,
    required Widget Function(BuildContext, Size) builder,
    Alignment? alignment = .center,
    Size? maxSize,
    Key? key,
  }) => ResponsiveSizedBox._(
    alignment: alignment,
    aspectRatioClamp: aspectRatioClamp,
    builder: builder,
    maxSize: maxSize,
    key: key,
  );

  /// Generative constructor for [ResponsiveSizedBox].
  const ResponsiveSizedBox._({
    required this.aspectRatioClamp,
    required this.alignment,
    this.builder,
    this.maxSize,
    this.child,
    super.key,
  }) : assert(
         child != null || builder != null,
         'Provide either child or builder',
       );

  /// {@macro AcceptableAspectRatios}
  final AcceptableAspectRatios aspectRatioClamp;

  /// The alignment of the child within the available space.
  final Alignment? alignment;

  /// Optional maximum size for the widget.
  final Size? maxSize;

  /// Descendant widget to scale responsively. Provide this or [builder].
  final Widget? child;

  /// Builder function that receives the optimal size and returns the widget to
  /// display. Provide this or [child].
  final Widget Function(BuildContext, Size)? builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scalar = AspectRatioScalar(
          aspectRatioClamp,
          constraints: constraints,
          maxSize: maxSize,
        );

        Widget result = child ?? builder!(context, scalar.optimalSize);

        result = SizedBox.fromSize(
          size: scalar.optimalSize,
          child: result,
        );

        if (alignment != null) {
          result = Align(
            alignment: alignment!,
            child: result,
          );
        }
        return result;
      },
    );
  }
}

/// Provides sizing information based on available dimensions and aspect ratios.
///
/// Usage:
/// ```dart
///
/// // Tallest allowed
/// double minAcceptableAspectRatio = 0.5;
/// // Ideal
/// double idealAspectRatio = 0.75;
/// // Widest allowed
/// double maxAcceptableAspectRatio = 1;
///
/// final scalar = AspectRatioScalar(
///   (minAcceptableAspectRatio, idealAspectRatio, maxAcceptableAspectRatio),
///   constraints: constraints,
///   maxSize: const Size(defaultWidth, defaultHeight),
/// );
///
/// final scaledSize = scalar.optimalSize;
/// final scaledHeight = scalar.scaleHeight(100);
/// final scaledWidth = scalar.scaleWidth(100);
/// ```
class AspectRatioScalar {
  /// Instantiates an [AspectRatioScalar].
  AspectRatioScalar(
    this.aspectRatioClamp, {
    required this.constraints,
    this.maxSize,
  }) : assert(() {
         if (aspectRatioClamp.$1 != null &&
             aspectRatioClamp.$2 != null &&
             aspectRatioClamp.$1! >= aspectRatioClamp.$2!) {
           throw AssertionError(
             'aspectRatioClamp min must be less than ideal. '
             '${aspectRatioClamp.$1} >= ${aspectRatioClamp.$2}',
           );
         }
         if (aspectRatioClamp.$1 != null &&
             aspectRatioClamp.$3 != null &&
             aspectRatioClamp.$1! >= aspectRatioClamp.$3!) {
           throw AssertionError(
             'aspectRatioClamp min must be less than max. '
             '${aspectRatioClamp.$1} >= ${aspectRatioClamp.$3}',
           );
         }
         if (aspectRatioClamp.$2 != null &&
             aspectRatioClamp.$3 != null &&
             aspectRatioClamp.$2! >= aspectRatioClamp.$3!) {
           throw AssertionError(
             'aspectRatioClamp ideal must be less than max. '
             '${aspectRatioClamp.$2} >= ${aspectRatioClamp.$3}',
           );
         }
         return true;
       }(), 'Invalid aspectRatioClamp');

  /// {@macro AcceptableAspectRatios}
  final AcceptableAspectRatios aspectRatioClamp;

  /// The actual constraints of the widget, probably provided by a
  /// LayoutBuilder.
  final BoxConstraints constraints;

  /// The maximum size of the widget.
  final Size? maxSize;

  /// Runtime aspect ratio of the actually available space.
  double get constraintsAspectRatio =>
      constraints.maxWidth / constraints.maxHeight;

  /// The given aspect ratio clamped to the allowed range.
  double get optimalAspectRatio =>
      constraintsAspectRatio.clamp(minAspectRatio, maxAspectRatio);

  Size? _optimalSize;

  /// Returns the optimal [Size] for the desired aspect ratio and runtime
  /// [BoxConstraints].
  Size get optimalSize {
    if (_optimalSize == null) {
      if (optimalAspectRatio > constraintsAspectRatio) {
        // Optimal size is wider than available space; width is the constraint
        _optimalSize = Size(
          constraints.maxWidth,
          constraints.maxWidth / optimalAspectRatio,
        );
      } else {
        // Available space is wider than the optimal aspect ratio; height is
        // the constraint
        _optimalSize = Size(
          constraints.maxHeight * optimalAspectRatio,
          constraints.maxHeight,
        );
      }

      if (maxSize != null) {
        // Find the scale required to fit inside maxSize without changing the
        // aspect ratio. We only scale down (scale < 1.0).
        final scaleX = maxSize!.width / _optimalSize!.width;
        final scaleY = maxSize!.height / _optimalSize!.height;
        final double minScale = min(1, min(scaleX, scaleY));

        _optimalSize = _optimalSize! * minScale;
      }
    }
    assert(() {
      if (!_lte(_optimalSize!.height, constraints.maxHeight)) {
        throw AssertionError(
          'Calculated scaledSize height exceeded constraints. '
          '${_optimalSize!.height} > ${constraints.maxHeight}',
        );
      }
      if (!_lte(_optimalSize!.width, constraints.maxWidth)) {
        throw AssertionError(
          'Calculated scaledSize width exceeded constraints. '
          ' ${_optimalSize!.width} > ${constraints.maxWidth}',
        );
      }
      if (maxSize != null) {
        if (!_lte(_optimalSize!.height, maxSize!.height)) {
          throw AssertionError(
            'Calculated scaledSize height exceeded maxSize. '
            '${_optimalSize!.height} > ${maxSize!.height}',
          );
        }
        if (!_lte(_optimalSize!.width, maxSize!.width)) {
          throw AssertionError(
            'Calculated scaledSize width exceeded maxSize. '
            '${_optimalSize!.width} > ${maxSize!.width}',
          );
        }
      }
      return true;
    }(), 'Invalid optimalSize');
    return _optimalSize!;
  }

  /// Scales a given height value.
  double scaleHeight(double designHeight) => optimalSize.height / designHeight;

  /// Scales a given width value.
  double scaleWidth(double designWidth) => optimalSize.width / designWidth;

  /// Scales a given size value against the most constraining of the two
  /// dimensions.
  double scale(Size size) =>
      min(scaleWidth(size.width), scaleHeight(size.height));

  /// The axis that should be used for sizing. If provided by the constructor,
  /// then that axis will be used. Otherwise, the axis will be determined by
  /// which dimension is closer to its ideal size.
  ///
  /// When the [constraintsOrientation] is [LayoutOrientation.portrait], then
  /// width is the most constrained, which means all sizes are scaled based on
  /// the ratio of available width to ideal width.
  LayoutOrientation get constraintsOrientation =>
      _constraintsOrientation ??= constraintsAspectRatio.orientation;

  LayoutOrientation? _constraintsOrientation;

  /// The lowest allowed aspect ratio below which values must be clamped on the
  /// most constraining dimension, which is width.
  double get minAspectRatio => aspectRatioClamp.$1 ?? idealAspectRatio;

  /// The ideal aspect ratio, which is used to calculate the ideal height and
  /// width.
  double get idealAspectRatio => aspectRatioClamp.$2 ?? constraintsAspectRatio;

  /// The highest allowed aspect ratio above which values must be clamped on the
  /// most constraining dimension, which is height.
  double get maxAspectRatio => aspectRatioClamp.$3 ?? idealAspectRatio;
}

extension on double {
  /// Returns the orientation of the aspect ratio.
  LayoutOrientation get orientation {
    return switch (this) {
      < 1 => .portrait,
      > 1 => .landscape,
      == 1 => .square,
      _ => throw UnimplementedError('This is impossible'),
    };
  }
}

/// Returns true if [lower] is less than or equal to [higher] with [delta]
/// tolerance for floating point inaccuracies.
bool _lte(double lower, double higher, [double delta = 0.001]) {
  return (higher > lower) || (higher - lower) <= delta;
}
