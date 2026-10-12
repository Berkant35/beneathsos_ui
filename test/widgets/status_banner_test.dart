import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/readable.dart';

Widget _frame(
  Widget child, {
  Brightness brightness = Brightness.light,
  double textScale = 1,
  bool reduceMotion = false,
}) => MaterialApp(
  theme: brightness == Brightness.light
      ? BeneathTheme.light()
      : BeneathTheme.dark(),
  home: Builder(
    builder: (context) => MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(textScale),
        disableAnimations: reduceMotion,
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [child]),
        ),
      ),
    ),
  ),
);

Material _surface(WidgetTester tester) => tester.widget<Material>(
  find
      .descendant(
        of: find.byType(StatusBanner),
        matching: find.byType(Material),
      )
      .first,
);

Color? _textColour(WidgetTester tester, String message) =>
    tester.widget<Text>(find.text(message)).style?.color;

void main() {
  testWidgets('ready, light: white fill, dark text, calm border, check icon', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(const StatusBanner(kind: StatusKind.ready, message: 'Ready.')),
    );
    final shape = _surface(tester).shape! as RoundedRectangleBorder;
    expect(_surface(tester).color, BeneathColors.white);
    expect(shape.side.color, BeneathColors.outlineVariantLight);
    expect(_textColour(tester, 'Ready.'), BeneathColors.textLight);
    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
  });

  testWidgets('ready, dark: secondary surface fill, light text', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(
        const StatusBanner(kind: StatusKind.ready, message: 'Ready.'),
        brightness: Brightness.dark,
      ),
    );
    expect(_surface(tester).color, BeneathColors.surface2Dark);
    expect(_textColour(tester, 'Ready.'), BeneathColors.textDark);
  });

  testWidgets('attention: orange fill, dark text, warning icon', (
    tester,
  ) async {
    await tester.pumpWidget(
      _frame(const StatusBanner(kind: StatusKind.attention, message: 'Look.')),
    );
    expect(_surface(tester).color, BeneathColors.accentLight);
    expect(_textColour(tester, 'Look.'), BeneathColors.onAccent);
    expect(find.byIcon(Icons.warning_rounded), findsOneWidget);
  });

  testWidgets('blocked, light: readable red, block icon', (tester) async {
    await tester.pumpWidget(
      _frame(const StatusBanner(kind: StatusKind.blocked, message: 'Off.')),
    );
    expect(_surface(tester).color, BeneathColors.errorLight);
    expect(_textColour(tester, 'Off.'), BeneathColors.white);
    expect(find.byIcon(Icons.block_rounded), findsOneWidget);
  });

  testWidgets('blocked, dark: light red fill, dark red text', (tester) async {
    await tester.pumpWidget(
      _frame(
        const StatusBanner(kind: StatusKind.blocked, message: 'Off.'),
        brightness: Brightness.dark,
      ),
    );
    expect(_surface(tester).color, BeneathColors.errorDark);
    expect(_textColour(tester, 'Off.'), BeneathColors.onErrorDark);
  });

  testWidgets('a custom icon replaces the default', (tester) async {
    await tester.pumpWidget(
      _frame(
        const StatusBanner(
          kind: StatusKind.ready,
          message: 'Wait.',
          icon: Icons.hourglass_top_rounded,
        ),
      ),
    );
    expect(find.byIcon(Icons.hourglass_top_rounded), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_rounded), findsNothing);
  });

  testWidgets('tappable: a 56 px button with a chevron that calls onTap', (
    tester,
  ) async {
    var taps = 0;
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _frame(
        StatusBanner(
          kind: StatusKind.blocked,
          message: 'Tap me.',
          onTap: () => taps++,
        ),
      ),
    );
    expect(
      tester.getSize(find.byType(StatusBanner)).height,
      greaterThanOrEqualTo(56),
    );
    expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Tap me.')),
      isSemantics(label: 'Tap me.', isButton: true, isLiveRegion: true),
    );
    await tester.tap(find.byType(StatusBanner));
    expect(taps, 1);
    handle.dispose();
  });

  testWidgets('not tappable: no chevron, not a button, still a live region', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _frame(const StatusBanner(kind: StatusKind.ready, message: 'Ready.')),
    );
    expect(find.byIcon(Icons.chevron_right_rounded), findsNothing);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Ready.')),
      isSemantics(label: 'Ready.', isButton: false, isLiveRegion: true),
    );
    handle.dispose();
  });

  testWidgets('200 % text: the message wraps and is not clipped', (
    tester,
  ) async {
    const message =
        'Bluetooth permission is off. Tap to turn it on in Settings.';
    await tester.pumpWidget(
      _frame(
        StatusBanner(kind: StatusKind.blocked, message: message, onTap: () {}),
        textScale: 2,
      ),
    );
    expect(tester.takeException(), isNull);
    expectNotClipped(tester, find.text(message));
  });

  testWidgets('reduce motion: the cross-fade takes no time', (tester) async {
    await tester.pumpWidget(
      _frame(
        const StatusBanner(kind: StatusKind.ready, message: 'Ready.'),
        reduceMotion: true,
      ),
    );
    expect(
      tester.widget<AnimatedSwitcher>(find.byType(AnimatedSwitcher)).duration,
      Duration.zero,
    );
  });
}
