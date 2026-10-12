import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(
  Widget child, {
  Brightness brightness = Brightness.light,
  bool reduceMotion = false,
  double textScale = 1,
}) => MaterialApp(
  theme: brightness == Brightness.light
      ? BeneathTheme.light()
      : BeneathTheme.dark(),
  home: Builder(
    builder: (context) => MediaQuery(
      data: MediaQuery.of(context).copyWith(
        disableAnimations: reduceMotion,
        textScaler: TextScaler.linear(textScale),
      ),
      child: Scaffold(body: Center(child: child)),
    ),
  ),
);

CountdownRingPainter _painter(WidgetTester tester) => tester
    .widgetList<CustomPaint>(
      find.descendant(
        of: find.byType(CountdownRing),
        matching: find.byType(CustomPaint),
      ),
    )
    .map((paint) => paint.painter)
    .whereType<CountdownRingPainter>()
    .single;

Widget _ring(
  Duration remaining, {
  Duration total = const Duration(seconds: 15),
}) => CountdownRing(
  total: total,
  remaining: remaining,
  semanticLabel: 'time left',
);

void main() {
  test('centre text: seconds under a minute, m:ss above, rounded up', () {
    expect(CountdownRing.centreText(const Duration(seconds: 15)), '15');
    expect(CountdownRing.centreText(const Duration(milliseconds: 7500)), '8');
    expect(CountdownRing.centreText(Duration.zero), '0');
    expect(CountdownRing.centreText(const Duration(seconds: 60)), '1:00');
    expect(
      CountdownRing.centreText(const Duration(minutes: 13, seconds: 5)),
      '13:05',
    );
    expect(CountdownRing.centreText(const Duration(seconds: -3)), '0');
  });

  testWidgets(
    'full, half and empty fractions; arc in primary, track in outlineVariant',
    (tester) async {
      await tester.pumpWidget(_frame(_ring(const Duration(seconds: 15))));
      expect(_painter(tester).fraction, 1);
      expect(_painter(tester).arc, BeneathColors.primaryLight);
      expect(_painter(tester).track, BeneathColors.outlineVariantLight);
      await tester.pumpWidget(
        _frame(_ring(const Duration(milliseconds: 7500))),
      );
      expect(_painter(tester).fraction, 0.5);
      await tester.pumpWidget(_frame(_ring(Duration.zero)));
      expect(_painter(tester).fraction, 0);
    },
  );

  testWidgets(
    'clamps past zero and above total; a zero total does not divide by zero',
    (tester) async {
      await tester.pumpWidget(_frame(_ring(const Duration(seconds: -2))));
      expect(_painter(tester).fraction, 0);
      await tester.pumpWidget(_frame(_ring(const Duration(seconds: 20))));
      expect(_painter(tester).fraction, 1);
      await tester.pumpWidget(
        _frame(_ring(const Duration(seconds: 1), total: Duration.zero)),
      );
      expect(_painter(tester).fraction, 0);
    },
  );

  testWidgets('dark theme arc is the dark primary', (tester) async {
    await tester.pumpWidget(
      _frame(_ring(const Duration(seconds: 10)), brightness: Brightness.dark),
    );
    expect(_painter(tester).arc, BeneathColors.primaryDark);
  });

  testWidgets('reduce motion: number only, no arc', (tester) async {
    await tester.pumpWidget(
      _frame(_ring(const Duration(seconds: 10)), reduceMotion: true),
    );
    expect(_painter(tester).showArc, isFalse);
    expect(find.text('10'), findsOneWidget);
  });

  testWidgets('screen readers hear one label and it is not a live region', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(_frame(_ring(const Duration(seconds: 12))));
    expect(
      tester.getSemantics(find.byType(CountdownRing)),
      isSemantics(label: 'time left', isLiveRegion: false),
    );
    handle.dispose();
  });

  testWidgets('200 % text: the number shrinks to fit inside the ring', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        _ring(
          const Duration(minutes: 13, seconds: 5),
          total: const Duration(minutes: 15),
        ),
        textScale: 2,
      ),
    );
    expect(tester.takeException(), isNull);
    final ring = tester.getRect(find.byType(CountdownRing));
    final text = tester.getRect(find.text('13:05'));
    expect(
      ring.contains(text.topLeft) && ring.contains(text.bottomRight),
      isTrue,
    );
  });
}
