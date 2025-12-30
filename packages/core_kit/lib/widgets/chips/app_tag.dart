// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 tag component for displaying non-interactive labels,
/// categories, and status indicators.
///
/// The [AppTag] component is a simplified chip variant designed purely for
/// display purposes without interaction. It represents categories, labels,
/// statuses, or attributes in a compact, visually distinct format.
///
/// ## Features
///
/// - Non-interactive display (no tap response)
/// - Optional leading icon
/// - Semantic color variants (success, warning, error, info, neutral)
/// - Size variants (small, medium, large)
/// - Style variants (filled, outlined)
/// - Text overflow handling with ellipsis
/// - RTL language support
/// - Accessibility features
///
/// ## Basic Usage
///
/// ```dart
/// AppTag(
///   label: 'Featured',
///   colorVariant: AppTagColorVariant.success,
/// )
/// ```
///
/// ## With Icon
///
/// ```dart
/// AppTag(
///   label: 'Premium',
///   icon: Icons.star,
///   colorVariant: AppTagColorVariant.warning,
///   size: AppTagSize.large,
/// )
/// ```
///
/// ## Custom Colors
///
/// ```dart
/// AppTag(
///   label: 'Custom',
///   backgroundColor: Colors.purple,
///   textColor: Colors.white,
/// )
/// ```
///
/// ## Material Design 3 Specifications
///
/// ### Layout
/// - Small: 20dp height, 8dp padding, 12dp icon size, 4dp border radius
/// - Medium: 24dp height, 12dp padding, 16dp icon size, 6dp border radius
/// - Large: 32dp height, 12dp padding, 18dp icon size, 8dp border radius
///
/// ### Typography
/// - Small: labelSmall (11sp)
/// - Medium: labelMedium (12sp)
/// - Large: labelLarge (14sp)
///
/// ## Accessibility
///
/// - Semantic labels announce tag content
/// - Proper contrast ratios maintained
/// - Non-interactive state properly announced
///
/// See also:
/// - [Chip] - Flutter's base chip widget
/// - [Material Design 3 Chips](https://m3.material.io/components/chips/overview)
class AppTag extends StatelessWidget {
  /// Creates a Material Design 3 tag component.
  ///
  /// The [label] parameter is required and must not be empty.
  const AppTag({
    super.key,
    required this.label,
    this.icon,
    this.colorVariant = AppTagColorVariant.neutral,
    this.size = AppTagSize.medium,
    this.style = AppTagStyle.filled,
    this.backgroundColor,
    this.textColor,
    this.semanticLabel,
  }) : assert(label != '', 'Label must not be empty');

  /// The text to display in the tag.
  ///
  /// This is required and must not be empty. Long text will be truncated
  /// with an ellipsis.
  final String label;

  /// Optional icon to display before the label.
  ///
  /// The icon size is automatically adjusted based on [size].
  final IconData? icon;

  /// The semantic color variant to use.
  ///
  /// Provides predefined color schemes for common use cases like success,
  /// warning, error, info, and neutral states.
  ///
  /// Defaults to [AppTagColorVariant.neutral].
  final AppTagColorVariant colorVariant;

  /// The size variant of the tag.
  ///
  /// Controls the height, padding, icon size, border radius, and typography.
  ///
  /// Defaults to [AppTagSize.medium].
  final AppTagSize size;

  /// The visual style of the tag.
  ///
  /// - [AppTagStyle.filled]: Solid background color
  /// - [AppTagStyle.outlined]: Border with transparent background
  ///
  /// Defaults to [AppTagStyle.filled].
  final AppTagStyle style;

  /// Custom background color.
  ///
  /// If provided, overrides the color from [colorVariant].
  /// Only applies when [style] is [AppTagStyle.filled].
  final Color? backgroundColor;

  /// Custom text color.
  ///
  /// If provided, overrides the text color from [colorVariant].
  final Color? textColor;

  /// Semantic label for screen readers.
  ///
  /// If null, the [label] text is used for accessibility.
  final String? semanticLabel;

  /// Gets the height for the current size variant.
  double get _height {
    switch (size) {
      case AppTagSize.small:
        return 20.0;
      case AppTagSize.medium:
        return 24.0;
      case AppTagSize.large:
        return 32.0;
    }
  }

