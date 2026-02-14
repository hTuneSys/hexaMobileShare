// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'app_color_scheme.dart';
import 'app_typography.dart';
import 'app_radius.dart';

/// Main application theme based on Material Design 3.
///
/// Provides consistent theming for light, dark, and high-contrast modes.
/// High-contrast themes meet WCAG AAA standards (7:1 minimum contrast ratio)
/// for improved accessibility.
///
/// ## Available Themes
///
/// | Variant | Constructor | WCAG Level |
/// |---------|-------------|------------|
/// | Light | [light] | AA (4.5:1) |
/// | Dark | [dark] | AA (4.5:1) |
/// | High Contrast Light | [highContrastLight] | AAA (7:1) |
/// | High Contrast Dark | [highContrastDark] | AAA (7:1) |
///
/// ## Usage
///
/// ```dart
/// MaterialApp(
///   theme: AppTheme.light(),
///   darkTheme: AppTheme.dark(),
///   highContrastTheme: AppTheme.highContrastLight(),
///   highContrastDarkTheme: AppTheme.highContrastDark(),
/// )
/// ```
///
/// Flutter automatically selects the high-contrast variant when the user
/// enables **High Contrast** in system accessibility settings.
///
/// ## Accessibility Guide
///
/// ### High Contrast Specifications (M3)
///
/// - **Contrast ratio:** 7:1 minimum on all foreground/background pairs
/// - **Border emphasis:** 2dp borders on interactive elements (cards, buttons)
/// - **Focus indicators:** 4dp focus rings on input fields
/// - **Text weight:** `FontWeight.w500` body, `FontWeight.w600` titles/labels
///
/// ### Font Scale Adaptation
///
/// Use [FontScaleAdapter.scaleTextTheme] to adapt all 15 M3 text styles:
///
/// | Level | Factor | Use case |
/// |-------|--------|----------|
/// | `FontScale.small` | 0.85× | Compact / data-dense UI |
/// | `FontScale.normal` | 1.0× | Default |
/// | `FontScale.large` | 1.15× | Mild visual impairment |
/// | `FontScale.extraLarge` | 1.3× | Moderate visual impairment |
/// | `FontScale.accessibilityLarge` | 2.0× | Severe visual impairment |
///
/// ### Color Blindness Simulation
///
/// [ColorBlindnessSimulator] supports protanopia, deuteranopia, tritanopia,
/// and grayscale using Viénot transformation matrices.
///
/// ### Theme Validation
///
/// [ThemeValidator.meetsStandard] checks all foreground/background pairs
/// against [WcagLevel.aa] or [WcagLevel.aaa]. Run in tests to catch
/// contrast regressions early.
///
/// ### Quick Context Access
///
/// The [ThemeContext] extension on [BuildContext] provides shortcuts:
///
/// ```dart
/// context.theme        // Theme.of(context)
/// context.colorScheme  // Theme.of(context).colorScheme
/// context.isDarkMode   // colorScheme.brightness == Brightness.dark
/// ```
///
/// ### Additional Utilities
///
/// - [PlatformThemeAdapter] — iOS / Android platform adjustments
/// - [ThemeExporter] — export/import [ColorScheme] as JSON
/// - [ThemePreview] — preview a theme without applying it
/// - [ThemeComparison] — side-by-side theme comparison
/// - [ThemeDebugOverlay] — live theme token inspector (debug builds)
/// - [AccessibilityReportGenerator] — human-readable WCAG compliance report
/// - [ThemeDocumentationGenerator] — Markdown specs for design teams
///
/// ### Best Practices
///
/// 1. Always provide **all four variants** so Flutter can auto-switch.
/// 2. Validate themes with [ThemeValidator.meetsStandard] in tests.
/// 3. Test layouts at `FontScale.accessibilityLarge` (2×) for overflow.
/// 4. Use [ColorBlindnessSimulator] to confirm color distinguishability.
/// 5. Prefer `colorScheme.primary` over hardcoded hex values.
/// 6. Use `context.colorScheme` / `context.isDarkMode` for clean code.
class AppTheme {
  const AppTheme._();

