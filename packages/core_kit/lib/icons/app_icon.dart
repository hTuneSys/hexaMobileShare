// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A wrapper around Flutter's [Icon] widget that provides consistent sizing,
/// coloring, and semantic labeling for icons throughout the app.
///
/// AppIcon follows Material Design 3 icon specifications and provides:
/// - Standard size presets (16, 20, 24, 32, 48)
/// - Semantic color support from theme
/// - Built-in accessibility labels
/// - Simple, convenient API
///
/// **Why use AppIcon?**
/// - **Consistency**: All icons use standard M3 sizes
/// - **Semantic Colors**: Automatic color from theme (primary, error, etc.)
/// - **Accessibility**: Built-in semantic labels for screen readers
/// - **Convenience**: Simpler API than manually sizing icons
/// - **M3 Compliance**: Follows Material Design 3 icon guidelines
///
/// **Common use cases:**
/// - Button icons
/// - List tile leading/trailing icons
/// - App bar action icons
/// - Form field prefix/suffix icons
/// - Navigation icons
/// - Status indicators
///
/// **Example Usage:**
/// ```dart
/// // Default size (24dp) with theme color
/// AppIcon(Icons.search)
///
/// // With size preset
/// AppIcon.lg(Icons.favorite)
///
/// // With semantic color
/// AppIcon(
///   Icons.error,
///   semanticColor: AppIconSemanticColor.error,
/// )
///
/// // With custom color and accessibility label
/// AppIcon(
///   Icons.settings,
///   color: Colors.blue,
///   semanticLabel: 'Open settings',
/// )
///
/// // Custom size
/// AppIcon(
///   Icons.star,
///   size: 28,
/// )
/// ```
class AppIcon extends StatelessWidget {
  /// Creates an icon with optional size, color, and semantic label.
  ///
  /// If [size] is not provided, defaults to 24dp (Material Design 3 standard).
  /// If [color] is not provided and [semanticColor] is not set, uses
  /// [ColorScheme.onSurface] from the theme.
  const AppIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.semanticColor,
    this.semanticLabel,
  });

  /// Creates an extra small icon (16dp).
  ///
  /// Useful for dense UIs, inline icons, or small indicators.
  const AppIcon.xs(
    this.icon, {
    super.key,
    this.color,
    this.semanticColor,
    this.semanticLabel,
  }) : size = AppIconSize.xs;

  /// Creates a small icon (20dp).
  ///
  /// Useful for compact buttons, list items, or secondary icons.
  const AppIcon.sm(
    this.icon, {
    super.key,
    this.color,
    this.semanticColor,
    this.semanticLabel,
  }) : size = AppIconSize.sm;

  /// Creates a medium icon (24dp) - Material Design 3 default.
  ///
  /// This is the standard icon size for most use cases.
  const AppIcon.md(
    this.icon, {
    super.key,
    this.color,
    this.semanticColor,
    this.semanticLabel,
  }) : size = AppIconSize.md;

  /// Creates a large icon (32dp).
  ///
  /// Useful for prominent icons, headers, or feature highlights.
  const AppIcon.lg(
    this.icon, {
    super.key,
    this.color,
    this.semanticColor,
    this.semanticLabel,
  }) : size = AppIconSize.lg;

  /// Creates an extra large icon (48dp).
  ///
  /// Useful for hero icons, empty states, or primary feature icons.
  const AppIcon.xl(
    this.icon, {
    super.key,
    this.color,
    this.semanticColor,
    this.semanticLabel,
  }) : size = AppIconSize.xl;

  /// The icon to display. Typically from [Icons] material icon set.
  final IconData icon;

  /// The size of the icon in logical pixels.
  ///
  /// If not provided, defaults to 24dp (Material Design 3 standard).
  /// Use size presets ([AppIcon.xs], [AppIcon.sm], etc.) for consistency.
  final double? size;

  /// The color of the icon.
  ///
  /// If provided, overrides [semanticColor]. If both [color] and
  /// [semanticColor] are null, uses [ColorScheme.onSurface] from theme.
  final Color? color;

  /// The semantic color role from the Material Design 3 color scheme.
  ///
  /// Automatically picks the appropriate color from the theme's [ColorScheme].
  /// Ignored if [color] is provided.
  ///
  /// Example: [AppIconSemanticColor.error] uses [ColorScheme.error].
  final AppIconSemanticColor? semanticColor;

  /// A semantic label for the icon for screen readers.
  ///
  /// If provided, wraps the icon with [Semantics] widget for accessibility.
  /// Recommended for icons without accompanying text.
  ///
  /// Example: `'Search icon'` or `'Error indicator'`
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Resolve icon color: explicit color > semantic color > default
    final Color effectiveColor =
        color ?? _resolveSemanticColor(colorScheme) ?? colorScheme.onSurface;

    // Use default size if not specified
    final double effectiveSize = size ?? AppIconSize.md;

    final Widget iconWidget = Icon(
      icon,
      size: effectiveSize,
      color: effectiveColor,
    );

    // Wrap with Semantics if label provided
    if (semanticLabel != null) {
      return Semantics(label: semanticLabel, child: iconWidget);
    }

    return iconWidget;
  }

  /// Resolves the semantic color from the color scheme.
  Color? _resolveSemanticColor(ColorScheme colorScheme) {
    return switch (semanticColor) {
      AppIconSemanticColor.primary => colorScheme.primary,
      AppIconSemanticColor.onPrimary => colorScheme.onPrimary,
      AppIconSemanticColor.primaryContainer => colorScheme.primaryContainer,
      AppIconSemanticColor.onPrimaryContainer => colorScheme.onPrimaryContainer,
      AppIconSemanticColor.secondary => colorScheme.secondary,
      AppIconSemanticColor.onSecondary => colorScheme.onSecondary,
      AppIconSemanticColor.secondaryContainer => colorScheme.secondaryContainer,
      AppIconSemanticColor.onSecondaryContainer =>
        colorScheme.onSecondaryContainer,
      AppIconSemanticColor.tertiary => colorScheme.tertiary,
      AppIconSemanticColor.onTertiary => colorScheme.onTertiary,
      AppIconSemanticColor.tertiaryContainer => colorScheme.tertiaryContainer,
      AppIconSemanticColor.onTertiaryContainer =>
        colorScheme.onTertiaryContainer,
      AppIconSemanticColor.error => colorScheme.error,
      AppIconSemanticColor.onError => colorScheme.onError,
      AppIconSemanticColor.errorContainer => colorScheme.errorContainer,
      AppIconSemanticColor.onErrorContainer => colorScheme.onErrorContainer,
      AppIconSemanticColor.surface => colorScheme.surface,
      AppIconSemanticColor.onSurface => colorScheme.onSurface,
      AppIconSemanticColor.onSurfaceVariant => colorScheme.onSurfaceVariant,
      AppIconSemanticColor.outline => colorScheme.outline,
      AppIconSemanticColor.outlineVariant => colorScheme.outlineVariant,
      null => null,
    };
  }
}

