// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Consistent elevation and shadow styles following Material Design 3.
///
/// Material Design 3 uses a combination of shadows and surface tint overlays
/// to create elevation and depth in the UI. The elevation system consists of
/// 6 levels (0-5) that correspond to different component types and states.
///
/// ## Elevation Levels
///
/// - **Level 0** (none): 0dp - No elevation, flat on surface
/// - **Level 1** (sm): 1dp - Cards, filled buttons
/// - **Level 2** (md): 3dp - Elevated cards, hovering FABs
/// - **Level 3** (lg): 6dp - Floating Action Buttons (FAB)
/// - **Level 4** (xl): 8dp - Navigation drawers
/// - **Level 5** (2xl): 12dp - Dialogs, modal bottom sheets
///
/// ## Material Design 3 Elevation System
///
/// M3 elevation combines two visual elements:
///
/// 1. **Shadows**: Traditional drop shadows that create depth perception
/// 2. **Surface Tint**: A subtle color overlay using the primary color
///
/// ### When to Use What
///
/// - **Light Mode**: Both shadows and subtle tint (5-8% opacity)
/// - **Dark Mode**: More reliance on tint (8-14% opacity), subtle shadows
///
/// ### Common Use Cases
///
/// ```dart
/// // Card with Level 1 elevation
/// Container(
///   decoration: AppShadows.decorationWithTint(
///     context: context,
///     level: 1,
///   ),
///   child: CardContent(),
/// )
///
/// // FAB with Level 3 elevation
/// Container(
///   decoration: AppShadows.decorationWithTint(
///     context: context,
///     level: 3,
///     borderRadius: BorderRadius.circular(16),
///   ),
///   child: FABContent(),
/// )
/// ```
///
/// See also:
/// - Material Design 3 Elevation: https://m3.material.io/styles/elevation
class AppShadows {
  const AppShadows._();

  /// Level 0 - No shadow (0dp)
  ///
  /// Used for elements that should appear flat on the surface.
  /// No visual depth or separation from the background.
  static const List<BoxShadow> none = [];

