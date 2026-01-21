// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Consistent border radius values following Material Design 3 guidelines.
///
/// This class provides radius values and helper methods for creating consistent
/// rounded corners throughout the app. It follows Material Design 3's shape
/// system with standardized radius values from none (0dp) to full (pill shape).
///
/// ## Material Design 3 Radius Scale
///
/// Material Design 3 defines seven standard radius values:
///
/// | Size   | Value    | Usage                                    |
/// |--------|----------|------------------------------------------|
/// | none   | 0dp      | Sharp corners, no rounding               |
/// | xs     | 4dp      | Subtle rounding for text fields          |
/// | sm     | 8dp      | Light rounding for small buttons         |
/// | md     | 12dp     | Standard rounding for cards (M3 default) |
/// | lg     | 16dp     | Prominent rounding for large surfaces    |
/// | xl     | 28dp     | Extra large for dialogs and sheets       |
/// | full   | 9999dp   | Pill/capsule shape for buttons           |
///
/// ## Common Component Shapes
///
/// ```dart
/// // Cards - Medium radius
/// Container(
///   decoration: BoxDecoration(borderRadius: AppRadius.mdRadius),
/// );
///
/// // Buttons - Full radius (pill shape)
/// ElevatedButton(
///   style: ElevatedButton.styleFrom(
///     shape: AppRadius.fullShape,
///   ),
/// );
///
/// // Bottom sheets - Top corners only
/// Container(
///   decoration: BoxDecoration(borderRadius: AppRadius.topXl),
/// );
///
/// // Side drawer - Right corners only
/// Container(
///   decoration: BoxDecoration(borderRadius: AppRadius.rightMd),
/// );
///
/// // Premium cards - Continuous curves
/// Card(
///   shape: AppRadius.continuousMd,
///   child: child,
/// );
/// ```
///
/// ## Shape Types
///
/// AppRadius provides three types of shape helpers:
///
/// ### 1. RoundedRectangleBorder (Standard)
/// - `AppRadius.mdShape`, `AppRadius.fullShape`, etc.
/// - Standard circular curves
/// - Most common, works everywhere
///
/// ### 2. ContinuousRectangleBorder (Premium)
/// - `AppRadius.continuousMd`, `AppRadius.continuousXl`, etc.
/// - Smoother, more premium curves
/// - Material Design 3 feature
///
/// ### 3. Special Shapes
/// - `AppRadius.circular` - Perfect circle (FABs, avatars)
/// - `AppRadius.stadium` - Pill shape (alternative to fullShape)
///
/// ## Accessibility
///
/// Rounded corners do not affect touch target sizes. Ensure minimum touch
/// target size of 48x48dp regardless of corner radius.
///
/// See Material Design 3 shape system:
/// https://m3.material.io/styles/shape/shape-scale-tokens
class AppRadius {
  const AppRadius._();

  // ========================================================================
  // Radius Values
  // ========================================================================

  /// No radius: 0dp
  ///
  /// Use for sharp corners with no rounding.
  static const double none = 0.0;

  /// Extra small radius: 4dp
  ///
  /// Subtle rounding. Common for text fields and small chips.
  static const double xs = 4.0;

  /// Small radius: 8dp
  ///
  /// Light rounding. Common for small buttons and input fields.
  static const double sm = 8.0;

  /// Medium radius: 12dp
  ///
  /// Standard rounding. **Recommended for cards** following Material Design 3.
  static const double md = 12.0;

  /// Large radius: 16dp
  ///
  /// Prominent rounding. Common for larger containers and surfaces.
  static const double lg = 16.0;

  /// Extra large radius: 28dp
  ///
  /// Extra large rounding. **Recommended for dialogs and bottom sheets**.
  static const double xl = 28.0;

  /// Full/circle radius: 9999dp
  ///
  /// Creates pill/capsule shape. **Recommended for buttons** (M3 standard).
  static const double full = 9999.0;

  // ========================================================================
  // All Corners - Full BorderRadius
  // ========================================================================

  /// No radius on all corners.
  static const BorderRadius noneRadius = BorderRadius.zero;

  /// Extra small radius on all corners (4dp).
  static const BorderRadius xsRadius = BorderRadius.all(Radius.circular(xs));

  /// Small radius on all corners (8dp).
  static const BorderRadius smRadius = BorderRadius.all(Radius.circular(sm));

  /// Medium radius on all corners (12dp).
  ///
  /// **Recommended for cards** per Material Design 3.
  static const BorderRadius mdRadius = BorderRadius.all(Radius.circular(md));

  /// Large radius on all corners (16dp).
  static const BorderRadius lgRadius = BorderRadius.all(Radius.circular(lg));

  /// Extra large radius on all corners (28dp).
  ///
  /// **Recommended for dialogs** per Material Design 3.
  static const BorderRadius xlRadius = BorderRadius.all(Radius.circular(xl));

