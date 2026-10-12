@Tags(['golden'])
library;

import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden.dart';

void main() {
  setUpAll(loadBeneathFont);

  for (final brightness in Brightness.values) {
    testWidgets('card, ${brightness.name}', (tester) async {
      await tester.pumpWidget(
        goldenFrame(
          const SizedBox(
            width: 360,
            child: BeneathCard(
              title: 'Being prepared',
              icon: Icons.construction_rounded,
              child: Text(
                'This step is being prepared. Here you will draw the outline of the rubble site.',
              ),
            ),
          ),
          brightness: brightness,
        ),
      );
      await expectLater(
        find.byKey(goldenKey),
        matchesGoldenFile('goldens/card_${brightness.name}.png'),
      );
    });
  }
}
