import 'dart:ui' show PointMode;

import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';

/// Mockup 2 — rubble site outline (phases 4–5): corners tapped while walking around the rubble.
class RubbleSiteMockup extends StatelessWidget {
  const RubbleSiteMockup({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BeneathScaffold(
      title: 'Atatürk Cad. 12',
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const StatusBanner(
              kind: StatusKind.ready,
              message: 'Walk around the rubble and tap each corner.',
              icon: Icons.touch_app_rounded,
            ),
            const SizedBox(height: BeneathSpacing.m),
            BeneathCard(
              child: AspectRatio(
                aspectRatio: 1,
                child: CustomPaint(
                  painter: OutlinePainter(
                    grid: scheme.outlineVariant,
                    outline: scheme.primary,
                    label: Theme.of(context).textTheme.bodyMedium!
                        .copyWith(color: scheme.onSurface),
                  ),
                ),
              ),
            ),
            const SizedBox(height: BeneathSpacing.s),
            Text(
              'Outline: 4 corners · 18.2 × 12.4 m · scale from your steps',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: BeneathSpacing.l),
            PrimaryButton(
              label: 'Outline done',
              icon: Icons.check_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

/// A metric grid with the rubble outline and its edge lengths (sample data).
class OutlinePainter extends CustomPainter {
  const OutlinePainter({
    required this.grid,
    required this.outline,
    required this.label,
  });

  final Color grid;
  final Color outline;
  final TextStyle label;

  static const _corners = [
    Offset(0.24, 0.22),
    Offset(0.78, 0.18),
    Offset(0.82, 0.74),
    Offset(0.28, 0.8),
  ];
  static const _lengths = ['18.2 m', '12.4 m', '17.5 m', '13.1 m'];

  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = grid
      ..strokeWidth = 1;
    for (var i = 1; i < 10; i++) {
      final x = size.width * i / 10;
      final y = size.height * i / 10;
      canvas
        ..drawLine(Offset(x, 0), Offset(x, size.height), gridPaint)
        ..drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    final points = [
      for (final c in _corners) Offset(c.dx * size.width, c.dy * size.height),
    ];
    final path = Path()..addPolygon(points, true);
    canvas
      ..drawPath(
        path,
        Paint()
          ..color = outline
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      )
      ..drawPoints(
        PointMode.points,
        points,
        Paint()
          ..color = outline
          ..strokeWidth = 14
          ..strokeCap = StrokeCap.round,
      );
    final centroid = points.reduce((a, b) => a + b) / points.length.toDouble();
    for (var i = 0; i < points.length; i++) {
      final mid = (points[i] + points[(i + 1) % points.length]) / 2;
      final outward = mid - centroid;
      final anchor = mid + outward / outward.distance * 22;
      final painter = TextPainter(
        text: TextSpan(text: _lengths[i], style: label),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(
        canvas,
        anchor - Offset(painter.width / 2, painter.height / 2),
      );
    }
  }

  @override
  bool shouldRepaint(OutlinePainter oldDelegate) =>
      oldDelegate.grid != grid || oldDelegate.outline != outline;
}
