// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A utility class providing helper methods and preset text styles for
/// common patterns not covered by the standard Material Design 3 type scale.
///
/// This class offers:
/// - Semantic style presets (error, success, warning, info, link, muted)
/// - Modification helpers (bold, italic, underline, strikethrough)
/// - Color and opacity utilities
/// - Size scaling helpers
/// - Monospace styles for code
///
/// Example usage:
/// ```dart
/// // Semantic presets
/// Text('Error message', style: AppTextStyles.error(context))
/// Text('Success!', style: AppTextStyles.success(context))
///
/// // Modification helpers
/// Text('Bold text', style: AppTextStyles.bold(context))
/// Text('Link text', style: AppTextStyles.link(context))
///
/// // Combining helpers
/// final baseStyle = Theme.of(context).textTheme.bodyMedium;
/// Text('Custom', style: AppTextStyles.withColor(baseStyle, Colors.blue))
/// ```
class AppTextStyles {
  const AppTextStyles._();

  // ============================================================================
  // Semantic Presets
  // ============================================================================

  /// Returns a text style for error messages.
  ///
  /// Uses the error color from the theme's color scheme with medium weight.
  /// Based on bodyMedium from the text theme.
  static TextStyle error(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.error,
      fontWeight: FontWeight.w500,
    );
  }

  /// Returns a text style for success messages.
  ///
  /// Uses a green color indicating successful operations.
  /// Based on bodyMedium from the text theme.
  static TextStyle success(BuildContext context) {
    final theme = Theme.of(context);
    // Using tertiary as success color (can be customized in theme)
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.tertiary,
      fontWeight: FontWeight.w500,
    );
  }

  /// Returns a text style for warning messages.
  ///
  /// Uses the tertiary container color for warning indications.
  /// Based on bodyMedium from the text theme.
  static TextStyle warning(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.tertiaryContainer,
      fontWeight: FontWeight.w500,
    );
  }

  /// Returns a text style for informational messages.
  ///
  /// Uses the primary color for informational content.
  /// Based on bodyMedium from the text theme.
  static TextStyle info(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.w500,
    );
  }

  /// Returns a text style for link text.
  ///
  /// Uses the primary color with underline decoration to indicate
  /// clickable/tappable text.
  /// Based on bodyMedium from the text theme.
  static TextStyle link(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.primary,
      decoration: TextDecoration.underline,
      decorationColor: theme.colorScheme.primary,
    );
  }

  /// Returns a text style for muted/disabled text.
  ///
  /// Uses reduced opacity (60%) to indicate secondary or disabled content.
  /// Based on bodyMedium from the text theme.
  static TextStyle muted(BuildContext context) {
    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium!.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
    );
  }

  // ============================================================================
  // Modification Helpers
  // ============================================================================

  /// Returns a bold version of the given text style.
  ///
  /// Sets font weight to [FontWeight.bold] (w700).
  ///
  /// Example:
  /// ```dart
  /// final boldStyle = AppTextStyles.bold(
  ///   context,
  ///   style: Theme.of(context).textTheme.bodyLarge,
  /// );
  /// ```
  static TextStyle bold(BuildContext context, {TextStyle? style}) {
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium!;
    return baseStyle.copyWith(fontWeight: FontWeight.bold);
  }

  /// Returns an italic version of the given text style.
  ///
  /// Sets font style to [FontStyle.italic].
  static TextStyle italic(BuildContext context, {TextStyle? style}) {
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium!;
    return baseStyle.copyWith(fontStyle: FontStyle.italic);
  }

  /// Returns an underlined version of the given text style.
  ///
  /// Adds [TextDecoration.underline] to the text.
  static TextStyle underline(BuildContext context, {TextStyle? style}) {
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium!;
    return baseStyle.copyWith(
      decoration: TextDecoration.underline,
      decorationColor: baseStyle.color,
    );
  }

  /// Returns a strikethrough version of the given text style.
  ///
  /// Adds [TextDecoration.lineThrough] to indicate deleted or invalid content.
  static TextStyle strikethrough(BuildContext context, {TextStyle? style}) {
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium!;
    return baseStyle.copyWith(
      decoration: TextDecoration.lineThrough,
      decorationColor: baseStyle.color,
    );
  }

  // ============================================================================
  // Color Helpers
  // ============================================================================

  /// Returns a text style with the specified color.
  ///
  /// Applies the given [color] to the provided [style].
  ///
  /// Example:
  /// ```dart
  /// final redText = AppTextStyles.withColor(
  ///   Theme.of(context).textTheme.bodyLarge!,
  ///   Colors.red,
  /// );
  /// ```
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Returns a text style with the specified opacity.
  ///
  /// Applies the given [opacity] (0.0 to 1.0) to the text color.
  ///
  /// Example:
  /// ```dart
  /// final fadedText = AppTextStyles.withOpacity(
  ///   Theme.of(context).textTheme.bodyLarge!,
  ///   0.5,
  /// );
  /// ```
  static TextStyle withOpacity(TextStyle style, double opacity) {
    return style.copyWith(color: style.color?.withValues(alpha: opacity));
  }

  // ============================================================================
  // Size Helpers
  // ============================================================================

  /// Returns a larger version of the given text style.
  ///
  /// Increases font size by [factor] (default 1.2x).
  ///
  /// Example:
  /// ```dart
  /// final largerText = AppTextStyles.larger(
  ///   context,
  ///   style: Theme.of(context).textTheme.bodyMedium,
  ///   factor: 1.5,
  /// );
  /// ```
  static TextStyle larger(
    BuildContext context, {
    TextStyle? style,
    double factor = 1.2,
  }) {
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium!;
    final currentSize = baseStyle.fontSize ?? 14.0;
    return baseStyle.copyWith(fontSize: currentSize * factor);
  }

  /// Returns a smaller version of the given text style.
  ///
  /// Decreases font size by [factor] (default 0.85x).
  ///
  /// Example:
  /// ```dart
  /// final smallerText = AppTextStyles.smaller(
  ///   context,
  ///   style: Theme.of(context).textTheme.bodyMedium,
  /// );
  /// ```
  static TextStyle smaller(
    BuildContext context, {
    TextStyle? style,
    double factor = 0.85,
  }) {
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium!;
    final currentSize = baseStyle.fontSize ?? 14.0;
    return baseStyle.copyWith(fontSize: currentSize * factor);
  }

  // ============================================================================
  // Special Styles
  // ============================================================================

  /// Returns a monospace text style for displaying code.
  ///
  /// Uses a monospace font family for consistent character width,
  /// useful for code snippets, terminal output, or technical content.
  ///
  /// Example:
  /// ```dart
  /// Text('const value = 42;', style: AppTextStyles.monospace(context))
  /// ```
  static TextStyle monospace(BuildContext context, {TextStyle? style}) {
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium!;
    return baseStyle.copyWith(
      fontFamily: 'monospace',
      fontFamilyFallback: const ['Courier', 'Courier New', 'Monaco'],
    );
  }

  /// Returns a text style with custom line height.
  ///
  /// Adjusts the line height (spacing between lines) using [height] parameter.
  /// A value of 1.0 means normal line height, 1.5 means 150% of font size, etc.
  ///
  /// Example:
  /// ```dart
  /// final spacedText = AppTextStyles.withLineHeight(
  ///   Theme.of(context).textTheme.bodyMedium!,
  ///   1.8,
  /// );
  /// ```
  static TextStyle withLineHeight(TextStyle style, double height) {
    return style.copyWith(height: height);
  }

  /// Returns a text style with custom letter spacing.
  ///
  /// Adjusts the spacing between characters. Positive values increase spacing,
  /// negative values decrease it.
  ///
  /// Example:
  /// ```dart
  /// final wideText = AppTextStyles.withLetterSpacing(
  ///   Theme.of(context).textTheme.bodyMedium!,
  ///   2.0,
  /// );
  /// ```
  static TextStyle withLetterSpacing(TextStyle style, double spacing) {
    return style.copyWith(letterSpacing: spacing);
  }
}
