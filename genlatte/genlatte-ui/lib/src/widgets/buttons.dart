// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:genlatte/src/screens/app/app.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Standard application button with slightly rounded corners, a thin border,
/// and a transparent background.
class GenLatteOutlinedButton extends StatelessWidget {
  const GenLatteOutlinedButton._({
    required this.label,
    required this.onPressed,
    required _ButtonLuminence luminence,
    required this.size,
    super.key,
  }) : _luminence = luminence;

  /// Creates a new [GenLatteOutlinedButton] with a white border, suitable to
  /// pair with dark backgrounds.
  factory GenLatteOutlinedButton.light({
    required String label,
    required VoidCallback? onPressed,
    GenLatteButtonSize size = .normal,
    Key? key,
  }) {
    return GenLatteOutlinedButton._(
      label: label,
      onPressed: onPressed,
      luminence: .light,
      size: size,
      key: key,
    );
  }

  /// Creates a new [GenLatteOutlinedButton] with a red border, suitable for
  /// urgent alerts.
  factory GenLatteOutlinedButton.red({
    required String label,
    required VoidCallback? onPressed,
    GenLatteButtonSize size = .normal,
    Key? key,
  }) {
    return GenLatteOutlinedButton._(
      label: label,
      onPressed: onPressed,
      luminence: .red,
      size: size,
      key: key,
    );
  }

  /// Creates a new [GenLatteOutlinedButton] with a dark border, suitable to
  /// pair with light backgrounds.
  factory GenLatteOutlinedButton.dark({
    required String label,
    required VoidCallback? onPressed,
    GenLatteButtonSize size = .normal,
    Key? key,
  }) {
    return GenLatteOutlinedButton._(
      label: label,
      onPressed: onPressed,
      luminence: .dark,
      size: size,
      key: key,
    );
  }

  /// Text to show in the button.
  final String label;

  /// Callback to invoke when the button is pressed.
  final VoidCallback? onPressed;

  /// {@macro _ButtonLuminence}
  final _ButtonLuminence _luminence;

  /// {@macro _ButtonSize}
  final GenLatteButtonSize size;

  @override
  Widget build(BuildContext context) {
    final color = switch (_luminence) {
      .light => const Color(0xFFFFFFFF),
      .dark => const Color(0xFF000000),
      .red => const Color(0xFFD32F2F),
    };
    final padding = size == .normal
        ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    return Button(
      onPressed: onPressed,
      style: const ButtonStyle.outline()
          .withPadding(padding: padding)
          .withBackgroundColor(
            color: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            disabledColor: Colors.transparent,
          )
          .withBorder(
            border: Border.all(color: color),
            hoverBorder: Border.all(color: color),
            focusBorder: Border.all(color: color),
            disabledBorder: Border.all(color: color),
          )
          .withBorderRadius(
            borderRadius: BorderRadius.circular(12),
            hoverBorderRadius: BorderRadius.circular(12),
            focusBorderRadius: BorderRadius.circular(12),
            disabledBorderRadius: BorderRadius.circular(12),
          ),
      // There is a problem with the `withPadding()` method. The
      // plumbing which eventually resolves button padding
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: switch (size) {
            .normal => 14,
            .large => 16,
          },
        ),
      ),
    );
  }
}

/// Similar to an outline button, but used for configuring a coffee or the
/// generated art which will live atop it.
class GenLatteConfigurationButton extends StatelessWidget {
  /// Creates a new [GenLatteConfigurationButton].
  const GenLatteConfigurationButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
    required this.isTight,
    required this.uiScale,
    super.key,
  });

  /// Text to show in the button.
  final String label;

  /// Callback to invoke when the button is pressed.
  final VoidCallback onPressed;

  /// Whether this button is selected.
  final bool isSelected;

  /// If true, everything is a little smaller.
  final bool isTight;

  /// Scaling up or down of the UI element.
  final double uiScale;

  /// UI padding for tight buttons (before uiScaling).
  static const tightPadding = EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 6,
  );

  /// UI padding for normal buttons (before uiScaling).
  static const normalPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  static final _tightBorderRadius = BorderRadius.circular(6);
  static final _normalBorderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        (isTight ? _tightBorderRadius : _normalBorderRadius) * uiScale;
    final padding = (isTight ? tightPadding : normalPadding) * uiScale;
    final backgroundColor = isSelected ? AppColors.black : Colors.transparent;

    // Default values are 1px black.
    final border = Border.all();

    return Button(
      onPressed: onPressed,
      style: const ButtonStyle.outline()
          .withBackgroundColor(
            color: backgroundColor,
            hoverColor: backgroundColor,
            focusColor: backgroundColor,
            disabledColor: backgroundColor,
          )
          .withBorder(
            border: border,
            hoverBorder: border,
            focusBorder: border,
            disabledBorder: border,
          )
          .withBorderRadius(
            borderRadius: borderRadius,
            hoverBorderRadius: borderRadius,
            focusBorderRadius: borderRadius,
            disabledBorderRadius: borderRadius,
          )
          .withPadding(
            padding: padding,
            hoverPadding: padding,
            focusPadding: padding,
            disabledPadding: padding,
          ),
      // There is a problem with the `withPadding()` method. The
      // plumbing which eventually resolves button padding
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF000000),
          fontSize: 14 * uiScale,
        ),
      ),
    );
  }
}