  /// Gets the horizontal padding for the current size variant.
  double get _horizontalPadding {
    switch (size) {
      case AppTagSize.small:
        return 8.0;
      case AppTagSize.medium:
      case AppTagSize.large:
        return 12.0;
    }
  }

  /// Gets the icon size for the current size variant.
  double get _iconSize {
    switch (size) {
      case AppTagSize.small:
        return 12.0;
      case AppTagSize.medium:
        return 16.0;
      case AppTagSize.large:
        return 18.0;
    }
  }

  /// Gets the border radius for the current size variant.
  double get _borderRadius {
    switch (size) {
      case AppTagSize.small:
        return 4.0;
      case AppTagSize.medium:
        return 6.0;
      case AppTagSize.large:
        return 8.0;
    }
  }

  /// Gets the text style for the current size variant.
  TextStyle? _getTextStyle(ThemeData theme) {
    switch (size) {
      case AppTagSize.small:
        return theme.textTheme.labelSmall;
      case AppTagSize.medium:
        return theme.textTheme.labelMedium;
      case AppTagSize.large:
        return theme.textTheme.labelLarge;
    }
  }

  /// Gets the background color based on variant and theme.
  Color _getBackgroundColor(ColorScheme colorScheme) {
    if (backgroundColor != null) {
      return backgroundColor!;
    }

    switch (colorVariant) {
      case AppTagColorVariant.success:
        return colorScheme.primaryContainer;
      case AppTagColorVariant.warning:
        return colorScheme.tertiaryContainer;
      case AppTagColorVariant.error:
        return colorScheme.errorContainer;
      case AppTagColorVariant.info:
        return colorScheme.secondaryContainer;
      case AppTagColorVariant.neutral:
        return colorScheme.surfaceContainerHighest;
    }
  }

  /// Gets the text/icon color based on variant and theme.
  Color _getTextColor(ColorScheme colorScheme) {
    if (textColor != null) {
      return textColor!;
    }

    switch (colorVariant) {
      case AppTagColorVariant.success:
        return colorScheme.onPrimaryContainer;
      case AppTagColorVariant.warning:
        return colorScheme.onTertiaryContainer;
      case AppTagColorVariant.error:
        return colorScheme.onErrorContainer;
      case AppTagColorVariant.info:
        return colorScheme.onSecondaryContainer;
      case AppTagColorVariant.neutral:
        return colorScheme.onSurface;
    }
  }

  /// Gets the border color for outlined style.
  Color _getBorderColor(ColorScheme colorScheme) {
    // Use the same color logic as text color for borders
    return _getTextColor(colorScheme);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bgColor = _getBackgroundColor(colorScheme);
    final fgColor = _getTextColor(colorScheme);
    final borderColor = _getBorderColor(colorScheme);

    return Semantics(
      label: semanticLabel ?? label,
      button: false,
      container: true,
      child: Container(
        height: _height,
        padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
        decoration: BoxDecoration(
          color: style == AppTagStyle.filled ? bgColor : Colors.transparent,
          border: style == AppTagStyle.outlined
              ? Border.all(color: borderColor, width: 1.0)
              : null,
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Leading icon
            if (icon != null) ...[
              Icon(icon, size: _iconSize, color: fgColor),
              SizedBox(width: size == AppTagSize.small ? 4.0 : 6.0),
            ],

            // Label text
            Flexible(
              child: Text(
                label,
                style: _getTextStyle(theme)?.copyWith(color: fgColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Size variants for [AppTag].
enum AppTagSize {
  /// Small tag: 20dp height, 8dp padding, 12dp icon, 4dp radius
  small,

  /// Medium tag: 24dp height, 12dp padding, 16dp icon, 6dp radius
  medium,

  /// Large tag: 32dp height, 12dp padding, 18dp icon, 8dp radius
  large,
}

/// Style variants for [AppTag].
enum AppTagStyle {
  /// Solid background color
  filled,

  /// Border with transparent background
  outlined,
}

/// Semantic color variants for [AppTag].
enum AppTagColorVariant {
  /// Success state (green tones)
  success,

  /// Warning state (amber tones)
  warning,

  /// Error state (red tones)
  error,

  /// Information state (blue tones)
  info,

  /// Neutral state (gray tones)
  neutral,
}
