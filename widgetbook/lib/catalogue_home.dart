import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';

/// The catalogue's first page: what this is and how to use it (instead of Widgetbook's own page). It
/// sits outside the theme addon, so it brings the BeneathSOS theme itself.
class CatalogueHome extends StatelessWidget {
  /// Creates the home page.
  const CatalogueHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: BeneathTheme.light(),
      child: Builder(builder: _page),
    );
  }

  Widget _page(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(BeneathSpacing.l),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BeneathLogo.lockup(semanticLabel: 'BeneathSOS'),
                const SizedBox(height: BeneathSpacing.l),
                Text('BeneathSOS UI catalogue', style: text.headlineMedium),
                const SizedBox(height: BeneathSpacing.m),
                Text(
                  'The design system of BeneathSOS, an offline open-source app that helps volunteers '
                  'find phones trapped under earthquake rubble. Every component is shown in its real '
                  'states: pick one on the left, then switch light / dark, text size and phone size '
                  'in the addons.',
                  style: text.bodyLarge,
                ),
                const SizedBox(height: BeneathSpacing.m),
                Text(
                  'Built for stress, dust and sunlight: high contrast, large touch targets, 200 % '
                  'text. Source: github.com/Berkant35/beneathsos_ui',
                  style: text.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
