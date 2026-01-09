// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Consistent spacing values following Material Design 3 guidelines.
/// Uses a 4dp base unit for consistent spacing throughout the app.
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
  // SizedBox Helpers (Spacers)
  // ---------------------------------------------------------------------------

  /// SizedBox(width: 4.0)
  static const SizedBox horizontalXs = SizedBox(width: xs);

  /// SizedBox(width: 8.0)
  static const SizedBox horizontalSm = SizedBox(width: sm);

  /// SizedBox(width: 16.0)
  static const SizedBox horizontalMd = SizedBox(width: md);

  /// SizedBox(width: 24.0)
  static const SizedBox horizontalLg = SizedBox(width: lg);

  /// SizedBox(width: 32.0)
  static const SizedBox horizontalXl = SizedBox(width: xl);

  /// SizedBox(height: 4.0)
  static const SizedBox verticalXs = SizedBox(height: xs);

  /// SizedBox(height: 8.0)
  static const SizedBox verticalSm = SizedBox(height: sm);

  /// SizedBox(height: 16.0)
  static const SizedBox verticalMd = SizedBox(height: md);

  /// SizedBox(height: 24.0)
  static const SizedBox verticalLg = SizedBox(height: lg);

  /// SizedBox(height: 32.0)
  static const SizedBox verticalXl = SizedBox(height: xl);

  /// SizedBox(height: 48.0)
  static const SizedBox verticalXxl = SizedBox(height: xxl);

  // ---------------------------------------------------------------------------
  // Responsive Helpers
  // ---------------------------------------------------------------------------

  /// Returns a responsive spacing value based on the screen size.
  ///
  /// This method can be customized to scale spacing on larger screens.
  /// Currently returns the [baseValue] as is, but serves as a uniform access point
  /// for future responsive scaling logic.
  static double responsive(BuildContext context, double baseValue) {
    // Determine screen size and scale potentially
    // For now, adhering to strict 4dp grid without implicit scaling
    return baseValue;
  }
}
