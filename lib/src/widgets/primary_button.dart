import 'package:beneathsos_ui/src/theme/beneath_tokens.dart';
import 'package:beneathsos_ui/src/tokens/sizes.dart';
import 'package:flutter/material.dart';

/// The screen's one primary action: orange fill, dark label, 64 tall, full width.
/// Use at most one per screen, in the bottom half (thumb zone).
class PrimaryButton extends StatelessWidget {
  /// Creates the primary action. A null [onPressed] disables it.
  const PrimaryButton({
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
    final tokens = BeneathTokens.of(context);
    final style = FilledButton.styleFrom(
      backgroundColor: tokens.accent,
      foregroundColor: tokens.onAccent,
      iconSize: 24,
      minimumSize: const Size.fromHeight(BeneathSizes.primaryButtonHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BeneathSizes.radius),
      ),
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
    final iconData = icon;
    return iconData == null
        ? FilledButton(onPressed: onPressed, style: style, child: Text(label))
        : FilledButton.icon(
            onPressed: onPressed,
            style: style,
            icon: Icon(iconData),
            label: Text(label),
          );
  }
}
