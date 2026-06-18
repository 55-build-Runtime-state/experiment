// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/widgets/responsive_sized_box.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// The 3-logo footer widget.
class Footer extends StatelessWidget {
  /// Instantiates the footer widget.
  const Footer({this.fontColor = AppColors.white, this.uiScale = 1.0})
    : super(key: const ValueKey('app-footer'));

  /// The color of the footer text.
  final Color fontColor;

  /// The scale of the footer.
  final double uiScale;

  /// Default size of all assets is about ~301 pixels. This size was derived
  /// by first laying out the assets and measuring; not by picking a value and
  /// squeezing the assets to fit.
  static const double defaultWidth = 302;

  /// Default height of all assets is about ~24 pixels. This size was derived
  /// by first laying out the assets and measuring; not by picking a value and
  /// squeezing the assets to fit.
  static const double defaultHeight = 24;

  static const double _defaultFontSize = 12;

  static const double _defaultLogoWidth = 32;
  static const double _defaultSpacerWidth = 4;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizedBox.builder(
      aspectRatioClamp: (null, 302 / 24, null),
      maxSize: Size(defaultWidth * uiScale, defaultHeight * uiScale),
      builder: (context, size) {
        final heightScale = size.height / defaultHeight;
        final widthScale = size.width / defaultWidth;
        final double scale = min(heightScale, widthScale);
        final double spacerWidth = _defaultSpacerWidth * widthScale;
        final double fontSize = _defaultFontSize * scale;
        final double logoWidth = _defaultLogoWidth * scale;

        // Create repeatable widgets
        final spacer = SizedBox(width: spacerWidth);
        final verticalBar = _VerticalBar(scale: scale);
        final style = TextStyle(color: fontColor, fontSize: fontSize);
        return Row(
          children: [
            Image.asset('assets/gemini-logo.png', width: logoWidth),
            spacer,
            Text('Gemini', style: style),
            verticalBar,
            Image.asset('assets/firebase-logo.png', width: logoWidth),
            spacer,
            Text('Firebase', style: style),
            verticalBar,
            Image.asset('assets/flutter-logo.png', width: logoWidth),
            spacer,
            Text('Flutter', style: style),
          ],
        );
      },
    );
  }
}

class _VerticalBar extends StatelessWidget {
  const _VerticalBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * scale),
      child: VerticalDivider(
        width: 1 * scale,
        thickness: 1 * scale,
        color: const Color(0xFF838383),
      ),
    );
  }
}
