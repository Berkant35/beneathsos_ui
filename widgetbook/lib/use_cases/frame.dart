import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

/// Pads a use case and applies the "Reduce motion" knob (the system setting).
Widget frame(
  BuildContext context,
  Widget child, {
  bool reduceMotionKnob = false,
}) {
  final reduceMotion =
      reduceMotionKnob && context.knobs.boolean(label: 'Reduce motion');
  return MediaQuery(
    data: MediaQuery.of(context).copyWith(disableAnimations: reduceMotion),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: child,
    ),
  );
}
