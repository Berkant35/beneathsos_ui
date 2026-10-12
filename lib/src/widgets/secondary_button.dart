import 'package:beneathsos_ui/src/tokens/sizes.dart';
import 'package:flutter/material.dart';

/// A secondary action: 56 tall, full width. Light: white fill, navy label and border;
/// dark: secondary-surface fill, light label, outline border.
class SecondaryButton extends StatelessWidget {
  /// Creates a secondary action. A null [onPressed] disables it.
  const SecondaryButton({
    required this.label,
    required this.onPressed,
    this.icon,
    super.key,
  });

  /// Label, already localised.
  final String label;

  /// Called on tap; null disables the button.
  final VoidCallback? onPressed;

  /// Optional leading icon.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final light = scheme.brightness == Brightness.light;
    final style = OutlinedButton.styleFrom(
      backgroundColor: scheme.surfaceContainer,
      foregroundColor: light ? scheme.primary : scheme.onSurface,
      side: BorderSide(
        color: light ? scheme.primary : scheme.outline,
        width: 1.5,
      ),
      minimumSize: const Size.fromHeight(BeneathSizes.minTouchTarget),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BeneathSizes.radius),
      ),
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
    final iconData = icon;
    return iconData == null
        ? OutlinedButton(onPressed: onPressed, style: style, child: Text(label))
        : OutlinedButton.icon(
            onPressed: onPressed,
            style: style,
            icon: Icon(iconData),
            label: Text(label),
          );
  }
}
