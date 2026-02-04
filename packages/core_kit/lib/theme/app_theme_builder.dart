// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app_color_scheme.dart';
import 'app_radius.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Builds Material Design 3 themes from seed colors.
///
/// `AppThemeBuilder` provides a comprehensive solution for dynamic theme
/// generation and management. It enables apps to support custom brand colors,
/// user-selected themes, and Material You dynamic color extraction.
///
/// **Key Features:**
/// - Generate complete M3 themes from a single seed color
/// - Create light/dark theme pairs automatically
/// - Support for custom ColorScheme overrides
/// - Dynamic color extraction (Material You) support
/// - High contrast accessibility modes
/// - WCAG AA contrast validation
///
/// **Usage:**
/// ```dart
/// // Generate theme from seed color
/// final colorScheme = AppThemeBuilder.generateColorScheme(
///   seedColor: Colors.blue,
///   brightness: Brightness.light,
/// );
///
/// // Build theme pair
/// final themes = AppThemeBuilder.buildThemePair(
///   seedColor: Colors.blue,
/// );
/// ```
class AppThemeBuilder {
  const AppThemeBuilder._();

  /// Default seed color used when none is provided.
  static const Color defaultSeedColor = Color(0xFF6750A4);

  /// Minimum contrast ratio for WCAG AA compliance (normal text).
  static const double wcagAANormalText = 4.5;

  /// Minimum contrast ratio for WCAG AA compliance (large text/UI).
  static const double wcagAALargeText = 3.0;

  /// Minimum contrast ratio for WCAG AAA compliance (normal text).
  static const double wcagAAANormalText = 7.0;

  /// Generates a complete M3 ColorScheme from a seed color.
  ///
  /// Uses Flutter's built-in `ColorScheme.fromSeed` to create a Material 3
  /// color palette with proper tonal relationships.
  ///
  /// **Parameters:**
  /// - [seedColor]: The primary brand color to generate palette from
  /// - [brightness]: Theme brightness (light or dark)
  ///
  /// **Example:**
  /// ```dart
  /// final lightScheme = AppThemeBuilder.generateColorScheme(
  ///   seedColor: Colors.teal,
  ///   brightness: Brightness.light,
  /// );
  ///
  /// final darkScheme = AppThemeBuilder.generateColorScheme(
  ///   seedColor: Colors.teal,
  ///   brightness: Brightness.dark,
  /// );
  /// ```
  static ColorScheme generateColorScheme({
    required Color seedColor,
    Brightness brightness = Brightness.light,
  }) {
    return ColorScheme.fromSeed(seedColor: seedColor, brightness: brightness);
  }

  /// Generates a ColorScheme with custom color overrides.
  ///
  /// Allows overriding specific color roles while maintaining
  /// the seed color's tonal relationships for other colors.
  ///
  /// **Parameters:**
  /// - [seedColor]: Base color for generating the palette
  /// - [brightness]: Theme brightness
  /// - [primary], [secondary], [tertiary], etc.: Optional color overrides
  ///
  /// **Example:**
  /// ```dart
  /// final customScheme = AppThemeBuilder.generateCustomColorScheme(
  ///   seedColor: Colors.blue,
  ///   primary: Colors.indigo,
  ///   secondary: Colors.amber,
  /// );
  /// ```
  static ColorScheme generateCustomColorScheme({
    required Color seedColor,
    Brightness brightness = Brightness.light,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? surface,
    Color? onSurface,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
  }) {
    final baseScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return baseScheme.copyWith(
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      surface: surface,
      onSurface: onSurface,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
    );
  }