  /// Level 1 - Subtle elevation (1dp)
  ///
  /// Used for cards, filled buttons, and other slightly elevated components.
  /// Provides minimal depth while maintaining a cohesive surface appearance.
  ///
  /// Common components: Cards, Chips, Filled Buttons
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 1,
    ),
  ];

  /// Level 2 - Medium elevation (3dp)
  ///
  /// Used for elevated cards, hover states, and components that need
  /// to appear above the base surface layer.
  ///
  /// Common components: Elevated cards on hover, Search bars
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 2,
    ),
  ];

  /// Level 3 - High elevation (6dp)
  ///
  /// Used for Floating Action Buttons (FABs) and other prominently
  /// floating elements that need significant visual separation.
  ///
  /// Common components: FABs, Menus, Tooltips
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 3,
    ),
  ];

  /// Level 4 - Very high elevation (8dp)
  ///
  /// Used for navigation drawers and other major UI components that
  /// overlay the main content surface.
  ///
  /// Common components: Navigation drawers, App bars (scrolled state)
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 8),
      blurRadius: 12,
      spreadRadius: 6,
    ),
  ];

  /// Level 5 - Maximum elevation (12dp)
  ///
  /// Used for dialogs, modal bottom sheets, and other critical overlays
  /// that need the highest visual prominence and separation from content.
  ///
  /// Common components: Dialogs, Modal bottom sheets, Date/time pickers
  static const List<BoxShadow> xxl = [
    BoxShadow(
      color: Color(0x0D000000),
      offset: Offset(0, 3),
      blurRadius: 6,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 12),
      blurRadius: 16,
      spreadRadius: 8,
    ),
  ];

  // ==================== Elevation Helpers ====================

  /// Returns the shadow list for a given elevation level (0-5).
  ///
  /// This helper allows you to programmatically select elevation levels
  /// instead of using the named constants directly.
  ///
  /// ```dart
  /// // Get shadows for level 3 (FAB elevation)
  /// List<BoxShadow> fabShadows = AppShadows.forLevel(3);
  ///
  /// Container(
  ///   decoration: BoxDecoration(boxShadow: fabShadows),
  ///   child: child,
  /// )
  /// ```
  ///
  /// Returns [none] if level is invalid or out of range.
  static List<BoxShadow> forLevel(int level) {
    switch (level) {
      case 0:
        return none;
      case 1:
        return sm;
      case 2:
        return md;
      case 3:
        return lg;
      case 4:
        return xl;
      case 5:
        return xxl;
      default:
        return none;
    }
  }

  /// Returns the human-readable name for an elevation level.
  ///
  /// Useful for debugging, logging, or UI development tools.
  ///
  /// ```dart
  /// print(AppShadows.levelName(3)); // 'lg'
  /// print(AppShadows.levelName(5)); // 'xxl'
  /// ```
  ///
  /// Returns 'none' for invalid levels.
  static String levelName(int level) {
    switch (level) {
      case 0:
        return 'none';
      case 1:
        return 'sm';
      case 2:
        return 'md';
      case 3:
        return 'lg';
      case 4:
        return 'xl';
      case 5:
        return 'xxl';
      default:
        return 'none';
    }
  }

  // ==================== M3 Surface Tint Helpers ====================

  /// Calculates the Material Design 3 surface tint overlay color.
  ///
  /// M3 uses surface tint (an overlay of the primary color) in addition
  /// to shadows to indicate elevation. The tint opacity increases with
  /// elevation level and is more prominent in dark mode.
  ///
  /// **Opacity by Level:**
  /// - Level 0: 0% (no tint)
  /// - Level 1: 5% (light) / 8% (dark)
  /// - Level 2: 6% (light) / 10% (dark)
  /// - Level 3: 8% (light) / 12% (dark)
  /// - Level 4: 10% (light) / 14% (dark)
  /// - Level 5: 12% (light) / 16% (dark)
  ///
  /// ```dart
  /// Color tint = AppShadows.getSurfaceTint(context, 3);
  ///
  /// Container(
  ///   decoration: BoxDecoration(
  ///     color: tint,
  ///     boxShadow: AppShadows.forLevel(3),
  ///   ),
  ///   child: child,
  /// )
  /// ```
  ///
  /// Returns transparent color for level 0 or invalid levels.
  static Color getSurfaceTint(BuildContext context, int level) {
    if (level < 0 || level > 5) return Colors.transparent;
    if (level == 0) return Colors.transparent;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    // Calculate opacity based on level and theme brightness
    final double opacity;
    if (isDark) {
      // Dark mode: higher opacity for better visibility
      opacity = switch (level) {
        1 => 0.08,
        2 => 0.10,
        3 => 0.12,
        4 => 0.14,
        5 => 0.16,
        _ => 0.0,
      };
    } else {
      // Light mode: subtle tint
      opacity = switch (level) {
        1 => 0.05,
        2 => 0.06,
        3 => 0.08,
        4 => 0.10,
        5 => 0.12,
        _ => 0.0,
      };
    }

    return primaryColor.withValues(alpha: opacity);
  }

  // ==================== BoxDecoration Helpers ====================

  /// Creates a complete BoxDecoration with M3 elevation (shadows + tint).
  ///
  /// This is the recommended way to apply elevation in Material Design 3,
  /// as it combines both shadows and surface tint overlays for proper
  /// depth perception.
  ///
  /// ```dart
  /// // Card with Level 1 elevation
  /// Container(
  ///   decoration: AppShadows.decorationWithTint(
  ///     context: context,
  ///     level: 1,
  ///     backgroundColor: Theme.of(context).colorScheme.surface,
  ///     borderRadius: BorderRadius.circular(12),
  ///   ),
  ///   child: CardContent(),
  /// )
  ///
  /// // FAB with Level 3 elevation
  /// Container(
  ///   decoration: AppShadows.decorationWithTint(
  ///     context: context,
  ///     level: 3,
  ///     backgroundColor: Theme.of(context).colorScheme.primaryContainer,
  ///     borderRadius: BorderRadius.circular(16),
  ///   ),
  ///   child: FABIcon(),
  /// )
  /// ```
  ///
  /// **Parameters:**
  /// - [context]: Build context for theme access
  /// - [level]: Elevation level (0-5)
  /// - [backgroundColor]: Base surface color (defaults to surface color)
  /// - [borderRadius]: Optional border radius
  ///
  /// The resulting decoration will have:
  /// 1. Base background color
  /// 2. M3 surface tint overlay (blended on top)
  /// 3. Elevation shadows
  static BoxDecoration decorationWithTint({
    required BuildContext context,
    required int level,
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    final baseColor = backgroundColor ?? Theme.of(context).colorScheme.surface;
    final tint = getSurfaceTint(context, level);
    final shadows = forLevel(level);

    // Blend base color with surface tint
    final blendedColor = Color.alphaBlend(tint, baseColor);

    return BoxDecoration(
      color: blendedColor,
      borderRadius: borderRadius,
      boxShadow: shadows,
    );
  }

  // ==================== Animation Helpers ====================

  /// Interpolates between two elevation levels for smooth animations.
  ///
  /// Useful for hover effects, press states, or any elevation transitions.
  /// The interpolation parameter [t] should be between 0.0 and 1.0.
  ///
  /// ```dart
  /// // Animate from Level 1 to Level 3 on hover
  /// AnimatedBuilder(
  ///   animation: _hoverAnimation,
  ///   builder: (context, child) {
  ///     return Container(
  ///       decoration: BoxDecoration(
  ///         boxShadow: AppShadows.lerpLevel(1, 3, _hoverAnimation.value),
  ///       ),
  ///       child: child,
  ///     );
  ///   },
  /// )
  /// ```
  ///
  /// **Parameters:**
  /// - [startLevel]: Starting elevation level (0-5)
  /// - [endLevel]: Ending elevation level (0-5)
  /// - [t]: Interpolation factor (0.0 = start, 1.0 = end)
  ///
  /// Returns interpolated shadow list. If levels are invalid or equal,
  /// returns the start level shadows.
  static List<BoxShadow> lerpLevel(int startLevel, int endLevel, double t) {
    // Clamp t to valid range
    final clampedT = t.clamp(0.0, 1.0);

    final startShadows = forLevel(startLevel);
    final endShadows = forLevel(endLevel);

    // If same level or one is empty, no interpolation needed
    if (startLevel == endLevel || clampedT == 0.0) return startShadows;
    if (clampedT == 1.0) return endShadows;

    // Interpolate each shadow property
    final maxLength = startShadows.length > endShadows.length
        ? startShadows.length
        : endShadows.length;

    return List.generate(maxLength, (index) {
      final startShadow = index < startShadows.length
          ? startShadows[index]
          : const BoxShadow(color: Colors.transparent);

      final endShadow = index < endShadows.length
          ? endShadows[index]
          : const BoxShadow(color: Colors.transparent);

      return BoxShadow.lerp(startShadow, endShadow, clampedT)!;
    });
  }
}
