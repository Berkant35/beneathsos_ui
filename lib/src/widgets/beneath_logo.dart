import 'package:beneathsos_ui/src/theme/beneath_tokens.dart';
import 'package:beneathsos_ui/src/tokens/typography.dart';
import 'package:beneathsos_ui/src/widgets/signal_exit_painter.dart';
import 'package:flutter/material.dart';

/// The BeneathSOS logo in theme colours. Logotypes are exempt from WCAG contrast minimums, so the
/// orange "SOS" may sit on the light background (text and icons may not).
class BeneathLogo extends StatelessWidget {
  /// The symbol alone, [size] × [size].
  const BeneathLogo.symbol({
    required this.semanticLabel,
    this.size = 48,
    super.key,
  }) : _lockup = false;

  /// Symbol + "Beneath" + "SOS", [height] tall. The wordmark ignores system text scaling; the
  /// whole lock-up scales down to fit a narrow space instead of overflowing.
  const BeneathLogo.lockup({
    required this.semanticLabel,
    double height = 48,
    super.key,
  }) : size = height,
       _lockup = true;

  /// What screen readers say (localised by the app, e.g. "BeneathSOS").
  final String semanticLabel;

  /// Symbol size, or lock-up height.
  final double size;

  final bool _lockup;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final accent = BeneathTokens.of(context).accent;
    final symbol = CustomPaint(
      size: Size.square(size),
      painter: SignalExitPainter(line: primary, accent: accent),
    );
    final Widget logo = _lockup
        ? FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                symbol,
                SizedBox(width: size * 0.2),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Beneath',
                        style: TextStyle(color: primary),
                      ),
                      TextSpan(
                        text: 'SOS',
                        style: TextStyle(color: accent),
                      ),
                    ],
                  ),
                  textScaler: TextScaler.noScaling,
                  style: TextStyle(
                    fontFamily: beneathFontFamily,
                    package: beneathFontPackage,
                    fontWeight: FontWeight.w800,
                    fontSize: size * 0.6,
                    height: 1,
                  ),
                ),
              ],
            ),
          )
        : symbol;
    return Semantics(
      label: semanticLabel,
      image: true,
      excludeSemantics: true,
      child: logo,
    );
  }
}
