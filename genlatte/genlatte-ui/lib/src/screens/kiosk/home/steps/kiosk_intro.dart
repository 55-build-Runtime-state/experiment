// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/kiosk/widgets/zip_item.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:text_responsive/text_responsive.dart';

const _whiteThinStyle = TextStyle(
  color: AppColors.white,
  fontWeight: FontWeight.normal,
);

const _whiteBoldStyle = TextStyle(
  color: AppColors.white,
  fontWeight: FontWeight.bold,
);

/// First screen of the kiosk flow which asks for the user's name.
class KioskIntro extends StatelessWidget {
  /// Creates a new [KioskIntro].
  const KioskIntro({required this.advance, super.key});

  /// Callback to advance to the next step.
  final VoidCallback advance;

  @override
  Widget build(BuildContext context) {
    final layoutInfo = context.watch<LayoutInformation>();
    final intraCardSpacer = layoutInfo.orientation.isLandscape
        ? const SizedBox(width: 16)
        : const SizedBox(height: 16);
    final startButtonSpacer = layoutInfo.orientation.isLandscape
        ? const SizedBox(width: 24)
        : const SizedBox(height: 24);
    return Padding(
      padding: layoutInfo.orientation.axis == .vertical
          ? const EdgeInsets.symmetric(horizontal: 32)
          : EdgeInsets.zero,
      child: Flex(
        direction: layoutInfo.orientation.axis,
        children: <Widget>[
          const Spacer(),
          Expanded(
            flex: 10,
            child: Flex(
              direction: layoutInfo.orientation.axis,
              children: <Widget>[
                const Expanded(
                  flex: 3,
                  child: ZipItem(
                    index: 3,
                    child: _IntroCard(
                      color: AppColors.googleIntroRed,
                      stepIndex: 1,
                      cta: 'Customize\nyour latte',
                    ),
                  ),
                ),
                intraCardSpacer,

                const Expanded(
                  flex: 3,
                  child: ZipItem(
                    index: 2,
                    child: _IntroCard(
                      color: AppColors.googleIntroBlue,
                      stepIndex: 2,
                      cta: 'Create your\nlatte art',
                    ),
                  ),
                ),
                intraCardSpacer,
                const Expanded(
                  flex: 3,
                  child: ZipItem(
                    index: 1,
                    child: _IntroCard(
                      color: AppColors.googleIntroGreen,
                      stepIndex: 3,
                      cta: 'Pick up\nyour drink',
                      helpText: 'AT THE BARISTA STATION',
                    ),
                  ),
                ),
                startButtonSpacer,
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ZipItem(
              index: 0,
              child: ResponsiveChevronButton(
                onPressed: advance,
                text: 'Start',
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({
    required this.color,
    required this.stepIndex,
    required this.cta,
    this.helpText,
  });

  final Color color;

  /// Number to show in a circle above the text.
  final int stepIndex;

  /// Main text.
  final String cta;

  /// Optional text below the [cta].
  final String? helpText;

  /// Standard width when the UI is in landscape mode (and the card itself is
  /// vertical);
  static const _defaultLandscapeWidth = 200;

  /// Standard height when the UI is in portrait mode (and the card itself is
  /// horizontal);
  static const _defaultPortraitHeight = 110;

  /// Minimum available width below which we must further shrink font sizes
  /// while the UI is in portrait mode (and the card is using a Column)
  static const _minPortraitWidth = 350;

  static const _minLandscapeAspectRatio = 0.65;
  static const _maxLandscapeAspectRatio = 0.933;

  static const _minPortraitAspectRatio = 1.3;
  static const _maxPortraitAspectRatio = 4.0;

  @override
  Widget build(BuildContext context) {
    final layoutInfo = context.watch<LayoutInformation>();
    return ResponsiveSizedBox.builder(
      aspectRatioClamp:
          (layoutInfo.orientation.isLandscape
                  ? (
                      _minLandscapeAspectRatio,
                      null,
                      _maxLandscapeAspectRatio,
                    )
                  : (
                      _minPortraitAspectRatio,
                      null,
                      _maxPortraitAspectRatio,
                    ))
              as AcceptableAspectRatios,
      builder: (context, size) {
        final constraints = BoxConstraints(
          maxWidth: size.width,
          maxHeight: size.height,
        );
        return Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: layoutInfo.orientation == .landscape
              ? _buildColumn(context, constraints)
              : _buildRow(context, constraints),
        );
      },
    );
  }

  Widget _buildRow(BuildContext context, BoxConstraints constraints) {
    double fontScalar = constraints.maxHeight / _defaultPortraitHeight;
    if (constraints.maxWidth < _minPortraitWidth) {
      fontScalar = fontScalar.clamp(
        constraints.maxWidth / _minPortraitWidth,
        1,
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          _StepCircle(stepIndex: stepIndex, fontScalar: fontScalar),
          const Spacer(),
          Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                cta,
                textAlign: TextAlign.center,
                style: _whiteThinStyle.copyWith(
                  fontSize: 24 * fontScalar,
                ),
              ),
              if (helpText != null && helpText!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  helpText!,
                  textAlign: TextAlign.center,
                  style: _whiteThinStyle.copyWith(
                    fontSize: 11 * fontScalar,
                  ),
                ),
              ],
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildColumn(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    double fontScalar = constraints.maxWidth / _defaultLandscapeWidth;
    final aspectRatio = constraints.maxWidth / constraints.maxHeight;

    // If the aspect ratio is too flat (too landscape), then a really wide width
    // can calculate text sizes that are too large for the available height.
    if (aspectRatio > _maxLandscapeAspectRatio) {
      fontScalar = fontScalar * (_maxLandscapeAspectRatio / aspectRatio);
    }

    double topPaddingScalar = 1;
    if (aspectRatio < _minLandscapeAspectRatio) {
      topPaddingScalar = _minLandscapeAspectRatio / aspectRatio;
    }

    return Column(
      children: <Widget>[
        SizedBox(height: constraints.maxHeight * 0.15 * topPaddingScalar),
        _StepCircle(stepIndex: stepIndex, fontScalar: fontScalar),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ParagraphTextWidget(
            cta,
            textAlign: TextAlign.center,
            style: _whiteThinStyle.copyWith(
              fontSize: 21 * fontScalar,
            ),
          ),
        ),
        if (helpText != null && helpText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ParagraphTextWidget(
              helpText!,
              textAlign: TextAlign.center,
              style: _whiteThinStyle.copyWith(
                fontSize: 10 * fontScalar,
              ),
            ),
          ),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({required this.stepIndex, required this.fontScalar});

  final int stepIndex;
  final double fontScalar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white),
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(16 * fontScalar),
      child: Text(
        stepIndex.toString(),
        style: _whiteBoldStyle.copyWith(
          fontSize: 18 * fontScalar,
        ),
      ),
    );
  }
}
