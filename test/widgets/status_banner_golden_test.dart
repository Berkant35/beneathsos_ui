@Tags(['golden'])
library;

import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden.dart';

void main() {
  setUpAll(loadBeneathFont);

  for (final brightness in Brightness.values) {
    testWidgets('status banners, ${brightness.name}', (tester) async {
      await tester.pumpWidget(
        goldenFrame(
          SizedBox(
            width: 360,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const StatusBanner(
                  kind: StatusKind.ready,
                  message: 'Bluetooth is on and ready.',
                ),
                const SizedBox(height: 12),
                const StatusBanner(
                  kind: StatusKind.attention,
                  message: 'Identity is changing.',
                ),
                const SizedBox(height: 12),
                StatusBanner(
                  kind: StatusKind.blocked,
                  message:
                      "Bluetooth is off. Turn it on in your phone's settings.",
                  onTap: () {},
                ),
              ],
            ),
          ),
          brightness: brightness,
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byKey(goldenKey),
        matchesGoldenFile('goldens/status_banners_${brightness.name}.png'),
      );
    });
  }
}
