// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 heading widget for displaying medium-sized section titles.
///
/// `AppH2` represents the second level heading (similar to HTML `<h2>` tag)
/// and should be used for section headings, secondary titles, and content
/// subdivisions. It uses Material Design 3's `headlineMedium` text style
/// (28sp, 400 weight by default).
///
/// This widget provides semantic heading structure for accessibility, allowing
/// screen readers to properly announce heading levels to users.
///
/// ## Usage
///
/// **Basic usage:**
/// ```dart
/// AppH2('Account Information')
/// ```
///
/// **With custom color:**
/// ```dart
/// AppH2(
///   'Security Settings',
///   color: Colors.green,
/// )
/// ```
///
/// **Center-aligned with bold weight:**
/// ```dart
/// AppH2(
///   'Overview',
///   textAlign: TextAlign.center,
///   fontWeight: FontWeight.bold,
/// )
/// ```
///
/// **Truncated text:**
/// ```dart
/// AppH2(
///   'Very Long Section Title That Should Be Truncated',
///   maxLines: 1,
///   overflow: TextOverflow.ellipsis,
/// )
/// ```
///
/// ## Common Use Cases
///
/// - Section headings within a page
/// - Category titles in lists
/// - Tab headers
/// - Card titles
/// - Feature group headings
/// - Settings section titles
///
/// ## Material Design 3 Specifications
///
/// - **Font size**: 28sp
/// - **Font weight**: 400 (regular)
/// - **Line height**: 36sp (1.286 ratio)
/// - **Letter spacing**: 0sp
///
/// ## Accessibility
///
/// This widget automatically wraps the text with a `Semantics` widget,
/// marking it as a heading with level 2. Screen readers will announce
/// this as "Heading Level 2" followed by the text content.
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
/// - [AppH3] for tertiary headings
/// - [Material Design 3 Typography](https://m3.material.io/styles/typography)
class AppH2 extends StatelessWidget {
  /// Creates a Material Design 3 heading widget (level 2).
  ///
  /// The [data] parameter must not be null and specifies the text to display.
  const AppH2(
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
  /// `headlineMedium` style (400).
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
        style: textTheme.headlineMedium?.copyWith(
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
