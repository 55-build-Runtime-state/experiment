// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

/// {@template SquishedWidget}
/// {@endtemplate}
class SquishedWidget extends StatelessWidget {
  /// {@macro SquishedWidget}
  const SquishedWidget({
    required this.effectStrength,
    required this.direction,
    required this.child,
    super.key,
  });

  /// Widget to squish.
  final Widget child;

  /// Direction of the force squishing the widget in radians.
  final double direction;

  /// Strength of the force squishing the widget. The value should be between
  /// -1 and 1, with a value of 0 indicating no squish.
  final double effectStrength;

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      (context, shader, innerChild) {
        return AnimatedSampler(
          (image, size, canvas) {
            shader
              ..setFloatUniforms((u) {
                u
                  ..setSize(size)
                  ..setFloat(direction)
                  // The widget accepts a value of -1 to 1, but the shader
                  // itself is written to look best between -0.5 and 0.5, so
                  // we need to divide the strength by 2.
                  ..setFloat(effectStrength / 2);
              })
              ..setImageSampler(0, image);

            canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
          },
          child: innerChild!,
        );
      },
      assetKey: 'assets/shaders/squish.glsl',
      child: child,
    );
  }
}
