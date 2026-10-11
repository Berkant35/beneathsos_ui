import 'package:beneathsos_ui/src/tokens/sizes.dart';
import 'package:flutter/widgets.dart';

/// Spacing scale in logical pixels.
abstract final class BeneathSpacing {
  /// 4.
  static const double xs = 4;

  /// 8.
  static const double s = 8;

  /// 12.
  static const double sm = 12;

  /// 16.
  static const double m = 16;

  /// 24.
  static const double l = 24;

  /// 32.
  static const double xl = 32;

  /// 48.
  static const double xxl = 48;

  /// Page padding: 16 on phones, 24 from [BeneathSizes.wideBreakpoint].
  static EdgeInsets pageFor(double width) =>
      EdgeInsets.all(width >= BeneathSizes.wideBreakpoint ? l : m);
}
