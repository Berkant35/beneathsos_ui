import 'package:beneathsos_ui/beneathsos_ui.dart';
import 'package:flutter/material.dart';

/// Mockup 6 — probability map (phase 9): an area with its confidence, never a single pin.
class ProbabilityMapMockup extends StatelessWidget {
  const ProbabilityMapMockup({super.key});

  static const _legend = [
    (Icons.circle, 'signal heard'),
    (Icons.circle_outlined, 'no signal'),
    (Icons.add_circle_outline_rounded, 'suggested next point'),
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return BeneathScaffold(
      title: 'Target A · Apple · Find My',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const StatusBanner(
            kind: StatusKind.attention,
            message: 'Its Bluetooth identity changes in about 2 min. Stay near the rubble.',
          ),
          const SizedBox(height: BeneathSpacing.sm),
          Expanded(
            // The map is a canvas, not a card: a framed surface that fills the space.
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainer,
                border: Border.all(color: scheme.outlineVariant),
                borderRadius: BorderRadius.circular(BeneathSizes.radius),
              ),
              child: CustomPaint(
                size: Size.infinite,
                painter: ProbabilityPainter(
                  outline: scheme.primary,
                  heat: scheme.primary,
                  grid: scheme.outlineVariant,
                  label: text.bodyMedium!.copyWith(color: scheme.onSurface),
                  background: scheme.surfaceContainer,
                ),
              ),
            ),
          ),
          const SizedBox(height: BeneathSpacing.s),
          Wrap(
            spacing: BeneathSpacing.m,
            runSpacing: BeneathSpacing.xs,
            children: [
              for (final (icon, label) in _legend)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 16, color: scheme.primary),
                    const SizedBox(width: BeneathSpacing.xs),
                    Flexible(child: Text(label, style: text.bodyMedium)),
                  ],
                ),
            ],
          ),
          const SizedBox(height: BeneathSpacing.sm),
          PrimaryButton(
            label: 'Measure here',
            icon: Icons.add_location_alt_rounded,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

/// Outline, placeholder heat, 50 % and 90 % regions, measured points and the next point.
class ProbabilityPainter extends CustomPainter {
  const ProbabilityPainter({
    required this.outline,
    required this.heat,
    required this.grid,
    required this.label,
    required this.background,
  });

  final Color outline;
  final Color heat;
  final Color grid;
  final TextStyle label;
  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    Offset at(double x, double y) => Offset(x * size.width, y * size.height);
    final rubble = Path()
      ..addPolygon([
        at(0.08, 0.1),
        at(0.92, 0.08),
        at(0.95, 0.9),
        at(0.1, 0.92),
      ], true);
    final centre = at(0.58, 0.48);
    final radius = size.shortestSide * 0.4;
    canvas
      ..drawPath(rubble, Paint()..color = grid.withValues(alpha: 0.35))
      ..drawCircle(
        centre,
        radius,
        Paint()
          ..shader = RadialGradient(
            colors: [heat.withValues(alpha: 0.45), heat.withValues(alpha: 0)],
          ).createShader(Rect.fromCircle(center: centre, radius: radius)),
      );
    final region = Paint()
      ..style = PaintingStyle.stroke
      ..color = outline;
    final ninety = Rect.fromCenter(
      center: centre,
      width: size.width * 0.55,
      height: size.height * 0.5,
    );
    final fifty = Rect.fromCenter(
      center: centre,
      width: size.width * 0.28,
      height: size.height * 0.24,
    );
    canvas
      ..drawOval(ninety, region..strokeWidth = 2)
      ..drawOval(fifty, region..strokeWidth = 4)
      ..drawPath(
        rubble,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = outline,
      );
    _text(
      canvas,
      'Most likely area · 50 %',
      fifty.bottomCenter + const Offset(0, 18),
      centered: true,
    );
    _text(
      canvas,
      '90 %',
      ninety.topCenter + const Offset(0, 18),
      centered: true,
    );
    final heard = Paint()..color = outline;
    final open = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = outline;
    for (final (point, dbm) in [
      (at(0.2, 0.18), '−84 dBm'),
      (at(0.8, 0.16), '−73 dBm'),
      (at(0.82, 0.82), '−70 dBm'),
    ]) {
      canvas.drawCircle(point, 9, heard);
      _text(canvas, dbm, point + const Offset(0, 26), centered: true);
    }
    final quiet = at(0.2, 0.8);
    canvas.drawCircle(quiet, 9, open);
    _text(canvas, 'no signal', quiet + const Offset(0, 26), centered: true);
    final next = at(0.5, 0.82);
    canvas
      ..drawCircle(next, 13, open)
      ..drawLine(next - const Offset(7, 0), next + const Offset(7, 0), open)
      ..drawLine(next - const Offset(0, 7), next + const Offset(0, 7), open);
    _text(canvas, 'next', next + const Offset(0, 30), centered: true);
  }

  /// A label with a small background so it stays readable over lines and heat.
  void _text(Canvas canvas, String value, Offset at, {bool centered = false}) {
    final painter = TextPainter(
      text: TextSpan(text: value, style: label),
      textDirection: TextDirection.ltr,
    )..layout();
    final origin = centered
        ? at - Offset(painter.width / 2, painter.height / 2)
        : at;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        (origin & painter.size).inflate(3),
        const Radius.circular(4),
      ),
      Paint()..color = background,
    );
    painter.paint(canvas, origin);
  }

  @override
  bool shouldRepaint(ProbabilityPainter oldDelegate) =>
      oldDelegate.outline != outline || oldDelegate.heat != heat;
}
