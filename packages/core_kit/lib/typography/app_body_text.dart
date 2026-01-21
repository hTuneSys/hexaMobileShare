// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A convenience widget for displaying body text with Material Design 3 styling.
///
/// [AppBodyText] provides a simple API for rendering body text (main content text)
/// with consistent typography from the app's theme. It automatically applies the
/// appropriate text style from [TextTheme] based on the variant.
///
/// ## Variants
///
/// - [AppBodyText.large] - 16sp, 400 weight, 0.5 letter spacing
/// - [AppBodyText.medium] - 14sp, 400 weight, 0.25 letter spacing (default)
/// - [AppBodyText.small] - 12sp, 400 weight, 0.4 letter spacing
///
/// ## Common Use Cases
///
/// - Paragraph text in articles or descriptions
/// - Main content text in cards
/// - Form helper text
/// - List item descriptions
/// - Dialog body text
///
/// ## Example Usage
///
/// ```dart
/// // Default body text (medium)
/// AppBodyText('This is body text')
///
/// // Large body text
/// AppBodyText.large('This is large body text')
///
/// // Small body text with semantic color
/// AppBodyText.small(
///   'This is small body text',
///   color: Theme.of(context).colorScheme.onSurfaceVariant,
/// )
///
/// // Bold body text
/// AppBodyText(
///   'This is bold text',
///   fontWeight: FontWeight.bold,
/// )
///
/// // Body text with overflow handling
/// AppBodyText(
///   'This is a very long text that might overflow',
///   maxLines: 2,
///   overflow: TextOverflow.ellipsis,
/// )
/// ```
///
/// See also:
///
/// - [Text] - The underlying Flutter text widget
/// - [TextTheme] - Material Design 3 text theme
/// - [AppCaption] - For caption text
/// - [AppLabel] - For label text
class AppBodyText extends StatelessWidget {
  /// Creates a body text widget with medium variant (default).
  ///
  /// The [data] parameter must not be null.
  const AppBodyText(
    this.data, {
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
    super.key,
  }) : _variant = _BodyTextVariant.medium;

  /// Creates a body text widget with large variant (16sp).
  ///
  /// Use this for emphasized or primary content that needs more prominence.
  const AppBodyText.large(
    this.data, {
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
    super.key,
  }) : _variant = _BodyTextVariant.large;

  /// Creates a body text widget with medium variant (14sp).
  const AppBodyText.medium(
    this.data, {
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
    super.key,
  }) : _variant = _BodyTextVariant.medium;

  /// Creates a body text widget with small variant (12sp).
  const AppBodyText.small(
    this.data, {
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.semanticsLabel,
    super.key,
  }) : _variant = _BodyTextVariant.small;

  /// The text to display.
  final String data;

  /// The color to use when drawing the text.
  ///
  /// If null, uses the color from the text style in the theme.
  final Color? color;

  /// The font weight to use when drawing the text.
  ///
  /// If null, uses the weight from the text style (typically 400).
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

  /// The text variant (large, medium, or small).
  final _BodyTextVariant _variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    // Select the appropriate text style based on variant
    final baseStyle = switch (_variant) {
      _BodyTextVariant.large => textTheme.bodyLarge,
      _BodyTextVariant.medium => textTheme.bodyMedium,
      _BodyTextVariant.small => textTheme.bodySmall,
    };

    // Apply custom color and font weight if provided
    final style = baseStyle?.copyWith(color: color, fontWeight: fontWeight);

    return Text(
      data,
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

/// Internal enum for body text variants.
enum _BodyTextVariant {
  /// Large body text (16sp, 400 weight, 0.5 letter spacing).
  large,

  /// Medium body text (14sp, 400 weight, 0.25 letter spacing).
  medium,

  /// Small body text (12sp, 400 weight, 0.4 letter spacing).
  small,
}
