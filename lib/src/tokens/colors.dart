import 'dart:ui';

/// The BeneathSOS palette (`docs/brand/README.md` in the hub). Widgets read colours from the theme;
/// use these constants only to build themes and in tests.
abstract final class BeneathColors {
  /// Ink navy — primary in the light theme.
  static const Color primaryLight = Color(0xFF1B2A4E);

  /// Light navy — primary in the dark theme.
  static const Color primaryDark = Color(0xFF9DB2E0);

  /// Safety orange — accent fill in the light theme. Never text or icons on light backgrounds.
  static const Color accentLight = Color(0xFFFF7900);

  /// Accent in the dark theme.
  static const Color accentDark = Color(0xFFFF8C2E);

  /// Text and icons on the accent, both themes. White on orange is forbidden.
  static const Color onAccent = Color(0xFF1A0D00);

  /// Error (blocked state) in the light theme.
  static const Color errorLight = Color(0xFFB3261E);

  /// Error in the dark theme.
  static const Color errorDark = Color(0xFFFFB4AB);

  /// Text and icons on the dark-theme error colour.
  static const Color onErrorDark = Color(0xFF690005);

  /// Background in the light theme.
  static const Color backgroundLight = Color(0xFFF5F6F9);

  /// Text in the light theme.
  static const Color textLight = Color(0xFF121A2B);

  /// Background in the dark theme.
  static const Color backgroundDark = Color(0xFF0C111D);

  /// Text in the dark theme.
  static const Color textDark = Color(0xFFE8ECF5);

  /// Secondary surface in the dark theme (cards, secondary buttons).
  static const Color surface2Dark = Color(0xFF22324F);

  /// Borders in the light theme (≥ 3:1 on its surfaces).
  static const Color outlineLight = Color(0xFF6B7590);

  /// Borders in the dark theme (≥ 3:1 on its surfaces).
  static const Color outlineDark = Color(0xFF8C9AB8);

  /// Calm borders and dividers in the light theme (decorative; never carries information).
  static const Color outlineVariantLight = Color(0xFFD5DAE5);

  /// Calm borders and dividers in the dark theme (decorative; never carries information).
  static const Color outlineVariantDark = Color(0xFF33456A);

  /// White.
  static const Color white = Color(0xFFFFFFFF);
}