  /// Builds a complete ThemeData from a ColorScheme.
  ///
  /// Creates a Material 3 theme with proper component theming,
  /// typography, and shape definitions.
  ///
  /// **Parameters:**
  /// - [colorScheme]: The color scheme to use
  /// - [textTheme]: Optional custom text theme
  ///
  /// **Example:**
  /// ```dart
  /// final scheme = AppThemeBuilder.generateColorScheme(
  ///   seedColor: Colors.purple,
  /// );
  /// final theme = AppThemeBuilder.buildTheme(colorScheme: scheme);
  /// ```
  static ThemeData buildTheme({
    required ColorScheme colorScheme,
    TextTheme? textTheme,
  }) {
    final effectiveTextTheme = textTheme ?? AppTypography.textTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: effectiveTextTheme,
      scaffoldBackgroundColor: colorScheme.surface,

      // AppBar theme
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 3,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: effectiveTextTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),

      // Card theme
      cardTheme: CardThemeData(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.mdRadius),
        clipBehavior: Clip.antiAlias,
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.lgRadius),
          textStyle: effectiveTextTheme.labelLarge,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.lgRadius),
          textStyle: effectiveTextTheme.labelLarge,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.lgRadius),
          textStyle: effectiveTextTheme.labelLarge,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.lgRadius),
          textStyle: effectiveTextTheme.labelLarge,
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: AppRadius.smRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.smRadius,
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.smRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.smRadius,
          borderSide: BorderSide(color: colorScheme.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.secondaryContainer,
        deleteIconColor: colorScheme.onSurfaceVariant,
        labelStyle: effectiveTextTheme.labelLarge,
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

      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.smRadius),
      ),

      // Divider theme
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Generates light and dark theme pair from a seed color.
  ///
  /// Useful for apps that support both light and dark modes
  /// with consistent brand colors.
  ///
  /// **Example:**
  /// ```dart
  /// final themes = AppThemeBuilder.buildThemePair(
  ///   seedColor: Colors.indigo,
  /// );
  ///
  /// MaterialApp(
  ///   theme: themes.light,
  ///   darkTheme: themes.dark,
  /// );
  /// ```
  static ({ThemeData light, ThemeData dark}) buildThemePair({
    required Color seedColor,
    TextTheme? textTheme,
  }) {
    final lightScheme = generateColorScheme(
      seedColor: seedColor,
      brightness: Brightness.light,
    );

    final darkScheme = generateColorScheme(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );

    return (
      light: buildTheme(colorScheme: lightScheme, textTheme: textTheme),
      dark: buildTheme(colorScheme: darkScheme, textTheme: textTheme),
    );
  }

  /// Validates color contrast for accessibility compliance.
  ///
  /// Returns `true` if the contrast ratio meets the specified minimum.
  /// Uses the WCAG formula for calculating contrast ratios.
  ///
  /// **Standards:**
  /// - WCAG AA (normal text): 4.5:1
  /// - WCAG AA (large text/UI): 3.0:1
  /// - WCAG AAA (normal text): 7.0:1
  ///
  /// **Example:**
  /// ```dart
  /// final isCompliant = AppThemeBuilder.validateContrast(
  ///   foreground: Colors.white,
  ///   background: Colors.blue,
  ///   minimumRatio: 4.5,
  /// ); // true - meets WCAG AA
  /// ```
  static bool validateContrast({
    required Color foreground,
    required Color background,
    double minimumRatio = wcagAANormalText,
  }) {
    final ratio = AppColorScheme.contrastRatio(foreground, background);
    return ratio >= minimumRatio;
  }

  /// Gets the contrast ratio between two colors.
  ///
  /// Returns a value between 1.0 (no contrast) and 21.0 (maximum contrast).
  ///
  /// **Example:**
  /// ```dart
  /// final ratio = AppThemeBuilder.getContrastRatio(
  ///   Colors.white,
  ///   Colors.black,
  /// ); // 21.0
  /// ```
  static double getContrastRatio(Color foreground, Color background) {
    return AppColorScheme.contrastRatio(foreground, background);
  }

  /// Creates a high contrast variant of a theme.
  ///
  /// Increases the contrast of colors for users who need
  /// better visibility. The [contrastLevel] parameter controls
  /// the intensity (0.0 = no change, 1.0 = maximum adjustment).
  ///
  /// **Example:**
  /// ```dart
  /// final highContrastTheme = AppThemeBuilder.buildHighContrastTheme(
  ///   baseTheme: normalTheme,
  ///   contrastLevel: 0.5,
  /// );
  /// ```
  static ThemeData buildHighContrastTheme({
    required ThemeData baseTheme,
    double contrastLevel = 0.5,
  }) {
    assert(
      contrastLevel >= 0.0 && contrastLevel <= 1.0,
      'contrastLevel must be between 0.0 and 1.0',
    );

    final colorScheme = baseTheme.colorScheme;
    final isLight = colorScheme.brightness == Brightness.light;

    // Increase contrast by adjusting color lightness
    Color adjustColor(Color color) {
      final hsl = HSLColor.fromColor(color);
      if (isLight) {
        // Make dark colors darker, light colors lighter
        final newLightness = hsl.lightness < 0.5
            ? (hsl.lightness - (contrastLevel * 0.2)).clamp(0.0, 1.0)
            : (hsl.lightness + (contrastLevel * 0.2)).clamp(0.0, 1.0);
        return hsl.withLightness(newLightness).toColor();
      } else {
        // For dark theme, make bright colors brighter
        final newLightness = hsl.lightness > 0.5
            ? (hsl.lightness + (contrastLevel * 0.2)).clamp(0.0, 1.0)
            : (hsl.lightness - (contrastLevel * 0.1)).clamp(0.0, 1.0);
        return hsl.withLightness(newLightness).toColor();
      }
    }

    final adjustedScheme = colorScheme.copyWith(
      primary: adjustColor(colorScheme.primary),
      secondary: adjustColor(colorScheme.secondary),
      tertiary: adjustColor(colorScheme.tertiary),
      error: adjustColor(colorScheme.error),
      onSurface: adjustColor(colorScheme.onSurface),
      onSurfaceVariant: adjustColor(colorScheme.onSurfaceVariant),
      outline: adjustColor(colorScheme.outline),
    );

    return baseTheme.copyWith(colorScheme: adjustedScheme);
  }

  /// Simulates dynamic color extraction (Material You).
  ///
  /// In production, use the `dynamic_color` package to extract
  /// colors from the device wallpaper. This method provides a
  /// simulation for development and testing.
  ///
  /// **Note:** Real dynamic color extraction is only available
  /// on Android 12+ devices.
  ///
  /// **Example:**
  /// ```dart
  /// // Simulate dynamic color from a "wallpaper" color
  /// final themes = AppThemeBuilder.buildFromDynamicColor(
  ///   wallpaperColor: Colors.blue,
  /// );
  /// ```
  static ({ThemeData light, ThemeData dark}) buildFromDynamicColor({
    required Color wallpaperColor,
    TextTheme? textTheme,
  }) {
    // In real implementation, use dynamic_color package:
    // CorePalette.of(wallpaperColor.value)
    // For now, we use the wallpaper color as seed
    return buildThemePair(seedColor: wallpaperColor, textTheme: textTheme);
  }

  /// Checks if the current platform supports dynamic colors.
  ///
  /// Dynamic color (Material You) is only available on:
  /// - Android 12 (API 31) and above
  ///
  /// Returns `false` on all other platforms.
  static bool get supportsDynamicColor {
    // In real implementation, check Android API level
    // For now, we return false for web and assume mobile support
    return !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  }
}

