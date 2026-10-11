import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden.dart';

SignalExitPainter _painter(WidgetTester tester) => tester
    .widgetList<CustomPaint>(
      find.descendant(
        of: find.byType(BeneathLogo),
        matching: find.byType(CustomPaint),
      ),
    )
    .map((paint) => paint.painter)
    .whereType<SignalExitPainter>()
    .single;

void main() {
  testWidgets('screen readers read the logo by its label, once', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      goldenFrame(
        const BeneathLogo.lockup(semanticLabel: 'BeneathSOS'),
        brightness: Brightness.light,
      ),
    );
    expect(find.bySemanticsLabel('BeneathSOS'), findsOneWidget);
    handle.dispose();
  });

  testWidgets('colours follow the light theme', (tester) async {
    await tester.pumpWidget(
      goldenFrame(
        const BeneathLogo.symbol(semanticLabel: 'BeneathSOS'),
        brightness: Brightness.light,
      ),
    );
    expect(
      (_painter(tester).line, _painter(tester).accent),
      (BeneathColors.primaryLight, BeneathColors.accentLight),
    );
  });

  testWidgets('colours follow the dark theme', (tester) async {
    await tester.pumpWidget(
      goldenFrame(
        const BeneathLogo.symbol(semanticLabel: 'BeneathSOS'),
        brightness: Brightness.dark,
      ),
    );
    expect(
      (_painter(tester).line, _painter(tester).accent),
      (BeneathColors.primaryDark, BeneathColors.accentDark),
    );
  });

  testWidgets(
    'the lock-up spells Beneath + SOS and ignores system text scaling',
    (tester) async {
      await tester.pumpWidget(
        goldenFrame(
          const BeneathLogo.lockup(semanticLabel: 'BeneathSOS'),
          brightness: Brightness.light,
        ),
      );
      final text = tester.widget<RichText>(
        find.descendant(
          of: find.byType(BeneathLogo),
          matching: find.byType(RichText),
        ),
      );
      expect(text.text.toPlainText(), 'BeneathSOS');
      expect(text.textScaler, TextScaler.noScaling);
    },
  );

  test('repaints only when a colour changes', () {
    const a = SignalExitPainter(
      line: BeneathColors.primaryLight,
      accent: BeneathColors.accentLight,
    );
    const b = SignalExitPainter(
      line: BeneathColors.primaryLight,
      accent: BeneathColors.accentLight,
    );
    const c = SignalExitPainter(
      line: BeneathColors.primaryDark,
      accent: BeneathColors.accentLight,
    );
    expect(a.shouldRepaint(b), isFalse);
    expect(a.shouldRepaint(c), isTrue);
  });
}
