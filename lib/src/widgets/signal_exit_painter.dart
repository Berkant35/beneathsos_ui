import 'package:flutter/rendering.dart';

/// Draws the "signal exit" symbol: rubble line, phone dot below it, three arcs rising and fading.
/// Geometry is the brand's 48-unit grid (`docs/brand/README.md` in the hub).
class SignalExitPainter extends CustomPainter {
  /// Creates the painter; [line] colours the rubble line, [accent] the dot and arcs.
  const SignalExitPainter({required this.line, required this.accent});

  /// Rubble-line colour.
  final Color line;

  /// Dot and arc colour.
  final Color accent;

  static const double _grid = 48;
  static const double _stroke = 3.6;
  // (start x, end x, y, radius, opacity) — SVG "M x1 y A r r 0 0 1 x2 y".
  static const _arcs = [
    (18.5, 29.5, 24.5, 7.5, 1.0),
    (13.5, 34.5, 19.5, 14.5, 0.75),
    (8.5, 39.5, 14.5, 21.5, 0.5),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.shortestSide / _grid;
    canvas
      ..save()
      ..translate(
        (size.width - _grid * scale) / 2,
        (size.height - _grid * scale) / 2,
      )
      ..scale(scale);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _stroke
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawLine(
        const Offset(6, 30),
        const Offset(42, 30),
        stroke..color = line,
      )
      ..drawCircle(const Offset(24, 38), 3.4, Paint()..color = accent);
    for (final (x1, x2, y, radius, opacity) in _arcs) {
      final arc = Path()
        ..moveTo(x1, y)
        ..arcToPoint(Offset(x2, y), radius: Radius.circular(radius));
      canvas.drawPath(arc, stroke..color = accent.withValues(alpha: opacity));
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(SignalExitPainter oldDelegate) =>
      oldDelegate.line != line || oldDelegate.accent != accent;
}
