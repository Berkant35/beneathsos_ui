@Tags(['golden'])
library;

import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/golden.dart';

void main() {
  setUpAll(loadBeneathFont);

  for (final brightness in Brightness.values) {
    testWidgets('countdown rings, ${brightness.name}', (tester) async {
      const total = Duration(seconds: 15);
      await tester.pumpWidget(
        goldenFrame(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CountdownRing(
                total: total,
                remaining: total,
                semanticLabel: '15 s',
                size: 120,
              ),
              const SizedBox(width: 16),
              const CountdownRing(
                total: total,
                remaining: Duration(milliseconds: 7500),
                semanticLabel: '8 s',
                size: 120,
              ),
              const SizedBox(width: 16),
              Builder(
                builder: (context) => MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(disableAnimations: true),
                  child: const CountdownRing(
                    total: total,
                    remaining: Duration(milliseconds: 7500),
                    semanticLabel: '8 s',
                    size: 120,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const CountdownRing(
                total: Duration(minutes: 15),
                remaining: Duration(minutes: 13, seconds: 5),
                semanticLabel: '13 min 5 s',
                size: 120,
              ),
            ],
          ),
          brightness: brightness,
        ),
      );
      await expectLater(
        find.byKey(goldenKey),
        matchesGoldenFile('goldens/countdown_ring_${brightness.name}.png'),
      );
    });
  }
}
