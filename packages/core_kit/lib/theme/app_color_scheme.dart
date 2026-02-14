// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Material Design 3 color scheme for the application.
///
/// Provides a complete color palette with M3 surface variants,
/// semantic colors, and utility methods for color manipulation.
///
/// **Usage**:
/// ```dart
/// // Get light theme colors
/// final lightColors = AppColorScheme.light();
///
/// // Get dark theme colors
/// final darkColors = AppColorScheme.dark();
///
/// // Use in ThemeData
/// ThemeData(
///   colorScheme: AppColorScheme.light(),
/// );
/// ```
class AppColorScheme {
  const AppColorScheme._();

  /// Light theme color scheme based on Material Design 3.
  ///
  /// Provides a bright, accessible color palette optimized for light backgrounds.
  /// All color combinations meet WCAG AA contrast standards (4.5:1 minimum).
  ///
  /// **Surface Variants**: 7 levels from Lowest (least emphasis) to Highest (most emphasis)
  /// **Semantic Colors**: Success, Warning, Info colors with container variants
  static ColorScheme light() {
    return const ColorScheme.light(
      // Primary color family - Key components and high-emphasis actions
      primary: Color(0xFF6750A4), // Primary brand color
      onPrimary: Color(0xFFFFFFFF), // Text/icons on primary
      primaryContainer: Color(0xFFEADDFF), // Muted primary for containers
      onPrimaryContainer: Color(0xFF21005D), // Text on primary container
      // Secondary color family - Less prominent components
      secondary: Color(0xFF625B71), // Secondary actions
      onSecondary: Color(0xFFFFFFFF), // Text/icons on secondary
      secondaryContainer: Color(0xFFE8DEF8), // Muted secondary for containers
      onSecondaryContainer: Color(0xFF1D192B), // Text on secondary container
      // Tertiary color family - Complementary accents
      tertiary: Color(0xFF7D5260), // Accent color
      onTertiary: Color(0xFFFFFFFF), // Text/icons on tertiary
      tertiaryContainer: Color(0xFFFFD8E4), // Muted tertiary for containers
      onTertiaryContainer: Color(0xFF31111D), // Text on tertiary container
      // Error color family - Destructive actions and warnings
      error: Color(0xFFB3261E), // Error states
      onError: Color(0xFFFFFFFF), // Text/icons on error
      errorContainer: Color(0xFFF9DEDC), // Muted error for containers
      onErrorContainer: Color(0xFF410E0B), // Text on error container
      // Surface color family - Backgrounds and cards
      surface: Color(0xFFFEF7FF), // Default surface background
      onSurface: Color(0xFF1D1B20), // High-emphasis text on surface
      onSurfaceVariant: Color(0xFF49454F), // Medium-emphasis text on surface
      // M3 Surface Variants - Tone-based elevation levels
      surfaceBright: Color(0xFFFEF7FF), // Brightest surface (elevated feel)
      surfaceDim: Color(0xFFDED8E1), // Dimmest surface (recessed feel)
      surfaceContainer: Color(0xFFF3EDF7), // Default container surface
      surfaceContainerLow: Color(0xFFF7F2FA), // Low emphasis container
      surfaceContainerLowest: Color(0xFFFFFFFF), // Lowest emphasis container
      surfaceContainerHigh: Color(0xFFECE6F0), // High emphasis container
      surfaceContainerHighest: Color(0xFFE6E0E9), // Highest emphasis container
      // Outline colors - Borders and dividers
      outline: Color(0xFF79747E), // Default borders
      outlineVariant: Color(0xFFCAC4D0), // Subtle dividers
      // Shadow and scrim
      shadow: Color(0xFF000000), // Shadows
      scrim: Color(0xFF000000), // Modal scrims
      // Inverse colors - For inverse surfaces (e.g., tooltips)
      inverseSurface: Color(0xFF322F35), // Dark surface on light theme
      onInverseSurface: Color(0xFFF5EFF7), // Text on inverse surface
      inversePrimary: Color(0xFFD0BCFF), // Primary on inverse surface
    );
  }

