// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 card widget with consistent styling.
/// Provides elevation, padding, and optional tap handling.
class AppCard extends StatelessWidget {
  /// The widget to display inside the card
  final Widget child;

  /// Optional callback when the card is tapped
  final VoidCallback? onTap;

  /// Card elevation level (0-5)
  final double? elevation;

  /// Internal padding of the card
  final EdgeInsetsGeometry? padding;

  /// Card background color
  final Color? color;

  /// Card border radius
  final BorderRadius? borderRadius;

  /// Creates an AppCard
  const AppCard({
    required this.child,
    this.onTap,
    this.elevation,
    this.padding,
    this.color,
    this.borderRadius,
    super.key,
  });

  /// Creates a flat card with minimal elevation
  const AppCard.flat({
    required this.child,
    this.onTap,
    this.padding,
    this.color,
    this.borderRadius,
    super.key,
  }) : elevation = 0;

  /// Creates an elevated card with higher elevation
  const AppCard.elevated({
    required this.child,
    this.onTap,
    this.padding,
    this.color,
    this.borderRadius,
    super.key,
  }) : elevation = 4;

  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: elevation,
      color: color,
      shape: borderRadius != null
          ? RoundedRectangleBorder(borderRadius: borderRadius!)
          : null,
      child: padding != null ? Padding(padding: padding!, child: child) : child,
    );

    if (onTap != null) {
      return InkWell(onTap: onTap, borderRadius: borderRadius, child: card);
    }

    return card;
  }
}
