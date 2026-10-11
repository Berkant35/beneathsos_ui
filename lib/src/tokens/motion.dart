import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

/// Animation durations and curve. Motion only explains time or state; never decoration.
@immutable
final class BeneathMotion {
  /// Creates a motion set.
  const BeneathMotion({
    required this.short,
    required this.medium,
    required this.long,
    required this.curve,
  });

  /// Default motion: 150 / 250 / 400 ms, ease-out.
  static const BeneathMotion standard = BeneathMotion(
    short: Duration(milliseconds: 150),
    medium: Duration(milliseconds: 250),
    long: Duration(milliseconds: 400),
    curve: Curves.easeOutCubic,
  );

  /// Used when the system "reduce motion" setting is on: no animation.
  static const BeneathMotion reduced = BeneathMotion(
    short: Duration.zero,
    medium: Duration.zero,
    long: Duration.zero,
    curve: Curves.linear,
  );

  /// Small state changes (pressed, toggled).
  final Duration short;

  /// Elements entering or leaving.
  final Duration medium;

  /// Screen-level transitions.
  final Duration long;

  /// Easing curve.
  final Curve curve;
}
