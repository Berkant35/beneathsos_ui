import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

double _rounded(Color a, Color b) => (contrastRatio(a, b) * 10).round() / 10;

void main() {
  group('text pairs keep their WCAG ratio (spec §4)', () {
    final cases = <(String, Color, Color, double)>[
      (
        'white on primary',
        BeneathColors.white,
        BeneathColors.primaryLight,
        14.1,
      ),
      (
        'text on background',
        BeneathColors.textLight,
        BeneathColors.backgroundLight,
        16.1,
      ),
      (
        'on-accent on accent, light',
        BeneathColors.onAccent,
        BeneathColors.accentLight,
        7.3,
      ),
      (
        'on-accent on accent, dark',
        BeneathColors.onAccent,
        BeneathColors.accentDark,
        8.2,
      ),
      ('white on error', BeneathColors.white, BeneathColors.errorLight, 6.5),
      (
        'on-error on error, dark',
        BeneathColors.onErrorDark,
        BeneathColors.errorDark,
        7.7,
      ),
      (
        'on-primary on primary, dark',
        BeneathColors.backgroundDark,
        BeneathColors.primaryDark,
        8.9,
      ),
      (
        'text on background, dark',
        BeneathColors.textDark,
        BeneathColors.backgroundDark,
        15.9,
      ),
      (
        'text on secondary surface, dark',
        BeneathColors.textDark,
        BeneathColors.surface2Dark,
        10.8,
      ),
      (
        'accent on background, dark',
        BeneathColors.accentDark,
        BeneathColors.backgroundDark,
        8.1,
      ),
    ];
    for (final (name, fg, bg, expected) in cases) {
      test(name, () => expect(_rounded(fg, bg), expected));
    }
  });

  test('outlines reach 3:1 on every surface they sit on', () {
    expect(
      contrastRatio(BeneathColors.outlineLight, BeneathColors.backgroundLight),
      greaterThanOrEqualTo(3),
    );
    expect(
      contrastRatio(BeneathColors.outlineLight, BeneathColors.white),
      greaterThanOrEqualTo(3),
    );
    expect(
      contrastRatio(BeneathColors.outlineDark, BeneathColors.backgroundDark),
      greaterThanOrEqualTo(3),
    );
    expect(
      contrastRatio(BeneathColors.outlineDark, BeneathColors.surface2Dark),
      greaterThanOrEqualTo(3),
    );
  });

  test('orange stays forbidden for text and icons on light backgrounds', () {
    expect(
      contrastRatio(BeneathColors.accentLight, BeneathColors.backgroundLight),
      lessThan(3),
    );
    expect(
      contrastRatio(BeneathColors.white, BeneathColors.accentLight),
      lessThan(4.5),
    );
  });

  test('argument order does not matter', () {
    expect(
      contrastRatio(BeneathColors.white, BeneathColors.primaryLight),
      contrastRatio(BeneathColors.primaryLight, BeneathColors.white),
    );
  });
}
