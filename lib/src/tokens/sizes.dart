/// Field-ergonomics sizes (`docs/design/accessibility.md` in the hub).
abstract final class BeneathSizes {
  /// Smallest touch target — gloves, one hand, stress.
  static const double minTouchTarget = 56;

  /// Height of the primary action.
  static const double primaryButtonHeight = 64;

  /// Corner radius of buttons and cards.
  static const double radius = 16;

  /// Corner radius of small elements.
  static const double radiusSmall = 8;

  /// Width from which layouts use the wide page padding.
  static const double wideBreakpoint = 600;
}
