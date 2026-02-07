// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'dart:ui';

import 'package:flutter/material.dart';

/// A Material Design 3 theme extension that provides custom app-specific
/// properties beyond the standard Material theme.
///
/// [AppThemeExtension] extends Flutter's [ThemeExtension] to add custom design
/// tokens that aren't covered by Material Design 3's default theme. This allows
/// maintaining additional brand-specific colors, spacing values, shadows, and
/// typography styles while ensuring proper theme consistency and smooth transitions.
///
/// ## Features
///
/// - **Custom Semantic Colors**: Success, warning, info beyond MD3's error color
/// - **Additional Brand Colors**: accent2, accent3 for extended color palettes
/// - **Custom Spacing**: Micro, xxs, xs for finer spacing control
/// - **Custom Shadows**: Soft, hard, colored shadows for specialized effects
/// - **Typography Extensions**: Mono, display styles beyond MD3 text theme
/// - **Theme Transitions**: Smooth lerp animations when switching themes
/// - **JSON Serialization**: Persist custom theme settings
/// - **Type-Safe Access**: Extension methods for easy property access
///
/// ## Usage
///
/// ### Adding to MaterialApp Theme
///
/// ```dart
/// MaterialApp(
///   theme: ThemeData(
///     extensions: [
///       AppThemeExtension.light(),
///     ],
///   ),
///   darkTheme: ThemeData(
///     extensions: [
///       AppThemeExtension.dark(),
///     ],
///   ),
/// )
/// ```
///
/// ### Accessing Custom Properties
///
/// ```dart
/// // Via BuildContext extension
/// final customTheme = context.appThemeExtension;
/// final successColor = customTheme.successColor;
///
/// // Direct theme access
/// final customTheme = Theme.of(context).extension<AppThemeExtension>();
/// ```
///
/// ### Using Custom Colors
///
/// ```dart
/// Container(
///   color: context.appThemeExtension.successColor,
///   child: Text('Success!'),
/// )
/// ```
///
/// ### Custom Spacing
///
/// ```dart
/// Padding(
///   padding: EdgeInsets.all(context.appThemeExtension.spacingMicro),
///   child: widget,
/// )
/// ```
///
/// ### Custom Shadows
///
/// ```dart
/// Container(
///   decoration: BoxDecoration(
///     boxShadow: [context.appThemeExtension.shadowSoft],
///   ),
/// )
/// ```
///
/// ## Material Design 3 Compliance
///
/// While this extension adds custom properties, it follows MD3 principles:
/// - Semantic color naming (success, warning, info)
/// - Consistent spacing increments
/// - Elevation-based shadow system
/// - Typography scale extensions
///
/// ## Theme Transitions
///
/// The [lerp] method ensures smooth animations when switching between themes:
///
/// ```dart
/// // Theme changes animate smoothly
/// ThemeMode.light → ThemeMode.dark
/// ```
///
/// See also:
/// - [ThemeExtension] - Flutter's base theme extension class
/// - [AppTheme] - Main app theme configuration
/// - [Material Design 3](https://m3.material.io)
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  /// Creates a custom theme extension with the specified properties.
  ///
  /// All parameters are optional and default to null, allowing partial
  /// customization of theme properties.
  const AppThemeExtension({
    // Custom semantic colors
    this.successColor,
    this.warningColor,
    this.infoColor,
    this.accent2Color,
    this.accent3Color,
    // Custom spacing
    this.spacingMicro,
    this.spacingXxs,
    this.spacingXs,
    // Custom border radius
    this.radiusXxs,
    this.radiusXxl,
    // Custom shadows
    this.shadowSoft,
    this.shadowHard,
    this.shadowColored,
    // Typography extensions
    this.monoTextStyle,
    this.displayTextStyle,
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // Custom Semantic Colors
  // ═══════════════════════════════════════════════════════════════════════════

  /// Success color for positive actions and states.
  ///
  /// Typically green palette. Use for:
  /// - Success messages and confirmations
  /// - Positive status indicators
  /// - Completion states
  ///
  /// Example: Green 600 in light theme, Green 400 in dark theme
  final Color? successColor;

  /// Warning color for caution states.
  ///
  /// Typically amber/orange palette. Use for:
  /// - Warning messages
  /// - Caution indicators
  /// - Pending states requiring attention
  ///
  /// Example: Amber 700 in light theme, Amber 500 in dark theme
  final Color? warningColor;

  /// Info color for informational states.
  ///
  /// Typically blue palette. Use for:
  /// - Informational messages
  /// - Help text and hints
  /// - Neutral notifications
  ///
  /// Example: Blue 600 in light theme, Blue 400 in dark theme
  final Color? infoColor;

  /// Secondary brand color (accent 2).
  ///
  /// Additional brand color for extended color schemes.
  final Color? accent2Color;

  /// Tertiary brand color (accent 3).
  ///
  /// Additional brand color for extended color schemes.
  final Color? accent3Color;

  // ═══════════════════════════════════════════════════════════════════════════
  // Custom Spacing
  // ═══════════════════════════════════════════════════════════════════════════

  /// Micro spacing value (2dp).
  ///
  /// Use for hairline spacing between tightly coupled elements.
  final double? spacingMicro;

  /// Extra extra small spacing (4dp).
  ///
  /// Use for very tight spacing within components.
  final double? spacingXxs;

  /// Extra small spacing (8dp).
  ///
  /// Use for tight spacing between related elements.
  final double? spacingXs;

  // ═══════════════════════════════════════════════════════════════════════════
  // Custom Border Radius
  // ═══════════════════════════════════════════════════════════════════════════

  /// Extra extra small border radius (2dp).
  ///
  /// Use for very subtle rounded corners.
  final double? radiusXxs;

  /// Extra extra large border radius (32dp).
  ///
  /// Use for highly rounded corners and pill shapes.
  final double? radiusXxl;

  // ═══════════════════════════════════════════════════════════════════════════
  // Custom Shadows
  // ═══════════════════════════════════════════════════════════════════════════

  /// Soft shadow with lower opacity for subtle depth.
  ///
  /// Use for surfaces that need gentle elevation without strong contrast.
  final BoxShadow? shadowSoft;

  /// Hard shadow with higher opacity for strong depth.
  ///
  /// Use for surfaces that need pronounced elevation and separation.
  final BoxShadow? shadowHard;

  /// Colored shadow with custom tint.
  ///
  /// Use for branded shadows or special visual effects.
  final BoxShadow? shadowColored;

  // ═══════════════════════════════════════════════════════════════════════════
  // Typography Extensions
  // ═══════════════════════════════════════════════════════════════════════════

  /// Monospace text style for code and technical content.
  ///
  /// Use for:
  /// - Code snippets
  /// - Technical identifiers
  /// - Tabular numeric data
  final TextStyle? monoTextStyle;

  /// Display text style for extra-large headings.
  ///
  /// Use for:
  /// - Hero headings
  /// - Landing page titles
  /// - Marketing content
  final TextStyle? displayTextStyle;

  // ═══════════════════════════════════════════════════════════════════════════
  // Factory Constructors
  // ═══════════════════════════════════════════════════════════════════════════

  /// Creates a light theme extension with default values.
  ///
  /// Provides sensible defaults for light mode with proper contrast ratios.
  factory AppThemeExtension.light() {
    return AppThemeExtension(
      // Semantic colors - light theme
      successColor: const Color(0xFF2E7D32), // Green 800
      warningColor: const Color(0xFFF57C00), // Orange 800
      infoColor: const Color(0xFF1976D2), // Blue 700
      accent2Color: const Color(0xFF6A1B9A), // Purple 800
      accent3Color: const Color(0xFF00838F), // Cyan 800
      // Custom spacing
      spacingMicro: 2.0,
      spacingXxs: 4.0,
      spacingXs: 8.0,
      // Custom border radius
      radiusXxs: 2.0,
      radiusXxl: 32.0,
      // Custom shadows
      shadowSoft: BoxShadow(
        color: Colors.black.withValues(alpha: 0.08),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
      shadowHard: BoxShadow(
        color: Colors.black.withValues(alpha: 0.16),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
      shadowColored: BoxShadow(
        color: const Color(0xFF1976D2).withValues(alpha: 0.2),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
      // Typography
      monoTextStyle: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      displayTextStyle: const TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
      ),
    );
  }

  /// Creates a dark theme extension with default values.
  ///
  /// Provides sensible defaults for dark mode with proper contrast ratios.
  factory AppThemeExtension.dark() {
    return AppThemeExtension(
      // Semantic colors - dark theme
      successColor: const Color(0xFF66BB6A), // Green 400
      warningColor: const Color(0xFFFFB74D), // Orange 300
      infoColor: const Color(0xFF42A5F5), // Blue 400
      accent2Color: const Color(0xFFAB47BC), // Purple 400
      accent3Color: const Color(0xFF26C6DA), // Cyan 400
      // Custom spacing (same as light)
      spacingMicro: 2.0,
      spacingXxs: 4.0,
      spacingXs: 8.0,
      // Custom border radius (same as light)
      radiusXxs: 2.0,
      radiusXxl: 32.0,
      // Custom shadows (adjusted for dark theme)
      shadowSoft: BoxShadow(
        color: Colors.black.withValues(alpha: 0.24),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
      shadowHard: BoxShadow(
        color: Colors.black.withValues(alpha: 0.32),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
      shadowColored: BoxShadow(
        color: const Color(0xFF42A5F5).withValues(alpha: 0.3),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
      // Typography (same as light)
      monoTextStyle: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      ),
      displayTextStyle: const TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ThemeExtension Methods
  // ═══════════════════════════════════════════════════════════════════════════

  @override
  AppThemeExtension copyWith({
    Color? successColor,
    Color? warningColor,
    Color? infoColor,
    Color? accent2Color,
    Color? accent3Color,
    double? spacingMicro,
    double? spacingXxs,
    double? spacingXs,
    double? radiusXxs,
    double? radiusXxl,
    BoxShadow? shadowSoft,
    BoxShadow? shadowHard,
    BoxShadow? shadowColored,
    TextStyle? monoTextStyle,
    TextStyle? displayTextStyle,
  }) {
    return AppThemeExtension(
      successColor: successColor ?? this.successColor,
      warningColor: warningColor ?? this.warningColor,
      infoColor: infoColor ?? this.infoColor,
      accent2Color: accent2Color ?? this.accent2Color,
      accent3Color: accent3Color ?? this.accent3Color,
      spacingMicro: spacingMicro ?? this.spacingMicro,
      spacingXxs: spacingXxs ?? this.spacingXxs,
      spacingXs: spacingXs ?? this.spacingXs,
      radiusXxs: radiusXxs ?? this.radiusXxs,
      radiusXxl: radiusXxl ?? this.radiusXxl,
      shadowSoft: shadowSoft ?? this.shadowSoft,
      shadowHard: shadowHard ?? this.shadowHard,
      shadowColored: shadowColored ?? this.shadowColored,
      monoTextStyle: monoTextStyle ?? this.monoTextStyle,
      displayTextStyle: displayTextStyle ?? this.displayTextStyle,
    );
  }

  @override
  AppThemeExtension lerp(
    covariant ThemeExtension<AppThemeExtension>? other,
    double t,
  ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      // Lerp colors
      successColor: Color.lerp(successColor, other.successColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
      infoColor: Color.lerp(infoColor, other.infoColor, t),
      accent2Color: Color.lerp(accent2Color, other.accent2Color, t),
      accent3Color: Color.lerp(accent3Color, other.accent3Color, t),
      // Lerp spacing
      spacingMicro: lerpDouble(spacingMicro, other.spacingMicro, t),
      spacingXxs: lerpDouble(spacingXxs, other.spacingXxs, t),
      spacingXs: lerpDouble(spacingXs, other.spacingXs, t),
      // Lerp border radius
      radiusXxs: lerpDouble(radiusXxs, other.radiusXxs, t),
      radiusXxl: lerpDouble(radiusXxl, other.radiusXxl, t),
      // Lerp shadows
      shadowSoft: BoxShadow.lerp(shadowSoft, other.shadowSoft, t),
      shadowHard: BoxShadow.lerp(shadowHard, other.shadowHard, t),
      shadowColored: BoxShadow.lerp(shadowColored, other.shadowColored, t),
      // Lerp text styles
      monoTextStyle: TextStyle.lerp(monoTextStyle, other.monoTextStyle, t),
      displayTextStyle: TextStyle.lerp(
        displayTextStyle,
        other.displayTextStyle,
        t,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // JSON Serialization
  // ═══════════════════════════════════════════════════════════════════════════

  /// Converts this theme extension to a JSON map.
  ///
  /// Returns a Map representation that can be serialized to JSON for
  /// persistence or configuration.
  Map<String, dynamic> toJson() {
    return {
      'successColor': successColor?.toARGB32(),
      'warningColor': warningColor?.toARGB32(),
      'infoColor': infoColor?.toARGB32(),
      'accent2Color': accent2Color?.toARGB32(),
      'accent3Color': accent3Color?.toARGB32(),
      'spacingMicro': spacingMicro,
      'spacingXxs': spacingXxs,
      'spacingXs': spacingXs,
      'radiusXxs': radiusXxs,
      'radiusXxl': radiusXxl,
      // Shadows are not serialized due to complexity
      // Typography is not serialized due to complexity
    };
  }

  /// Creates an [AppThemeExtension] from a JSON map.
  ///
  /// Deserializes the JSON representation back into a theme extension instance.
  /// Shadow and typography properties are not restored and will be null.
  factory AppThemeExtension.fromJson(Map<String, dynamic> json) {
    return AppThemeExtension(
      successColor: json['successColor'] != null
          ? Color(json['successColor'] as int)
          : null,
      warningColor: json['warningColor'] != null
          ? Color(json['warningColor'] as int)
          : null,
      infoColor: json['infoColor'] != null
          ? Color(json['infoColor'] as int)
          : null,
      accent2Color: json['accent2Color'] != null
          ? Color(json['accent2Color'] as int)
          : null,
      accent3Color: json['accent3Color'] != null
          ? Color(json['accent3Color'] as int)
          : null,
      spacingMicro: json['spacingMicro'] as double?,
      spacingXxs: json['spacingXxs'] as double?,
      spacingXs: json['spacingXs'] as double?,
      radiusXxs: json['radiusXxs'] as double?,
      radiusXxl: json['radiusXxl'] as double?,
      // Shadows and typography not deserialized
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Extension Methods for Type-Safe Access
// ═════════════════════════════════════════════════════════════════════════════

/// Extension on [BuildContext] to provide easy access to [AppThemeExtension].
extension AppThemeExtensionContext on BuildContext {
  /// Gets the current [AppThemeExtension] from the theme.
  ///
  /// Returns the extension if present, otherwise returns a default light theme.
  ///
  /// Example:
  /// ```dart
  /// final successColor = context.appThemeExtension.successColor;
  /// ```
  AppThemeExtension get appThemeExtension {
    return Theme.of(this).extension<AppThemeExtension>() ??
        AppThemeExtension.light();
  }
}
