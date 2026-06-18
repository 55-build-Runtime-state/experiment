// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/kiosk/widgets/zip_item.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// The final screen in the kiosk wizard, where the user confirms their order.
class KioskConfirmation extends StatelessWidget {
  /// Creates a [KioskConfirmation] widget.
  const KioskConfirmation({
    required this.onNewOrder,
    required this.orderNumber,
    super.key,
  });

  /// Callback for when the user starts over.
  final VoidCallback onNewOrder;

  /// The order number.
  final int orderNumber;

  static const _breakpointWidth = 650;

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, info) {
        final newline = info.width > _breakpointWidth ? '\n' : ' ';

        final scale = (min(info.width, _breakpointWidth) / _breakpointWidth)
            .clamp(0.5, 1.0);

        final whiteTextTitle = TextStyle(
          color: AppColors.white,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w500,
          fontSize: 44 * scale,
        );
        final orderNumberStyle = whiteTextTitle.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 48 * scale,
        );
        final whiteTextBody = whiteTextTitle.copyWith(
          fontSize: 20 * scale,
        );
        final whiteTextSmall = whiteTextTitle.copyWith(
          fontSize: 14 * scale,
        );

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: info.width * 0.1),
          child: Column(
            children: <Widget>[
              const Spacer(),
              ZipItem(
                index: 4,
                child: Text(
                  'Order #$orderNumber',
                  style: orderNumberStyle,
                ),
              ),
              const SizedBox(height: 24),
              ZipItem(
                index: 3,
                child: Text(
                  'Pick up your order',
                  style: whiteTextTitle,
                  textAlign: .center,
                ),
              ),
              const SizedBox(height: 24),
              ZipItem(
                index: 2,
                child: Text(
                  'Proceed to the line to pickup your order.$newline'
                  'You can check your place in line on the order board.',
                  style: whiteTextBody,
                  textAlign: .center,
                ),
              ),
              const SizedBox(height: 24),
              ZipItem(
                index: 1,
                child: Text(
                  'Want to know more?$newline'
                  'Talk to someone by the pickup area about using Flutter or '
                  'Firebase.',
                  style: whiteTextSmall,
                  textAlign: .center,
                ),
              ),
              const SizedBox(height: 36),
              ZipItem(
                index: 0,
                child: GenLatteOutlinedButton.light(
                  label: 'Start a new order',
                  size: .large,
                  onPressed: onNewOrder,
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
