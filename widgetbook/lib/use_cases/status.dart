import 'package:beneathsos_catalogue/use_cases/frame.dart';
import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookUseCase _banner(
  String name,
  StatusKind kind,
  String message, {
  bool tappable = false,
  IconData? icon,
}) => WidgetbookUseCase(
  name: name,
  builder: (context) => frame(
    context,
    StatusBanner(
      kind: kind,
      message: context.knobs.string(label: 'Message', initialValue: message),
      icon: icon,
      onTap: tappable ? () {} : null,
    ),
    reduceMotionKnob: true,
  ),
);

/// One status line: what happened, then what to do.
final statusBanner = WidgetbookComponent(
  name: 'StatusBanner',
  useCases: [
    _banner('Ready', StatusKind.ready, 'Bluetooth is on and ready.'),
    _banner(
      'Checking',
      StatusKind.ready,
      'Checking Bluetooth…',
      icon: Icons.hourglass_top_rounded,
    ),
    _banner('Attention', StatusKind.attention, 'Identity is changing.'),
    _banner(
      'Blocked',
      StatusKind.blocked,
      "Bluetooth is off. Turn it on in your phone's settings.",
    ),
    _banner(
      'Blocked, tappable',
      StatusKind.blocked,
      'Bluetooth permission is needed. Tap to allow it.',
      tappable: true,
    ),
    _banner(
      'Long message (Turkish)',
      StatusKind.blocked,
      'Bu telefon Bluetooth LE desteklemiyor. Başka bir telefonla arayın.',
    ),
  ],
);
