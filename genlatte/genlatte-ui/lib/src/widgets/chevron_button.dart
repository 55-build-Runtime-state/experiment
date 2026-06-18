// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math';

import 'package:flutter/services.dart';
import 'package:genlatte/src/screens/app/theme.dart';
import 'package:genlatte/src/widgets/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// The orientation of the chevron button.
enum ChevronButtonType {
  /// A tall chevron button, suitable for rows within landscape UIs.
  vertical,

  /// A short chevron button, suitable for columns within portrait UIs.
  flat,
}

/// A button that is shaped like a chevron pointing to the right. The two
/// shapes, `vertical` and `flat`, are for tablets/desktop and mobile
/// respectively.
class ChevronButton extends StatefulWidget {
  /// Generic constructor for a [ChevronButton].
  ChevronButton._({
    required this.builder,
    required ChevronButtonType type,
    required this.color,
    required this.width,
    required this.height,
    required this.onPressed,
    required this.scale,
    required this.textColor,
    required this.textPadding,
    this.borderColor,
    super.key,
  }) {
    painterBuilder = type == ChevronButtonType.vertical
        ? (Color color, Color? borderColor) =>
              _verticalPainter(color, borderColor, scale)
        : (Color color, Color? borderColor) =>
              _flatPainter(color, borderColor, scale);
  }

  /// Creates a [ChevronButton] with vertical orientation at the given scale.
  factory ChevronButton.vertical({
    required Widget Function(BuildContext, double, Color?) builder,
    VoidCallback? onPressed,
    double scale = 1.0,
    Color? color,
    Color? borderColor,
    Color? textColor,
    Key? key,
  }) => ChevronButton._(
    builder: builder,
    width: _VerticalChevronPainter._defaultWidth * scale,
    height: _VerticalChevronPainter._defaultHeight * scale,
    color: color ?? AppColors.chevronYellow,
    borderColor: borderColor,
    onPressed: onPressed,
    scale: scale,
    textColor: textColor,
    textPadding: EdgeInsets.only(
      left: (_VerticalChevronPainter._defaultArrowDepth * scale) * 0.98,
    ),
    type: .vertical,
    key: key,
  );

  /// Creates a [ChevronButton] with flat orientation and the given scale.
  factory ChevronButton.flat({
    required Widget Function(BuildContext, double, Color?) builder,
    VoidCallback? onPressed,
    double scale = 1.0,
    Color? color,
    Color? borderColor,
    Color? textColor,
    Key? key,
  }) => ChevronButton._(
    builder: builder,
    width: _FlatChevronPainter._defaultWidth * scale,
    height: _FlatChevronPainter._defaultHeight * scale,
    color: color ?? AppColors.chevronYellow,
    borderColor: borderColor,
    onPressed: onPressed,
    scale: scale,
    textColor: textColor,
    textPadding: EdgeInsets.zero,
    type: .flat,
    key: key,
  );

  static CustomPainter _verticalPainter(
    Color color,
    Color? borderColor,
    double scale,
  ) => _VerticalChevronPainter(
    color: color,
    borderColor: borderColor,
    radius: _VerticalChevronPainter._defaultCornerRadius * scale,
    depth: _VerticalChevronPainter._defaultArrowDepth * scale,
    scale: scale,
  );

  static CustomPainter _flatPainter(
    Color color,
    Color? borderColor,
    double scale,
  ) => _FlatChevronPainter(
    color: color,
    borderColor: borderColor,
    tailWidth: _FlatChevronPainter._defaultTailWidth * scale,
    arrowWidth: _FlatChevronPainter._defaultArrowWidth * scale,
    scale: scale,
  );

  /// Descendant builder with UI scaling.
  final Widget Function(
    BuildContext context,
    double textScale,
    Color? textColor,
  )
  builder;

  /// Final width of the chevron.
  final double width;

  /// Final height of the chevron.
  final double height;

  /// Color of the chevron.
  final Color color;

  /// Optional border color that defaults to the main color if omitted.
  final Color? borderColor;

