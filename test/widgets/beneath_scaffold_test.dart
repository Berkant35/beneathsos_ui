import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(Widget home, {double width = 375}) => MaterialApp(
  theme: BeneathTheme.light(),
  home: MediaQuery(
    data: MediaQueryData(size: Size(width, 800)),
    child: home,
  ),
);

void main() {
  testWidgets('without a title there is no app bar', (tester) async {
    await tester.pumpWidget(_app(const BeneathScaffold(body: Text('body'))));
    expect(find.byType(AppBar), findsNothing);
    expect(find.text('body'), findsOneWidget);
  });

  testWidgets('with a title the app bar shows it', (tester) async {
    await tester.pumpWidget(
      _app(const BeneathScaffold(title: 'Title', body: Text('body'))),
    );
    expect(find.widgetWithText(AppBar, 'Title'), findsOneWidget);
  });

  testWidgets('page padding is 16 on phones and none when not padded', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const BeneathScaffold(body: Text('body'))));
    expect(tester.getTopLeft(find.text('body')).dx, greaterThanOrEqualTo(16));
    await tester.pumpWidget(
      _app(const BeneathScaffold(padded: false, body: Text('body'))),
    );
    expect(
      find
          .byType(Padding)
          .evaluate()
          .where(
            (e) => (e.widget as Padding).padding == const EdgeInsets.all(16),
          ),
      isEmpty,
    );
  });
}
