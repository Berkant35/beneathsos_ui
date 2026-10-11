@Tags(['golden'])
library;

import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden.dart';

void main() {
  setUpAll(loadBeneathFont);

  for (final brightness in Brightness.values) {
    testWidgets('symbol, ${brightness.name}', (tester) async {
      await tester.pumpWidget(
        goldenFrame(
          const BeneathLogo.symbol(size: 96, semanticLabel: 'BeneathSOS'),
          brightness: brightness,
        ),
      );
      await expectLater(
        find.byKey(goldenKey),
        matchesGoldenFile('goldens/logo_symbol_${brightness.name}.png'),
      );
    });

    testWidgets('lock-up, ${brightness.name}', (tester) async {
      await tester.pumpWidget(
        goldenFrame(
          const BeneathLogo.lockup(semanticLabel: 'BeneathSOS'),
          brightness: brightness,
        ),
      );
      await expectLater(
        find.byKey(goldenKey),
        matchesGoldenFile('goldens/logo_lockup_${brightness.name}.png'),
      );
    });
  }
}
