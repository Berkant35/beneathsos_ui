import 'package:beneathsos_catalogue/use_cases/frame.dart';
import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:widgetbook/widgetbook.dart';

/// Countdowns: the 15 s measurement and the minutes-long identity rotation.
final countdownRing = WidgetbookComponent(
  name: 'CountdownRing',
  useCases: [
    WidgetbookUseCase(
      name: 'Measurement 15 s',
      builder: (context) {
        final seconds = context.knobs.double.slider(
          label: 'Remaining (s)',
          initialValue: 12,
          max: 15,
          divisions: 15,
        );
        return frame(
          context,
          CountdownRing(
            total: const Duration(seconds: 15),
            remaining: Duration(milliseconds: (seconds * 1000).round()),
            semanticLabel: '${seconds.round()} seconds left',
          ),
          reduceMotionKnob: true,
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Identity rotation 15 min',
      builder: (context) {
        final minutes = context.knobs.double.slider(
          label: 'Remaining (min)',
          initialValue: 13.1,
          max: 15,
        );
        return frame(
          context,
          CountdownRing(
            total: const Duration(minutes: 15),
            remaining: Duration(seconds: (minutes * 60).round()),
            semanticLabel: '${minutes.toStringAsFixed(1)} minutes left',
          ),
          reduceMotionKnob: true,
        );
      },
    ),
  ],
);
