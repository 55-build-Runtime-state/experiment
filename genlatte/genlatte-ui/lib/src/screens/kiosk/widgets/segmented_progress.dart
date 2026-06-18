// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_animate/flutter_animate.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A horizontal progress bar that is segmented into multiple steps, with the
/// current step being indicated by increased width.
class SegmentedProgress extends StatelessWidget {
  /// Creates a new [SegmentedProgress].
  const SegmentedProgress({
    required this.currentStep,
    required this.totalSteps,
    this.inactiveHeight = 8.0,
    this.activeHeight = 20.0,
    this.maxWidth = 220,
    super.key,
  }) : assert(
         currentStep < totalSteps,
         'currentStep must be less than totalSteps; you have an off-by-1 error',
       );

  /// The current step.
  final int currentStep;

  /// The total number of steps.
  final int totalSteps;

  /// The height of all steps whose index does not equal [currentStep].
  final double inactiveHeight;

  /// The height of the step whose index equals [currentStep].
  final double activeHeight;

  /// The maximum width of the progress bar.
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth,
      height: activeHeight,
      child: _SegmentedProgressInner(
        currentStep: currentStep,
        totalSteps: totalSteps,
        inactiveHeight: inactiveHeight,
        activeHeight: activeHeight,
      ),
    );
  }
}

class _SegmentedProgressInner extends StatelessWidget {
  const _SegmentedProgressInner({
    required this.currentStep,
    required this.totalSteps,
    required this.inactiveHeight,
    required this.activeHeight,
  });

  /// The current step.
  final int currentStep;

  /// The total number of steps.
  final int totalSteps;

  /// The height of all steps whose index does not equal [currentStep].
  final double inactiveHeight;

  /// The height of the step whose index equals [currentStep].
  final double activeHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final segmentWidth = (totalWidth * 0.92) / totalSteps;

        return Row(
          mainAxisAlignment: .spaceBetween,
          children: List.generate(totalSteps, (index) {
            final height = index == currentStep ? activeHeight : inactiveHeight;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              width: segmentWidth,
              height: height,
              decoration: ShapeDecoration(
                color: index <= currentStep
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.muted,
                shape: const StadiumBorder(),
              ),
            );
          }),
        );
      },
    ).animate().fadeIn(
      // 100ms per item on the intro card, of which there are 4
      // 100ms being the outro speed of each ZipItem's animation
      delay: const Duration(milliseconds: 400),
    );
  }
}
