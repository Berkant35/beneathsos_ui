import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void _expectCommon(ThemeData theme, Color accent) {
  final s = theme.colorScheme;
  for (final role in [
    s.primary,
    s.secondary,
    s.tertiary,
    s.primaryContainer,
    s.secondaryContainer,
    s.tertiaryContainer,
    s.onSurface,
    s.onSurfaceVariant,
    s.outline,
  ]) {
    expect(role, isNot(accent), reason: 'no Material role may be orange');
  }
  expect(theme.extension<BeneathTokens>()!.accent, accent);
  expect(
    theme.textTheme.bodyMedium!.fontFamily,
    'packages/beneathsos_ui/AtkinsonHyperlegibleNext',
  );
  for (final style in [
    theme.filledButtonTheme.style,
    theme.outlinedButtonTheme.style,
    theme.textButtonTheme.style,
    theme.elevatedButtonTheme.style,
  ]) {
    expect(
      style!.minimumSize!.resolve(<WidgetState>{})!.height,
      greaterThanOrEqualTo(56),
    );
  }
  expect(theme.scaffoldBackgroundColor, s.surface);
  expect(
    theme.primaryTextTheme.bodyLarge!.fontFamily,
    'packages/beneathsos_ui/AtkinsonHyperlegibleNext',
  );
  final icon = theme.iconButtonTheme.style?.minimumSize?.resolve(
    <WidgetState>{},
  );
  expect(
    icon,
    isNotNull,
    reason: 'icon buttons (e.g. Back) need a 56 px target',
  );
  expect(icon!.shortestSide, greaterThanOrEqualTo(56));
}

void main() {
  test('light theme uses the brand palette', () {
    final theme = BeneathTheme.light();
    final s = theme.colorScheme;
    expect(s.brightness, Brightness.light);
    expect(
      (s.primary, s.onPrimary),
      (BeneathColors.primaryLight, BeneathColors.white),
    );
    expect(
      (s.secondary, s.tertiary),
      (BeneathColors.primaryLight, BeneathColors.primaryLight),
    );
    expect(
      (s.surface, s.onSurface),
      (BeneathColors.backgroundLight, BeneathColors.textLight),
    );
    expect(s.surfaceContainer, BeneathColors.white);
    expect(
      (s.error, s.onError),
      (BeneathColors.errorLight, BeneathColors.white),
    );
    expect(s.outline, BeneathColors.outlineLight);
    _expectCommon(theme, BeneathColors.accentLight);
  });

  test('dark theme uses the brand palette', () {
    final theme = BeneathTheme.dark();
    final s = theme.colorScheme;
    expect(s.brightness, Brightness.dark);
    expect(
      (s.primary, s.onPrimary),
      (BeneathColors.primaryDark, BeneathColors.backgroundDark),
    );
    expect(
      (s.secondary, s.tertiary),
      (BeneathColors.primaryDark, BeneathColors.primaryDark),
    );
    expect(
      (s.surface, s.onSurface),
      (BeneathColors.backgroundDark, BeneathColors.textDark),
    );
    expect(s.surfaceContainer, BeneathColors.surface2Dark);
    expect(
      (s.error, s.onError),
      (BeneathColors.errorDark, BeneathColors.onErrorDark),
    );
    expect(s.outline, BeneathColors.outlineDark);
    _expectCommon(theme, BeneathColors.accentDark);
  });

  test('outlineVariant is the calm border colour', () {
    expect(
      BeneathTheme.light().colorScheme.outlineVariant,
      BeneathColors.outlineVariantLight,
    );
    expect(
      BeneathTheme.dark().colorScheme.outlineVariant,
      BeneathColors.outlineVariantDark,
    );
  });

  test('themes are stable between calls (no theme animation on rebuild)', () {
    expect(BeneathTheme.light(), BeneathTheme.light());
    expect(BeneathTheme.dark(), BeneathTheme.dark());
  });
}
