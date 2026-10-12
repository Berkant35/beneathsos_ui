import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';

/// Mockup 1 — first-run notice (phase 4): what the app does and does not do.
class FirstRunNoticeMockup extends StatelessWidget {
  const FirstRunNoticeMockup({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return BeneathScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: BeneathSpacing.m),
            const Center(
              child: BeneathLogo.lockup(semanticLabel: 'BeneathSOS'),
            ),
            const SizedBox(height: BeneathSpacing.l),
            Semantics(
              header: true,
              child: Text('Before you start', style: text.headlineSmall),
            ),
            const SizedBox(height: BeneathSpacing.m),
            const BeneathCard(
              title: 'What BeneathSOS does',
              icon: Icons.info_outline_rounded,
              child: Text(
                'It measures the Bluetooth signal of a phone at several points and shows '
                'the area where it most likely is — an area, never an exact spot.',
              ),
            ),
            const SizedBox(height: BeneathSpacing.m),
            const BeneathCard(
              title: 'What it does not do',
              icon: Icons.warning_amber_rounded,
              child: Text(
                'It does not replace professional rescue. Call 112 and follow AFAD and the '
                'rescue teams on site.',
              ),
            ),
            const SizedBox(height: BeneathSpacing.m),
            Text(
              'BeneathSOS is an independent open-source project and is not affiliated with '
              'AFAD or any government agency.',
              style: text.bodySmall,
            ),
            const SizedBox(height: BeneathSpacing.xl),
            PrimaryButton(label: 'I understand', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
