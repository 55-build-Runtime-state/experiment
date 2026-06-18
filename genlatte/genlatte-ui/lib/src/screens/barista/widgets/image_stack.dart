// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: use_if_null_to_convert_nulls_to_bools

import 'dart:math' show min;

import 'package:genlatte_data/models.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' hide IconButton;

/// Widget to display the generated latte image with the name overlayed.
class ImageStack extends StatelessWidget {
  /// Instantiates a [ImageStack] widget.
  const ImageStack({required this.scaleFactor, required this.latte, super.key});

  /// The scale factor to apply to the widget.
  final double scaleFactor;

  /// The latte to display.
  final Latte latte;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox.square(
          dimension: min(
            constraints.maxWidth,
            constraints.maxHeight,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    8 * scaleFactor,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        latte.metadata.isImageApproved == false
                            ? 'https://firebasestorage.googleapis.com/v0/b/gcdemos-26-int-dd-latteart.firebasestorage.app/o/latteImages%2FfallbackImage%2Ficon_flutter.png?alt=media&token=06a3ac7e-7929-4507-8105-9eddb4445892'
                            : latte.metadata.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8 * scaleFactor),
                  color: latte.metadata.isNameApproved != false
                      ? Colors.black.withValues(alpha: 0.5)
                      : Colors.red.withValues(alpha: 0.5),
                  child: Text(
                    latte.order.name!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18 * scaleFactor,
                    ),
                  ),
                  // child: Text(
                  //   '${latte.order.name!}'
                  //   '${latte.metadata.isNameApproved == false ? ' ❌' : ''}',
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 18 * scaleFactor,
                  //   ),
                  // ),
                ),
              ),
              if (latte.metadata.isImageApproved == false)
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.all(8 * scaleFactor),
                    color: Colors.red.withValues(alpha: 0.5),
                    child: Text(
                      'Image rejected',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14 * scaleFactor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
