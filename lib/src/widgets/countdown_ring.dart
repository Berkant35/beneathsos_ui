import 'dart:math' as math;

import 'package:beneathsos_ui/src/theme/beneath_tokens.dart';
import 'package:flutter/material.dart';

/// A countdown: progress arc for the remaining time and the time in the middle. The caller rebuilds
/// it as time passes (it never animates on its own). With "reduce motion" only the number is shown.
class CountdownRing extends StatelessWidget {
  /// Creates a ring. [semanticLabel] is localised by the app (e.g. "12 seconds left").
  const CountdownRing({
    required this.total,
    required this.remaining,
    required this.semanticLabel,
    this.size = 160,
    super.key,
  });

  /// Full duration.
  final Duration total;

  /// Time left (clamped to 0…[total]).
  final Duration remaining;

  /// What screen readers say; not a live region — the app decides when to announce.
  final String semanticLabel;

  /// Diameter.
  final double size;

  /// `12` under a minute, `13:05` from a minute; rounded up, never negative.
  static String centreText(Duration remaining) {
    final seconds = remaining.isNegative
        ? 0
        : (remaining.inMilliseconds / 1000).ceil();
    if (seconds < 60) return '$seconds';
    return '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final totalMs = total.inMilliseconds;
    final fraction = totalMs <= 0
        ? 0.0
        : (remaining.inMilliseconds / totalMs).clamp(0.0, 1.0);
    final style = BeneathTokens.of(context).numeric
        .copyWith(color: scheme.onSurface, fontSize: size * 0.28);
    return Semantics(
      label: semanticLabel,
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: CountdownRingPainter(
            fraction: fraction,
            track: scheme.outlineVariant,
            arc: scheme.primary,
            showArc: !MediaQuery.disableAnimationsOf(context),
            strokeWidth: size * 12 / 160,
          ),
          child: Padding(
            padding: EdgeInsets.all(size * 0.2),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(centreText(remaining), style: style),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints the track circle and, unless [showArc] is false, the remaining-time arc from 12 o'clock.
class CountdownRingPainter extends CustomPainter {
  /// Creates the painter.
  const CountdownRingPainter({
    required this.fraction,
    required this.track,
    required this.arc,
    required this.showArc,
    required this.strokeWidth,
  });

  /// Remaining fraction, 0…1.
  final double fraction;

  /// Track colour.
  final Color track;

  /// Arc colour.
  final Color arc;

  /// Whether the arc is drawn (false with "reduce motion").
  final bool showArc;

  /// Stroke width of track and arc.
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(strokeWidth / 2);
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawOval(rect, stroke..color = track);
    if (showArc && fraction > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * fraction,
        false,
        stroke
          ..color = arc
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(CountdownRingPainter oldDelegate) =>
      oldDelegate.fraction != fraction ||
      oldDelegate.track != track ||
      oldDelegate.arc != arc ||
      oldDelegate.showArc != showArc ||
      oldDelegate.strokeWidth != strokeWidth;
}
