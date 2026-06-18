// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:genlatte/src/widgets/buttons.dart';

/// Builder function that receives the calculated scaling factor for the UI.
typedef DynamicButtonLayoutBuilder =
    Widget Function(
      BuildContext context,
      double uiScale,
    );

/// A widget that analytically figures out the optimal UI scaling factor
/// necessary to fit a sequence of GenLatteConfigurationButton widgets into
/// the provided horizontal and vertical space.
class DynamicButtonLayout extends StatefulWidget {
  /// Creates a new DynamicButtonLayout.
  const DynamicButtonLayout({
    required this.availableSize,
    required this.options,
    required this.isTight,
    required this.builder,
    required this.rowSpacing,
    required this.columnSpacing,
    this.minScale = 0.1,
    this.maxScale = 2.0,
    super.key,
  });

  /// The size the layout must fit within.
  final Size availableSize;

  /// The labels that will be placed in the buttons.
  final List<String> options;

  /// Whether the buttons should be rendered with tight padding.
  final bool isTight;

  /// Render the final layout with the calculated `uiScale`.
  final DynamicButtonLayoutBuilder builder;

  /// Vertical spacing between wrapped rows.
  final double rowSpacing;

  /// Horizontal spacing between buttons on the same row.
  final double columnSpacing;

  /// The minimum scale factor to softly bottom out at.
  final double minScale;

  /// The maximum scale factor to search up to.
  final double maxScale;

  @override
  State<DynamicButtonLayout> createState() => _DynamicButtonLayoutState();
}

class _DynamicButtonLayoutState extends State<DynamicButtonLayout> {
  // Cache to store the computed optimal UI scale for a given set of parameters.
  static final Map<int, double> _scaleCache = {};

  @override
  Widget build(BuildContext context) {
    if (widget.options.isEmpty) {
      return widget.builder(context, 1);
    }

    final defaultStyle = DefaultTextStyle.of(context).style;
    final textScaler =
        MediaQuery.maybeTextScalerOf(context) ?? TextScaler.noScaling;

    // Generate a hash representing all relevant layout inputs.
    final hashKey = Object.hash(
      widget.availableSize,
      Object.hashAll(widget.options),
      widget.isTight,
      widget.rowSpacing,
      widget.columnSpacing,
      widget.minScale,
      widget.maxScale,
      defaultStyle,
      textScaler,
    );

    if (_scaleCache.containsKey(hashKey)) {
      return widget.builder(context, _scaleCache[hashKey]!);
    }

    double low = widget.minScale;
    double high = widget.maxScale;
    double bestScale = low;

    // Binary search to find the highest scale that fits.
    if (_fits(high, defaultStyle, textScaler)) {
      bestScale = high;
    } else {
      while (high - low > 0.01) {
        final mid = (low + high) / 2;
        if (_fits(mid, defaultStyle, textScaler)) {
          bestScale = mid;
          low = mid;
        } else {
          high = mid;
        }
      }
    }

    _scaleCache[hashKey] = bestScale;
    return widget.builder(context, bestScale);
  }

  bool _fits(
    double scale,
    TextStyle baseStyle,
    TextScaler textScaler,
  ) {
    final paddingX =
        (widget.isTight
            ? GenLatteConfigurationButton.tightPadding.horizontal
            : GenLatteConfigurationButton.normalPadding.horizontal) *
        scale;
    final paddingY =
        (widget.isTight
            ? GenLatteConfigurationButton.tightPadding.vertical
            : GenLatteConfigurationButton.normalPadding.vertical) *
        scale;

    // We add an extra 4 pixels conservatively to account for shadcn
    // internal border/focus ring spacing that might be unaccounted for.
    const borderSlopX = 6.0;
    const borderSlopY = 6.0;

    double totalHeight = 0;
    double currentRowWidth = 0;
    double rowHeight = 0;

    for (int i = 0; i < widget.options.length; i++) {
      // Calculate exactly for this scale using proper text scaler and style
      final tp = TextPainter(
        text: TextSpan(
          text: widget.options[i],
          style: baseStyle.copyWith(fontSize: 14 * scale),
        ),
        textDirection: TextDirection.ltr,
        textScaler: textScaler,
      )..layout();

      // We conservatively buffer the size by 1.05 and add the slop
      final buttonWidth = tp.width * 1.05 + paddingX + borderSlopX;
      final buttonHeight = tp.height * 1.05 + paddingY + borderSlopY;

      if (currentRowWidth + buttonWidth > widget.availableSize.width) {
        // Need to wrap to the next row (if we already have items)
        if (currentRowWidth > 0) {
          totalHeight += rowHeight + (widget.rowSpacing * scale);
        }
        currentRowWidth = buttonWidth + (widget.columnSpacing * scale);
        rowHeight = buttonHeight;

        if (buttonWidth > widget.availableSize.width) {
          // Even alone, this button is too wide to fit the width constraint!
          return false;
        }
      } else {
        // Fits perfectly on the current row
        currentRowWidth += buttonWidth + (widget.columnSpacing * scale);
        rowHeight = max(rowHeight, buttonHeight);
      }
    }

    // Add the height of the last row
    if (rowHeight > 0) {
      totalHeight += rowHeight;
    }

    return totalHeight <= widget.availableSize.height;
  }
}