/// Material Design 3 standard icon sizes in logical pixels.
///
/// These sizes follow M3 icon specifications and ensure consistent
/// icon sizing throughout the application.
///
/// **Size Guidelines:**
/// - **xs (16dp)**: Dense UIs, inline icons, small indicators
/// - **sm (20dp)**: Compact buttons, list items, secondary icons
/// - **md (24dp)**: Default size - most common use case (M3 standard)
/// - **lg (32dp)**: Prominent icons, headers, feature highlights
/// - **xl (48dp)**: Hero icons, empty states, primary features
class AppIconSize {
  const AppIconSize._();

  /// Extra small icon size: 16dp
  ///
  /// Use for: Dense UIs, inline icons, small indicators
  static const double xs = 16.0;

  /// Small icon size: 20dp
  ///
  /// Use for: Compact buttons, list items, secondary icons
  static const double sm = 20.0;

  /// Medium icon size: 24dp - Material Design 3 default
  ///
  /// Use for: Most icons - standard size for app bars, buttons, lists
  static const double md = 24.0;

  /// Large icon size: 32dp
  ///
  /// Use for: Prominent icons, headers, feature highlights
  static const double lg = 32.0;

  /// Extra large icon size: 48dp
  ///
  /// Use for: Hero icons, empty states, primary feature icons
  static const double xl = 48.0;
}

/// Semantic color roles for icons based on Material Design 3 color scheme.
///
/// These colors automatically adapt to the app's theme (light/dark mode)
/// and ensure proper contrast and accessibility.
///
/// **Usage:**
/// ```dart
/// // Error icon
/// AppIcon(
///   Icons.error,
///   semanticColor: AppIconSemanticColor.error,
/// )
///
/// // Primary action icon
/// AppIcon(
///   Icons.add,
///   semanticColor: AppIconSemanticColor.primary,
/// )
/// ```
enum AppIconSemanticColor {
  /// Primary brand color - high emphasis actions
  primary,

  /// Text/icons on primary color
  onPrimary,

  /// Muted primary for containers
  primaryContainer,

  /// Text/icons on primary container
  onPrimaryContainer,

  /// Secondary actions - less prominent
  secondary,

  /// Text/icons on secondary color
  onSecondary,

  /// Muted secondary for containers
  secondaryContainer,

  /// Text/icons on secondary container
  onSecondaryContainer,

  /// Tertiary accents - complementary
  tertiary,

  /// Text/icons on tertiary color
  onTertiary,

  /// Muted tertiary for containers
  tertiaryContainer,

  /// Text/icons on tertiary container
  onTertiaryContainer,

  /// Error states - destructive actions
  error,

  /// Text/icons on error color
  onError,

  /// Muted error for containers
  errorContainer,

  /// Text/icons on error container
  onErrorContainer,

  /// Default surface background
  surface,

  /// High-emphasis text on surface
  onSurface,

  /// Medium-emphasis text on surface
  onSurfaceVariant,

  /// Default borders
  outline,

  /// Subtle dividers
  outlineVariant,
}
