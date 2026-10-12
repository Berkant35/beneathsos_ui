import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';

/// Mockup 7 — victim mode (phase 10): the simplest screen; large text, no animation, dimmed.
class VictimModeMockup extends StatelessWidget {
  const VictimModeMockup({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    // Full-bleed: no app bar, nothing to distract (CLAUDE.md §5.3 exception for victim mode).
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(BeneathSpacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.wifi_tethering_rounded,
                size: 72,
                color: scheme.primary,
              ),
              const SizedBox(height: BeneathSpacing.l),
              Text(
                'Your phone is sending a help signal.',
                style: text.displaySmall,
              ),
              const SizedBox(height: BeneathSpacing.l),
              Text('Stay calm. Save your battery.', style: text.headlineSmall),
              const SizedBox(height: BeneathSpacing.m),
              Text(
                'When you hear rescuers, tap the screen 3 times.',
                style: text.bodyLarge,
              ),
              const SizedBox(height: BeneathSpacing.l),
              BeneathCard(
                title: 'Battery',
                icon: Icons.battery_5_bar_rounded,
                child: Text('64 %', style: BeneathTokens.of(context).numeric),
              ),
              const SizedBox(height: BeneathSpacing.xl),
              PrimaryButton(
                label: 'Play SOS sound',
                icon: Icons.volume_up_rounded,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
