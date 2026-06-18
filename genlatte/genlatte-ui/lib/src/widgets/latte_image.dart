// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:genlatte/src/widgets/stacked_images.dart';

/// Renders a latte image with the cup outline.
class LatteImageWidget extends StatelessWidget {
  /// Creates a [LatteImageWidget] widget.
  const LatteImageWidget({
    required this.imageUrl,
    this.dimension,
    this.topScaleRatio = 0.92,
    this.thumbnailSize = false,
    super.key,
  });

  /// Size of the widget.
  final double? dimension;

  /// The latte image to show above the coffee cup image.
  final String imageUrl;

  /// The scale ratio of the [imageUrl] image relative to the cup background.
  final double topScaleRatio;

  /// Set this to `true` to convey that the widget will always be
  /// thumbnail-sized and thus can use a low-resolution asset.
  ///
  /// Defaults to `false`.
  final bool thumbnailSize;

  @override
  Widget build(BuildContext context) {
    final child = StackedImages(
      bottom: Image.asset(
        thumbnailSize
            ? 'assets/latte-background-thumb.png'
            : 'assets/latte-background.png',
      ),
      top: _MultiplyBlend(
        child: ClipOval(child: Image.network(imageUrl, fit: .cover)),
      ),
      topScaleRatio: topScaleRatio,
    );

    if (dimension != null) {
      return SizedBox.square(dimension: dimension, child: child);
    }
    return child;
  }
}

class _MultiplyBlend extends SingleChildRenderObjectWidget {
  const _MultiplyBlend({super.child});

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderMultiply();
}

class _RenderMultiply extends RenderProxyBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.canvas.saveLayer(
        offset & size,
        Paint()..blendMode = BlendMode.multiply,
      );
      context.paintChild(child!, offset);
      context.canvas.restore();
    }
  }
}
