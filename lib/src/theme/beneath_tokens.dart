import 'package:beneathsos_ui/src/tokens/colors.dart';
import 'package:beneathsos_ui/src/tokens/motion.dart';
import 'package:beneathsos_ui/src/tokens/typography.dart';
import 'package:flutter/material.dart';

/// Brand tokens Material has no slot for. Read with [BeneathTokens.of].
@immutable
class BeneathTokens extends ThemeExtension<BeneathTokens> {
  /// Creates tokens.
  const BeneathTokens({
    required this.accent,
    required this.onAccent,
    required this.numeric,
  });

  /// Light-theme tokens.
  factory BeneathTokens.light() => BeneathTokens(
    accent: BeneathColors.accentLight,
    onAccent: BeneathColors.onAccent,
    numeric: BeneathTypography.numeric(),
  );

  /// Dark-theme tokens.
  factory BeneathTokens.dark() => BeneathTokens(
    accent: BeneathColors.accentDark,
    onAccent: BeneathColors.onAccent,
    numeric: BeneathTypography.numeric(),
  );

  /// Action and attention fill. In the light theme never use it for text or icons.
  final Color accent;

  /// Text and icons on [accent].
  final Color onAccent;

  /// Style for changing numbers (dBm, countdowns, metres).
  final TextStyle numeric;

  /// The tokens of the nearest theme. Throws a [StateError] if the theme is not a BeneathSOS theme.
  static BeneathTokens of(BuildContext context) =>
      Theme.of(context).extension<BeneathTokens>() ??
      (throw StateError(
        'No BeneathTokens: use BeneathTheme.light() or BeneathTheme.dark().',
      ));

  /// Motion for this context: [BeneathMotion.reduced] when the system asks to reduce motion.
  static BeneathMotion motionOf(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context)
      ? BeneathMotion.reduced
      : BeneathMotion.standard;

  @override
  BeneathTokens copyWith({
    Color? accent,
    Color? onAccent,
    TextStyle? numeric,
  }) => BeneathTokens(
    accent: accent ?? this.accent,
    onAccent: onAccent ?? this.onAccent,
    numeric: numeric ?? this.numeric,
  );

  @override
  BeneathTokens lerp(covariant BeneathTokens? other, double t) {
    if (other == null) return this;
    return BeneathTokens(
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      numeric: TextStyle.lerp(numeric, other.numeric, t)!,
    );
  }
}
