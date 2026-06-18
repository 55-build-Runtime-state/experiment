// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' show min;

import 'package:flutter_svg/svg.dart';
import 'package:genlatte/src/screens/kiosk/widgets/zip_item.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:genlatte_data/models.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// The final step in the kiosk wizard, where the user accepts their order.
class KioskSubmitOrder extends StatelessWidget {
  /// Creates a [KioskSubmitOrder] widget.
  const KioskSubmitOrder({
    required this.advance,
    required this.metadata,
    required this.order,
    required this.returnToLatteConfig,
    super.key,
  });

  /// Callback for when the user accepts the order.
  ///
  /// If the value is null then the order is probably being submitted as we
  /// speak.
  final VoidCallback? advance;

  /// The order to display.
  final LatteOrder order;

  /// The order's server-owned metadata.
  final LatteOrderMetadata metadata;

  /// Press handler for the "Edit drink" button.
  final VoidCallback returnToLatteConfig;

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, info) {
        return info.aspectRatio < 1.6
            ? _buildColumn(context, info)
            : _buildRow(context, info);
      },
    );
  }

  Widget _buildColumn(BuildContext context, LayoutInformation info) {
    final imageDiameter = min(info.width * 0.5, info.height * 0.3);
    final verticalScalar = info.height / 500;
    final h3ScaledText = _whiteText.copyWith(
      fontSize: 24 * verticalScalar,
    );
    final pTagScaledText = _whiteText.copyWith(
      fontSize: 14 * verticalScalar,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          if (metadata.imageUrl != null)
            ZipItem(
              index: 2,
              child: LatteImageWidget(
                imageUrl: metadata.imageUrl!,
                dimension: imageDiameter,
              ),
            ),
          if (metadata.imageUrl == null)
            SizedBox(
              height: imageDiameter,
              width: imageDiameter,
              child: const CircularProgressIndicator(),
            ),
          SizedBox(height: 12 * verticalScalar),
          ZipItem(
            index: 2,
            child: Text(
              'Order recap for ${order.name}',
              textAlign: .center,
              style: h3ScaledText,
            ),
          ),
          SizedBox(height: 12 * verticalScalar),
          ZipItem(
            index: 2,
            child: Wrap(
              alignment: .center,
              spacing: 24,
              runSpacing: 12,
              children: <Widget>[
                Row(
                  mainAxisSize: .min,
                  children: <Widget>[
                    const GreenCheckMark(),
                    SizedBox(width: 8 * verticalScalar),
                    Text('Latte', style: pTagScaledText),
                  ],
                ),
                Row(
                  mainAxisSize: .min,
                  children: <Widget>[
                    const GreenCheckMark(),
                    SizedBox(width: 8 * verticalScalar),
                    Text(
                      '${order.milk!} milk',
                      style: pTagScaledText,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: .min,
                  children: <Widget>[
                    const GreenCheckMark(),
                    SizedBox(width: 8 * verticalScalar),
                    Text(
                      order.sweetener!.toLowerCase() != 'none'
                          ? order.sweetener!
                          : 'No sweetener',
                      style: pTagScaledText,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12 * verticalScalar),
          ZipItem(
            index: 2,
            child: GenLatteOutlinedButton.light(
              onPressed: returnToLatteConfig,
              label: 'Edit drink',
            ),
          ),
          SizedBox(height: 24 * verticalScalar),
          ZipItem(
            index: 1,
            child: Text(
              'Your happy place latte art:',
              textAlign: .center,
              style: h3ScaledText,
            ),
          ),
          SizedBox(height: 8 * verticalScalar),
          ZipItem(
            index: 1,
            child: Text(
              '“${order.happyPlace!.trim()}”',
              textAlign: .center,
              style: h3ScaledText.copyWith(fontWeight: .bold),
            ),
          ),
          const Spacer(),
          ZipItem(
            index: 0,
            child: ResponsiveChevronButton(
              onPressed: advance,
              style: .flat,
              scale: 0.6 * verticalScalar,
              text: 'Submit',
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, LayoutInformation info) {
    final topPadding = info.height * 0.15;
    final horizontalPadding = info.width * 0.1;
    final availableHorizontalSpace = info.width - (horizontalPadding * 2);
    final availableVerticalSpace = info.height - (topPadding * 2);

    final statusColumnWidth = availableHorizontalSpace * 0.3;
    final imageColumnWidth = availableHorizontalSpace * 0.4;
    final submitButtonWidth = availableHorizontalSpace * 0.3;

    const imagePadding = EdgeInsets.fromLTRB(32, 0, 32, 32);
    final imageDiameter = min(
      imageColumnWidth - (imagePadding.left + imagePadding.right),
      availableVerticalSpace - (imagePadding.top + imagePadding.bottom),
    );

    final milkConfigText = _whiteText.copyWith(
      fontSize: 36 * statusColumnWidth / 300,
    );

    /// Number of pixels down from the top of the row until the center of the
    /// image
    final centerOfImageY = imagePadding.top + imageDiameter / 2;

    return Stack(
      children: [
        Positioned(
          top: topPadding,
          left: horizontalPadding,
          width: statusColumnWidth,
          height: availableVerticalSpace,
          child: ZipItem(
            index: 2,
            child: Column(
              crossAxisAlignment: .start,
              children: <Widget>[
                const Text('Order recap for', style: _whiteText),
                Text('${order.name}:', style: milkConfigText),
                const Spacer(),
                Row(
                  children: <Widget>[
                    const GreenCheckMark(),
                    const SizedBox(width: 12),
                    Text('Latte', style: milkConfigText),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const GreenCheckMark(),
                    const SizedBox(width: 12),
                    Text('${order.milk} milk', style: milkConfigText),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const GreenCheckMark(),
                    const SizedBox(width: 12),
                    if (order.sweetener!.toLowerCase() == 'none')
                      Text('No sweetener', style: milkConfigText),
                    if (order.sweetener!.toLowerCase() != 'none')
                      Text('${order.sweetener}', style: milkConfigText),
                  ],
                ),
                const Spacer(),
                GenLatteOutlinedButton.light(
                  onPressed: returnToLatteConfig,
                  label: 'Edit drink',
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
        Positioned(
          top: topPadding,
          left: horizontalPadding + statusColumnWidth,
          width: imageColumnWidth,
          height: availableVerticalSpace,
          child: ZipItem(
            index: 1,
            child: Column(
              children: <Widget>[
                Center(
                  child: LatteImageWidget(
                    imageUrl: metadata.imageUrl!,
                    dimension: imageDiameter,
                  ),
                ),
                SizedBox(height: imagePadding.bottom),
                const Text('Your happy place latte art:', style: _whiteText),
                const SizedBox(height: 12),
                Text(
                  '${order.happyPlace}',
                  textAlign: .center,
                  style: _whiteText,
                ).h3,
              ],
            ),
          ),
        ),
        Positioned(
          top: topPadding,
          right: horizontalPadding,
          width: submitButtonWidth,
          height: centerOfImageY * 2,
          child: ZipItem(
            index: 0,
            child: ResponsiveChevronButton(
              onPressed: advance,
              style: .flat,
              scale: submitButtonWidth / 300,
              text: 'Submit',
            ),
          ),
        ),
      ],
    );
  }
}

/// A green check mark icon.
class GreenCheckMark extends StatelessWidget {
  /// Creates a [GreenCheckMark] widget.
  const GreenCheckMark({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset('assets/green-check.svg');
  }
}

const _whiteText = TextStyle(
  color: Colors.white,
);