  /// Full radius on all corners (pill shape).
  ///
  /// **Recommended for buttons** per Material Design 3.
  static const BorderRadius fullRadius = BorderRadius.all(
    Radius.circular(full),
  );

  // ========================================================================
  // Top Only - Partial BorderRadius
  // ========================================================================

  /// Extra small radius on top corners only (4dp).
  static const BorderRadius topXs = BorderRadius.only(
    topLeft: Radius.circular(xs),
    topRight: Radius.circular(xs),
  );

  /// Small radius on top corners only (8dp).
  static const BorderRadius topSm = BorderRadius.only(
    topLeft: Radius.circular(sm),
    topRight: Radius.circular(sm),
  );

  /// Medium radius on top corners only (12dp).
  static const BorderRadius topMd = BorderRadius.only(
    topLeft: Radius.circular(md),
    topRight: Radius.circular(md),
  );

  /// Large radius on top corners only (16dp).
  static const BorderRadius topLg = BorderRadius.only(
    topLeft: Radius.circular(lg),
    topRight: Radius.circular(lg),
  );

  /// Extra large radius on top corners only (28dp).
  ///
  /// **Recommended for bottom sheets** per Material Design 3.
  static const BorderRadius topXl = BorderRadius.only(
    topLeft: Radius.circular(xl),
    topRight: Radius.circular(xl),
  );

  // ========================================================================
  // Bottom Only - Partial BorderRadius
  // ========================================================================

  /// Extra small radius on bottom corners only (4dp).
  static const BorderRadius bottomXs = BorderRadius.only(
    bottomLeft: Radius.circular(xs),
    bottomRight: Radius.circular(xs),
  );

  /// Small radius on bottom corners only (8dp).
  static const BorderRadius bottomSm = BorderRadius.only(
    bottomLeft: Radius.circular(sm),
    bottomRight: Radius.circular(sm),
  );

  /// Medium radius on bottom corners only (12dp).
  static const BorderRadius bottomMd = BorderRadius.only(
    bottomLeft: Radius.circular(md),
    bottomRight: Radius.circular(md),
  );

  /// Large radius on bottom corners only (16dp).
  static const BorderRadius bottomLg = BorderRadius.only(
    bottomLeft: Radius.circular(lg),
    bottomRight: Radius.circular(lg),
  );

  /// Extra large radius on bottom corners only (28dp).
  static const BorderRadius bottomXl = BorderRadius.only(
    bottomLeft: Radius.circular(xl),
    bottomRight: Radius.circular(xl),
  );

  // ========================================================================
  // Left/Right Only - Partial BorderRadius
  // ========================================================================

  /// Extra small radius on left corners only (4dp).
  static const BorderRadius leftXs = BorderRadius.only(
    topLeft: Radius.circular(xs),
    bottomLeft: Radius.circular(xs),
  );

  /// Small radius on left corners only (8dp).
  static const BorderRadius leftSm = BorderRadius.only(
    topLeft: Radius.circular(sm),
    bottomLeft: Radius.circular(sm),
  );

  /// Medium radius on left corners only (12dp).
  static const BorderRadius leftMd = BorderRadius.only(
    topLeft: Radius.circular(md),
    bottomLeft: Radius.circular(md),
  );

  /// Large radius on left corners only (16dp).
  static const BorderRadius leftLg = BorderRadius.only(
    topLeft: Radius.circular(lg),
    bottomLeft: Radius.circular(lg),
  );

  /// Extra large radius on left corners only (28dp).
  static const BorderRadius leftXl = BorderRadius.only(
    topLeft: Radius.circular(xl),
    bottomLeft: Radius.circular(xl),
  );

  /// Extra small radius on right corners only (4dp).
  static const BorderRadius rightXs = BorderRadius.only(
    topRight: Radius.circular(xs),
    bottomRight: Radius.circular(xs),
  );

  /// Small radius on right corners only (8dp).
  static const BorderRadius rightSm = BorderRadius.only(
    topRight: Radius.circular(sm),
    bottomRight: Radius.circular(sm),
  );

  /// Medium radius on right corners only (12dp).
  static const BorderRadius rightMd = BorderRadius.only(
    topRight: Radius.circular(md),
    bottomRight: Radius.circular(md),
  );

  /// Large radius on right corners only (16dp).
  static const BorderRadius rightLg = BorderRadius.only(
    topRight: Radius.circular(lg),
    bottomRight: Radius.circular(lg),
  );

  /// Extra large radius on right corners only (28dp).
  static const BorderRadius rightXl = BorderRadius.only(
    topRight: Radius.circular(xl),
    bottomRight: Radius.circular(xl),
  );

  // ========================================================================
  // Custom Corner Helpers
  // ========================================================================

