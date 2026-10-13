import 'package:beneathsos_catalogue/catalogue_home.dart';
import 'package:beneathsos_catalogue/flows/flows.dart';
import 'package:beneathsos_catalogue/use_cases/brand.dart';
import 'package:beneathsos_catalogue/use_cases/buttons.dart';
import 'package:beneathsos_catalogue/use_cases/cards.dart';
import 'package:beneathsos_catalogue/use_cases/countdown.dart';
import 'package:beneathsos_catalogue/use_cases/foundations.dart';
import 'package:beneathsos_catalogue/use_cases/layout.dart';
import 'package:beneathsos_catalogue/use_cases/status.dart';
import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

final _light = WidgetbookTheme(name: 'Light', data: BeneathTheme.light());
final _dark = WidgetbookTheme(name: 'Dark', data: BeneathTheme.dark());

/// Every component of `beneathsos_ui`, grouped as the catalogue shows them.
List<WidgetbookNode> catalogueDirectories() => [
  WidgetbookCategory(name: 'Foundations', children: [colours, typography]),
  WidgetbookCategory(
    name: 'Components',
    children: [
      logo,
      primaryButton,
      secondaryButton,
      statusBanner,
      card,
      countdownRing,
      scaffold,
    ],
  ),
  flowsCategory,
];

/// The BeneathSOS component catalogue (Widgetbook).
class CatalogueApp extends StatelessWidget {
  /// Creates the catalogue; [initialRoute] and [dark] are for tests and deep links.
  const CatalogueApp({super.key, this.initialRoute = '/', this.dark = false});

  /// Widgetbook route, e.g. `/?path=components/statusbanner/blocked`.
  final String initialRoute;

  /// Start in the dark theme.
  final bool dark;

  @override
  Widget build(BuildContext context) => Widgetbook.material(
    initialRoute: initialRoute,
    home: const CatalogueHome(),
    directories: catalogueDirectories(),
    addons: [
      MaterialThemeAddon(
        themes: [_light, _dark],
        initialTheme: dark ? _dark : _light,
      ),
      TextScaleAddon(min: 1, divisions: 2),
      ViewportAddon(const [
        ViewportData(
          name: 'Small phone 375 × 667',
          width: 375,
          height: 667,
          pixelRatio: 2,
          platform: TargetPlatform.iOS,
        ),
        ViewportData(
          name: 'Phone 402 × 874',
          width: 402,
          height: 874,
          pixelRatio: 3,
          platform: TargetPlatform.iOS,
        ),
      ]),
    ],
  );
}
