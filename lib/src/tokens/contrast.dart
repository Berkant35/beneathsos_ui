import 'dart:math' as math;
import 'dart:ui';

/// WCAG 2.2 contrast ratio of two opaque colours, from 1 to 21. Argument order does not matter.
double contrastRatio(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}
