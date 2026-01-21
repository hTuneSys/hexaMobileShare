// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 heading widget for displaying smaller subsection titles.
///
/// `AppH3` represents the third level heading (similar to HTML `<h3>` tag)
/// and should be used for subsection headings, tertiary titles, and nested
/// content divisions. It uses Material Design 3's `headlineSmall` text style
/// (24sp, 400 weight by default).
///
/// This widget provides semantic heading structure for accessibility, allowing
/// screen readers to properly announce heading levels to users.
///
/// ## Usage
///
/// **Basic usage:**
/// ```dart
/// AppH3('Personal Details')
/// ```
///
/// **With custom color:**
/// ```dart
/// AppH3(
///   'Privacy Options',
///   color: Colors.purple,
/// )
/// ```
///
/// **Center-aligned with bold weight:**
/// ```dart
/// AppH3(
///   'Summary',
///   textAlign: TextAlign.center,
///   fontWeight: FontWeight.bold,
/// )
/// ```
///
/// **Truncated text:**
/// ```dart
/// AppH3(
///   'Very Long Subsection Title That Should Be Truncated',
///   maxLines: 1,
///   overflow: TextOverflow.ellipsis,
/// )
/// ```
///
/// ## Common Use Cases
///
/// - Subsection headings within sections
/// - List group headers
/// - FAQ question headings
/// - Feature detail titles
/// - Step titles in multi-step forms
/// - Expansion panel headers
///
/// ## Material Design 3 Specifications
///
/// - **Font size**: 24sp
/// - **Font weight**: 400 (regular)
/// - **Line height**: 32sp (1.333 ratio)
/// - **Letter spacing**: 0sp
///
/// ## Accessibility
///
/// This widget automatically wraps the text with a `Semantics` widget,
/// marking it as a heading with level 3. Screen readers will announce
/// this as "Heading Level 3" followed by the text content.
///
/// ## Visual Hierarchy
///
/// Use heading levels to create clear visual hierarchy:
/// - **AppH1**: Largest, most prominent (page titles)
/// - **AppH2**: Secondary headings (section titles)
/// - **AppH3**: Tertiary headings (subsection titles)
///
/// See also:
///
/// - [AppH1] for primary headings
/// - [AppH2] for secondary headings
/// - [Material Design 3 Typography](https://m3.material.io/styles/typography)
class AppH3 extends StatelessWidget {
  /// Creates a Material Design 3 heading widget (level 3).
  ///
  /// The [data] parameter must not be null and specifies the text to display.
  const AppH3(
    this.data, {
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    super.key,
  });

  /// The text to display in the heading.
  final String data;

  /// The color to use for the text.
  ///
  /// If null, defaults to the theme's `onSurface` color.
  final Color? color;

  /// The font weight to use for the text.
  ///
  /// If null, uses the default weight from Material Design 3
  /// `headlineSmall` style (400).
  final FontWeight? fontWeight;

  /// How to align the text horizontally.
  ///
  /// If null, defaults to [TextAlign.start].
  final TextAlign? textAlign;

  /// An optional maximum number of lines for the text to span.
  ///
  /// If the text exceeds the given number of lines, it will be truncated
  /// according to [overflow].
  final int? maxLines;

  /// How visual overflow should be handled.
  ///
  /// Defaults to [TextOverflow.clip] if not specified.
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Semantics(
      header: true,
      child: Text(
        data,
        style: textTheme.headlineSmall?.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
