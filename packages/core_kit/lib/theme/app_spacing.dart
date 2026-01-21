// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Consistent spacing values following Material Design 3 guidelines.
/// Uses a 4dp base unit for consistent spacing throughout the app.
///
/// **Spacing Values:**
/// - Use these constants for padding, margin, and spacing
/// - For spacing widgets, use [Gap], [HGap], or [VGap] from core_kit
///
/// **Example Usage:**
/// ```dart
/// // Padding
/// Padding(padding: AppSpacing.edgeInsetsAllMd)
///
/// // Spacing between widgets
/// Gap.md()  // Use Gap instead of AppSpacing.verticalMd
/// ```
class AppSpacing {
  const AppSpacing._();

  /// Extra small spacing: 4dp
  static const double xs = 4.0;

  /// Small spacing: 8dp
  static const double sm = 8.0;

  /// Medium spacing: 16dp
  static const double md = 16.0;

  /// Large spacing: 24dp
  static const double lg = 24.0;

  /// Extra large spacing: 32dp
  static const double xl = 32.0;

  /// Extra extra large spacing: 48dp
  static const double xxl = 48.0;

  /// Extra extra extra large spacing: 64dp
  static const double xxxl = 64.0;

  // ---------------------------------------------------------------------------
  // EdgeInsets Helpers
  // ---------------------------------------------------------------------------

  /// EdgeInsets.all(4.0)
  static const EdgeInsets edgeInsetsAllXs = EdgeInsets.all(xs);

  /// EdgeInsets.all(8.0)
  static const EdgeInsets edgeInsetsAllSm = EdgeInsets.all(sm);

  /// EdgeInsets.all(16.0)
  static const EdgeInsets edgeInsetsAllMd = EdgeInsets.all(md);

  /// EdgeInsets.all(24.0)
  static const EdgeInsets edgeInsetsAllLg = EdgeInsets.all(lg);

  /// EdgeInsets.all(32.0)
  static const EdgeInsets edgeInsetsAllXl = EdgeInsets.all(xl);

  /// EdgeInsets.symmetric(horizontal: 4.0)
  static const EdgeInsets edgeInsetsHXs = EdgeInsets.symmetric(horizontal: xs);

  /// EdgeInsets.symmetric(horizontal: 8.0)
  static const EdgeInsets edgeInsetsHSm = EdgeInsets.symmetric(horizontal: sm);

  /// EdgeInsets.symmetric(horizontal: 16.0)
  static const EdgeInsets edgeInsetsHMd = EdgeInsets.symmetric(horizontal: md);

  /// EdgeInsets.symmetric(horizontal: 24.0)
  static const EdgeInsets edgeInsetsHLg = EdgeInsets.symmetric(horizontal: lg);

  /// EdgeInsets.symmetric(vertical: 4.0)
  static const EdgeInsets edgeInsetsVXs = EdgeInsets.symmetric(vertical: xs);

  /// EdgeInsets.symmetric(vertical: 8.0)
  static const EdgeInsets edgeInsetsVSm = EdgeInsets.symmetric(vertical: sm);

  /// EdgeInsets.symmetric(vertical: 16.0)
  static const EdgeInsets edgeInsetsVMd = EdgeInsets.symmetric(vertical: md);

  /// EdgeInsets.symmetric(vertical: 24.0)
  static const EdgeInsets edgeInsetsVLg = EdgeInsets.symmetric(vertical: lg);

  // ---------------------------------------------------------------------------
  // Responsive Helpers
  // ---------------------------------------------------------------------------

  /// Returns a responsive spacing value based on the screen size.
  ///
  /// Scales spacing values based on screen width breakpoints:
  /// - Mobile (<600dp): 1.0x (base)
  /// - Tablet (600-840dp): 1.25x
  /// - Desktop (>840dp): 1.5x
  ///
  /// This ensures comfortable spacing on larger screens while maintaining
  /// the 4dp grid system (all scaled values are rounded to nearest 4dp).
  ///
  /// **Example:**
  /// ```dart
  /// // Returns 16.0 on mobile, 20.0 on tablet, 24.0 on desktop
  /// final spacing = AppSpacing.responsive(context, AppSpacing.md);
  /// ```
  static double responsive(BuildContext context, double baseValue) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Material Design 3 breakpoints
    double scaleFactor;
    if (screenWidth < 600) {
      scaleFactor = 1.0; // Mobile
    } else if (screenWidth < 840) {
      scaleFactor = 1.25; // Tablet
    } else {
      scaleFactor = 1.5; // Desktop
    }

    // Scale and round to nearest 4dp to maintain grid
    final scaledValue = baseValue * scaleFactor;
    return (scaledValue / 4).round() * 4.0;
  }
}
