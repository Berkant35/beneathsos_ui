import 'package:beneathsos_catalogue/use_cases/frame.dart';
import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:widgetbook/widgetbook.dart';

/// The logo.
final logo = WidgetbookComponent(
  name: 'BeneathLogo',
  useCases: [
    WidgetbookUseCase(
      name: 'Lock-up',
      builder: (context) =>
          frame(context, const BeneathLogo.lockup(semanticLabel: 'BeneathSOS')),
    ),
    WidgetbookUseCase(
      name: 'Symbol',
      builder: (context) => frame(
        context,
        BeneathLogo.symbol(
          semanticLabel: 'BeneathSOS',
          size: context.knobs.double.slider(
            label: 'Size',
            initialValue: 96,
            min: 16,
            max: 256,
          ),
        ),
      ),
    ),
  ],
);
