// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A convenience widget for displaying label text with Material Design 3 styling.
///
/// [AppLabel] provides a simple API for rendering label text (text used in
/// buttons, tabs, form fields, and other interactive elements) with consistent
/// typography from the app's theme. It automatically applies the appropriate
/// text style from [TextTheme] based on the variant.
///
/// ## Variants
///
/// - [AppLabel.large] - 14sp, 500 weight, 0.1 letter spacing (buttons)
/// - [AppLabel.medium] - 12sp, 500 weight, 0.5 letter spacing (tabs, chips)
/// - [AppLabel.small] - 11sp, 500 weight, 0.5 letter spacing (dense labels)
///
/// ## Common Use Cases
///
/// - Button text ("Submit", "Cancel", "Next")
/// - Tab labels ("Home", "Profile", "Settings")
/// - Chip labels
/// - Form field labels ("Email", "Password")
/// - Menu item labels
/// - Filter/tag labels
///
/// ## Example Usage
///
/// ```dart
/// // Default label (medium)
/// AppLabel('Submit')
///
/// // Large label (for buttons)
/// AppLabel.large('Continue')
///
/// // Small label (for chips)
/// AppLabel.small('New')
///
/// // Uppercase label (common for buttons)
/// AppLabel.large(
///   'confirm',
///   uppercase: true,
/// )
///
/// // Label with semantic color
/// AppLabel(
///   'Delete',
///   color: Theme.of(context).colorScheme.error,
/// )
///
/// // Label with custom weight
/// AppLabel(
///   'Important',
///   fontWeight: FontWeight.bold,
/// )
/// ```
///
/// See also:
///
/// - [Text] - The underlying Flutter text widget
/// - [TextTheme] - Material Design 3 text theme
/// - [AppBodyText] - For body text
/// - [AppCaption] - For caption text
class AppLabel extends StatelessWidget {
  /// Creates a label text widget with medium variant (default).
  ///
  /// The [data] parameter must not be null.
  const AppLabel(
    this.data, {
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
    this.uppercase = false,
    super.key,
  }) : _variant = _LabelVariant.medium;

  /// Creates a label text widget with large variant (14sp).
  ///
  /// Use this for button text and other prominent labels that need emphasis.
  const AppLabel.large(
    this.data, {
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
    this.uppercase = false,
    super.key,
  }) : _variant = _LabelVariant.large;

  /// Creates a label text widget with medium variant (12sp).
  const AppLabel.medium(
    this.data, {
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
    this.uppercase = false,
    super.key,
  }) : _variant = _LabelVariant.medium;

  /// Creates a label text widget with small variant (11sp).
  ///
  /// Use this for dense labels such as chips, tags, or small form field labels.
  const AppLabel.small(
    this.data, {
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
    this.uppercase = false,
    super.key,
  }) : _variant = _LabelVariant.small;

  /// The text to display.
  final String data;

  /// The color to use when drawing the text.
  ///
  /// If null, uses the color from the text style in the theme.
  final Color? color;

  /// The font weight to use when drawing the text.
  ///
  /// If null, uses the weight from the text style (typically 500 for labels).
  final FontWeight? fontWeight;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// An optional maximum number of lines for the text to span.
  ///
  /// If the text exceeds the given number of lines, it will be truncated
  /// according to [overflow].
  final int? maxLines;

  /// How visual overflow should be handled.
  ///
  /// If [maxLines] is specified, this determines what happens when the text
  /// would otherwise overflow. Supported values for Material Design 3:
  /// - [TextOverflow.clip] - Clip the overflowing text (default)
  /// - [TextOverflow.ellipsis] - Use an ellipsis (...) to indicate overflow
  final TextOverflow? overflow;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was
  /// unlimited horizontal space.
  final bool? softWrap;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  final TextDirection? textDirection;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This is useful for replacing abbreviations or
  /// shorthands with their expanded forms for screen readers.
  final String? semanticsLabel;

  /// Whether to display the text in uppercase.
  ///
  /// This is a common pattern for button labels and other prominent labels
  /// in Material Design 3. Defaults to false.
  final bool uppercase;

  /// The label variant (large, medium, or small).
  final _LabelVariant _variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // Select the appropriate text style based on variant
    final baseStyle = switch (_variant) {
      _LabelVariant.large => textTheme.labelLarge,
      _LabelVariant.medium => textTheme.labelMedium,
      _LabelVariant.small => textTheme.labelSmall,
    };

    // Apply custom color and font weight if provided
    final style = baseStyle?.copyWith(color: color, fontWeight: fontWeight);

    // Apply uppercase transformation if requested
    final displayText = uppercase ? data.toUpperCase() : data;

    return Text(
      displayText,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textDirection: textDirection,
      semanticsLabel: semanticsLabel,
    );
  }
}

/// Internal enum for label variants.
enum _LabelVariant {
  /// Large label (14sp, 500 weight, 0.1 letter spacing).
  large,

  /// Medium label (12sp, 500 weight, 0.5 letter spacing).
  medium,

  /// Small label (11sp, 500 weight, 0.5 letter spacing).
  small,
}
