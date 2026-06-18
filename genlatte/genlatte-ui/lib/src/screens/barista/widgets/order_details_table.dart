// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:text_responsive/text_responsive.dart';

/// Simple model for the data to display.
class OrderDetailItem {
  /// Instantiates a [OrderDetailItem].
  OrderDetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  /// Leading visual indicator of what the row is about.
  final Widget icon;

  /// Plain text label.
  final String label;

  /// Configuration value for the label.
  final String value;
}

/// Displays a list of [OrderDetailItem]s in a table.
class OrderDetailsWidget extends StatelessWidget {
  /// Instantiates an [OrderDetailsWidget].
  const OrderDetailsWidget({
    required this.details,
    this.scaleFactor = 1.0,
    super.key,
  });

  /// The details to display.
  final List<OrderDetailItem> details;

  /// The factor by which to scale the UI.
  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    if (details.isEmpty) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scaleFactor),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4 * scaleFactor,
            offset: Offset(0, 2 * scaleFactor),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Hugs the content tightly
        children: details.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == details.length - 1;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10 * scaleFactor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Side: Icon and Label
                    Row(
                      children: [
                        SizedBox(
                          width: 24 * scaleFactor,
                          child: Center(
                            child: Transform.scale(
                              scale: scaleFactor,
                              child: item.icon,
                            ),
                          ),
                        ),
                        SizedBox(width: 12 * scaleFactor),
                        ParagraphTextWidget(
                          item.label,
                          style: TextStyle(
                            fontSize: 12 * scaleFactor,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),

                    // Right Side: Value
                    ParagraphTextWidget(
                      item.value,
                      style: TextStyle(
                        fontSize: 16 * scaleFactor,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              // Smart Divider: Only show if it's NOT the last item
              if (!isLast)
                Divider(
                  height: 1 * scaleFactor,
                  thickness: 1 * scaleFactor,
                  color: Colors.grey.shade200,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
