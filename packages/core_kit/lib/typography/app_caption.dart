// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 caption text widget for displaying small, secondary text.
///
/// The [AppCaption] component provides a consistent way to display captions,
/// timestamps, labels, and helper text throughout the application. It follows
/// Material Design 3 typography guidelines and automatically adapts to the
/// app's theme.
///
/// ## Usage
///
/// ```dart
/// // Basic caption
/// AppCaption(text: 'Photo taken on January 10, 2026')
///
/// // Timestamp
/// AppCaption(text: '2 hours ago')
///
/// // Helper text with custom color
/// AppCaption(
///   text: 'This field is required',
///   color: Theme.of(context).colorScheme.error,
/// )
///
/// // Caption with overflow handling
/// AppCaption(
///   text: 'Very long caption text that might overflow...',
///   maxLines: 2,
///   overflow: TextOverflow.ellipsis,
/// )
///
/// // Label-style caption (smaller, medium weight)
/// AppCaption(
///   text: 'LABEL',
///   useLabel: true,
/// )
/// ```
///
/// ## When to Use
///
/// **AppCaption is ideal for:**
/// - Image captions and photo credits
/// - Timestamps ("2 hours ago", "Updated yesterday")
/// - Form field helper text and hints
/// - Metadata labels (file size, date modified, author)
/// - Small labels in cards or list items
/// - Copyright notices and legal text
/// - Supporting information that shouldn't dominate
///
/// **Choose the right style:**
/// - **Default (bodySmall)**: Most captions, timestamps, helper text
/// - **Label style (labelSmall)**: Small labels, tags, metadata keys
///
/// ## Typography Styles
///
/// This component uses Material Design 3 text styles:
///
/// **bodySmall** (default):
/// - Font size: 12sp
/// - Font weight: 400 (regular)
/// - Letter spacing: 0.4
/// - Use for: General captions, timestamps, helper text
///
/// **labelSmall** (when useLabel = true):
/// - Font size: 11sp
/// - Font weight: 500 (medium)
/// - Letter spacing: 0.5
/// - Use for: Small labels, tags, metadata keys
///
/// ## Color Guidelines
///
/// By default, captions use `onSurfaceVariant` color (60% emphasis) to
/// indicate secondary information. This ensures captions don't compete
/// with primary content for attention.
///
/// You can override the color for special cases:
/// - Error messages: Use `colorScheme.error`
/// - Success messages: Use `colorScheme.primary` or custom green
/// - Warnings: Use custom amber/orange
///
/// ## Accessibility
///
/// This component automatically provides proper accessibility support:
/// - Text is readable by screen readers
/// - Semantic labels are properly set
/// - Minimum contrast ratios maintained (when using theme colors)
/// - Text scaling supported through Material Design 3 typography
///
/// ## Material Design 3 Compliance
///
/// This component follows MD3 specifications:
/// - Typography: Uses theme's `bodySmall` or `labelSmall` text styles
/// - Color: Defaults to `onSurfaceVariant` for 60% emphasis
/// - Spacing: Inherits from parent layout (no built-in padding)
/// - Accessibility: Proper semantic labels and contrast
///
/// See also:
/// - [Material Design 3 Typography](https://m3.material.io/styles/typography)
/// - [AppLabel] for larger label text
/// - [AppBodyText] for regular body text
class AppCaption extends StatelessWidget {
  /// Creates a caption text widget.
  ///
  /// The [text] parameter is required and specifies the caption content.
  ///
  /// By default, the caption uses the theme's `bodySmall` text style and
  /// `onSurfaceVariant` color. Set [useLabel] to true to use `labelSmall`
  /// style instead (smaller, medium weight).
  ///
  /// Use [maxLines] and [overflow] to control how long text is handled.
  /// Use [textAlign] to control text alignment within its container.
  const AppCaption({
    required this.text,
    this.color,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.textAlign = TextAlign.start,
    this.useLabel = false,
    super.key,
  });

  /// The caption text to display.
  ///
  /// This text is required and will be displayed using the appropriate
  /// Material Design 3 text style (bodySmall or labelSmall).
  final String text;

  /// The color to use for the caption text.
  ///
  /// If null, defaults to [ColorScheme.onSurfaceVariant] which provides
  /// 60% emphasis appropriate for secondary text.
  ///
  /// Override this for special cases like error messages:
  /// ```dart
  /// AppCaption(
  ///   text: 'Error: Invalid input',
  ///   color: Theme.of(context).colorScheme.error,
  /// )
  /// ```
  final Color? color;

  /// The maximum number of lines for the caption text.
  ///
  /// If null (default), the text will wrap to as many lines as needed.
  /// If set, text will be limited to this many lines and [overflow]
  /// will determine how excess text is handled.
  ///
  /// Example:
  /// ```dart
  /// AppCaption(
  ///   text: 'Long caption...',
  ///   maxLines: 2,
  ///   overflow: TextOverflow.ellipsis,
  /// )
  /// ```
  final int? maxLines;

  /// How visual overflow should be handled.
  ///
  /// Defaults to [TextOverflow.clip]. Common options:
  /// - [TextOverflow.clip]: Clip the overflowing text
  /// - [TextOverflow.ellipsis]: Show ellipsis (...) for overflow
  /// - [TextOverflow.fade]: Fade out the overflowing text
  /// - [TextOverflow.visible]: Allow overflow to be visible
  ///
  /// This is most useful when combined with [maxLines].
  final TextOverflow overflow;

  /// How the text should be aligned horizontally.
  ///
  /// Defaults to [TextAlign.start] (left in LTR, right in RTL).
  ///
  /// Common options:
  /// - [TextAlign.start]: Align to the start edge (default)
  /// - [TextAlign.center]: Center the text
  /// - [TextAlign.end]: Align to the end edge
  /// - [TextAlign.justify]: Justify the text
  final TextAlign textAlign;

  /// Whether to use label style instead of body style.
  ///
  /// When false (default), uses `bodySmall` (12sp, 400 weight).
  /// When true, uses `labelSmall` (11sp, 500 weight).
  ///
  /// Use label style for small labels, tags, and metadata keys.
  /// Use body style (default) for general captions and helper text.
  ///
  /// Example:
  /// ```dart
  /// // Regular caption
  /// AppCaption(text: 'Photo taken yesterday')
  ///
  /// // Label-style caption
  /// AppCaption(text: 'FILE SIZE', useLabel: true)
  /// ```
  final bool useLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Select appropriate text style based on useLabel flag
    final textStyle = useLabel ? textTheme.labelSmall : textTheme.bodySmall;

    // Use onSurfaceVariant for 60% emphasis (secondary text)
    final effectiveColor = color ?? colorScheme.onSurfaceVariant;

    return Semantics(
      label: text,
      child: Text(
        text,
        style: textStyle?.copyWith(color: effectiveColor),
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
      ),
    );
  }
}
