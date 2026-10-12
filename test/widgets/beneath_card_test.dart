import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(Widget child, {Brightness brightness = Brightness.light}) =>
    MaterialApp(
      theme: brightness == Brightness.light
          ? BeneathTheme.light()
          : BeneathTheme.dark(),
      home: Scaffold(
        body: Padding(padding: const EdgeInsets.all(16), child: child),
      ),
    );

Material _surface(WidgetTester tester) => tester.widget<Material>(
  find
      .descendant(of: find.byType(BeneathCard), matching: find.byType(Material))
      .first,
);

Color _border(WidgetTester tester) =>
    (_surface(tester).shape! as RoundedRectangleBorder).side.color;

void main() {
  testWidgets(
    'shows title, icon and content on the container colour with a calm border',
    (tester) async {
      await tester.pumpWidget(
        _frame(
          const BeneathCard(
            title: 'Being prepared',
            icon: Icons.construction_rounded,
            child: Text('Body'),
          ),
        ),
      );
      expect(find.text('Being prepared'), findsOneWidget);
      expect(find.byIcon(Icons.construction_rounded), findsOneWidget);
      expect(find.text('Body'), findsOneWidget);
      expect(_surface(tester).color, BeneathColors.white);
      expect(_border(tester), BeneathColors.outlineVariantLight);
    },
  );

  testWidgets('dark: secondary surface and dark border', (tester) async {
    await tester.pumpWidget(
      _frame(
        const BeneathCard(child: Text('Body')),
        brightness: Brightness.dark,
      ),
    );
    expect(_surface(tester).color, BeneathColors.surface2Dark);
    expect(_border(tester), BeneathColors.outlineVariantDark);
  });

  testWidgets('with onTap it is a button for screen readers and calls back', (
    tester,
  ) async {
    var taps = 0;
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _frame(
        BeneathCard(
          title: 'Open',
          onTap: () => taps++,
          child: const Text('Body'),
        ),
      ),
    );
    expect(
      tester.getSemantics(find.byType(BeneathCard)),
      isSemantics(isButton: true),
    );
    await tester.tap(find.byType(BeneathCard));
    expect(taps, 1);
    handle.dispose();
  });

  testWidgets('without onTap it is not a button', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _frame(const BeneathCard(title: 'Info', child: Text('Body'))),
    );
    expect(
      tester.getSemantics(find.byType(BeneathCard)),
      isNot(isSemantics(isButton: true)),
    );
    handle.dispose();
  });

  testWidgets('the title is a heading for screen readers', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _frame(const BeneathCard(title: 'Being prepared', child: Text('Body'))),
    );
    expect(
      tester.getSemantics(find.text('Being prepared')),
      isSemantics(label: 'Being prepared', isHeader: true),
    );
    handle.dispose();
  });

  testWidgets('a tappable card is a button, not a heading', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _frame(
        BeneathCard(title: 'Open', onTap: () {}, child: const Text('Body')),
      ),
    );
    expect(
      tester.getSemantics(find.byType(BeneathCard)),
      isSemantics(isButton: true, isHeader: false),
    );
    handle.dispose();
  });
}
