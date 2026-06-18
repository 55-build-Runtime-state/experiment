// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:google_fonts/google_fonts.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Colors namespace.
class AppColors {
  /// Hot pink.
  static const placeholderColor = Color(0xFFDD40E4);

  /// Main gold of the "GenLatte" label.
  static const latteArtGold = Color(0xFFECC03B);

  /// Extremely bold yellow.
  static const chevronYellow = Color(0xFFFBBC04);

  /// Google blue.
  static const googleBlue = Color(0xFF5F83EE);

  /// Google red.
  static const googleIntroRed = Color(0xFFD85140);

  /// Google intro blue.
  static const googleIntroBlue = Color(0xFF5383EC);

  /// Google intro green.
  static const googleIntroGreen = Color(0xFF58A65C);

  /// Inactive grey.
  static const mutedGrey = Color(0xFF484848);

  /// Placeholder grey (black with 30% opacity).
  static const placeholderGrey = Color(0x4D000000);

  /// Black.
  static const black = Color(0xFF000000);

  /// Pretty close to black.
  static const almostBlack = Color(0xFF121212);

  /// White.
  static const white = Color(0xFFFFFFFF);

  /// Transparent.
  static const transparent = Color(0x00000000);
}

const _colorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Lighter color which sits behind the slightly darker circles
  background: AppColors.almostBlack,

  // Base text color.
  foreground: Colors.black,
  card: AppColors.white,
  cardForeground: AppColors.black,
  popover: AppColors.white,
  popoverForeground: AppColors.black,

  // Google-y Blue
  primary: AppColors.googleBlue,
  primaryForeground: AppColors.black,
  secondary: Color(0xFFCCCCCC),
  secondaryForeground: AppColors.googleBlue,
  muted: AppColors.mutedGrey,

  // Text input "placeholder" color
  mutedForeground: AppColors.placeholderGrey,
  accent: AppColors.googleBlue,
  accentForeground: AppColors.placeholderColor,
  destructive: AppColors.googleIntroRed,
  border: AppColors.white,
  input: AppColors.white,

  // Highlight around focused elements, like text inputs
  ring: AppColors.googleBlue,
  chart1: AppColors.placeholderColor,
  chart2: AppColors.placeholderColor,
  chart3: AppColors.placeholderColor,
  chart4: AppColors.placeholderColor,
  chart5: AppColors.placeholderColor,
);

/// Canonicalize an alternate color scheme which creates dark borders; useful
/// for forms with text inputs which would really benefit from having visible
/// borders.
///
/// The issue is that buttons also use `border` for their colors; and some
/// buttons have different border colors than text inputs.
final ColorScheme _formsColorScheme = _colorScheme.copyWith(
  border: () => AppColors.almostBlack,
);

/// How them letters should look.
final Typography typography = Typography(
  sans: GoogleFonts.googleSans(),
  mono: GoogleFonts.jetBrainsMono(),
  xSmall: const TextStyle(fontSize: 10),
  small: const TextStyle(fontSize: 13.5),
  base: const TextStyle(fontSize: 16),
  large: const TextStyle(fontSize: 18),
  xLarge: const TextStyle(fontSize: 20),
  x2Large: const TextStyle(fontSize: 24),
  x3Large: const TextStyle(fontSize: 30),
  x4Large: const TextStyle(fontSize: 36),
  x5Large: const TextStyle(fontSize: 48),
  x6Large: const TextStyle(fontSize: 60),
  x7Large: const TextStyle(fontSize: 72),
  x8Large: const TextStyle(fontSize: 96),
  x9Large: const TextStyle(fontSize: 144),
  thin: const TextStyle(fontWeight: FontWeight.w100),
  light: const TextStyle(fontWeight: FontWeight.w300),
  extraLight: const TextStyle(fontWeight: FontWeight.w200),
  normal: const TextStyle(fontWeight: FontWeight.w400),
  medium: const TextStyle(fontWeight: FontWeight.w500),
  semiBold: const TextStyle(fontWeight: FontWeight.w600),
  bold: const TextStyle(fontWeight: FontWeight.w700),
  extraBold: const TextStyle(fontWeight: FontWeight.w800),
  black: const TextStyle(fontWeight: FontWeight.w900),
  italic: const TextStyle(fontStyle: FontStyle.italic),

  h1: const TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.black,
  ),
  h2: const TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  ),
  h3: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  ),
  // Used for app bars of pages, which are intentionally smaller than other
  // headers used for prominent cards
  h4: const TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400,
    color: AppColors.latteArtGold,
  ),
  p: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
  blockQuote: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  ),
  inlineCode: GoogleFonts.jetBrainsMono().copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
  lead: const TextStyle(fontSize: 20),
  textLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
  textSmall: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  textMuted: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
);

/// Returns the appropriate theme for the current orientation.
ThemeData getThemeForOrientation(BuildContext context) {
  return ThemeData(
    colorScheme: _colorScheme,
    typography: typography,
    radius: 0.6,
  );
}

/// Special theme for forms with text inputs which are otherwise white-on-white.
final ThemeData formsTheme = ThemeData(
  colorScheme: _formsColorScheme,
  typography: typography,
  radius: 0.6,
);