  /// Creates a [BorderRadius] with top-left corner only.
  ///
  /// Example:
  /// ```dart
  /// Container(
  ///   decoration: BoxDecoration(
  ///     borderRadius: AppRadius.onlyTopLeft(AppRadius.md),
  ///   ),
  /// )
  /// ```
  static BorderRadius onlyTopLeft(double radius) {
    return BorderRadius.only(topLeft: Radius.circular(radius));
  }

  /// Creates a [BorderRadius] with top-right corner only.
  static BorderRadius onlyTopRight(double radius) {
    return BorderRadius.only(topRight: Radius.circular(radius));
  }

  /// Creates a [BorderRadius] with bottom-left corner only.
  static BorderRadius onlyBottomLeft(double radius) {
    return BorderRadius.only(bottomLeft: Radius.circular(radius));
  }

  /// Creates a [BorderRadius] with bottom-right corner only.
  static BorderRadius onlyBottomRight(double radius) {
    return BorderRadius.only(bottomRight: Radius.circular(radius));
  }

  // ========================================================================
  // Shape Helpers - RoundedRectangleBorder for Material Widgets
  // ========================================================================

  /// No radius shape (sharp corners).
  static const RoundedRectangleBorder noneShape = RoundedRectangleBorder(
    borderRadius: noneRadius,
  );

  /// Extra small radius shape (4dp).
  static const RoundedRectangleBorder xsShape = RoundedRectangleBorder(
    borderRadius: xsRadius,
  );

  /// Small radius shape (8dp).
  static const RoundedRectangleBorder smShape = RoundedRectangleBorder(
    borderRadius: smRadius,
  );

  /// Medium radius shape (12dp).
  static const RoundedRectangleBorder mdShape = RoundedRectangleBorder(
    borderRadius: mdRadius,
  );

  /// Large radius shape (16dp).
  static const RoundedRectangleBorder lgShape = RoundedRectangleBorder(
    borderRadius: lgRadius,
  );

  /// Extra large radius shape (28dp).
  static const RoundedRectangleBorder xlShape = RoundedRectangleBorder(
    borderRadius: xlRadius,
  );

  /// Full radius shape (pill/capsule).
  ///
  /// **Recommended for Material 3 buttons**.
  static const RoundedRectangleBorder fullShape = RoundedRectangleBorder(
    borderRadius: fullRadius,
  );

  // ========================================================================
  // Continuous Curve Shapes - Material Design 3
  // ========================================================================

  /// Continuous curve shape with no radius.
  ///
  /// Material Design 3 continuous curves create smoother, more premium
  /// rounded corners compared to standard circular curves.
  ///
  /// Example:
  /// ```dart
  /// Card(
  ///   shape: AppRadius.continuousNone,
  ///   child: child,
  /// )
  /// ```
  static const ContinuousRectangleBorder continuousNone =
      ContinuousRectangleBorder(borderRadius: noneRadius);

  /// Continuous curve shape with extra small radius (4dp).
  static const ContinuousRectangleBorder continuousXs =
      ContinuousRectangleBorder(borderRadius: xsRadius);

  /// Continuous curve shape with small radius (8dp).
  static const ContinuousRectangleBorder continuousSm =
      ContinuousRectangleBorder(borderRadius: smRadius);

  /// Continuous curve shape with medium radius (12dp).
  ///
  /// Recommended for cards with a premium, smooth appearance.
  static const ContinuousRectangleBorder continuousMd =
      ContinuousRectangleBorder(borderRadius: mdRadius);

  /// Continuous curve shape with large radius (16dp).
  static const ContinuousRectangleBorder continuousLg =
      ContinuousRectangleBorder(borderRadius: lgRadius);

  /// Continuous curve shape with extra large radius (28dp).
  ///
  /// Recommended for dialogs and sheets with smooth, premium curves.
  static const ContinuousRectangleBorder continuousXl =
      ContinuousRectangleBorder(borderRadius: xlRadius);

  /// Continuous curve shape with full radius.
  static const ContinuousRectangleBorder continuousFull =
      ContinuousRectangleBorder(borderRadius: fullRadius);

  // ========================================================================
  // Circular Shape Helpers
  // ========================================================================

  /// Creates a circular shape with extra small radius (4dp).
  ///
  /// Example:
  /// ```dart
  /// ElevatedButton(
  ///   style: ElevatedButton.styleFrom(shape: AppRadius.circularXs),
  /// )
  /// ```
  static const CircleBorder circularXs = CircleBorder();

  /// Circular shape. Alias for consistency with other radius sizes.
  static const CircleBorder circular = CircleBorder();

  // ========================================================================
  // Stadium Shape (Pill Shape)
  // ========================================================================

  /// Stadium/capsule shape for pill-style buttons.
  ///
  /// This is semantically equivalent to [fullShape] but uses [StadiumBorder]
  /// which is more explicit about the intent.
  static const StadiumBorder stadium = StadiumBorder();
}
