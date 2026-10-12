import 'package:beneathsos_ui/src/theme/beneath_tokens.dart';
import 'package:beneathsos_ui/src/tokens/sizes.dart';
import 'package:beneathsos_ui/src/tokens/spacing.dart';
import 'package:flutter/material.dart';

/// What a [StatusBanner] reports. Each kind has its own colour **and** icon — never colour alone.
enum StatusKind {
  /// All good, or neutral progress.
  ready,

  /// Needs attention soon (e.g. the target's identity is changing).
  attention,

  /// Something blocks the task (Bluetooth off, permission missing). Red means blocked only.
  blocked,
}

/// One status line: what happened, then what to do. With [onTap] the whole banner is a button.
/// Changes are announced to screen readers (live region) and cross-fade unless motion is reduced.
class StatusBanner extends StatelessWidget {
  /// Creates a banner. [message] is localised by the app.
  const StatusBanner({
    required this.kind,
    required this.message,
    this.onTap,
    this.icon,
    super.key,
  });

  /// What the banner reports.
  final StatusKind kind;

  /// What happened and what to do.
  final String message;

  /// Makes the banner a button (≥ 56 tall, trailing chevron).
  final VoidCallback? onTap;

  /// Replaces the kind's default icon.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tokens = BeneathTokens.of(context);
    final (background, foreground, border, defaultIcon) = switch (kind) {
      StatusKind.ready => (
        scheme.surfaceContainer,
        scheme.onSurface,
        scheme.outlineVariant,
        Icons.check_circle_rounded,
      ),
      StatusKind.attention => (
        tokens.accent,
        tokens.onAccent,
        Colors.transparent,
        Icons.warning_rounded,
      ),
      StatusKind.blocked => (
        scheme.error,
        scheme.onError,
        Colors.transparent,
        Icons.block_rounded,
      ),
    };
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(BeneathSizes.radius),
      side: BorderSide(color: border),
    );
    final style = Theme.of(context).textTheme.bodyLarge
        ?.copyWith(color: foreground, fontWeight: FontWeight.w600);
    final tap = onTap;
    final banner = Material(
      key: ValueKey((kind, message)),
      color: background,
      shape: shape,
      child: InkWell(
        onTap: tap,
        customBorder: shape,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: BeneathSizes.minTouchTarget,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: BeneathSpacing.m,
              vertical: BeneathSpacing.sm,
            ),
            child: Row(
              children: [
                Icon(icon ?? defaultIcon, color: foreground, size: 28),
                const SizedBox(width: BeneathSpacing.sm),
                Expanded(child: Text(message, style: style)),
                if (tap != null)
                  Icon(Icons.chevron_right_rounded, color: foreground),
              ],
            ),
          ),
        ),
      ),
    );
    return MergeSemantics(
      child: Semantics(
        liveRegion: true,
        button: tap != null,
        child: AnimatedSwitcher(
          duration: BeneathTokens.motionOf(context).medium,
          child: banner,
        ),
      ),
    );
  }
}
