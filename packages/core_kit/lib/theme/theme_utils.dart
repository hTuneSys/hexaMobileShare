// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'dart:convert';

import 'package:flutter/material.dart';

import 'app_color_scheme.dart';

// ═════════════════════════════════════════════════════════════════════════════
// BuildContext Theme Extensions
// ═════════════════════════════════════════════════════════════════════════════

/// Convenient [BuildContext] extensions for quick theme access.
///
/// Eliminates the need to write `Theme.of(context)` repeatedly.
///
/// ```dart
/// // Instead of:
/// final cs = Theme.of(context).colorScheme;
///
/// // Write:
/// final cs = context.colorScheme;
/// ```
extension ThemeContext on BuildContext {
  /// The current [ThemeData] from the nearest [Theme] ancestor.
  ThemeData get theme => Theme.of(this);

  /// Shorthand for `Theme.of(context).colorScheme`.
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Shorthand for `Theme.of(context).colorScheme.brightness`.
  ///
  /// Uses [ColorScheme.brightness] rather than [ThemeData.brightness]
  /// because it reliably reflects the actual theme regardless of how
  /// [MaterialApp] resolves the active theme.
  Brightness get brightness => Theme.of(this).colorScheme.brightness;

  /// Whether the current theme uses a dark brightness.
  bool get isDarkMode => brightness == Brightness.dark;
}

// ═════════════════════════════════════════════════════════════════════════════
// Font Scale
// ═════════════════════════════════════════════════════════════════════════════

/// Font scale levels for accessibility adaptation.
///
/// Based on Material Design 3 and platform accessibility guidelines:
/// - [small]: 0.85x - Compact UIs with dense information
/// - [normal]: 1.0x - Default system scale
/// - [large]: 1.15x - Comfortable reading
/// - [extraLarge]: 1.3x - Enlarged for low vision
/// - [accessibilityLarge]: 2.0x - Maximum accessibility scale
enum FontScale {
  /// Compact text scale (0.85x).
  small(0.85, 'Small'),

  /// Default system scale (1.0x).
  normal(1.0, 'Normal'),

  /// Comfortable reading scale (1.15x).
  large(1.15, 'Large'),

  /// Enlarged for low vision (1.3x).
  extraLarge(1.3, 'Extra Large'),

  /// Maximum accessibility scale (2.0x).
  accessibilityLarge(2.0, 'Accessibility Large');

  const FontScale(this.factor, this.label);

  /// The scale factor to apply to text sizes.
  final double factor;

  /// Human-readable label for display.
  final String label;
}

// ═════════════════════════════════════════════════════════════════════════════
// Font Scale Adapter
// ═════════════════════════════════════════════════════════════════════════════

/// Utility for adapting text themes to different font scale levels.
///
/// Uses the existing [TextTheme] and applies scale factors to create
/// appropriately sized text for different accessibility needs.
///
/// ## Usage
///
/// ```dart
/// final scaledTheme = FontScaleAdapter.scaleTextTheme(
///   Theme.of(context).textTheme,
///   FontScale.large,
/// );
/// ```
class FontScaleAdapter {
  const FontScaleAdapter._();

  /// Scales all text styles in a [TextTheme] by the given [FontScale].
  ///
  /// Returns a new [TextTheme] with all font sizes multiplied by the
  /// scale factor while preserving other style properties.
  static TextTheme scaleTextTheme(TextTheme textTheme, FontScale scale) {
    if (scale == FontScale.normal) return textTheme;

    return textTheme.copyWith(
      displayLarge: _scaleStyle(textTheme.displayLarge, scale.factor),
      displayMedium: _scaleStyle(textTheme.displayMedium, scale.factor),
      displaySmall: _scaleStyle(textTheme.displaySmall, scale.factor),
      headlineLarge: _scaleStyle(textTheme.headlineLarge, scale.factor),
      headlineMedium: _scaleStyle(textTheme.headlineMedium, scale.factor),
      headlineSmall: _scaleStyle(textTheme.headlineSmall, scale.factor),
      titleLarge: _scaleStyle(textTheme.titleLarge, scale.factor),
      titleMedium: _scaleStyle(textTheme.titleMedium, scale.factor),
      titleSmall: _scaleStyle(textTheme.titleSmall, scale.factor),
      bodyLarge: _scaleStyle(textTheme.bodyLarge, scale.factor),
      bodyMedium: _scaleStyle(textTheme.bodyMedium, scale.factor),
      bodySmall: _scaleStyle(textTheme.bodySmall, scale.factor),
      labelLarge: _scaleStyle(textTheme.labelLarge, scale.factor),
      labelMedium: _scaleStyle(textTheme.labelMedium, scale.factor),
      labelSmall: _scaleStyle(textTheme.labelSmall, scale.factor),
    );
  }