  /// Light theme configuration
  static ThemeData light() {
    final colorScheme = AppColorScheme.light();
    final textTheme = AppTypography.textTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,

      // AppBar theme
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 3,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdRadius),
        clipBehavior: Clip.antiAlias,
      ),

      // Button themes — M3 shape: corner.full (Stadium)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // Input decoration theme — M3 shape: corner.extraSmall (top)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Chip theme — M3 shape: corner.small (8dp)
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.secondaryContainer,
        deleteIconColor: colorScheme.onSurfaceVariant,
        labelStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.smRadius),
      ),

      // Dialog theme — M3 shape: corner.extraLarge (28dp)
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xlRadius),
        elevation: 3,
      ),

      // Bottom sheet theme — M3 shape: corner.extraLarge (top)
      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
        elevation: 2,
        backgroundColor: colorScheme.surface,
      ),

      // Snackbar theme — M3 shape: corner.extraSmall (4dp)
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xsRadius),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Dark theme configuration
  static ThemeData dark() {
    final colorScheme = AppColorScheme.dark();
    final textTheme = AppTypography.textTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,

      // AppBar theme
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 3,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdRadius),
        clipBehavior: Clip.antiAlias,
      ),

      // Button themes — M3 shape: corner.full (Stadium)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge,
        ),
      ),

      // Input decoration theme — M3 shape: corner.extraSmall (top)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.secondaryContainer,
        deleteIconColor: colorScheme.onSurfaceVariant,
        labelStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.smRadius),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xlRadius),
        elevation: 3,
      ),

      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
        elevation: 2,
        backgroundColor: colorScheme.surface,
      ),

      // Snackbar theme — M3 shape: corner.extraSmall (4dp)
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.xsRadius),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// High-contrast light theme for WCAG AAA accessibility.
  ///
  /// Provides a minimum 7:1 contrast ratio for all text/background pairs.
  /// Features:
  /// - Higher contrast color values
  /// - 2dp borders on interactive elements
  /// - Font weight 500+ for body text
  /// - 4dp focus indicators
  ///
  /// Use via `MaterialApp.highContrastTheme` to automatically apply when
  /// the user enables high-contrast mode in system settings.
  static ThemeData highContrastLight() {
    final colorScheme = AppColorScheme.highContrastLight();
    final textTheme = _highContrastTextTheme(AppTypography.textTheme());

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,

      // AppBar theme - stronger contrast
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 3,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),

      // Card theme - visible borders
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdRadius,
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // Button themes — M3 shape: corner.full (Stadium) + 2dp HC borders
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: StadiumBorder(
            side: BorderSide(color: colorScheme.outline, width: 2),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: StadiumBorder(
            side: BorderSide(color: colorScheme.outline, width: 2),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: const StadiumBorder(),
          side: BorderSide(color: colorScheme.outline, width: 2),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Input decoration theme — M3 shape: corner.extraSmall + HC borders
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.outline, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.outline, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Chip theme - visible borders
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.secondaryContainer,
        deleteIconColor: colorScheme.onSurfaceVariant,
        labelStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.smRadius,
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.xlRadius,
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
        elevation: 3,
      ),

      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
        elevation: 2,
        backgroundColor: colorScheme.surface,
      ),

      // Snackbar theme — M3 shape: corner.extraSmall + HC borders
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.xsRadius,
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
      ),

      // Divider theme - thicker for visibility
      dividerTheme: DividerThemeData(
        color: colorScheme.outline,
        thickness: 2,
        space: 2,
      ),

      // Focus theme - 4dp focus indicators
      focusColor: colorScheme.primary.withValues(alpha: 0.3),
    );
  }

  /// High-contrast dark theme for WCAG AAA accessibility.
  ///
  /// Provides a minimum 7:1 contrast ratio for all text/background pairs.
  /// Features:
  /// - Higher contrast color values on dark backgrounds
  /// - 2dp borders on interactive elements
  /// - Font weight 500+ for body text
  /// - 4dp focus indicators
  ///
  /// Use via `MaterialApp.highContrastDarkTheme` to automatically apply when
  /// the user enables high-contrast mode and dark theme in system settings.
  static ThemeData highContrastDark() {
    final colorScheme = AppColorScheme.highContrastDark();
    final textTheme = _highContrastTextTheme(AppTypography.textTheme());

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,

      // AppBar theme - stronger contrast
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 3,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),

      // Card theme - visible borders
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mdRadius,
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // Button themes — M3 shape: corner.full (Stadium) + 2dp HC borders
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: StadiumBorder(
            side: BorderSide(color: colorScheme.outline, width: 2),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: StadiumBorder(
            side: BorderSide(color: colorScheme.outline, width: 2),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: const StadiumBorder(),
          side: BorderSide(color: colorScheme.outline, width: 2),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: const StadiumBorder(),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // Input decoration theme — M3 shape: corner.extraSmall (4dp) + 2dp HC borders
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.outline, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.outline, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.xsRadius,
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),

      // Chip theme — M3 shape: corner.small (8dp) + visible borders
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.secondaryContainer,
        deleteIconColor: colorScheme.onSurfaceVariant,
        labelStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.smRadius,
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
      ),

      // Dialog theme — M3 shape: corner.extraLarge (28dp)
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.xlRadius,
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
        elevation: 3,
      ),

      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
        elevation: 2,
        backgroundColor: colorScheme.surface,
      ),

      // Snackbar theme — M3 shape: corner.extraSmall (4dp) + 2dp HC borders
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.xsRadius,
          side: BorderSide(color: colorScheme.outline, width: 2),
        ),
      ),

      // Divider theme - thicker for visibility
      dividerTheme: DividerThemeData(
        color: colorScheme.outline,
        thickness: 2,
        space: 2,
      ),

      // Focus theme - 4dp focus indicators
      focusColor: colorScheme.primary.withValues(alpha: 0.3),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // Private Helpers
  // ═══════════════════════════════════════════════════════════════════════════

  /// Applies higher font weights for high-contrast themes.
  ///
  /// Bumps font weights to 500+ for improved readability per WCAG AAA:
  /// - body/label styles: 400 → 500
  /// - title styles: 500 → 600
  /// - headline/display styles: 400 → 500
  static TextTheme _highContrastTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontWeight: FontWeight.w500),
      displayMedium: base.displayMedium?.copyWith(fontWeight: FontWeight.w500),
      displaySmall: base.displaySmall?.copyWith(fontWeight: FontWeight.w500),
      headlineLarge: base.headlineLarge?.copyWith(fontWeight: FontWeight.w500),
      headlineMedium: base.headlineMedium?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: base.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
      titleLarge: base.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: base.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      titleSmall: base.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      bodyLarge: base.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      bodyMedium: base.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
      bodySmall: base.bodySmall?.copyWith(fontWeight: FontWeight.w500),
      labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      labelMedium: base.labelMedium?.copyWith(fontWeight: FontWeight.w600),
      labelSmall: base.labelSmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
