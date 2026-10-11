import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final theme = BeneathTypography.textTheme();

  test('every role uses the bundled Atkinson font', () {
    final styles = [
      theme.displaySmall,
      theme.headlineSmall,
      theme.titleLarge,
      theme.bodyLarge,
      theme.bodyMedium,
      theme.bodySmall,
      theme.labelLarge,
      BeneathTypography.numeric(),
    ];
    for (final style in styles) {
      expect(
        style!.fontFamily,
        'packages/beneathsos_ui/AtkinsonHyperlegibleNext',
      );
    }
  });

  test('body text is never below 17', () {
    expect(theme.bodyLarge!.fontSize, 19);
    expect(theme.bodyMedium!.fontSize, 17);
  });

  test('spec sizes and weights', () {
    expect(
      (theme.displaySmall!.fontSize, theme.displaySmall!.fontWeight),
      (32, FontWeight.w800),
    );
    expect(
      (theme.headlineSmall!.fontSize, theme.headlineSmall!.fontWeight),
      (24, FontWeight.w700),
    );
    expect(
      (theme.titleLarge!.fontSize, theme.titleLarge!.fontWeight),
      (20, FontWeight.w700),
    );
    expect(
      (theme.labelLarge!.fontSize, theme.labelLarge!.fontWeight),
      (19, FontWeight.w700),
    );
    expect(
      (theme.bodySmall!.fontSize, theme.bodySmall!.fontWeight),
      (15, FontWeight.w400),
    );
    expect(
      theme.bodyLarge!.height! * theme.bodyLarge!.fontSize!,
      closeTo(28, 0.001),
    );
  });

  test('numbers use bold tabular figures so changing values do not jump', () {
    final numeric = BeneathTypography.numeric();
    expect(numeric.fontFeatures, contains(const FontFeature.tabularFigures()));
    expect((numeric.fontSize, numeric.fontWeight), (28, FontWeight.w800));
  });
}
