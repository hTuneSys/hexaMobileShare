// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 overline/eyebrow text widget for displaying small,
/// uppercase text above headings or titles.
///
/// [AppOverline] is a specialized text widget that follows Material Design 3
/// guidelines for overline text. It automatically transforms text to uppercase,
/// uses appropriate typography scale (labelSmall), and applies lower emphasis
/// color (onSurfaceVariant) to provide context without competing with the
/// main headline.
///
/// This widget is commonly used in editorial layouts, news articles, content
/// cards, and marketing materials to provide category labels, section
/// identifiers, or contextual information above primary content.
///
/// ## Usage
///
/// ```dart
/// // Basic overline
/// AppOverline('Technology')
///
/// // With custom color
/// AppOverline(
///   'Featured Article',
///   color: Theme.of(context).colorScheme.primary,
/// )
///
/// // Above a headline (common pattern)
/// Column(
///   crossAxisAlignment: CrossAxisAlignment.start,
///   children: [
///     AppOverline('Business'),
///     SizedBox(height: 8),
///     Text(
///       'Market reaches new heights',
///       style: Theme.of(context).textTheme.headlineMedium,
///     ),
///   ],
/// )
/// ```
///
/// ## When to Use
///
/// **Category Labels**: Display content categories above article titles
/// - "TECHNOLOGY", "BUSINESS", "SPORTS"
/// - Section identifiers in news apps or blogs
///
/// **Step Indicators**: Show progression in multi-step flows
/// - "STEP 1", "STEP 2 OF 3"
/// - Chapter or section numbers
///
/// **Contextual Labels**: Provide additional context above main content
/// - Date/time labels above events
/// - Tag or badge labels
/// - Feature section eyebrows
///
/// **Content Cards**: Add category or source information
/// - Card headers showing content type
/// - Source attribution above article previews
///
/// ## Typography Specifications
///
/// This widget follows Material Design 3 specifications:
/// - Text style: labelSmall (11sp, 500 weight, 0.5 letter spacing)
/// - Text transform: Uppercase (ALL CAPS)
/// - Default color: onSurfaceVariant (60% emphasis)
/// - Line height: Default from theme
///
/// ## Accessibility
///
/// The uppercase transformation is purely visual. Screen readers will
/// announce the original text without modification. This ensures proper
/// pronunciation and readability for users with visual impairments.
///
/// ## Material Design 3 Compliance
///
/// This component strictly follows MD3 guidelines:
/// - Uses theme's labelSmall text style
/// - Applies automatic uppercase transformation
/// - Default color is onSurfaceVariant for lower emphasis
/// - Supports custom colors while maintaining accessibility
///
/// See also:
/// - [Material Design 3 Typography](https://m3.material.io/styles/typography)
/// - [Text] for the underlying Flutter widget
class AppOverline extends StatelessWidget {
  /// Creates an overline text widget.
  ///
  /// The [data] parameter is required and contains the text to display.
  /// Text will be automatically transformed to uppercase for visual
  /// presentation while preserving the original text for screen readers.
  ///
  /// The [color] parameter defaults to [ColorScheme.onSurfaceVariant] to
  /// provide lower emphasis compared to primary content. Custom colors
  /// can be provided while maintaining accessibility contrast ratios.
  ///
  /// The [textAlign] parameter controls text alignment and defaults to
  /// [TextAlign.start] (left-aligned in LTR, right-aligned in RTL).
  ///
  /// Example:
  /// ```dart
  /// AppOverline('Technology')
  /// // Displays: TECHNOLOGY (in labelSmall style, onSurfaceVariant color)
  /// ```
  const AppOverline(
    this.data, {
    this.color,
    this.textAlign = TextAlign.start,
    super.key,
  });

  /// The text to display.
  ///
  /// This text will be automatically transformed to uppercase for display
  /// while maintaining the original case for screen reader accessibility.
  final String data;

  /// The color to use for the text.
  ///
  /// If null, defaults to [ColorScheme.onSurfaceVariant] which provides
  /// appropriate lower emphasis for overline/eyebrow text.
  ///
  /// When providing a custom color, ensure adequate contrast ratio
  /// (minimum 4.5:1) for accessibility compliance.
  final Color? color;

  /// How the text should be aligned horizontally.
  ///
  /// Defaults to [TextAlign.start] which respects text directionality:
  /// - Left-aligned in left-to-right languages (LTR)
  /// - Right-aligned in right-to-left languages (RTL)
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.onSurfaceVariant;

    return Text(
      data.toUpperCase(),
      style: theme.textTheme.labelSmall?.copyWith(color: effectiveColor),
      textAlign: textAlign,
    );
  }
}
