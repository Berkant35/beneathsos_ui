@Tags(['golden'])
library;

import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden.dart';

void main() {
  setUpAll(loadBeneathFont);

  for (final brightness in Brightness.values) {
    testWidgets('buttons, ${brightness.name}', (tester) async {
      await tester.pumpWidget(
        goldenFrame(
          SizedBox(
            width: 360,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryButton(
                  label: 'Start a search',
                  icon: Icons.search_rounded,
                  onPressed: () {},
                ),
                const SizedBox(height: 16),
                SecondaryButton(label: 'I am trapped', onPressed: () {}),
              ],
            ),
          ),
          brightness: brightness,
        ),
      );
      await expectLater(
        find.byKey(goldenKey),
        matchesGoldenFile('goldens/buttons_${brightness.name}.png'),
      );
    });
  }
}
