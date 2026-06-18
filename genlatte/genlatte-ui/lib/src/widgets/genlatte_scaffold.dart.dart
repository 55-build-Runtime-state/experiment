// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:genlatte/src/screens/app/app.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Wraps a shadcn [Scaffold] to supply the dotted background behind all
/// customer-facing screens.
class GenLatteScaffold extends StatelessWidget {
  /// Instantiates a [GenLatteScaffold] widget.
  const GenLatteScaffold({
    required this.child,
    this.headers = const [],
    this.footers = const [],
    super.key,
  });

  /// Header widgets passed straight to the shadcn [Scaffold].
  final List<Widget> headers;

  /// Footer widgets passed straight to the shadcn [Scaffold].
  final List<Widget> footers;

  /// The UI to sit atop the dotted background.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.almostBlack,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. The Background Layer
          LayoutBuilder(
            builder: (context, constraints) {
              return CustomPaint(
                size: Size(constraints.maxWidth, constraints.maxHeight),
                painter: _CircleTessellationPainter(
                  circleColor: AppColors.black,
                ),
              );
            },
          ),
          // 2. The Content Layer
          Scaffold(
            backgroundColor: Colors.transparent,
            headers: headers,
            footers: footers,
            child: child,
          ),
        ],
      ),
    );
  }
}

class _CircleTessellationPainter extends CustomPainter {
  _CircleTessellationPainter({required this.circleColor});
  final Color circleColor;

  /// Constants from requirements
  static const double circleRadius = 100;
  static const double circleDiameter = circleRadius * 2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.fill;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // Calculate how many columns/rows we need to cover the screen plus buffers
    // We add 1 to the count to ensure circles clipped by the edge are still
    // drawn.
    final int horizontalCount = (centerX / circleDiameter).ceil() + 1;
    final int verticalCount = (centerY / circleDiameter).ceil() + 1;

    // Helper function to draw a vertical column of circles at a specific X
    void drawColumn(double xCenter) {
      // Draw center circle
      canvas.drawCircle(Offset(xCenter, centerY), circleRadius, paint);

      // Draw circles moving Up and Down from center
      for (int i = 1; i <= verticalCount; i++) {
        final offset = i * circleDiameter;
        canvas
          ..drawCircle(
            Offset(xCenter, centerY - offset),
            circleRadius,
            paint,
          )
          ..drawCircle(
            Offset(xCenter, centerY + offset),
            circleRadius,
            paint,
          );
      }
    }

    // --- Draw Columns ---

    // The requirement states the vertical center is a junction of two columns.
    // Innermost centers are 180px left and right of center.

    // Draw the Right side columns (starting at center + 180)
    for (int i = 0; i <= horizontalCount; i++) {
      // center + 180, center + 540, etc.
      final x = centerX + circleRadius + (i * circleDiameter);
      drawColumn(x);
    }

    // Draw the Left side columns (starting at center - 180)
    for (int i = 0; i <= horizontalCount; i++) {
      // center - 180, center - 540, etc.
      final x = centerX - circleRadius - (i * circleDiameter);
      drawColumn(x);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Since the circles are static, we never need to repaint unless rebuilt
    return false;
  }
}
