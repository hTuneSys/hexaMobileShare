// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/widgets.dart';

/// A widget that provides spacing between flex items (Row/Column).
/// Automatically adapts to horizontal or vertical based on parent.
class Gap extends StatelessWidget {
  /// The size of the gap in logical pixels
  final double size;

  /// Creates a gap with the specified size
  const Gap(this.size, {super.key});

  /// Extra small gap (4dp)
  const Gap.xs({super.key}) : size = 4.0;

  /// Small gap (8dp)
  const Gap.sm({super.key}) : size = 8.0;

  /// Medium gap (16dp)
  const Gap.md({super.key}) : size = 16.0;

  /// Large gap (24dp)
  const Gap.lg({super.key}) : size = 24.0;

  /// Extra large gap (32dp)
  const Gap.xl({super.key}) : size = 32.0;

  /// Extra extra large gap (48dp)
  const Gap.xxl({super.key}) : size = 48.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: size, height: size);
  }
}

/// A horizontal gap widget for use in Row widgets
class HGap extends StatelessWidget {
  /// The width of the gap in logical pixels
  final double width;

  /// Creates a horizontal gap with the specified width
  const HGap(this.width, {super.key});

  /// Extra small horizontal gap (4dp)
  const HGap.xs({super.key}) : width = 4.0;

  /// Small horizontal gap (8dp)
  const HGap.sm({super.key}) : width = 8.0;

  /// Medium horizontal gap (16dp)
  const HGap.md({super.key}) : width = 16.0;

  /// Large horizontal gap (24dp)
  const HGap.lg({super.key}) : width = 24.0;

  /// Extra large horizontal gap (32dp)
  const HGap.xl({super.key}) : width = 32.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}

/// A vertical gap widget for use in Column widgets
class VGap extends StatelessWidget {
  /// The height of the gap in logical pixels
  final double height;

  /// Creates a vertical gap with the specified height
  const VGap(this.height, {super.key});

  /// Extra small vertical gap (4dp)
  const VGap.xs({super.key}) : height = 4.0;

  /// Small vertical gap (8dp)
  const VGap.sm({super.key}) : height = 8.0;

  /// Medium vertical gap (16dp)
  const VGap.md({super.key}) : height = 16.0;

  /// Large vertical gap (24dp)
  const VGap.lg({super.key}) : height = 24.0;

  /// Extra large vertical gap (32dp)
  const VGap.xl({super.key}) : height = 32.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
