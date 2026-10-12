import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

BeneathMotion _motion(WidgetTester tester) =>
    BeneathTokens.motionOf(tester.element(find.byType(SizedBox)));

void main() {
  test('light and dark tokens carry the theme accent', () {
    expect(BeneathTokens.light().accent, BeneathColors.accentLight);
    expect(BeneathTokens.dark().accent, BeneathColors.accentDark);
    expect(BeneathTokens.light().onAccent, BeneathColors.onAccent);
  });

  test('lerp ends on the target tokens', () {
    final lerped = BeneathTokens.light().lerp(BeneathTokens.dark(), 1);
    expect(lerped.accent, BeneathColors.accentDark);
  });

  testWidgets('reduce motion turns every duration to zero', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: SizedBox(),
      ),
    );
    final motion = _motion(tester);
    expect([
      motion.short,
      motion.medium,
      motion.long,
    ], everyElement(Duration.zero));
  });

  testWidgets('standard motion is 150 / 250 / 400 ms', (tester) async {
    await tester.pumpWidget(
      const MediaQuery(data: MediaQueryData(), child: SizedBox()),
    );
    final motion = _motion(tester);
    expect(
      [motion.short, motion.medium, motion.long],
      const [
        Duration(milliseconds: 150),
        Duration(milliseconds: 250),
        Duration(milliseconds: 400),
      ],
    );
  });

  testWidgets('of() explains a missing theme extension', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    expect(
      () => BeneathTokens.of(tester.element(find.byType(SizedBox))),
      throwsA(isA<StateError>()),
    );
  });

  test('tokens with equal values are equal', () {
    expect(BeneathTokens.light(), BeneathTokens.light());
    expect(BeneathTokens.light().hashCode, BeneathTokens.light().hashCode);
    expect(BeneathTokens.light(), isNot(BeneathTokens.dark()));
  });
}