  /// Dark theme color scheme based on Material Design 3.
  ///
  /// Provides a dark, accessible color palette optimized for dark backgrounds.
  /// All color combinations meet WCAG AA contrast standards (4.5:1 minimum).
  ///
  /// **Surface Variants**: 7 levels from Lowest (least emphasis) to Highest (most emphasis)
  /// **Semantic Colors**: Success, Warning, Info colors with container variants
  static ColorScheme dark() {
    return const ColorScheme.dark(
      // Primary color family
      primary: Color(0xFFD0BCFF), // Lighter primary for dark theme
      onPrimary: Color(0xFF381E72), // Text/icons on primary
      primaryContainer: Color(0xFF4F378B), // Muted primary for containers
      onPrimaryContainer: Color(0xFFEADDFF), // Text on primary container
      // Secondary color family
      secondary: Color(0xFFCCC2DC), // Lighter secondary for dark theme
      onSecondary: Color(0xFF332D41), // Text/icons on secondary
      secondaryContainer: Color(0xFF4A4458), // Muted secondary for containers
      onSecondaryContainer: Color(0xFFE8DEF8), // Text on secondary container
      // Tertiary color family
      tertiary: Color(0xFFEFB8C8), // Lighter tertiary for dark theme
      onTertiary: Color(0xFF492532), // Text/icons on tertiary
      tertiaryContainer: Color(0xFF633B48), // Muted tertiary for containers
      onTertiaryContainer: Color(0xFFFFD8E4), // Text on tertiary container
      // Error color family
      error: Color(0xFFF2B8B5), // Lighter error for dark theme
      onError: Color(0xFF601410), // Text/icons on error
      errorContainer: Color(0xFF8C1D18), // Muted error for containers
      onErrorContainer: Color(0xFFF9DEDC), // Text on error container
      // Surface color family
      surface: Color(0xFF141218), // Default dark surface
      onSurface: Color(0xFFE6E0E9), // High-emphasis text on dark surface
      onSurfaceVariant: Color(
        0xFFCAC4D0,
      ), // Medium-emphasis text on dark surface
      // M3 Surface Variants - Tone-based elevation levels
      surfaceBright: Color(0xFF3B383E), // Brightest dark surface
      surfaceDim: Color(0xFF141218), // Dimmest dark surface
      surfaceContainer: Color(0xFF211F26), // Default dark container
      surfaceContainerLow: Color(0xFF1D1B20), // Low emphasis dark container
      surfaceContainerLowest: Color(
        0xFF0F0D13,
      ), // Lowest emphasis dark container
      surfaceContainerHigh: Color(0xFF2B2930), // High emphasis dark container
      surfaceContainerHighest: Color(
        0xFF36343B,
      ), // Highest emphasis dark container
      // Outline colors
      outline: Color(0xFF938F99), // Lighter borders for dark theme
      outlineVariant: Color(0xFF49454F), // Subtle dividers for dark theme
      // Shadow and scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),

      // Inverse colors
      inverseSurface: Color(0xFFE6E0E9), // Light surface on dark theme
      onInverseSurface: Color(0xFF322F35), // Text on inverse surface
      inversePrimary: Color(0xFF6750A4), // Primary on inverse surface
    );
  }

