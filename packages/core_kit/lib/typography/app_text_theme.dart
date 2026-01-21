// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Utility class for working with Flutter's TextTheme.
///
/// Provides extension methods, theme merging utilities, responsive scaling,
/// and debugging helpers for easier text theme management.
///
/// Example usage:
/// ```dart
/// // Access theme text styles
/// final theme = context.textTheme;
/// Text('Hello', style: theme.bodyLarge);
///
/// // Responsive scaling
/// final scaledTheme = AppTextTheme.responsive(context, baseSize: 16);
///
/// // Merge themes
/// final merged = AppTextTheme.merge(baseTheme, overrideTheme);
/// ```
class AppTextTheme {
  const AppTextTheme._();

  /// Merges two TextThemes, with [override] taking precedence over [base].
  ///
  /// Returns a new TextTheme where non-null values from [override] replace
  /// corresponding values in [base].
  ///
  /// Example:
  /// ```dart
  /// final base = Theme.of(context).textTheme;
  /// final custom = TextTheme(bodyLarge: TextStyle(fontSize: 18));
  /// final merged = AppTextTheme.merge(base, custom);
  /// ```
  static TextTheme merge(TextTheme base, TextTheme override) {
    return base.merge(override);
  }

  /// Creates a responsive TextTheme scaled based on screen size.
  ///
  /// The [context] is used to determine screen width for scaling.
  /// [baseSize] is the reference font size (default: 16.0).
  /// [scaleFactor] adjusts the scaling intensity (default: 1.0).
  ///
  /// Breakpoints:
  /// - Small (< 600px): 0.9x scale
  /// - Medium (600-1200px): 1.0x scale
  /// - Large (> 1200px): 1.1x scale
  ///
  /// Example:
  /// ```dart
  /// final responsiveTheme = AppTextTheme.responsive(
  ///   context,
  ///   baseSize: 16.0,
  ///   scaleFactor: 1.2,
  /// );
  /// ```
  static TextTheme responsive(
    BuildContext context, {
    double baseSize = 16.0,
    double scaleFactor = 1.0,
  }) {
    final width = MediaQuery.of(context).size.width;
    final scale = _calculateScale(width) * scaleFactor;
    final theme = Theme.of(context).textTheme;

    return theme.apply(fontSizeFactor: scale, fontSizeDelta: 0.0);
  }

  /// Calculates scale factor based on screen width.
  static double _calculateScale(double width) {
    if (width < 600) {
      return 0.9; // Small screens (mobile)
    } else if (width < 1200) {
      return 1.0; // Medium screens (tablet)
    } else {
      return 1.1; // Large screens (desktop)
    }
  }

  /// Creates a custom TextTheme with specified font family.
  ///
  /// Applies [fontFamily] to all text styles in the theme.
  ///
  /// Example:
  /// ```dart
  /// final customTheme = AppTextTheme.withFontFamily(
  ///   Theme.of(context).textTheme,
  ///   'CustomFont',
  /// );
  /// ```
  static TextTheme withFontFamily(TextTheme base, String fontFamily) {
    return base.apply(fontFamily: fontFamily);
  }

  /// Creates a TextTheme with custom color applied to all styles.
  ///
  /// Example:
  /// ```dart
  /// final coloredTheme = AppTextTheme.withColor(
  ///   Theme.of(context).textTheme,
  ///   Colors.blue,
  /// );
  /// ```
  static TextTheme withColor(TextTheme base, Color color) {
    return base.apply(bodyColor: color, displayColor: color);
  }

  /// Creates a debugging map of all TextTheme styles.
  ///
  /// Returns a map with style names as keys and TextStyle objects as values.
  /// Useful for debugging and visualizing theme configuration.
  ///
  /// Example:
  /// ```dart
  /// final styles = AppTextTheme.debugStyles(context);
  /// styles.forEach((name, style) {
  ///   print('$name: ${style.fontSize}px');
  /// });
  /// ```
  static Map<String, TextStyle?> debugStyles(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return {
      'displayLarge': theme.displayLarge,
      'displayMedium': theme.displayMedium,
      'displaySmall': theme.displaySmall,
      'headlineLarge': theme.headlineLarge,
      'headlineMedium': theme.headlineMedium,
      'headlineSmall': theme.headlineSmall,
      'titleLarge': theme.titleLarge,
      'titleMedium': theme.titleMedium,
      'titleSmall': theme.titleSmall,
      'bodyLarge': theme.bodyLarge,
      'bodyMedium': theme.bodyMedium,
      'bodySmall': theme.bodySmall,
      'labelLarge': theme.labelLarge,
      'labelMedium': theme.labelMedium,
      'labelSmall': theme.labelSmall,
    };
  }

  /// Creates a scaled version of a specific TextStyle.
  ///
  /// Multiplies the fontSize by [scale] factor.
  ///
  /// Example:
  /// ```dart
  /// final scaled = AppTextTheme.scaleStyle(
  ///   Theme.of(context).textTheme.bodyLarge!,
  ///   1.5,
  /// );
  /// ```
  static TextStyle scaleStyle(TextStyle style, double scale) {
    return style.copyWith(fontSize: (style.fontSize ?? 14.0) * scale);
  }

  /// Creates a bold version of a TextStyle.
  ///
  /// Example:
  /// ```dart
  /// final bold = AppTextTheme.bold(
  ///   Theme.of(context).textTheme.bodyLarge!,
  /// );
  /// ```
  static TextStyle bold(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.bold);
  }

  /// Creates an italic version of a TextStyle.
  ///
  /// Example:
  /// ```dart
  /// final italic = AppTextTheme.italic(
  ///   Theme.of(context).textTheme.bodyLarge!,
  /// );
  /// ```
  static TextStyle italic(TextStyle style) {
    return style.copyWith(fontStyle: FontStyle.italic);
  }
}

/// Extension on BuildContext for easier TextTheme access.
///
/// Provides a convenient shorthand for accessing the current theme's TextTheme.
///
/// Example:
/// ```dart
/// Text('Hello', style: context.textTheme.bodyLarge);
/// ```
extension TextThemeContext on BuildContext {
  /// Quick access to the current theme's TextTheme.
  TextTheme get textTheme => Theme.of(this).textTheme;
}

/// Extension on TextTheme for additional utility methods.
///
/// Provides convenient methods for common TextTheme operations.
extension TextThemeExtensions on TextTheme {
  /// Creates a copy with responsive scaling applied.
  ///
  /// Example:
  /// ```dart
  /// final scaled = theme.textTheme.withScale(1.2);
  /// ```
  TextTheme withScale(double scale) {
    return apply(fontSizeFactor: scale);
  }

  /// Creates a copy with custom color applied.
  ///
  /// Example:
  /// ```dart
  /// final colored = theme.textTheme.withColor(Colors.blue);
  /// ```
  TextTheme withColor(Color color) {
    return apply(bodyColor: color, displayColor: color);
  }

  /// Creates a copy with custom font family.
  ///
  /// Example:
  /// ```dart
  /// final custom = theme.textTheme.withFontFamily('CustomFont');
  /// ```
  TextTheme withFontFamily(String fontFamily) {
    return apply(fontFamily: fontFamily);
  }
}
