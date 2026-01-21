// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Material Design 3 typography scale for the application.
///
/// Provides a complete type system following the Material Design 3 specifications.
/// The type scale includes 15 predefined text styles organized into 5 categories:
///
/// **Display** (displayLarge, displayMedium, displaySmall):
/// - Largest text on screen (57sp - 36sp)
/// - Use for: Hero sections, landing page titles, major announcements
/// - Example: App splash screen title, welcome messages
///
/// **Headline** (headlineLarge, headlineMedium, headlineSmall):
/// - High-emphasis text (32sp - 24sp)
/// - Use for: Page titles, section headers, dialog titles
/// - Example: Screen headers, card group titles
///
/// **Title** (titleLarge, titleMedium, titleSmall):
/// - Medium-emphasis text (22sp - 14sp)
/// - Use for: Card titles, list item headers, prominent labels
/// - Example: Card headings, toolbar titles, tab labels
///
/// **Body** (bodyLarge, bodyMedium, bodySmall):
/// - Main content text (16sp - 12sp)
/// - Use for: Paragraphs, descriptions, long-form content
/// - Example: Article text, list item descriptions, help text
///
/// **Label** (labelLarge, labelMedium, labelSmall):
/// - UI element labels (14sp - 11sp)
/// - Use for: Buttons, tabs, form labels, captions
/// - Example: Button text, input labels, timestamps
///
/// ## Usage Example
///
/// ```dart
/// // Using theme text styles
/// Text(
///   'Welcome',
///   style: Theme.of(context).textTheme.displayLarge,
/// )
///
/// // Using helper methods
/// Text(
///   'Important',
///   style: AppTypography.bold(
///     Theme.of(context).textTheme.bodyLarge,
///   ),
/// )
///
/// // Responsive text scaling
/// Text(
///   'Scalable',
///   style: AppTypography.responsive(
///     Theme.of(context).textTheme.titleMedium,
///     context,
///   ),
/// )
///
/// // Common patterns
/// Text(
///   'Click here',
///   style: AppTypography.linkStyle(context),
/// )
/// ```
///
/// ## Accessibility
///
/// - All text styles support dynamic type scaling
/// - Minimum body text size is 12sp (meets WCAG guidelines)
/// - Proper contrast ratios when used with theme colors
/// - Line heights optimized for readability
///
/// See also:
/// - [Material Design 3 Type Scale](https://m3.material.io/styles/typography/type-scale-tokens)
/// - [AppTheme] for complete theme configuration
class AppTypography {
  const AppTypography._();

  /// Base font family for the app.
  ///
  /// Roboto is the default Material Design font, providing excellent
  /// readability across all screen sizes and densities.
  static const String fontFamily = 'Roboto';