  /// UI scalar.
  final double scale;

  /// Optional text color that defaults to the main color if omitted.
  final Color? textColor;

  /// Special padding for the button text to make it look centered.
  final EdgeInsets textPadding;

  /// Callback when the button is pressed.
  final VoidCallback? onPressed;

  /// That which draws the button itself.
  late final CustomPainter Function(Color, Color?) painterBuilder;

  @override
  State<ChevronButton> createState() => _ChevronButtonState();
}

class _ChevronButtonState extends State<ChevronButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    // Darken the color slightly when hovered or focused
    final effectiveColor = (widget.onPressed == null)
        ? const Color(0xFF3D3D3D)
        : (_isHovered || _isFocused)
        ? Color.lerp(widget.color, Colors.black, 0.1)!
        : widget.color;

    final effectiveBorderColor = widget.borderColor == null
        ? null
        : (widget.onPressed == null)
        ? const Color(0xFF3D3D3D)
        : (_isHovered || _isFocused)
        ? Color.lerp(widget.borderColor, Colors.black, 0.1)!
        : widget.borderColor;

    return Semantics(
      button: true,
      enabled: widget.onPressed != null,
      onTap: widget.onPressed,
      child: FocusableActionDetector(
        mouseCursor: SystemMouseCursors.click,
        onShowFocusHighlight: (value) => setState(() => _isFocused = value),
        onShowHoverHighlight: (value) => setState(() => _isHovered = value),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) => widget.onPressed?.call(),
          ),
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        child: GestureDetector(
          onTap: widget.onPressed,
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: widget.painterBuilder(
                      effectiveColor,
                      effectiveBorderColor,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: widget.textPadding,
                    child: widget.builder(
                      context,
                      widget.scale,
                      widget.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VerticalChevronPainter extends CustomPainter {
  _VerticalChevronPainter({
    required this.color,
    required this.radius,
    required this.depth,
    required this.scale,
    this.borderColor,
  });

  final Color color;
  final Color? borderColor;
  final double radius;
  final double depth;
  final double scale;

  static const double _defaultWidth = 214;
  static const double _defaultHeight = 405;
  static const double _aspectRatio = _defaultWidth / _defaultHeight;
  static const Size _defaultSize = Size(_defaultWidth, _defaultHeight);
  static const double _defaultCornerRadius = 20;
  static const double _defaultArrowDepth = 27;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final w = size.width;
    final h = size.height;

    // Calculate the vertical center for the chevron tip
    final centerY = h / 2;

    // We add a tiny smoothing curve at the arrow tip so it's not razor sharp
    const tipRadius = 4.0;

    final path = Path()
      // 1. Start at Top-Left (after the corner)
      // The shape is indented on the left, so x starts at 0 and goes IN by
      // 'depth'
      ..moveTo(0, radius)
      // 2. Top-Left Corner
      // We use ArcToPoint to ensure a perfect circular corner regardless of
      // scale
      ..arcToPoint(
        Offset(radius, 0),
        radius: Radius.circular(radius),
      )
      // 3. Top Edge
      // Goes to the right, but stops short for the right corner.
      // The right side is shifted "out" by `depth`.
      // The main body width is (w - depth).
      ..lineTo(w - depth - radius, 0)
      // 4. Top-Right Corner
      ..arcToPoint(
        Offset(w - depth, radius),
        radius: Radius.circular(radius),
      )
      // 5. Right Side (Top Half) -> Going OUT to the tip
      // We curve slightly to the tip at (w, centerY)
      ..lineTo(w - 0.5, centerY - tipRadius)
      // 6. Right Tip (Small curve for the point)
      ..quadraticBezierTo(w, centerY, w - 0.5, centerY + tipRadius)
      // 7. Right Side (Bottom Half) -> Going IN to bottom corner
      ..lineTo(w - depth, h - radius)
      // 8. Bottom-Right Corner
      ..arcToPoint(
        Offset(w - depth - radius, h),
        radius: Radius.circular(radius),
      )
      // 9. Bottom Edge
      ..lineTo(radius, h)
      // 10. Bottom-Left Corner
      ..arcToPoint(
        Offset(0, h - radius),
        radius: Radius.circular(radius),
      )
      // 11. Left Side (Bottom Half) -> Going IN to the indentation
      ..lineTo(depth, centerY + tipRadius)
      // 12. Left Indent Tip (Small internal curve)
      ..quadraticBezierTo(depth - 1.0, centerY, depth, centerY - tipRadius)
      // 13. Left Side (Top Half) -> Going OUT to start
      ..lineTo(0, radius)
      ..close();

    canvas.drawPath(path, paint);

    final finalBorderColor = borderColor ?? color;
    final strokePaint = Paint()
      ..color = finalBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0 * scale
      ..isAntiAlias = true;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _VerticalChevronPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.radius != radius ||
        oldDelegate.depth != depth ||
        oldDelegate.scale != scale;
  }
}

class _FlatChevronPainter extends CustomPainter {
  _FlatChevronPainter({
    required this.color,
    required this.tailWidth,
    required this.arrowWidth,
    required this.scale,
    this.borderColor,
  });
  final Color color;
  final Color? borderColor;
  final double tailWidth;
  final double arrowWidth;
  final double scale;

  // Original SVG dimensions
  static const double _defaultHeight = 90;
  static const double _defaultWidth = 234;
  static const double _aspectRatio = _defaultWidth / _defaultHeight;
  static const Size _defaultSize = Size(_defaultWidth, _defaultHeight);

  // Original feature widths (calculated from SVG coordinates)
  // Left tail is approx 15px wide (x=0 to x=15)
  static const double _defaultTailWidth = 15;
  // Right arrow is approx 38px wide (from flat edge x=196 to tip x=234)
  static const double _defaultArrowWidth = 38;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    final w = size.width;
    final h = size.height;
    final s = scale;

    // We calculate the "flat" part start point on the right
    final rightFlatX = w - arrowWidth;

    final path = Path()
      // --- 1. Top Edge ---
      // Start after the tail (x = tailWidth)
      ..moveTo(tailWidth, 0)
      // Draw straight line to the start of the arrow
      ..lineTo(rightFlatX, 0)
      // --- 2. Right Arrow Head ---
      // All coordinates are relative to `rightFlatX`.
      // We use the original SVG control points multiplied by `s` (scale).
      // Top curve of arrow
      ..cubicTo(
        rightFlatX + (4.7 * s),
        0,
        rightFlatX + (9.1 * s),
        2.2 * s,
        rightFlatX + (12.0 * s),
        6.0 * s,
      )
      // Line to tip approach
      ..lineTo(rightFlatX + (34.4 * s), 36.0 * s)
      // The Tip Rounding
      ..cubicTo(
        rightFlatX + (38.4 * s),
        41.3 * s,
        rightFlatX + (38.4 * s),
        48.6 * s,
        rightFlatX + (34.4 * s),
        54.0 * s,
      )
      // Line back from tip
      ..lineTo(rightFlatX + (12.0 * s), 84.0 * s)
      // Bottom curve of arrow
      ..cubicTo(
        rightFlatX + (9.1 * s),
        87.8 * s,
        rightFlatX + (4.7 * s),
        90.0 * s,
        rightFlatX,
        90.0 * s,
      )
      // --- 3. Bottom Edge ---
      ..lineTo(tailWidth, h)
      // --- 4. Left Tail (The Wave) ---
      // We draw from bottom (h) up to top (0).
      // The X coordinates are relative to 0.
      // Bottom wave segment
      ..cubicTo(2.7 * s, 90.0 * s, -4.4 * s, 76.0 * s, 3.0 * s, 66.0 * s)
      // Line Inward
      ..lineTo(12.0 * s, 54.0 * s)
      // Middle wave segment
      ..cubicTo(16.0 * s, 48.6 * s, 16.0 * s, 41.3 * s, 12.0 * s, 36.0 * s)
      // Line Outward
      ..lineTo(3.0 * s, 24.0 * s)
      // Top wave segment
      ..cubicTo(-4.4 * s, 14.0 * s, 2.7 * s, 0, tailWidth, 0)
      ..close();

    canvas.drawPath(path, paint);

    final finalBorderColor = borderColor ?? color;
    final strokePaint = Paint()
      ..color = finalBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0 * s
      ..isAntiAlias = true;
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _FlatChevronPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.scale != scale ||
        oldDelegate.tailWidth != tailWidth;
  }
}

/// Delegates to a [ChevronButton] that adapts to the current orientation.
class ResponsiveChevronButton extends StatelessWidget {
  /// Instantiates a [ResponsiveChevronButton].
  const ResponsiveChevronButton({
    required this.onPressed,
    required this.text,
    this.color,
    this.borderColor,
    this.textColor,
    this.scale,
    this.style,
    super.key,
  });

  /// CLick handler.
  final VoidCallback? onPressed;

  /// The color of the button.
  final Color? color;

  /// Optional border color that defaults to the main color if omitted.
  final Color? borderColor;

  /// Optional text color that defaults to the main color if omitted.
  final Color? textColor;

  /// Button text.
  final String text;

  /// Scalar for the button.
  final double? scale;

  /// Button style.
  final ChevronButtonType? style;

  @override
  Widget build(BuildContext context) {
    return LayoutProvider.builder(
      builder: (context, layoutInfo) {
        return (style == .vertical) ||
                (style != .flat && layoutInfo.orientation.isPortrait)
            ? ResponsiveSizedBox.builder(
                aspectRatioClamp: (
                  null,
                  _VerticalChevronPainter._aspectRatio,
                  null,
                ),
                maxSize: _VerticalChevronPainter._defaultSize,
                builder: (context, Size size) {
                  final calculatedScale =
                      size.height / _VerticalChevronPainter._defaultHeight;
                  final finalScale = scale != null
                      ? min(scale!, calculatedScale)
                      : calculatedScale;

                  // 200px width is about the min width before 5-character
                  // strings start to squish and wrap
                  final baseFontSize = 44 * (size.width / 200);

                  return Center(
                    child: SizedBox.fromSize(
                      size: size * (scale ?? 1),
                      child: ChevronButton.vertical(
                        builder: (context, double textScale, Color? textColor) {
                          return WrappedText(
                            style: (context, theme) {
                              return theme.typography.h1.copyWith(
                                // h1 font size is coming as 60, but need
                                // smaller to fit nicely
                                fontSize:
                                    baseFontSize * min(textScale, finalScale),
                                color: textColor,
                              );
                            },
                            child: Text(text),
                          );
                        },
                        color: color,
                        borderColor: borderColor,
                        textColor: textColor,
                        onPressed: onPressed,
                        scale: finalScale,
                      ),
                    ),
                  );
                },
              )
            : ResponsiveSizedBox.builder(
                aspectRatioClamp: (
                  null,
                  _FlatChevronPainter._aspectRatio,
                  null,
                ),
                maxSize: _FlatChevronPainter._defaultSize * (scale ?? 1),
                builder: (context, Size size) {
                  final calculatedScale =
                      size.height / _FlatChevronPainter._defaultHeight;
                  final finalScale = scale != null
                      ? min(scale!, calculatedScale)
                      : calculatedScale;
                  return Center(
                    child: SizedBox.fromSize(
                      size: size,
                      child: ChevronButton.flat(
                        builder:
                            (context, double textScale, Color? textColor) //
                            => WrappedText(
                              style: (context, theme) =>
                                  theme.typography.h1.copyWith(
                                    fontSize:
                                        // h1 font size is coming as 60, but
                                        // need about a 10% reduction to size
                                        // this nicely
                                        54 * min(textScale, finalScale),
                                    color: textColor,
                                  ),
                              child: Text(text),
                            ),
                        color: color,
                        borderColor: borderColor,
                        textColor: textColor,
                        onPressed: onPressed,
                        scale: finalScale,
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