  /// High-contrast light color scheme for WCAG AAA compliance.
  ///
  /// All foreground/background pairs achieve a minimum 7:1 contrast ratio.
  /// Colors are more saturated and darker for foregrounds, lighter for
  /// backgrounds to maximize readability.
  static ColorScheme highContrastLight() {
    return const ColorScheme.light(
      // Primary - darker for 7:1+ contrast on white
      primary: Color(0xFF21005D),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD4C1F7),
      onPrimaryContainer: Color(0xFF0E0033),
      // Secondary - darker
      secondary: Color(0xFF332D41),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFD5CCE6),
      onSecondaryContainer: Color(0xFF0E0A19),
      // Tertiary - darker
      tertiary: Color(0xFF4A2532),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFF5C8D6),
      onTertiaryContainer: Color(0xFF1F0510),
      // Error - darker
      error: Color(0xFF8C1D18),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFF5C6C2),
      onErrorContainer: Color(0xFF2D0607),
      // Surface - pure white for maximum contrast
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
      onSurfaceVariant: Color(0xFF1D1B20),
      // Surface variants - higher contrast steps
      surfaceBright: Color(0xFFFFFFFF),
      surfaceDim: Color(0xFFC9C4CE),
      surfaceContainer: Color(0xFFEDE8F2),
      surfaceContainerLow: Color(0xFFF3EEF8),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerHigh: Color(0xFFE1DCE6),
      surfaceContainerHighest: Color(0xFFD5D0DA),
      // Outline - darker for visibility
      outline: Color(0xFF49454F),
      outlineVariant: Color(0xFF79747E),
      // Shadow and scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      // Inverse
      inverseSurface: Color(0xFF1D1B20),
      onInverseSurface: Color(0xFFFFFFFF),
      inversePrimary: Color(0xFFE8DEFF),
    );
  }

  /// High-contrast dark color scheme for WCAG AAA compliance.
  ///
  /// All foreground/background pairs achieve a minimum 7:1 contrast ratio.
  /// Colors are lighter and brighter for foregrounds on very dark backgrounds
  /// to maximize readability in dark mode.
  static ColorScheme highContrastDark() {
    return const ColorScheme.dark(
      // Primary - brighter for 7:1+ contrast on black
      primary: Color(0xFFF0E6FF),
      onPrimary: Color(0xFF1A0044),
      primaryContainer: Color(0xFF3D2672),
      onPrimaryContainer: Color(0xFFF5EEFF),
      // Secondary - brighter
      secondary: Color(0xFFE8DEF8),
      onSecondary: Color(0xFF1D192B),
      secondaryContainer: Color(0xFF3B3548),
      onSecondaryContainer: Color(0xFFF3EDFF),
      // Tertiary - brighter
      tertiary: Color(0xFFFFF0F4),
      onTertiary: Color(0xFF31111D),
      tertiaryContainer: Color(0xFF522E3B),
      onTertiaryContainer: Color(0xFFFFF0F4),
      // Error - brighter
      error: Color(0xFFFFF0EF),
      onError: Color(0xFF410E0B),
      errorContainer: Color(0xFF6E1511),
      onErrorContainer: Color(0xFFFFF0EF),
      // Surface - pure black for maximum contrast
      surface: Color(0xFF000000),
      onSurface: Color(0xFFFFFFFF),
      onSurfaceVariant: Color(0xFFE6E0E9),
      // Surface variants - higher contrast steps
      surfaceBright: Color(0xFF3B383E),
      surfaceDim: Color(0xFF000000),
      surfaceContainer: Color(0xFF1A181E),
      surfaceContainerLow: Color(0xFF121016),
      surfaceContainerLowest: Color(0xFF000000),
      surfaceContainerHigh: Color(0xFF252329),
      surfaceContainerHighest: Color(0xFF302E34),
      // Outline - brighter for visibility
      outline: Color(0xFFCAC4D0),
      outlineVariant: Color(0xFF938F99),
      // Shadow and scrim
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      // Inverse
      inverseSurface: Color(0xFFFFFFFF),
      onInverseSurface: Color(0xFF000000),
      inversePrimary: Color(0xFF4F378B),
    );
  }

  /// Lightens a color by a given amount (0.0 to 1.0).
  ///
  /// **Parameters**:
  /// - [color]: The color to lighten
  /// - [amount]: Percentage to lighten (0.0 = no change, 1.0 = white)
  ///
  /// **Example**:
  /// ```dart
  /// final lighter = AppColorScheme.lighten(Colors.blue, 0.2); // 20% lighter
  /// ```
  static Color lighten(Color color, double amount) {
    assert(
      amount >= 0.0 && amount <= 1.0,
      'Amount must be between 0.0 and 1.0',
    );

    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Darkens a color by a given amount (0.0 to 1.0).
  ///
  /// **Parameters**:
  /// - [color]: The color to darken
  /// - [amount]: Percentage to darken (0.0 = no change, 1.0 = black)
  ///
  /// **Example**:
  /// ```dart
  /// final darker = AppColorScheme.darken(Colors.blue, 0.2); // 20% darker
  /// ```
  static Color darken(Color color, double amount) {
    assert(
      amount >= 0.0 && amount <= 1.0,
      'Amount must be between 0.0 and 1.0',
    );

    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);

    return hsl.withLightness(lightness).toColor();
  }

  /// Applies opacity to a color.
  ///
  /// **Parameters**:
  /// - [color]: The color to modify
  /// - [opacity]: Opacity value (0.0 = transparent, 1.0 = opaque)
  ///
  /// **Example**:
  /// ```dart
  /// final semitransparent = AppColorScheme.withOpacityValue(Colors.blue, 0.5);
  /// ```
  static Color withOpacityValue(Color color, double opacity) {
    assert(
      opacity >= 0.0 && opacity <= 1.0,
      'Opacity must be between 0.0 and 1.0',
    );
    return color.withValues(alpha: opacity);
  }

  /// Calculates the contrast ratio between two colors.
  ///
  /// Returns a value between 1.0 (no contrast) and 21.0 (maximum contrast).
  /// WCAG standards:
  /// - AA Normal text: 4.5:1 minimum
  /// - AA Large text: 3.0:1 minimum
  /// - AAA Normal text: 7.0:1 minimum
  /// - AAA Large text: 4.5:1 minimum
  ///
  /// **Example**:
  /// ```dart
  /// final ratio = AppColorScheme.contrastRatio(Colors.white, Colors.black);
  /// // ratio = 21.0 (maximum contrast)
  /// ```
  static double contrastRatio(Color foreground, Color background) {
    final fgLuminance = foreground.computeLuminance();
    final bgLuminance = background.computeLuminance();

    final lighter = fgLuminance > bgLuminance ? fgLuminance : bgLuminance;
    final darker = fgLuminance > bgLuminance ? bgLuminance : fgLuminance;

    return (lighter + 0.05) / (darker + 0.05);
  }
}