/// Standard application button with slightly rounded corners and a filled white
/// background.
class GenLatteFilledButton extends StatelessWidget {
  /// Creates a new [GenLatteFilledButton].
  const GenLatteFilledButton({
    required this.onPressed,
    this.label,
    this.icon,
    this.trailingIcon,
    this.size = .normal,
    super.key,
  }) : assert(
         label != null || icon != null || trailingIcon != null,
         'Must provide either a label or an icon or trailingIcon.',
       );

  /// Text to show in the button.
  final String? label;

  /// Icon to show in the button.
  final IconData? icon;

  /// Icon to show after the label.
  final IconData? trailingIcon;

  /// Callback to invoke when the button is pressed.
  final VoidCallback onPressed;

  /// {@macro _ButtonSize}
  final GenLatteButtonSize size;

  /// Maximum and default size of a button; used to scale down UI values when
  /// this button finds itself in tighter quarters.
  static const _defaultSize = 60;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double uiScale =
            (min(constraints.maxWidth, constraints.maxHeight) / _defaultSize)
                .clamp(0.5, 1);
        final padding = size == .normal
            ? EdgeInsets.symmetric(
                horizontal: 16 * uiScale,
                vertical: 12 * uiScale,
              )
            : EdgeInsets.symmetric(
                horizontal: 16 * uiScale,
                vertical: 16 * uiScale,
              );
        final labelChild = label != null
            ? Text(
                label!,
                style: TextStyle(
                  color: const Color(0xFF000000),
                  fontSize: 16 * uiScale,
                ),
              )
            : null;
        final iconChild = icon != null
            ? Icon(icon, size: 24 * uiScale, color: const Color(0xFF000000))
            : null;

        final trailingIconChild = trailingIcon != null
            ? Icon(
                trailingIcon,
                size: 24 * uiScale,
                color: const Color(0xFF000000),
              )
            : null;

        // If we only have an icon, force an outright circular shape
        final ButtonShape shape = icon != null && label == null
            ? .circle
            : .rectangle;

        final border = shape == .rectangle
            ? Border.all(color: const Color(0x00000000))
            : null;

        final borderRadius = shape == .rectangle
            ? BorderRadius.circular(999)
            : null;

        var buttonStyle = ButtonStyle.outline(shape: shape)
            .withPadding(padding: padding)
            .withBackgroundColor(color: const Color(0xFFFFFFFF));

        buttonStyle = buttonStyle.withBorder(
          border: border,
          hoverBorder: border,
          focusBorder: border,
          disabledBorder: border,
        );

        buttonStyle = buttonStyle.withBorderRadius(
          borderRadius: borderRadius,
          hoverBorderRadius: borderRadius,
          focusBorderRadius: borderRadius,
          disabledBorderRadius: borderRadius,
        );

        return Button(
          onPressed: onPressed,
          style: buttonStyle,
          // This key is needed to force the button to rebuild when the shape
          // changes.
          // https://github.com/sunarya-thito/shadcn_flutter/issues/404
          key: ValueKey('button-$shape'),
          child: Row(
            mainAxisSize: .min,
            children: <Widget>[
              ?iconChild,
              if (iconChild != null && labelChild != null) //
                SizedBox(width: 8 * uiScale),
              ?labelChild,
              if (trailingIcon != null && labelChild != null) //
                SizedBox(width: 8 * uiScale),
              ?trailingIconChild,
            ],
          ),
        );
      },
    );
  }
}

/// {@template _ButtonLuminence}
/// Color flavor of a button.
/// {@endtemplate}
enum _ButtonLuminence {
  /// Indicates a primarily white button, suitable for dark backgrounds.
  light,

  /// Indicates a primarily dark button, suitable for light luminence
  /// backgrounds.
  dark,

  /// Indicates a red button, suitable for urgent alerts.
  red,
}

/// {@template ButtonSize}
/// Size of a button.
/// {@endtemplate}
enum GenLatteButtonSize {
  /// Default button sizing
  normal,

  /// Extra padding, for when it really matters
  large,
}