/// Manages app-wide theme state with persistence support.
///
/// `ThemeNotifier` provides a reactive way to manage theme changes
/// throughout your application. It supports:
/// - Seed color customization
/// - Theme mode switching (light/dark/system)
/// - High contrast mode
/// - Persistence callbacks for saving user preferences
///
/// **Usage:**
/// ```dart
/// final themeNotifier = ThemeNotifier(
///   seedColor: Colors.blue,
///   onThemeChanged: (color, mode, highContrast) {
///     // Save to SharedPreferences
///     prefs.setInt('seedColor', color.value);
///     prefs.setString('themeMode', mode.name);
///     prefs.setBool('highContrast', highContrast);
///   },
/// );
///
/// // Use with ChangeNotifierProvider
/// ChangeNotifierProvider.value(
///   value: themeNotifier,
///   child: MaterialApp(...),
/// );
/// ```
class ThemeNotifier extends ChangeNotifier {
  /// Creates a ThemeNotifier with initial settings.
  ///
  /// **Parameters:**
  /// - [seedColor]: Initial seed color (defaults to M3 purple)
  /// - [themeMode]: Initial theme mode (defaults to system)
  /// - [highContrast]: Enable high contrast mode
  /// - [onThemeChanged]: Callback for persisting changes
  ThemeNotifier({
    Color? seedColor,
    ThemeMode themeMode = ThemeMode.system,
    bool highContrast = false,
    this.onThemeChanged,
  }) : _seedColor = seedColor ?? AppThemeBuilder.defaultSeedColor,
       _themeMode = themeMode,
       _highContrast = highContrast {
    _rebuildThemes();
  }