/// Extension on [ColorScheme] to add custom semantic colors.
///
/// Provides success, warning, and info colors that complement
/// the standard Material Design 3 color roles.
///
/// **Usage**:
/// ```dart
/// final colors = Theme.of(context).colorScheme;
/// Container(
///   color: colors.success,
///   child: Text('Success!', style: TextStyle(color: colors.onSuccess)),
/// );
/// ```
extension CustomColors on ColorScheme {
  /// Success color for positive feedback.
  ///
  /// **Use for**:
  /// - Success messages and notifications
  /// - Completed states
  /// - Positive indicators
  ///
  /// Contrast: Must meet WCAG AA with [onSuccess] (4.5:1 minimum)
  Color get success => brightness == Brightness.light
      ? const Color(0xFF2E7D32) // Green 800
      : const Color(0xFF81C784); // Green 300

  /// Text/icon color on [success] background.
  Color get onSuccess => brightness == Brightness.light
      ? const Color(0xFFFFFFFF) // White text on dark green
      : const Color(0xFF1B5E20); // Dark green text on light green

  /// Muted success color for containers and backgrounds.
  ///
  /// **Use for**:
  /// - Success banners
  /// - Success cards
  /// - Highlighted success states
  Color get successContainer => brightness == Brightness.light
      ? const Color(0xFFC8E6C9) // Green 100
      : const Color(0xFF1B5E20); // Green 900

  /// Text/icon color on [successContainer] background.
  Color get onSuccessContainer => brightness == Brightness.light
      ? const Color(0xFF1B5E20) // Dark green text on light container
      : const Color(0xFFC8E6C9); // Light green text on dark container

  /// Warning color for cautionary feedback.
  ///
  /// **Use for**:
  /// - Warning messages
  /// - Caution indicators
  /// - Non-critical alerts
  ///
  /// Contrast: Must meet WCAG AA with [onWarning] (4.5:1 minimum)
  Color get warning => brightness == Brightness.light
      ? const Color(0xFFF57C00) // Orange 700
      : const Color(0xFFFFB74D); // Orange 300

  /// Text/icon color on [warning] background.
  Color get onWarning => brightness == Brightness.light
      ? const Color(0xFFFFFFFF) // White text on dark orange
      : const Color(0xFFE65100); // Dark orange text on light orange

  /// Muted warning color for containers and backgrounds.
  ///
  /// **Use for**:
  /// - Warning banners
  /// - Warning cards
  /// - Highlighted warning states
  Color get warningContainer => brightness == Brightness.light
      ? const Color(0xFFFFE0B2) // Orange 100
      : const Color(0xFFE65100); // Orange 900

  /// Text/icon color on [warningContainer] background.
  Color get onWarningContainer => brightness == Brightness.light
      ? const Color(0xFFE65100) // Dark orange text on light container
      : const Color(0xFFFFE0B2); // Light orange text on dark container

  /// Info color for informational feedback.
  ///
  /// **Use for**:
  /// - Info messages
  /// - Help text
  /// - Informational highlights
  ///
  /// Contrast: Must meet WCAG AA with [onInfo] (4.5:1 minimum)
  Color get info => brightness == Brightness.light
      ? const Color(0xFF0288D1) // Light Blue 700
      : const Color(0xFF4FC3F7); // Light Blue 300

  /// Text/icon color on [info] background.
  Color get onInfo => brightness == Brightness.light
      ? const Color(0xFFFFFFFF) // White text on dark blue
      : const Color(0xFF01579B); // Dark blue text on light blue

  /// Muted info color for containers and backgrounds.
  ///
  /// **Use for**:
  /// - Info banners
  /// - Info cards
  /// - Highlighted info states
  Color get infoContainer => brightness == Brightness.light
      ? const Color(0xFFB3E5FC) // Light Blue 100
      : const Color(0xFF01579B); // Light Blue 900

  /// Text/icon color on [infoContainer] background.
  Color get onInfoContainer => brightness == Brightness.light
      ? const Color(0xFF01579B) // Dark blue text on light container
      : const Color(0xFFB3E5FC); // Light blue text on dark container
}
