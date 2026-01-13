// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/widgets.dart';
import '../theme/app_spacing.dart';

/// A widget that provides spacing between flex items (Row/Column).
///
/// Gap creates consistent spacing using Material Design 3 spacing values
/// from [AppSpacing]. It works seamlessly in both horizontal (Row) and
/// vertical (Column) layouts by setting both width and height.
///
/// For explicit direction control, use [HGap] for horizontal spacing
/// or [VGap] for vertical spacing.
///
/// Example usage in a Column:
/// ```dart
/// Column(
///   children: [
///     Text('First item'),
///     Gap.md(), // 16dp vertical spacing
///     Text('Second item'),
///   ],
/// )
/// ```
///
/// Example usage in a Row:
/// ```dart
/// Row(
///   children: [
///     Icon(Icons.star),
///     Gap.sm(), // 8dp horizontal spacing
///     Text('Favorite'),
///   ],
/// )
/// ```
class Gap extends StatelessWidget {
  /// The size of the gap in logical pixels
  final double size;

  /// Creates a gap with the specified size.
  ///
  /// Consider using named constructors ([Gap.xs], [Gap.sm], etc.)
  /// for consistency with the design system.
  const Gap(this.size, {super.key});

  /// Extra small gap (4dp) - [AppSpacing.xs]
  const Gap.xs({super.key}) : size = AppSpacing.xs;

  /// Small gap (8dp) - [AppSpacing.sm]
  const Gap.sm({super.key}) : size = AppSpacing.sm;

  /// Medium gap (16dp) - [AppSpacing.md]
  const Gap.md({super.key}) : size = AppSpacing.md;

  /// Large gap (24dp) - [AppSpacing.lg]
  const Gap.lg({super.key}) : size = AppSpacing.lg;

  /// Extra large gap (32dp) - [AppSpacing.xl]
  const Gap.xl({super.key}) : size = AppSpacing.xl;

  /// Extra extra large gap (48dp) - [AppSpacing.xxl]
  const Gap.xxl({super.key}) : size = AppSpacing.xxl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size);
  }
}

/// A horizontal gap widget for explicit horizontal spacing in Row widgets.
///
/// HGap provides horizontal-only spacing, making it ideal for Row layouts
/// where you want to be explicit about the direction.
///
/// Example:
/// ```dart
/// Row(
///   children: [
///     IconButton(icon: Icons.home),
///     HGap.md(), // 16dp horizontal spacing
///     IconButton(icon: Icons.settings),
///   ],
/// )
/// ```
class HGap extends StatelessWidget {
  /// The width of the gap in logical pixels
  final double width;

  /// Creates a horizontal gap with the specified width.
  ///
  /// Consider using named constructors for design system consistency.
  const HGap(this.width, {super.key});

  /// Extra small horizontal gap (4dp) - [AppSpacing.xs]
  const HGap.xs({super.key}) : width = AppSpacing.xs;

  /// Small horizontal gap (8dp) - [AppSpacing.sm]
  const HGap.sm({super.key}) : width = AppSpacing.sm;

  /// Medium horizontal gap (16dp) - [AppSpacing.md]
  const HGap.md({super.key}) : width = AppSpacing.md;

  /// Large horizontal gap (24dp) - [AppSpacing.lg]
  const HGap.lg({super.key}) : width = AppSpacing.lg;

  /// Extra large horizontal gap (32dp) - [AppSpacing.xl]
  const HGap.xl({super.key}) : width = AppSpacing.xl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

/// A vertical gap widget for explicit vertical spacing in Column widgets.
///
/// VGap provides vertical-only spacing, making it ideal for Column layouts
/// where you want to be explicit about the direction.
///
/// Example:
/// ```dart
/// Column(
///   children: [
///     Text('Header'),
///     VGap.lg(), // 24dp vertical spacing
///     Text('Content'),
///   ],
/// )
/// ```
class VGap extends StatelessWidget {
  /// The height of the gap in logical pixels
  final double height;

  /// Creates a vertical gap with the specified height.
  ///
  /// Consider using named constructors for design system consistency.
  const VGap(this.height, {super.key});

  /// Extra small vertical gap (4dp) - [AppSpacing.xs]
  const VGap.xs({super.key}) : height = AppSpacing.xs;

  /// Small vertical gap (8dp) - [AppSpacing.sm]
  const VGap.sm({super.key}) : height = AppSpacing.sm;

  /// Medium vertical gap (16dp) - [AppSpacing.md]
  const VGap.md({super.key}) : height = AppSpacing.md;

  /// Large vertical gap (24dp) - [AppSpacing.lg]
  const VGap.lg({super.key}) : height = AppSpacing.lg;

  /// Extra large vertical gap (32dp) - [AppSpacing.xl]
  const VGap.xl({super.key}) : height = AppSpacing.xl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
