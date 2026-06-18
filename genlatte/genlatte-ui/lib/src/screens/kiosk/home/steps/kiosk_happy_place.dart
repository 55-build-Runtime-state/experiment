// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:genlatte/src/screens/app/app.dart';
import 'package:genlatte/src/screens/kiosk/widgets/zip_item.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:text_responsive/text_responsive.dart';

/// {@template KioskHappyPlace}
/// The screen where the user is asked for their happy place.
/// {@endtemplate}
class KioskHappyPlace extends StatefulWidget {
  /// {@macro KioskHappyPlace}
  const KioskHappyPlace({
    required this.happyPlace,
    required this.submitHappyPlace,
    super.key,
  });

  /// The user's happy place.
  final String? happyPlace;

  /// Callback to submit the user's happy place.
  final void Function(String)? submitHappyPlace;

  @override
  State<KioskHappyPlace> createState() => _KioskHappyPlaceState();
}

class _KioskHappyPlaceState extends State<KioskHappyPlace> {
  final TextEditingController _controller = TextEditingController();

  // Used to track when the happy place changes from falsey to truthy to
  // activate the button
  String? _happyPlace;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.happyPlace ?? '';
    _controller.addListener(_updateHappyPlaceLocally);
    _happyPlace = widget.happyPlace;
  }

  @override
  void didUpdateWidget(covariant KioskHappyPlace oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.happyPlace == null && oldWidget.happyPlace != null) {
      setState(() {
        _controller.clear();
        _happyPlace = null;
      });
    }
  }

  DateTime? _lastToastTime;

  void _showLimitReachedToast() {
    final now = DateTime.now();
    if (_lastToastTime == null ||
        now.difference(_lastToastTime!) > const Duration(seconds: 3)) {
      _lastToastTime = now;
      showToast(
        context: context,
        builder: (context, overlay) {
          return SurfaceCard(
            child: Basic(
              title: const Text(
                'Character limit reached',
                style: TextStyle(color: AppColors.googleIntroRed),
              ).large,
              subtitle: const Text(
                'The happy place must be 50 characters or less',
                style: TextStyle(color: AppColors.black),
              ).base,
              trailing: OutlineButton(
                onPressed: overlay.close,
                child: const Text(
                  'OK',
                  style: TextStyle(color: AppColors.googleIntroRed),
                ),
              ),
            ),
          );
        },
        location: ToastLocation.bottomCenter,
        showDuration: const Duration(seconds: 3),
      );
    }
  }

  void _updateHappyPlaceLocally() {
    final String? oldHappyPlace = _happyPlace;
    _happyPlace = _controller.text;
    if (oldHappyPlace == null ||
        oldHappyPlace.isEmpty && _happyPlace!.isNotEmpty) {
      // Trigger an update to activate the button.
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, layoutInfo) {
        final Axis axis = layoutInfo.aspectRatio < 1.6
            ? .vertical
            : .horizontal;
        return Padding(
          padding: axis == .vertical
              ? const EdgeInsets.symmetric(horizontal: 24)
              : EdgeInsets.zero,
          child: Flex(
            direction: axis,
            children: [
              if (axis == .horizontal) const Spacer(flex: 3),
              if (axis == .vertical) const Spacer(),
              Expanded(
                flex: 9,
                child: ZipItem(
                  index: 1,
                  child: ResponsiveSizedBox(
                    aspectRatioClamp: (
                      CardShape.tall.aspectRatio,
                      null,
                      CardShape.expanded.aspectRatio,
                    ),
                    maxSize: CardShape.expanded.size * 1.2,
                    child: _HappyPlaceConfigurationCard(
                      controller: _controller,
                      onLimitReached: _showLimitReachedToast,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: ZipItem(
                  index: 0,
                  child: Padding(
                    padding: axis == .vertical
                        ? const EdgeInsets.only(top: 16)
                        : EdgeInsets.zero,
                    child: ResponsiveChevronButton(
                      onPressed:
                          widget.submitHappyPlace != null &&
                              _happyPlace != null &&
                              _happyPlace!.isNotEmpty
                          ? () => widget.submitHappyPlace!(_happyPlace!)
                          : null,
                      scale: axis == .horizontal ? 0.6 : null,
                      text: 'Next',
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _HappyPlaceConfigurationCard extends StatelessWidget {
  const _HappyPlaceConfigurationCard({
    required this.controller,
    required this.onLimitReached,
  });

  final TextEditingController controller;
  final VoidCallback onLimitReached;

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, layout) {
        // 1.3 chosen by eyeballing when the quadrants start to feel crowded
        return layout.aspectRatio < 1.3
            ? _buildColumn(context, layout)
            : _buildQuadrants(context, layout);
      },
    );
  }

  Widget _buildColumn(BuildContext context, LayoutInformation layout) {
    final double edgeInsets =
        (layout.constrainingDimension * 0.1) //
            .clamp(16, 64);
    final stackConstraints = BoxConstraints.tight(
      Size(
        layout.width - (edgeInsets * 2),
        layout.height - (edgeInsets * 2),
      ),
    );

    final double floor = layout.constrainingDimension > 250 ? 1 : 0.5;
    final double inputScalar = max(floor, layout.constrainingDimension / 400);
    final scaledTextStyle = Theme.of(context).typography.large.copyWith(
      fontSize: Theme.of(context).typography.large.fontSize! * inputScalar,
    );
    return Container(
      decoration: BoxDecoration(
        color: Flavor.weirdGreen.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(edgeInsets),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: stackConstraints.maxHeight * 0.30,
            child: ParagraphTextWidget(
              'Ok, now tell me about your happy place',
              style: Theme.of(context).typography.h1,
              maxLines: 3,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            height: stackConstraints.maxHeight * 0.65,
            bottom: 0,
            child: ShaderMask(
              shaderCallback: (rect) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                  stops: [0.6, 1],
                ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset('assets/flutter-latte.png'),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            width: stackConstraints.maxWidth,
            height: stackConstraints.maxHeight * 0.4,
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .end,
              children: [
                TextField(
                  autocorrect: false,
                  controller: controller,
                  decoration: BoxDecoration(
                    border: const Border(), // defaults to BorderStyle.none
                    borderRadius: BorderRadius.all(
                      Radius.circular(8 * inputScalar),
                    ),
                    color: Theme.of(context).colorScheme.input,
                  ),
                  inputFormatters: [
                    CharacterLimitFormatter(50, onLimitReached),
                  ],
                  maxLength: 50,
                  placeholder: Text(
                    'Imagine your happy place',
                    overflow: .ellipsis,
                    style: scaledTextStyle,
                  ),
                  style: scaledTextStyle,
                ),
                const SizedBox(height: 12),
                if (layout.constrainingDimension > 250)
                  const ParagraphTextWidget('This will inspire your latte!'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuadrants(BuildContext context, LayoutInformation layout) {
    final double edgeInsets =
        (layout.constrainingDimension * 0.12) //
            .clamp(16, 64);
    final stackConstraints = BoxConstraints.tight(
      Size(
        layout.width - (edgeInsets * 2),
        layout.height - (edgeInsets * 2),
      ),
    );

    final double floor = layout.constrainingDimension > 250 ? 1 : 0.5;
    final double inputScalar = max(floor, layout.constrainingDimension / 400);
    final textStyle = Theme.of(context).typography.large;
    final scaledTextStyle = textStyle.copyWith(
      fontSize: textStyle.fontSize! * inputScalar,
    );
    final scaledSmallTextStyle = Theme.of(context).typography.small.copyWith(
      fontSize: Theme.of(context).typography.small.fontSize! * inputScalar,
    );
    return Container(
      decoration: BoxDecoration(
        color: Flavor.weirdGreen.backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(edgeInsets),
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: stackConstraints.maxWidth * 0.4,
            child: Image.asset('assets/flutter-latte.png'),
          ),
          Positioned(
            left: 0,
            top: 0,
            width: stackConstraints.maxWidth * 0.55,
            height: stackConstraints.maxHeight * 0.55,
            child: ParagraphTextWidget(
              'Ok, now tell me about your happy place',
              style: Theme.of(context).typography.h1,
              maxLines: 3,
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            width: stackConstraints.maxWidth * 0.6,
            height: stackConstraints.maxHeight * 0.4,
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .end,
              children: [
                TextField(
                  autocorrect: false,
                  controller: controller,
                  decoration: BoxDecoration(
                    border: const Border(), // defaults to BorderStyle.none
                    borderRadius: BorderRadius.all(
                      Radius.circular(8 * inputScalar),
                    ),
                    color: Theme.of(context).colorScheme.input,
                  ),
                  inputFormatters: [
                    CharacterLimitFormatter(50, onLimitReached),
                  ],
                  maxLength: 50,
                  placeholder: Text(
                    'Imagine your happy place',
                    style: scaledTextStyle,
                  ),
                  style: scaledTextStyle,
                ),
                const SizedBox(height: 12),
                if (layout.constrainingDimension > 250)
                  Text(
                    'This will inspire your latte!',
                    style: scaledSmallTextStyle,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A [TextInputFormatter] that limits the number of characters in a
/// [TextField].
class CharacterLimitFormatter extends TextInputFormatter {
  /// Creates a new [CharacterLimitFormatter].
  CharacterLimitFormatter(this.limit, this.onLimitReached);

  /// The maximum number of characters allowed.
  final int limit;

  /// Callback to be invoked when the character limit is reached.
  final VoidCallback onLimitReached;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.length > limit) {
      onLimitReached();
      if (oldValue.text.length >= limit) {
        return oldValue;
      }
      return TextEditingValue(
        text: newValue.text.substring(0, limit),
        selection: TextSelection.collapsed(offset: limit),
      );
    }
    return newValue;
  }
}
