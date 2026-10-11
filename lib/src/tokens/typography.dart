import 'package:flutter/material.dart';

/// Font family declared in this package's `pubspec.yaml`.
const String beneathFontFamily = 'AtkinsonHyperlegibleNext';

/// Package that bundles the font; `TextStyle.package` resolves it from any app.
const String beneathFontPackage = 'beneathsos_ui';

/// Text roles (spec §4). Colours come from the theme; sizes scale with the system text size.
abstract final class BeneathTypography {
  static TextStyle _style(double size, double lineHeight, FontWeight weight) =>
      TextStyle(
        fontFamily: beneathFontFamily,
        package: beneathFontPackage,
        fontSize: size,
        height: lineHeight / size,
        fontWeight: weight,
      );

  /// Every Material text slot. Body text never goes below 17; 15 is fine print only.
  static TextTheme textTheme() => TextTheme(
    displayLarge: _style(40, 48, FontWeight.w800),
    displayMedium: _style(36, 44, FontWeight.w800),
    displaySmall: _style(32, 40, FontWeight.w800),
    headlineLarge: _style(28, 36, FontWeight.w700),
    headlineMedium: _style(26, 34, FontWeight.w700),
    headlineSmall: _style(24, 32, FontWeight.w700),
    titleLarge: _style(20, 28, FontWeight.w700),
    titleMedium: _style(19, 26, FontWeight.w600),
    titleSmall: _style(17, 24, FontWeight.w600),
    bodyLarge: _style(19, 28, FontWeight.w400),
    bodyMedium: _style(17, 24, FontWeight.w400),
    bodySmall: _style(15, 20, FontWeight.w400),
    labelLarge: _style(19, 24, FontWeight.w700),
    labelMedium: _style(17, 22, FontWeight.w600),
    labelSmall: _style(15, 20, FontWeight.w600),
  );

  /// dBm, countdowns, metres: bold tabular figures, so changing numbers do not jump.
  static TextStyle numeric() => _style(
    28,
    32,
    FontWeight.w800,
  ).copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
}
