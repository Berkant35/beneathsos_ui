import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';

/// Mockup 5 — 15 s point measurement (phase 7): hold still; "no signal" is information.
class MeasurementMockup extends StatelessWidget {
  const MeasurementMockup({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return BeneathScaffold(
      title: 'Point 3 of 5',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: BeneathSpacing.l),
            const Center(
              child: CountdownRing(
                total: Duration(seconds: 15),
                remaining: Duration(seconds: 9),
                semanticLabel: '9 seconds left',
                size: 200,
              ),
            ),
            const SizedBox(height: BeneathSpacing.l),
            Text(
              'Hold the phone still at this point.',
              style: text.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BeneathSpacing.l),
            const StatusBanner(
              kind: StatusKind.ready,
              message: 'Signal heard: −71 dBm.',
              icon: Icons.graphic_eq_rounded,
            ),
            const SizedBox(height: BeneathSpacing.sm),
            const StatusBanner(
              kind: StatusKind.ready,
              message: 'The phone is still.',
            ),
            const SizedBox(height: BeneathSpacing.xl),
            SecondaryButton(label: 'Discard this point', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
