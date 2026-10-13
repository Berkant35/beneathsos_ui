import 'package:beneathsos_catalogue/catalogue.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';

/// Widgetbook route path of every use case (`category/component/use-case`, lower-case, dashes).
List<String> _useCasePaths() {
  String slug(String name) => name.replaceAll(' ', '-').toLowerCase();
  return [
    for (final category in catalogueDirectories().cast<WidgetbookCategory>())
      for (final component in category.children!.cast<WidgetbookComponent>())
        for (final useCase in component.useCases)
          '${slug(category.name)}/${slug(component.name)}/${slug(useCase.name)}',
  ];
}

void main() {
  test('the catalogue covers every public component', () {
    final components = [
      for (final category in catalogueDirectories().cast<WidgetbookCategory>())
        ...category.children!.map((node) => node.name),
    ];
    expect(
      components,
      containsAll(<String>[
        'Colours',
        'Typography',
        'BeneathLogo',
        'PrimaryButton',
        'SecondaryButton',
        'StatusBanner',
        'BeneathCard',
        'CountdownRing',
        'BeneathScaffold',
      ]),
    );
  });

  testWidgets(
    'the catalogue opens on the BeneathSOS home, not a marketing page',
    (tester) async {
      await tester.pumpWidget(const CatalogueApp());
      await tester.pumpAndSettle();
      expect(find.text('BeneathSOS UI catalogue'), findsOneWidget);
    },
  );

  for (final path in _useCasePaths()) {
    for (final dark in [false, true]) {
      testWidgets('$path renders (${dark ? 'dark' : 'light'})', (tester) async {
        tester.view
          ..physicalSize = const Size(1600, 1200)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.reset);
        await tester.pumpWidget(
          CatalogueApp(initialRoute: '/?path=$path', dark: dark),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        final state = WidgetbookState.of(
          tester.element(find.byType(Text).first),
        );
        expect(
          state.useCase,
          isNotNull,
          reason: 'path did not open a use case',
        );
      });
    }
  }
}
