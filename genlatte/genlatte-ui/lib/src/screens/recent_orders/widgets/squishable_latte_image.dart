// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math';
import 'package:genlatte/src/screens/recent_orders/models/models.dart';
import 'package:genlatte/src/screens/recent_orders/widgets/widgets.dart';
import 'package:genlatte/src/widgets/latte_image.dart' show LatteImageWidget;
import 'package:genlatte_data/models.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A widget that displays a latte image that floats around the screen.
class SquishableLatteImage extends StatefulWidget {
  /// Instantiates a [SquishableLatteImage].
  const SquishableLatteImage({
    required this.image,
    required this.lattePosition,
    this.paddingPercentage = 1,
    this.wobblesPerContact = 6,
    this.contactDuration = const Duration(milliseconds: 2000),
    this.dampener = 0.3,
    super.key,
  });

  /// The image to display.
  final RecentLatteImage image;

  /// The position, size, direction, and speed of the latte image in pixels.
  final AbsoluteLattePosition lattePosition;

  /// Number of phases of wobble to animate through during contact.
  ///
  /// A value of 1 should result in the circle squishing once and then
  /// returning to normal. A value of 2 should result in the circle squishing
  /// in the initial direction, swinging back into a perpendicular squish of
  /// reduced amplitude, then resetting to normal. A value of 3 should result
  /// in an initial squish, perpendicular squish at a reduced amplitude, then
  /// original squish again at yet further reduced amplitude, before settling
  /// back to normal.
  ///
  /// Etc etc.
  final int wobblesPerContact;

  /// Percentage of default latte padding to be used, as represented via a
  /// normalized double.
  ///
  /// A value of 1 is full padding to support the wobble animation, whereas a
  /// value of 0 is zero padding, which will increase the rendered size of the
  /// image.
  final double paddingPercentage;

  /// The duration of the wobble animation.
  final Duration contactDuration;

  /// Overall reduction of the wobble amplitude. Should be between 0 and 1.
  final double dampener;

  @override
  State<SquishableLatteImage> createState() => _SquishableLatteImageState();
}

class _SquishableLatteImageState extends State<SquishableLatteImage>
    with TickerProviderStateMixin {
  late final AnimationController _wobbleController;

  /// Vector of impact which is applying a squish to the image.
  double? _squishAngle;

  late final WobbleCalculator _wobbleCalculator;

  @override
  void initState() {
    super.initState();

    _wobbleController =
        AnimationController(
            vsync: this,
            duration: widget.contactDuration,
          )
          ..addListener(() {
            if (!mounted) return;
            setState(() {});
          })
          ..addStatusListener((status) {
            if (!mounted) return;
            if (status == AnimationStatus.completed) {
              setState(() {
                _squishAngle = null;
              });
            }
          });

    _wobbleCalculator = WobbleCalculator(
      wobblesPerContact: widget.wobblesPerContact,
    );
  }

  @override
  void didUpdateWidget(covariant SquishableLatteImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.lattePosition.lastCollisionAt !=
        oldWidget.lattePosition.lastCollisionAt) {
      _squishAngle = widget.lattePosition.squishAngle;
      if (_squishAngle != null) {
        _startWobbleAnimation();
      }
    }
  }

  @override
  void dispose() {
    _wobbleController.dispose();
    super.dispose();
  }

  void _startWobbleAnimation() {
    _wobbleController
      ..duration = widget.contactDuration
      ..forward(from: 0).ignore();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = SizedBox(
      width: widget.lattePosition.radius * 3,
      height: widget.lattePosition.radius * 3,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.all(
              widget.lattePosition.radius * 0.5 * widget.paddingPercentage,
            ),
            child: LatteImageWidget(
              imageUrl: widget.image.imageUrl,
            ),
          ),
        ],
      ),
    );

    if (_squishAngle != null) {
      final wobble = _wobbleCalculator.getWobble(_wobbleController.value);
      child = SquishedWidget(
        direction: !wobble.isPerpendicular
            ? _squishAngle!
            : _squishAngle! + (pi / 2),
        effectStrength: wobble.strength * widget.dampener,
        child: child,
      );
    }

    return child;
  }
}
