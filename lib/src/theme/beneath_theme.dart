import 'package:beneathsos_ui/src/theme/beneath_tokens.dart';
import 'package:beneathsos_ui/src/tokens/colors.dart';
import 'package:beneathsos_ui/src/tokens/sizes.dart';
import 'package:beneathsos_ui/src/tokens/typography.dart';
import 'package:flutter/material.dart';

/// The BeneathSOS light and dark themes. Apps pass both and follow the system setting.
abstract final class BeneathTheme {
  /// Light theme.
  static ThemeData light() => _build(_light, BeneathTokens.light());

  /// Dark theme.
  static ThemeData dark() => _build(_dark, BeneathTokens.dark());

  // secondary and tertiary are navy on purpose: no built-in widget may paint orange text or icons.
  static const ColorScheme _light = ColorScheme(
    brightness: Brightness.light,
    primary: BeneathColors.primaryLight,
    onPrimary: BeneathColors.white,
    secondary: BeneathColors.primaryLight,
    onSecondary: BeneathColors.white,
    tertiary: BeneathColors.primaryLight,
    onTertiary: BeneathColors.white,
    error: BeneathColors.errorLight,
    onError: BeneathColors.white,
    surface: BeneathColors.backgroundLight,
    onSurface: BeneathColors.textLight,
    surfaceContainerLowest: BeneathColors.white,
    surfaceContainerLow: BeneathColors.white,
    surfaceContainer: BeneathColors.white,
    surfaceContainerHigh: BeneathColors.white,
    surfaceContainerHighest: BeneathColors.white,
    outline: BeneathColors.outlineLight,
  );

  static const ColorScheme _dark = ColorScheme(
    brightness: Brightness.dark,
    primary: BeneathColors.primaryDark,
    onPrimary: BeneathColors.backgroundDark,
    secondary: BeneathColors.primaryDark,
    onSecondary: BeneathColors.backgroundDark,
    tertiary: BeneathColors.primaryDark,
    onTertiary: BeneathColors.backgroundDark,
    error: BeneathColors.errorDark,
    onError: BeneathColors.onErrorDark,
    surface: BeneathColors.backgroundDark,
    onSurface: BeneathColors.textDark,
    surfaceContainerLowest: BeneathColors.surface2Dark,
    surfaceContainerLow: BeneathColors.surface2Dark,
    surfaceContainer: BeneathColors.surface2Dark,
    surfaceContainerHigh: BeneathColors.surface2Dark,
    surfaceContainerHighest: BeneathColors.surface2Dark,
    outline: BeneathColors.outlineDark,
  );

  static ThemeData _build(ColorScheme scheme, BeneathTokens tokens) {
    final text = BeneathTypography.textTheme();
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(BeneathSizes.radius),
    );
    const minimum = Size(
      BeneathSizes.minTouchTarget,
      BeneathSizes.minTouchTarget,
    );
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      textTheme: text,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      extensions: [tokens],
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.primary,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: text.headlineSmall?.copyWith(color: scheme.primary),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: minimum,
          shape: shape,
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: minimum,
          shape: shape,
          textStyle: text.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: minimum,
          shape: shape,
          textStyle: text.labelLarge,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: minimum,
          shape: shape,
          textStyle: text.labelLarge,
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainer,
        shape: shape,
        elevation: 0,
      ),
      listTileTheme: const ListTileThemeData(
        minVerticalPadding: 10,
        minTileHeight: BeneathSizes.minTouchTarget,
      ),
    );
  }
}
