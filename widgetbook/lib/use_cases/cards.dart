import 'package:beneathsos_catalogue/use_cases/frame.dart';
import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

/// Content card.
final card = WidgetbookComponent(
  name: 'BeneathCard',
  useCases: [
    WidgetbookUseCase(
      name: 'Title and icon',
      builder: (context) => frame(
        context,
        const BeneathCard(
          title: 'Being prepared',
          icon: Icons.construction_rounded,
          child: Text(
            'This step is being prepared. Here you will draw the outline of the rubble site.',
          ),
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Plain',
      builder: (context) =>
          frame(context, const BeneathCard(child: Text('Body text.'))),
    ),
    WidgetbookUseCase(
      name: 'Tappable',
      builder: (context) => frame(
        context,
        BeneathCard(
          title: 'Open',
          onTap: () {},
          child: const Text('Tap to open.'),
        ),
      ),
    ),
  ],
);
