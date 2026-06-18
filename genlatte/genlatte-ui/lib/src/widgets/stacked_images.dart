// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/widgets.dart';

/// A widget that stacks two widgets (typically images) on top of each other.
///
/// The [top] widget is centered over the [bottom] widget and is scaled
/// according to [topScaleRatio].
class StackedImages extends StatelessWidget {
  /// Creates a [StackedImages] widget.
  const StackedImages({
    required this.bottom,
    required this.top,
    this.topScaleRatio = 0.8,
    super.key,
  });

  /// The widget at the bottom of the stack. This widget determines the
  /// overall size of the [StackedImages] widget.
  final Widget bottom;

  /// The widget centered on top of the [bottom] widget.
  final Widget top;

  /// The scale ratio of the [top] widget relative to the [bottom] widget's
  /// size.
  ///
  /// For example, `0.8` means the [top] widget will be 80% the size of the
  /// [bottom] widget.
  final double topScaleRatio;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        bottom,
        Positioned.fill(
          child: FractionallySizedBox(
            widthFactor: topScaleRatio,
            heightFactor: topScaleRatio,
            child: top,
          ),
        ),
      ],
    );
  }
}
