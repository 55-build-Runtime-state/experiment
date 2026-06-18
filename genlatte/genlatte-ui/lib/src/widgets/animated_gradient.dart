// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:genlatte/src/screens/app/theme.dart';

class AnimatedGradientBackground extends StatelessWidget {
  const AnimatedGradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base background
        Container(color: AppColors.white),
        
        // Animated Blobs
        _Blob(
          color: AppColors.googleIntroBlue.withValues(alpha: 0.3),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          duration: 10.seconds,
        ),
        _Blob(
          color: AppColors.googleIntroRed.withValues(alpha: 0.2),
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          duration: 8.seconds,
          delay: 1.seconds,
        ),
        _Blob(
          color: AppColors.googleIntroGreen.withValues(alpha: 0.2),
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          duration: 12.seconds,
          delay: 2.seconds,
        ),
        _Blob(
          color: AppColors.latteArtGold.withValues(alpha: 0.2),
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          duration: 15.seconds,
          delay: 3.seconds,
        ),

        // Blur effect to make it look like a mesh gradient
        const IgnorePointer(
          child: SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({
    required this.color,
    required this.begin,
    required this.end,
    required this.duration,
    this.delay = Duration.zero,
  });

  final Color color;
  final Alignment begin;
  final Alignment end;
  final Duration duration;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return Animate(
      onPlay: (controller) => controller.repeat(reverse: true),
      delay: delay,
    ).custom(
      duration: duration,
      builder: (context, value, child) {
        final alignment = Alignment.lerp(begin, end, value)!;
        return Align(
          alignment: alignment,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color,
                  blurRadius: 150,
                  spreadRadius: 100,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