  /// Callback invoked when theme settings change.
  ///
  /// Use this to persist theme preferences to storage.
  final void Function(Color seedColor, ThemeMode mode, bool highContrast)?
  onThemeChanged;

  Color _seedColor;
  ThemeMode _themeMode;
  bool _highContrast;
  late ThemeData _lightTheme;
  late ThemeData _darkTheme;

  /// Current seed color.
  Color get seedColor => _seedColor;

  /// Current theme mode.
  ThemeMode get themeMode => _themeMode;

  /// Whether high contrast mode is enabled.
  bool get highContrast => _highContrast;

  /// Current light theme.
  ThemeData get lightTheme => _lightTheme;

  /// Current dark theme.
  ThemeData get darkTheme => _darkTheme;

  /// Updates the seed color and regenerates themes.
  void setSeedColor(Color color) {
    if (_seedColor == color) return;
    _seedColor = color;
    _rebuildThemes();
    _notifyChange();
  }

  /// Updates the theme mode.
  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    _notifyChange();
  }

  /// Toggles between light and dark theme modes.
  ///
  /// If currently in system mode, switches to light mode.
  void toggleTheme() {
    switch (_themeMode) {
      case ThemeMode.light:
        setThemeMode(ThemeMode.dark);
      case ThemeMode.dark:
        setThemeMode(ThemeMode.light);
      case ThemeMode.system:
        setThemeMode(ThemeMode.light);
    }
  }

  /// Enables or disables high contrast mode.
  void setHighContrast(bool enabled) {
    if (_highContrast == enabled) return;
    _highContrast = enabled;
    _rebuildThemes();
    _notifyChange();
  }

  /// Toggles high contrast mode.
  void toggleHighContrast() {
    setHighContrast(!_highContrast);
  }

  void _rebuildThemes() {
    final themes = AppThemeBuilder.buildThemePair(seedColor: _seedColor);

    if (_highContrast) {
      _lightTheme = AppThemeBuilder.buildHighContrastTheme(
        baseTheme: themes.light,
      );
      _darkTheme = AppThemeBuilder.buildHighContrastTheme(
        baseTheme: themes.dark,
      );
    } else {
      _lightTheme = themes.light;
      _darkTheme = themes.dark;
    }
  }

  void _notifyChange() {
    notifyListeners();
    onThemeChanged?.call(_seedColor, _themeMode, _highContrast);
  }
}

/// Animated theme switcher widget.
///
/// Wraps child widgets and provides smooth animated transitions
/// when the theme changes.
///
/// **Usage:**
/// ```dart
/// AnimatedThemeSwitcher(
///   duration: Duration(milliseconds: 300),
///   child: MaterialApp(...),
/// );
/// ```
class AnimatedThemeSwitcher extends StatelessWidget {
  /// Creates an AnimatedThemeSwitcher.
  const AnimatedThemeSwitcher({
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    super.key,
  });

  /// The child widget to animate.
  final Widget child;

  /// Duration of theme transition animation.
  final Duration duration;

  /// Animation curve.
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: Theme.of(context),
      duration: duration,
      curve: curve,
      child: child,
    );
  }
}
