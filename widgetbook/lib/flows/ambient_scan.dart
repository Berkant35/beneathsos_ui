import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';

/// Mockup 3 — 30 s ambient scan (phase 6): surface phones are listed so they are never suggested.
class AmbientScanMockup extends StatelessWidget {
  const AmbientScanMockup({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return BeneathScaffold(
      title: 'Ambient scan',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: BeneathSpacing.l),
            const Center(
              child: CountdownRing(
                total: Duration(seconds: 30),
                remaining: Duration(seconds: 18),
                semanticLabel: '18 seconds left',
                size: 200,
              ),
            ),
            const SizedBox(height: BeneathSpacing.l),
            Text(
              'Stand 10 m away from the rubble.',
              style: text.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BeneathSpacing.s),
            Text(
              'Phones on the surface — rescuers, bystanders — are listed now and will not be '
              'suggested as targets.',
              style: text.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BeneathSpacing.l),
            BeneathCard(
              title: 'Surface phones found',
              icon: Icons.phone_iphone_rounded,
              child: Text('7', style: BeneathTokens.of(context).numeric),
            ),
          ],
        ),
      ),
    );
  }
}