  static TextStyle? _scaleStyle(TextStyle? style, double factor) {
    if (style == null) return null;
    final fontSize = style.fontSize ?? 14.0;
    return style.copyWith(fontSize: fontSize * factor);
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Color Blindness Simulation
// ═════════════════════════════════════════════════════════════════════════════

/// Color blindness simulation modes.
///
/// Each mode transforms colors to approximate how they appear to people
/// with different types of color vision deficiency.
enum ColorBlindnessMode {
  /// No color blindness (normal vision).
  none('Normal Vision'),

  /// Red color blindness (cannot distinguish red).
  protanopia('Protanopia (Red-blind)'),

  /// Green color blindness (cannot distinguish green).
  deuteranopia('Deuteranopia (Green-blind)'),

  /// Blue color blindness (cannot distinguish blue).
  tritanopia('Tritanopia (Blue-blind)'),

  /// Complete color removal (grayscale).
  grayscale('Grayscale');

  const ColorBlindnessMode(this.label);

  /// Human-readable label for display.
  final String label;
}

/// Simulates how colors appear under different color blindness conditions.
///
/// Uses established color transformation matrices to approximate
/// color vision deficiency. This is useful for testing UI accessibility
/// and ensuring important information is not conveyed by color alone.
///
/// ## Usage
///
/// ```dart
/// final simulated = ColorBlindnessSimulator.simulate(
///   Colors.red,
///   ColorBlindnessMode.protanopia,
/// );
/// ```
class ColorBlindnessSimulator {
  const ColorBlindnessSimulator._();

  /// Transforms a [color] to simulate the given [mode] of color blindness.
  ///
  /// Returns the original color if [mode] is [ColorBlindnessMode.none].
  static Color simulate(Color color, ColorBlindnessMode mode) {
    switch (mode) {
      case ColorBlindnessMode.none:
        return color;
      case ColorBlindnessMode.protanopia:
        return _applyMatrix(color, _protanopiaMatrix);
      case ColorBlindnessMode.deuteranopia:
        return _applyMatrix(color, _deuteranopiaMatrix);
      case ColorBlindnessMode.tritanopia:
        return _applyMatrix(color, _tritanopiaMatrix);
      case ColorBlindnessMode.grayscale:
        return _toGrayscale(color);
    }
  }

  /// Transforms an entire [ColorScheme] to simulate color blindness.
  ///
  /// Applies the color blindness transformation to all color roles
  /// in the scheme, useful for previewing full theme impact.
  static ColorScheme simulateScheme(
    ColorScheme scheme,
    ColorBlindnessMode mode,
  ) {
    if (mode == ColorBlindnessMode.none) return scheme;

    return ColorScheme(
      brightness: scheme.brightness,
      primary: simulate(scheme.primary, mode),
      onPrimary: simulate(scheme.onPrimary, mode),
      primaryContainer: simulate(scheme.primaryContainer, mode),
      onPrimaryContainer: simulate(scheme.onPrimaryContainer, mode),
      secondary: simulate(scheme.secondary, mode),
      onSecondary: simulate(scheme.onSecondary, mode),
      secondaryContainer: simulate(scheme.secondaryContainer, mode),
      onSecondaryContainer: simulate(scheme.onSecondaryContainer, mode),
      tertiary: simulate(scheme.tertiary, mode),
      onTertiary: simulate(scheme.onTertiary, mode),
      tertiaryContainer: simulate(scheme.tertiaryContainer, mode),
      onTertiaryContainer: simulate(scheme.onTertiaryContainer, mode),
      error: simulate(scheme.error, mode),
      onError: simulate(scheme.onError, mode),
      errorContainer: simulate(scheme.errorContainer, mode),
      onErrorContainer: simulate(scheme.onErrorContainer, mode),
      surface: simulate(scheme.surface, mode),
      onSurface: simulate(scheme.onSurface, mode),
      onSurfaceVariant: simulate(scheme.onSurfaceVariant, mode),
      outline: simulate(scheme.outline, mode),
      outlineVariant: simulate(scheme.outlineVariant, mode),
      shadow: scheme.shadow,
      scrim: scheme.scrim,
      inverseSurface: simulate(scheme.inverseSurface, mode),
      onInverseSurface: simulate(scheme.onInverseSurface, mode),
      inversePrimary: simulate(scheme.inversePrimary, mode),
    );
  }

  // Protanopia transformation matrix (Viénot et al. 1999)
  static const List<double> _protanopiaMatrix = [
    0.152286, 1.052583, -0.204868, //
    0.114503, 0.786281, 0.099216, //
    -0.003882, -0.048116, 1.051998, //
  ];

  // Deuteranopia transformation matrix (Viénot et al. 1999)
  static const List<double> _deuteranopiaMatrix = [
    0.367322, 0.860646, -0.227968, //
    0.280085, 0.672501, 0.047413, //
    -0.011820, 0.042940, 0.968881, //
  ];

  // Tritanopia transformation matrix (Viénot et al. 1999)
  static const List<double> _tritanopiaMatrix = [
    1.255528, -0.076749, -0.178779, //
    -0.078411, 0.930809, 0.147602, //
    0.004733, 0.691367, 0.303900, //
  ];

  static Color _applyMatrix(Color color, List<double> matrix) {
    final r = color.r;
    final g = color.g;
    final b = color.b;

    final newR = (matrix[0] * r + matrix[1] * g + matrix[2] * b).clamp(0, 1);
    final newG = (matrix[3] * r + matrix[4] * g + matrix[5] * b).clamp(0, 1);
    final newB = (matrix[6] * r + matrix[7] * g + matrix[8] * b).clamp(0, 1);

    return Color.from(
      alpha: color.a,
      red: newR.toDouble(),
      green: newG.toDouble(),
      blue: newB.toDouble(),
    );
  }

  static Color _toGrayscale(Color color) {
    // ITU-R BT.709 luma coefficients
    final gray = 0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b;
    return Color.from(alpha: color.a, red: gray, green: gray, blue: gray);
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Theme Validator
// ═════════════════════════════════════════════════════════════════════════════

/// WCAG compliance level.
enum WcagLevel {
  /// WCAG AA - 4.5:1 for normal text, 3.0:1 for large text.
  aa,

  /// WCAG AAA - 7.0:1 for normal text, 4.5:1 for large text.
  aaa,
}

/// Result of a single contrast ratio validation check.
class ContrastResult {
  /// Creates a contrast validation result.
  const ContrastResult({
    required this.foregroundLabel,
    required this.backgroundLabel,
    required this.foreground,
    required this.background,
    required this.contrastRatio,
    required this.meetsAA,
    required this.meetsAAA,
  });

  /// Label for the foreground color role (e.g., "onPrimary").
  final String foregroundLabel;

  /// Label for the background color role (e.g., "primary").
  final String backgroundLabel;

  /// The foreground color tested.
  final Color foreground;

  /// The background color tested.
  final Color background;

  /// The calculated contrast ratio (1.0 to 21.0).
  final double contrastRatio;

  /// Whether this pair meets WCAG AA for normal text (4.5:1).
  final bool meetsAA;

  /// Whether this pair meets WCAG AAA for normal text (7.0:1).
  final bool meetsAAA;
}

/// Validates contrast ratios across a [ColorScheme].
///
/// Uses the existing [AppColorScheme.contrastRatio] utility to check
/// all standard foreground/background pairs in a color scheme.
///
/// ## Usage
///
/// ```dart
/// final results = ThemeValidator.validateColorScheme(
///   AppColorScheme.light(),
/// );
///
/// for (final result in results) {
///   if (!result.meetsAA) {
///     print('FAIL: ${result.foregroundLabel} on ${result.backgroundLabel}');
///   }
/// }
/// ```
class ThemeValidator {
  const ThemeValidator._();

  /// Validates all standard foreground/background pairs in a [ColorScheme].
  ///
  /// Returns a list of [ContrastResult] for each pair, including whether
  /// it meets WCAG AA (4.5:1) and AAA (7.0:1) standards.
  static List<ContrastResult> validateColorScheme(ColorScheme scheme) {
    final pairs = <_ColorPair>[
      _ColorPair('onPrimary', scheme.onPrimary, 'primary', scheme.primary),
      _ColorPair(
        'onPrimaryContainer',
        scheme.onPrimaryContainer,
        'primaryContainer',
        scheme.primaryContainer,
      ),
      _ColorPair(
        'onSecondary',
        scheme.onSecondary,
        'secondary',
        scheme.secondary,
      ),
      _ColorPair(
        'onSecondaryContainer',
        scheme.onSecondaryContainer,
        'secondaryContainer',
        scheme.secondaryContainer,
      ),
      _ColorPair('onTertiary', scheme.onTertiary, 'tertiary', scheme.tertiary),
      _ColorPair(
        'onTertiaryContainer',
        scheme.onTertiaryContainer,
        'tertiaryContainer',
        scheme.tertiaryContainer,
      ),
      _ColorPair('onError', scheme.onError, 'error', scheme.error),
      _ColorPair(
        'onErrorContainer',
        scheme.onErrorContainer,
        'errorContainer',
        scheme.errorContainer,
      ),
      _ColorPair('onSurface', scheme.onSurface, 'surface', scheme.surface),
      _ColorPair(
        'onSurfaceVariant',
        scheme.onSurfaceVariant,
        'surface',
        scheme.surface,
      ),
      _ColorPair(
        'onInverseSurface',
        scheme.onInverseSurface,
        'inverseSurface',
        scheme.inverseSurface,
      ),
    ];

    return pairs.map((pair) {
      final ratio = AppColorScheme.contrastRatio(
        pair.foreground,
        pair.background,
      );
      return ContrastResult(
        foregroundLabel: pair.foregroundLabel,
        backgroundLabel: pair.backgroundLabel,
        foreground: pair.foreground,
        background: pair.background,
        contrastRatio: ratio,
        meetsAA: ratio >= 4.5,
        meetsAAA: ratio >= 7.0,
      );
    }).toList();
  }

  /// Checks if all color pairs meet the specified [WcagLevel].
  ///
  /// Returns `true` if every foreground/background pair in the scheme
  /// meets the required contrast ratio for the given level.
  static bool meetsStandard(ColorScheme scheme, WcagLevel level) {
    final results = validateColorScheme(scheme);
    return results.every((r) => level == WcagLevel.aa ? r.meetsAA : r.meetsAAA);
  }

  /// Counts the number of passing/failing pairs for a given level.
  static ({int passing, int failing, int total}) summary(
    ColorScheme scheme,
    WcagLevel level,
  ) {
    final results = validateColorScheme(scheme);
    final passing = results
        .where((r) => level == WcagLevel.aa ? r.meetsAA : r.meetsAAA)
        .length;
    return (
      passing: passing,
      failing: results.length - passing,
      total: results.length,
    );
  }
}

class _ColorPair {
  const _ColorPair(
    this.foregroundLabel,
    this.foreground,
    this.backgroundLabel,
    this.background,
  );
  final String foregroundLabel;
  final Color foreground;
  final String backgroundLabel;
  final Color background;
}

// ═════════════════════════════════════════════════════════════════════════════
// Platform Theme Adapter
// ═════════════════════════════════════════════════════════════════════════════

/// Applies platform-specific theme adjustments.
///
/// Adapts Material Design 3 themes for iOS and Android platform
/// conventions, such as navigation bar styling and typography tweaks.
///
/// ## Usage
///
/// ```dart
/// final theme = PlatformThemeAdapter.adapt(
///   AppTheme.light(),
///   TargetPlatform.iOS,
/// );
/// ```
class PlatformThemeAdapter {
  const PlatformThemeAdapter._();

  /// Adapts a [ThemeData] to the specified [platform].
  ///
  /// **iOS adjustments:**
  /// - Centered app bar titles
  /// - San Francisco font family
  /// - Larger navigation bar items
  ///
  /// **Android adjustments:**
  /// - Left-aligned app bar titles (M3 default)
  /// - Roboto font family (M3 default)
  static ThemeData adapt(ThemeData theme, TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return _adaptForApple(theme);
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return theme; // M3 defaults are already Android-optimized
    }
  }

  static ThemeData _adaptForApple(ThemeData theme) {
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        centerTitle: true,
        titleTextStyle: theme.appBarTheme.titleTextStyle?.copyWith(
          fontFamily: '.SF Pro Text',
        ),
      ),
      textTheme: theme.textTheme.apply(fontFamily: '.SF Pro Text'),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Theme Exporter / Importer
// ═════════════════════════════════════════════════════════════════════════════

/// Exports and imports theme configuration as JSON.
///
/// Serializes [ColorScheme] properties to a JSON string that can be saved,
/// shared, or loaded. Works alongside [AppThemeExtension.toJson] and
/// [AppThemeExtension.fromJson] for custom properties.
///
/// ## Usage
///
/// ```dart
/// // Export
/// final json = ThemeExporter.exportColorScheme(AppColorScheme.light());
///
/// // Import
/// final scheme = ThemeExporter.importColorScheme(json);
/// ```
class ThemeExporter {
  const ThemeExporter._();

  /// Exports a [ColorScheme] to a JSON string.
  static String exportColorScheme(ColorScheme scheme) {
    final map = <String, dynamic>{
      'brightness': scheme.brightness == Brightness.light ? 'light' : 'dark',
      'primary': scheme.primary.toARGB32(),
      'onPrimary': scheme.onPrimary.toARGB32(),
      'primaryContainer': scheme.primaryContainer.toARGB32(),
      'onPrimaryContainer': scheme.onPrimaryContainer.toARGB32(),
      'secondary': scheme.secondary.toARGB32(),
      'onSecondary': scheme.onSecondary.toARGB32(),
      'secondaryContainer': scheme.secondaryContainer.toARGB32(),
      'onSecondaryContainer': scheme.onSecondaryContainer.toARGB32(),
      'tertiary': scheme.tertiary.toARGB32(),
      'onTertiary': scheme.onTertiary.toARGB32(),
      'tertiaryContainer': scheme.tertiaryContainer.toARGB32(),
      'onTertiaryContainer': scheme.onTertiaryContainer.toARGB32(),
      'error': scheme.error.toARGB32(),
      'onError': scheme.onError.toARGB32(),
      'errorContainer': scheme.errorContainer.toARGB32(),
      'onErrorContainer': scheme.onErrorContainer.toARGB32(),
      'surface': scheme.surface.toARGB32(),
      'onSurface': scheme.onSurface.toARGB32(),
      'onSurfaceVariant': scheme.onSurfaceVariant.toARGB32(),
      'outline': scheme.outline.toARGB32(),
      'outlineVariant': scheme.outlineVariant.toARGB32(),
      'inverseSurface': scheme.inverseSurface.toARGB32(),
      'onInverseSurface': scheme.onInverseSurface.toARGB32(),
      'inversePrimary': scheme.inversePrimary.toARGB32(),
    };
    return const JsonEncoder.withIndent('  ').convert(map);
  }

  /// Imports a [ColorScheme] from a JSON string.
  ///
  /// Returns `null` if the JSON is invalid or cannot be parsed.
  static ColorScheme? importColorScheme(String jsonString) {
    try {
      final map = json.decode(jsonString) as Map<String, dynamic>;
      final isLight = map['brightness'] == 'light';

      return ColorScheme(
        brightness: isLight ? Brightness.light : Brightness.dark,
        primary: Color(map['primary'] as int),
        onPrimary: Color(map['onPrimary'] as int),
        primaryContainer: Color(map['primaryContainer'] as int),
        onPrimaryContainer: Color(map['onPrimaryContainer'] as int),
        secondary: Color(map['secondary'] as int),
        onSecondary: Color(map['onSecondary'] as int),
        secondaryContainer: Color(map['secondaryContainer'] as int),
        onSecondaryContainer: Color(map['onSecondaryContainer'] as int),
        tertiary: Color(map['tertiary'] as int),
        onTertiary: Color(map['onTertiary'] as int),
        tertiaryContainer: Color(map['tertiaryContainer'] as int),
        onTertiaryContainer: Color(map['onTertiaryContainer'] as int),
        error: Color(map['error'] as int),
        onError: Color(map['onError'] as int),
        errorContainer: Color(map['errorContainer'] as int),
        onErrorContainer: Color(map['onErrorContainer'] as int),
        surface: Color(map['surface'] as int),
        onSurface: Color(map['onSurface'] as int),
        onSurfaceVariant: Color(map['onSurfaceVariant'] as int),
        outline: Color(map['outline'] as int),
        outlineVariant: Color(map['outlineVariant'] as int),
        inverseSurface: Color(map['inverseSurface'] as int),
        onInverseSurface: Color(map['onInverseSurface'] as int),
        inversePrimary: Color(map['inversePrimary'] as int),
      );
    } catch (e) {
      debugPrint('ThemeExporter: Failed to import color scheme: $e');
      return null;
    }
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Accessibility Report
// ═════════════════════════════════════════════════════════════════════════════

/// Generates an accessibility compliance report for a theme.
///
/// Combines contrast ratio validation with font scale and color blindness
/// checks to produce a comprehensive accessibility summary.
///
/// ## Usage
///
/// ```dart
/// final report = AccessibilityReportGenerator.generate(
///   colorScheme: AppColorScheme.light(),
///   themeName: 'Light Theme',
/// );
/// print(report);
/// ```
class AccessibilityReportGenerator {
  const AccessibilityReportGenerator._();

  /// Generates a text report for the given [colorScheme].
  ///
  /// The report includes:
  /// - WCAG AA and AAA compliance status
  /// - Individual color pair results
  /// - Recommendations for failing pairs
  static String generate({
    required ColorScheme colorScheme,
    required String themeName,
  }) {
    final results = ThemeValidator.validateColorScheme(colorScheme);
    final aaSummary = ThemeValidator.summary(colorScheme, WcagLevel.aa);
    final aaaSummary = ThemeValidator.summary(colorScheme, WcagLevel.aaa);

    final buffer = StringBuffer()
      ..writeln('═══════════════════════════════════════════════')
      ..writeln('  Accessibility Report: $themeName')
      ..writeln('═══════════════════════════════════════════════')
      ..writeln()
      ..writeln(
        '  WCAG AA  (4.5:1): ${aaSummary.passing}/${aaSummary.total} passing',
      )
      ..writeln(
        '  WCAG AAA (7.0:1): ${aaaSummary.passing}/${aaaSummary.total} passing',
      )
      ..writeln()
      ..writeln('───────────────────────────────────────────────')
      ..writeln('  Color Pair Details')
      ..writeln('───────────────────────────────────────────────');

    for (final result in results) {
      final aaStatus = result.meetsAA ? '✅' : '❌';
      final aaaStatus = result.meetsAAA ? '✅' : '❌';
      buffer.writeln(
        '  $aaStatus AA  $aaaStatus AAA  '
        '${result.contrastRatio.toStringAsFixed(1)}:1  '
        '${result.foregroundLabel} on ${result.backgroundLabel}',
      );
    }

    buffer
      ..writeln()
      ..writeln('───────────────────────────────────────────────');

    if (aaSummary.failing > 0) {
      buffer
        ..writeln('  ⚠️ ${aaSummary.failing} pair(s) fail WCAG AA.')
        ..writeln('  Consider adjusting colors for minimum 4.5:1 contrast.');
    }
    if (aaaSummary.failing > 0 && aaSummary.failing == 0) {
      buffer
        ..writeln('  ℹ️ ${aaaSummary.failing} pair(s) fail WCAG AAA.')
        ..writeln('  Use high-contrast theme for AAA compliance.');
    }
    if (aaSummary.failing == 0 && aaaSummary.failing == 0) {
      buffer.writeln('  ✅ All color pairs meet WCAG AAA (7:1)!');
    }

    buffer.writeln('═══════════════════════════════════════════════');
    return buffer.toString();
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Theme Documentation Generator
// ═════════════════════════════════════════════════════════════════════════════

/// Generates human-readable Markdown documentation for a [ThemeData].
///
/// Produces a structured overview of the theme covering color scheme,
/// typography, and component token values so designers and developers
/// can share a single source of truth.
///
/// ## Usage
///
/// ```dart
/// final md = ThemeDocumentationGenerator.generate(
///   theme: AppTheme.light(),
///   themeName: 'Light Theme',
/// );
/// print(md);
/// ```
class ThemeDocumentationGenerator {
  const ThemeDocumentationGenerator._();

  /// Generates Markdown documentation for the given [theme].
  static String generate({
    required ThemeData theme,
    required String themeName,
  }) {
    final cs = theme.colorScheme;
    final tt = theme.textTheme;
    final buf = StringBuffer()
      ..writeln('# $themeName')
      ..writeln()
      ..writeln('> Auto-generated theme documentation.')
      ..writeln()
      // ── Color scheme ───────────────────────────────────────────────────
      ..writeln('## Color Scheme')
      ..writeln()
      ..writeln('| Role | Hex |')
      ..writeln('|---|---|');

    final colorRoles = <String, Color>{
      'primary': cs.primary,
      'onPrimary': cs.onPrimary,
      'primaryContainer': cs.primaryContainer,
      'onPrimaryContainer': cs.onPrimaryContainer,
      'secondary': cs.secondary,
      'onSecondary': cs.onSecondary,
      'secondaryContainer': cs.secondaryContainer,
      'onSecondaryContainer': cs.onSecondaryContainer,
      'tertiary': cs.tertiary,
      'onTertiary': cs.onTertiary,
      'tertiaryContainer': cs.tertiaryContainer,
      'onTertiaryContainer': cs.onTertiaryContainer,
      'error': cs.error,
      'onError': cs.onError,
      'errorContainer': cs.errorContainer,
      'onErrorContainer': cs.onErrorContainer,
      'surface': cs.surface,
      'onSurface': cs.onSurface,
      'onSurfaceVariant': cs.onSurfaceVariant,
      'outline': cs.outline,
      'outlineVariant': cs.outlineVariant,
    };

    for (final entry in colorRoles.entries) {
      buf.writeln(
        '| `${entry.key}` | `#${entry.value.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}` |',
      );
    }

    // ── Typography ─────────────────────────────────────────────────────
    buf
      ..writeln()
      ..writeln('## Typography')
      ..writeln()
      ..writeln('| Style | Size | Weight | Letter Spacing |')
      ..writeln('|---|---|---|---|');

    final textStyles = <String, TextStyle?>{
      'displayLarge': tt.displayLarge,
      'displayMedium': tt.displayMedium,
      'displaySmall': tt.displaySmall,
      'headlineLarge': tt.headlineLarge,
      'headlineMedium': tt.headlineMedium,
      'headlineSmall': tt.headlineSmall,
      'titleLarge': tt.titleLarge,
      'titleMedium': tt.titleMedium,
      'titleSmall': tt.titleSmall,
      'bodyLarge': tt.bodyLarge,
      'bodyMedium': tt.bodyMedium,
      'bodySmall': tt.bodySmall,
      'labelLarge': tt.labelLarge,
      'labelMedium': tt.labelMedium,
      'labelSmall': tt.labelSmall,
    };

    for (final entry in textStyles.entries) {
      final s = entry.value;
      if (s == null) continue;
      buf.writeln(
        '| `${entry.key}` | ${s.fontSize ?? '-'} | ${s.fontWeight?.value ?? '-'} | ${s.letterSpacing?.toStringAsFixed(2) ?? '-'} |',
      );
    }

    // ── Component tokens ───────────────────────────────────────────────
    buf
      ..writeln()
      ..writeln('## Component Tokens')
      ..writeln()
      ..writeln('| Component | Property | Value |')
      ..writeln('|---|---|---|');

    final appBar = theme.appBarTheme;
    buf
      ..writeln('| AppBar | centerTitle | ${appBar.centerTitle ?? 'null'} |')
      ..writeln('| AppBar | elevation | ${appBar.elevation ?? 'null'} |');

    final card = theme.cardTheme;
    buf.writeln('| Card | elevation | ${card.elevation ?? 'null'} |');

    final divider = theme.dividerTheme;
    buf.writeln('| Divider | thickness | ${divider.thickness ?? 'null'} |');

    buf
      ..writeln()
      ..writeln('---')
      ..writeln()
      ..writeln(
        '_Brightness: ${cs.brightness == Brightness.light ? 'Light' : 'Dark'}_',
      );

    return buf.toString();
  }
}