  /// Creates a Material Design 3 text theme.
  ///
  /// Returns a complete [TextTheme] with all 15 text styles properly
  /// configured according to Material Design 3 specifications.
  ///
  /// This should be used in [ThemeData.textTheme] to ensure consistent
  /// typography throughout the application.
  static TextTheme textTheme() {
    return const TextTheme(
      // Display styles - largest text on screen
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 64 / 57,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 52 / 45,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 44 / 36,
      ),
      // Headline styles - high-emphasis text
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 40 / 32,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 36 / 28,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 32 / 24,
      ),
      // Title styles - medium-emphasis text
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 28 / 22,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 24 / 16,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 20 / 14,
      ),
      // Body styles - main text
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 24 / 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 20 / 14,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 16 / 12,
      ),
      // Label styles - buttons and tabs
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 20 / 14,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 16 / 12,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 16 / 11,
      ),
    );
  }

  // Text Style Modification Helpers

  /// Returns a bold version of the given text style.
  ///
  /// Sets font weight to [FontWeight.w700] (bold).
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Bold Text',
  ///   style: AppTypography.bold(
  ///     Theme.of(context).textTheme.bodyLarge,
  ///   ),
  /// )
  /// ```
  static TextStyle bold(TextStyle? style) {
    return style?.copyWith(fontWeight: FontWeight.w700) ?? const TextStyle();
  }

  /// Returns an italic version of the given text style.
  ///
  /// Sets font style to [FontStyle.italic].
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Italic Text',
  ///   style: AppTypography.italic(
  ///     Theme.of(context).textTheme.bodyMedium,
  ///   ),
  /// )
  /// ```
  static TextStyle italic(TextStyle? style) {
    return style?.copyWith(fontStyle: FontStyle.italic) ?? const TextStyle();
  }

  /// Returns a text style with the specified color.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Colored Text',
  ///   style: AppTypography.withColor(
  ///     Theme.of(context).textTheme.titleMedium,
  ///     Colors.blue,
  ///   ),
  /// )
  /// ```
  static TextStyle withColor(TextStyle? style, Color color) {
    return style?.copyWith(color: color) ?? TextStyle(color: color);
  }

  /// Returns a text style with the specified font size.
  ///
  /// Use sparingly - prefer using the predefined text styles from the type scale.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Custom Size',
  ///   style: AppTypography.withSize(
  ///     Theme.of(context).textTheme.bodyMedium,
  ///     18,
  ///   ),
  /// )
  /// ```
  static TextStyle withSize(TextStyle? style, double fontSize) {
    return style?.copyWith(fontSize: fontSize) ?? TextStyle(fontSize: fontSize);
  }

  /// Returns a text style with the specified line height.
  ///
  /// The [lineHeight] parameter is a multiplier of the font size.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Custom Line Height',
  ///   style: AppTypography.withLineHeight(
  ///     Theme.of(context).textTheme.bodyLarge,
  ///     1.8,
  ///   ),
  /// )
  /// ```
  static TextStyle withLineHeight(TextStyle? style, double lineHeight) {
    return style?.copyWith(height: lineHeight) ?? TextStyle(height: lineHeight);
  }

  /// Returns a text style with the specified letter spacing.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Spaced Text',
  ///   style: AppTypography.withLetterSpacing(
  ///     Theme.of(context).textTheme.labelLarge,
  ///     1.2,
  ///   ),
  /// )
  /// ```
  static TextStyle withLetterSpacing(TextStyle? style, double letterSpacing) {
    return style?.copyWith(letterSpacing: letterSpacing) ??
        TextStyle(letterSpacing: letterSpacing);
  }

  // Responsive Text Scaling

  /// Returns a responsively scaled text style based on screen width.
  ///
  /// Applies a scale factor based on device width:
  /// - Small devices (< 600dp): 0.9x scale
  /// - Medium devices (600-840dp): 1.0x scale (no change)
  /// - Large devices (> 840dp): 1.1x scale
  ///
  /// This ensures text remains readable on all screen sizes while
  /// maintaining proper hierarchy.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Responsive Text',
  ///   style: AppTypography.responsive(
  ///     Theme.of(context).textTheme.headlineMedium,
  ///     context,
  ///   ),
  /// )
  /// ```
  static TextStyle responsive(TextStyle? style, BuildContext context) {
    if (style == null) return const TextStyle();

    final width = MediaQuery.of(context).size.width;
    double scaleFactor;

    if (width < 600) {
      scaleFactor = 0.9; // Small devices
    } else if (width < 840) {
      scaleFactor = 1.0; // Medium devices
    } else {
      scaleFactor = 1.1; // Large devices
    }

    return style.copyWith(fontSize: (style.fontSize ?? 14) * scaleFactor);
  }

  /// Returns a text style scaled by the specified factor.
  ///
  /// Use this for custom scaling needs beyond the responsive preset.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Scaled Text',
  ///   style: AppTypography.scale(
  ///     Theme.of(context).textTheme.titleLarge,
  ///     1.5,
  ///   ),
  /// )
  /// ```
  static TextStyle scale(TextStyle? style, double scaleFactor) {
    if (style == null) return const TextStyle();

    return style.copyWith(fontSize: (style.fontSize ?? 14) * scaleFactor);
  }

  // Common Pattern Helpers

  /// Returns a text style suitable for clickable links.
  ///
  /// Uses the theme's primary color with underline decoration.
  ///
  /// Example:
  /// ```dart
  /// GestureDetector(
  ///   onTap: () => launch('https://example.com'),
  ///   child: Text(
  ///     'Click here',
  ///     style: AppTypography.linkStyle(context),
  ///   ),
  /// )
  /// ```
  static TextStyle linkStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.primary,
      decoration: TextDecoration.underline,
      decorationColor: Theme.of(context).colorScheme.primary,
    );
  }

  /// Returns a text style for error messages.
  ///
  /// Uses the theme's error color.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Invalid email address',
  ///   style: AppTypography.errorStyle(context),
  /// )
  /// ```
  static TextStyle errorStyle(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error);
  }

  /// Returns a text style for success messages.
  ///
  /// Uses a green color appropriate for success states.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Profile updated successfully',
  ///   style: AppTypography.successStyle(context),
  /// )
  /// ```
  static TextStyle successStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
      color: const Color(0xFF4CAF50), // Material Green
    );
  }

  /// Returns a text style for warning messages.
  ///
  /// Uses an orange color appropriate for warning states.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Connection unstable',
  ///   style: AppTypography.warningStyle(context),
  /// )
  /// ```
  static TextStyle warningStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
      color: const Color(0xFFFF9800), // Material Orange
    );
  }

  /// Returns a text style for hint or placeholder text.
  ///
  /// Uses the theme's onSurface color with reduced opacity.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Enter your email',
  ///   style: AppTypography.hintStyle(context),
  /// )
  /// ```
  static TextStyle hintStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
    );
  }

  /// Returns a text style for disabled text.
  ///
  /// Uses the theme's onSurface color with low opacity.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Disabled option',
  ///   style: AppTypography.disabledStyle(context),
  /// )
  /// ```
  static TextStyle disabledStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38),
    );
  }

  /// Returns a text style with monospace font for code snippets.
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'const value = 42;',
  ///   style: AppTypography.codeStyle(context),
  /// )
  /// ```
  static TextStyle codeStyle(BuildContext context) {
    return Theme.of(context).textTheme.bodySmall!.copyWith(
      fontFamily: 'monospace',
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    );
  }
}
