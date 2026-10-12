import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';

/// Mockup 4 — choose the target (phase 6): candidates ranked with the reason in plain words.
class ChooseTargetMockup extends StatelessWidget {
  const ChooseTargetMockup({super.key});

  static const _candidates = [
    (
      'Apple · Find My',
      'Not moving · weak signal · not seen on the surface',
      Icons.signal_cellular_alt_1_bar_rounded,
      true,
    ),
    (
      'Samsung phone',
      'Not moving · medium signal',
      Icons.signal_cellular_alt_2_bar_rounded,
      false,
    ),
    (
      'Unknown device',
      'Moving — probably on the surface',
      Icons.signal_cellular_alt_rounded,
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BeneathScaffold(
      title: 'Choose the target',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const StatusBanner(
              kind: StatusKind.ready,
              message: "Hold a rescuer's phone next to yours to exclude it.",
              icon: Icons.phonelink_ring_rounded,
            ),
            const SizedBox(height: BeneathSpacing.m),
            for (final (name, reason, signal, selected) in _candidates) ...[
              BeneathCard(
                title: name,
                icon: selected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,
                onTap: () {},
                child: Row(
                  children: [
                    Icon(signal, color: scheme.primary),
                    const SizedBox(width: BeneathSpacing.s),
                    Expanded(child: Text(reason)),
                  ],
                ),
              ),
              const SizedBox(height: BeneathSpacing.sm),
            ],
            const SizedBox(height: BeneathSpacing.m),
            PrimaryButton(
              label: 'Track this phone',
              icon: Icons.track_changes_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
