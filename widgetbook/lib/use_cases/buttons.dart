import 'package:beneathsos_catalogue/use_cases/frame.dart';
import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

/// The screen's one primary action.
final primaryButton = WidgetbookComponent(
  name: 'PrimaryButton',
  useCases: [
    WidgetbookUseCase(
      name: 'With icon',
      builder: (context) => frame(
        context,
        PrimaryButton(
          label: context.knobs.string(
            label: 'Label',
            initialValue: 'Start a search',
          ),
          icon: Icons.search_rounded,
          onPressed: () {},
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => frame(
        context,
        const PrimaryButton(label: 'Start a search', onPressed: null),
      ),
    ),
  ],
);

/// Secondary actions.
final secondaryButton = WidgetbookComponent(
  name: 'SecondaryButton',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) => frame(
        context,
        SecondaryButton(
          label: context.knobs.string(
            label: 'Label',
            initialValue: 'I am trapped',
          ),
          onPressed: () {},
        ),
      ),
    ),
    WidgetbookUseCase(
      name: 'Disabled',
      builder: (context) => frame(
        context,
        const SecondaryButton(label: 'I am trapped', onPressed: null),
      ),
    ),
  ],
);
