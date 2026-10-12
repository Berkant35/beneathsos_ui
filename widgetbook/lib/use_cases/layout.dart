import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

/// Screen frame.
final scaffold = WidgetbookComponent(
  name: 'BeneathScaffold',
  useCases: [
    WidgetbookUseCase(
      name: 'With title',
      builder: (context) => const BeneathScaffold(
        title: 'New search',
        body: Text('Page content with the standard padding.'),
      ),
    ),
    WidgetbookUseCase(
      name: 'Without title',
      builder: (context) => const BeneathScaffold(
        body: Text('Home-style page without an app bar.'),
      ),
    ),
  ],
);
