import 'package:beneathsos_catalogue/use_cases/frame.dart';
import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

/// Palette swatches with their measured contrast.
final colours = WidgetbookComponent(
  name: 'Colours',
  useCases: [
    WidgetbookUseCase(
      name: 'Theme roles',
      builder: (context) {
        final s = Theme.of(context).colorScheme;
        final accent = BeneathTokens.of(context);
        final roles = <(String, Color, Color)>[
          ('primary', s.primary, s.onPrimary),
          ('surface', s.surface, s.onSurface),
          ('surfaceContainer', s.surfaceContainer, s.onSurface),
          ('error', s.error, s.onError),
          ('accent (fill only)', accent.accent, accent.onAccent),
        ];
        return frame(
          context,
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (name, fill, on) in roles)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: fill,
                    border: Border.all(color: s.outlineVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$name — text ${contrastRatio(on, fill).toStringAsFixed(1)} : 1',
                    style: TextStyle(color: on),
                  ),
                ),
            ],
          ),
        );
      },
    ),
  ],
);

/// Every text role of the theme.
final typography = WidgetbookComponent(
  name: 'Typography',
  useCases: [
    WidgetbookUseCase(
      name: 'Text roles',
      builder: (context) {
        final t = Theme.of(context).textTheme;
        final roles = <(String, TextStyle?)>[
          ('Hero · displaySmall 32', t.displaySmall),
          ('Title · headlineSmall 24', t.headlineSmall),
          ('Subtitle · titleLarge 20', t.titleLarge),
          ('Body · bodyLarge 19', t.bodyLarge),
          ('Body · bodyMedium 17', t.bodyMedium),
          ('Button · labelLarge 19', t.labelLarge),
          ('Fine print · bodySmall 15', t.bodySmall),
        ];
        return frame(
          context,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final (name, style) in roles)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(name, style: style),
                ),
              Text(
                '−71 dBm · 12 · 13:05',
                style: BeneathTokens.of(context).numeric,
              ),
            ],
          ),
        );
      },
    ),
  ],
);
