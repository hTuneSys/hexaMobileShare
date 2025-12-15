// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

import '../../theme/app_radius.dart';

/// A Material Design 3 card widget with consistent styling.
///
/// [AppCard] is a versatile surface container that groups related content and actions.
/// It supports various styles including flat, elevated, and outlined variants.
///
/// Example:
/// ```dart
/// AppCard(
///   onTap: () {},
///   child: Text('Card Content'),
/// )
/// ```
class AppCard extends StatelessWidget {
  /// The widget to display inside the card.
  final Widget child;

  /// Optional callback when the card is tapped.
  /// If provided, the card becomes interactive with a ripple effect.
  final VoidCallback? onTap;

  /// Card elevation level.
  /// - 0: Flat
  /// - 1: Default
  /// - 3: Elevated
  final double? elevation;

  /// Internal padding of the card.
  final EdgeInsetsGeometry? padding;

  /// Card background color.
  final Color? color;

  /// Card border radius. Defaults to [AppRadius.md] (12dp).
  final BorderRadiusGeometry? borderRadius;

  /// External margin of the card.
  final EdgeInsetsGeometry? margin;

  /// Content clipping behavior.
  final Clip? clipBehavior;

  /// Color of the shadow when elevation is > 0.
  final Color? shadowColor;

  /// Overlay color for M3 elevation tint.
  final Color? surfaceTintColor;

  /// Whether to paint the border in front of the child.
  final bool borderOnForeground;

  /// Custom shape border.
  final ShapeBorder? shape;

  /// Creates a default [AppCard] with standard styling (1dp elevation).
  const AppCard({
    required this.child,
    this.onTap,
    this.elevation = 1.0,
    this.padding,
    this.color,
    this.borderRadius,
    this.margin,
    this.clipBehavior,
    this.shadowColor,
    this.surfaceTintColor,
    this.borderOnForeground = true,
    this.shape,
    super.key,
  });

  /// Creates a flat [AppCard] with no elevation (0dp).
  /// Useful for grouping content on a surface without adding depth.
  const AppCard.flat({
    required this.child,
    this.onTap,
    this.padding,
    this.color,
    this.borderRadius,
    this.margin,
    this.clipBehavior,
    this.shadowColor,
    this.surfaceTintColor,
    this.borderOnForeground = true,
    this.shape,
    super.key,
  }) : elevation = 0;

  /// Creates an elevated [AppCard] with higher elevation (3dp).
  /// Used for items that need more emphasis or separation.
  const AppCard.elevated({
    required this.child,
    this.onTap,
    this.padding,
    this.color,
    this.borderRadius,
    this.margin,
    this.clipBehavior,
    this.shadowColor,
    this.surfaceTintColor,
    this.borderOnForeground = true,
    this.shape,
    super.key,
  }) : elevation = 3;

  /// Creates an outlined [AppCard] with a border and no elevation.
  /// Useful for situations where elevation is not appropriate but separation is needed.
  const AppCard.outlined({
    required this.child,
    this.onTap,
    this.padding,
    this.color,
    this.borderRadius,
    this.margin,
    this.clipBehavior,
    this.shadowColor,
    this.surfaceTintColor,
    this.borderOnForeground = true,
    this.shape,
    super.key,
  }) : elevation = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOutlined = elevation == 0 && color == null && shape == null;

    // Determine the shape with border radius
    final effectiveShape =
        shape ??
        (isOutlined
            ? RoundedRectangleBorder(
                side: BorderSide(color: theme.colorScheme.outline),
                borderRadius: borderRadius ?? AppRadius.mdRadius,
              )
            : RoundedRectangleBorder(
                borderRadius: borderRadius ?? AppRadius.mdRadius,
              ));

    return Card(
      elevation: elevation,
      color: color,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      margin: margin,
      shape: effectiveShape,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      borderOnForeground: borderOnForeground,
      child: onTap != null
          ? InkWell(
              onTap: onTap,
              // Match the card's shape for the ripple
              customBorder: effectiveShape,
              child: padding != null
                  ? Padding(padding: padding!, child: child)
                  : child,
            )
          : (padding != null
                ? Padding(padding: padding!, child: child)
                : child),
    );
  }
}
