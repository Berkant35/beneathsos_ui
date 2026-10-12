import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame(Widget child, {Brightness brightness = Brightness.light}) =>
    MaterialApp(
      theme: brightness == Brightness.light
          ? BeneathTheme.light()
          : BeneathTheme.dark(),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [child]),
        ),
      ),
    );

ButtonStyle _style<T extends ButtonStyleButton>(WidgetTester tester) =>
    tester.widget<T>(find.byType(T)).style!;

void main() {
  testWidgets('primary: 64 tall, full width, dark text on orange', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(PrimaryButton(label: 'Start a search', onPressed: () {})),
    );
    final size = tester.getSize(find.byType(PrimaryButton));
    expect(size.height, 64);
    expect(size.width, 800 - 32);
    final style = _style<FilledButton>(tester);
    expect(
      style.backgroundColor!.resolve(<WidgetState>{}),
      BeneathColors.accentLight,
    );
    expect(
      style.foregroundColor!.resolve(<WidgetState>{}),
      BeneathColors.onAccent,
    );
  });

  testWidgets('primary: dark theme uses the dark accent', (tester) async {
    await tester.pumpWidget(
      _frame(
        PrimaryButton(label: 'Start', onPressed: () {}),
        brightness: Brightness.dark,
      ),
    );
    expect(
      _style<FilledButton>(tester).backgroundColor!.resolve(<WidgetState>{}),
      BeneathColors.accentDark,
    );
  });

  testWidgets('primary: tap calls onPressed and the icon is shown', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      _frame(
        PrimaryButton(
          label: 'Start',
          icon: Icons.search_rounded,
          onPressed: () => taps++,
        ),
      ),
    );
    expect(find.byIcon(Icons.search_rounded), findsOneWidget);
    await tester.tap(find.text('Start'));
    expect(taps, 1);
  });

  testWidgets('primary: screen readers hear a button with its label', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _frame(PrimaryButton(label: 'Start a search', onPressed: () {})),
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Start a search')),
      isSemantics(label: 'Start a search', isButton: true, isEnabled: true),
    );
    handle.dispose();
  });

  testWidgets('secondary: 56 tall; light = white fill, navy label and border', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(SecondaryButton(label: 'I am trapped', onPressed: () {})),
    );
    expect(tester.getSize(find.byType(SecondaryButton)).height, 56);
    final style = _style<OutlinedButton>(tester);
    expect(
      style.backgroundColor!.resolve(<WidgetState>{}),
      BeneathColors.white,
    );
    expect(
      style.foregroundColor!.resolve(<WidgetState>{}),
      BeneathColors.primaryLight,
    );
    expect(
      style.side!.resolve(<WidgetState>{})!.color,
      BeneathColors.primaryLight,
    );
  });

  testWidgets('secondary: dark = #22324F fill, light label', (tester) async {
    await tester.pumpWidget(
      _frame(
        SecondaryButton(label: 'I am trapped', onPressed: () {}),
        brightness: Brightness.dark,
      ),
    );
    final style = _style<OutlinedButton>(tester);
    expect(
      style.backgroundColor!.resolve(<WidgetState>{}),
      BeneathColors.surface2Dark,
    );
    expect(
      style.foregroundColor!.resolve(<WidgetState>{}),
      BeneathColors.textDark,
    );
  });

  testWidgets('both buttons draw 24 px icons', (tester) async {
    await tester.pumpWidget(
      _frame(PrimaryButton(label: 'Start', onPressed: () {})),
    );
    expect(_style<FilledButton>(tester).iconSize!.resolve(<WidgetState>{}), 24);
    await tester.pumpWidget(
      _frame(SecondaryButton(label: 'Trapped', onPressed: () {})),
    );
    expect(
      _style<OutlinedButton>(tester).iconSize!.resolve(<WidgetState>{}),
      24,
    );
  });
}
