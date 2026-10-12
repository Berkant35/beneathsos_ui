import 'package:beneathsos_ui/src/tokens/sizes.dart';
import 'package:beneathsos_ui/src/tokens/spacing.dart';
import 'package:flutter/material.dart';

/// A content card: container fill, calm border, optional title with icon. With [onTap] it is a
/// button for screen readers.
class BeneathCard extends StatelessWidget {
  /// Creates a card.
  const BeneathCard({
    required this.child,
    this.title,
    this.icon,
    this.onTap,
    super.key,
  });

  /// Card content.
  final Widget child;

  /// Optional title, already localised.
  final String? title;

  /// Optional icon before the title.
  final IconData? icon;

  /// Makes the card tappable.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final title = this.title;
    final icon = this.icon;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(BeneathSizes.radius),
      side: BorderSide(color: scheme.outlineVariant),
    );
    final content = Padding(
      padding: const EdgeInsets.all(BeneathSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, color: scheme.primary, size: 28),
                  const SizedBox(width: BeneathSpacing.sm),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: scheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: BeneathSpacing.sm),
          ],
          child,
        ],
      ),
    );
    final tap = onTap;
    final card = Material(
      color: scheme.surfaceContainer,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: tap == null ? content : InkWell(onTap: tap, child: content),
    );
    return tap == null ? card : Semantics(button: true, child: card);
  }
}
