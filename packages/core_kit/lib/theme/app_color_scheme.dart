// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Material Design 3 color scheme for the application.
/// Provides light and dark color schemes with semantic color tokens.
class AppColorScheme {
  const AppColorScheme._();

  /// Light color scheme based on Material Design 3
  static ColorScheme light() {
    return ColorScheme.light(
      primary: const Color(0xFF6750A4),
      onPrimary: const Color(0xFFFFFFFF),
      primaryContainer: const Color(0xFFEADDFF),
      onPrimaryContainer: const Color(0xFF21005D),
      secondary: const Color(0xFF625B71),
      onSecondary: const Color(0xFFFFFFFF),
      secondaryContainer: const Color(0xFFE8DEF8),
      onSecondaryContainer: const Color(0xFF1D192B),
      tertiary: const Color(0xFF7D5260),
      onTertiary: const Color(0xFFFFFFFF),
      tertiaryContainer: const Color(0xFFFFD8E4),
      onTertiaryContainer: const Color(0xFF31111D),
      error: const Color(0xFFB3261E),
      onError: const Color(0xFFFFFFFF),
      errorContainer: const Color(0xFFF9DEDC),
      onErrorContainer: const Color(0xFF410E0B),
      surface: const Color(0xFFFEF7FF),
      onSurface: const Color(0xFF1D1B20),
      surfaceContainerHighest: const Color(0xFFE6E0E9),
      onSurfaceVariant: const Color(0xFF49454F),
      outline: const Color(0xFF79747E),
      outlineVariant: const Color(0xFFCAC4D0),
      shadow: const Color(0xFF000000),
      scrim: const Color(0xFF000000),
      inverseSurface: const Color(0xFF322F35),
      onInverseSurface: const Color(0xFFF5EFF7),
      inversePrimary: const Color(0xFFD0BCFF),
    );
  }

  /// Dark color scheme based on Material Design 3
  static ColorScheme dark() {
    return ColorScheme.dark(
      primary: const Color(0xFFD0BCFF),
      onPrimary: const Color(0xFF381E72),
      primaryContainer: const Color(0xFF4F378B),
      onPrimaryContainer: const Color(0xFFEADDFF),
      secondary: const Color(0xFFCCC2DC),
      onSecondary: const Color(0xFF332D41),
      secondaryContainer: const Color(0xFF4A4458),
      onSecondaryContainer: const Color(0xFFE8DEF8),
      tertiary: const Color(0xFFEFB8C8),
      onTertiary: const Color(0xFF492532),
      tertiaryContainer: const Color(0xFF633B48),
      onTertiaryContainer: const Color(0xFFFFD8E4),
      error: const Color(0xFFF2B8B5),
      onError: const Color(0xFF601410),
      errorContainer: const Color(0xFF8C1D18),
      onErrorContainer: const Color(0xFFF9DEDC),
      surface: const Color(0xFF141218),
      onSurface: const Color(0xFFE6E0E9),
      surfaceContainerHighest: const Color(0xFF49454F),
      onSurfaceVariant: const Color(0xFFCAC4D0),
      outline: const Color(0xFF938F99),
      outlineVariant: const Color(0xFF49454F),
      shadow: const Color(0xFF000000),
      scrim: const Color(0xFF000000),
      inverseSurface: const Color(0xFFE6E0E9),
      onInverseSurface: const Color(0xFF322F35),
      inversePrimary: const Color(0xFF6750A4),
    );
  }
}
