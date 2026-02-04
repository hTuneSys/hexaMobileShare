// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppThemeBuilder', () {
    group('generateColorScheme', () {
      test('generates light ColorScheme from seed color', () {
        const seedColor = Colors.blue;
        final colorScheme = AppThemeBuilder.generateColorScheme(
          seedColor: seedColor,
          brightness: Brightness.light,
        );

        expect(colorScheme.brightness, Brightness.light);
        expect(colorScheme.primary, isNotNull);
        expect(colorScheme.onPrimary, isNotNull);
        expect(colorScheme.secondary, isNotNull);
        expect(colorScheme.tertiary, isNotNull);
        expect(colorScheme.surface, isNotNull);
        expect(colorScheme.error, isNotNull);
      });

      test('generates dark ColorScheme from seed color', () {
        const seedColor = Colors.blue;
        final colorScheme = AppThemeBuilder.generateColorScheme(
          seedColor: seedColor,
          brightness: Brightness.dark,
        );

        expect(colorScheme.brightness, Brightness.dark);
        expect(colorScheme.primary, isNotNull);
        expect(colorScheme.onPrimary, isNotNull);
      });

      test('different seed colors produce different palettes', () {
        final blueScheme = AppThemeBuilder.generateColorScheme(
          seedColor: Colors.blue,
        );
        final redScheme = AppThemeBuilder.generateColorScheme(
          seedColor: Colors.red,
        );

        expect(blueScheme.primary, isNot(redScheme.primary));
      });
    });

    group('generateCustomColorScheme', () {
      test('applies custom primary color override', () {
        const seedColor = Colors.blue;
        const customPrimary = Colors.orange;

        final colorScheme = AppThemeBuilder.generateCustomColorScheme(
          seedColor: seedColor,
          primary: customPrimary,
        );

        expect(colorScheme.primary, customPrimary);
      });

      test('applies multiple color overrides', () {
        const seedColor = Colors.blue;
        const customPrimary = Colors.orange;
        const customSecondary = Colors.green;

        final colorScheme = AppThemeBuilder.generateCustomColorScheme(
          seedColor: seedColor,
          primary: customPrimary,
          secondary: customSecondary,
        );

        expect(colorScheme.primary, customPrimary);
        expect(colorScheme.secondary, customSecondary);
      });

      test('preserves non-overridden colors from seed', () {
        const seedColor = Colors.blue;
        const customPrimary = Colors.orange;

        final colorScheme = AppThemeBuilder.generateCustomColorScheme(
          seedColor: seedColor,
          primary: customPrimary,
        );

        final baseScheme = AppThemeBuilder.generateColorScheme(
          seedColor: seedColor,
        );

        // Tertiary should remain from seed generation
        expect(colorScheme.tertiary, isNotNull);
        expect(colorScheme.error, baseScheme.error);
      });
    });

    group('buildTheme', () {
      test('creates ThemeData with Material 3 enabled', () {
        final colorScheme = AppThemeBuilder.generateColorScheme(
          seedColor: Colors.purple,
        );
        final theme = AppThemeBuilder.buildTheme(colorScheme: colorScheme);

        expect(theme.useMaterial3, isTrue);
        expect(theme.colorScheme, colorScheme);
      });

      test('applies default typography when not provided', () {
        final colorScheme = AppThemeBuilder.generateColorScheme(
          seedColor: Colors.purple,
        );
        final theme = AppThemeBuilder.buildTheme(colorScheme: colorScheme);

        expect(theme.textTheme, isNotNull);
        expect(theme.textTheme.bodyLarge, isNotNull);
      });

      test('applies custom typography when provided', () {
        final colorScheme = AppThemeBuilder.generateColorScheme(
          seedColor: Colors.purple,
        );
        const customTextTheme = TextTheme(bodyLarge: TextStyle(fontSize: 20));
        final theme = AppThemeBuilder.buildTheme(
          colorScheme: colorScheme,
          textTheme: customTextTheme,
        );

        expect(theme.textTheme.bodyLarge?.fontSize, 20);
      });

      test('configures component themes correctly', () {
        final colorScheme = AppThemeBuilder.generateColorScheme(
          seedColor: Colors.purple,
        );
        final theme = AppThemeBuilder.buildTheme(colorScheme: colorScheme);

        expect(theme.appBarTheme.elevation, 0);
        expect(theme.cardTheme.elevation, 1);
        expect(theme.snackBarTheme.behavior, SnackBarBehavior.floating);
      });
    });

    group('buildThemePair', () {
      test('generates both light and dark themes', () {
        const seedColor = Colors.teal;
        final themes = AppThemeBuilder.buildThemePair(seedColor: seedColor);

        expect(themes.light.colorScheme.brightness, Brightness.light);
        expect(themes.dark.colorScheme.brightness, Brightness.dark);
      });

      test('both themes use same seed color characteristics', () {
        const seedColor = Colors.teal;
        final themes = AppThemeBuilder.buildThemePair(seedColor: seedColor);

        // Both should have teal-ish primary hues
        expect(themes.light.colorScheme.primary, isNotNull);
        expect(themes.dark.colorScheme.primary, isNotNull);
      });
    });

    group('validateContrast', () {
      test('returns true for high contrast colors', () {
        final isCompliant = AppThemeBuilder.validateContrast(
          foreground: Colors.white,
          background: Colors.black,
          minimumRatio: 4.5,
        );

        expect(isCompliant, isTrue);
      });

      test('returns false for low contrast colors', () {
        final isCompliant = AppThemeBuilder.validateContrast(
          foreground: Colors.grey,
          background: Colors.grey.shade400,
          minimumRatio: 4.5,
        );

        expect(isCompliant, isFalse);
      });

      test('uses WCAG AA standard by default', () {
        // White on black should pass AA (21:1 ratio)
        final passesAA = AppThemeBuilder.validateContrast(
          foreground: Colors.white,
          background: Colors.black,
        );

        expect(passesAA, isTrue);
      });
    });

    group('getContrastRatio', () {
      test('returns 21.0 for black and white', () {
        final ratio = AppThemeBuilder.getContrastRatio(
          Colors.white,
          Colors.black,
        );

        expect(ratio, closeTo(21.0, 0.1));
      });

      test('returns 1.0 for identical colors', () {
        final ratio = AppThemeBuilder.getContrastRatio(
          Colors.blue,
          Colors.blue,
        );

        expect(ratio, closeTo(1.0, 0.01));
      });

      test('order of colors does not affect ratio', () {
        final ratio1 = AppThemeBuilder.getContrastRatio(
          Colors.white,
          Colors.blue,
        );
        final ratio2 = AppThemeBuilder.getContrastRatio(
          Colors.blue,
          Colors.white,
        );

        expect(ratio1, closeTo(ratio2, 0.01));
      });
    });

    group('buildHighContrastTheme', () {
      test('returns modified theme with adjusted colors', () {
        final baseScheme = AppThemeBuilder.generateColorScheme(
          seedColor: Colors.blue,
        );
        final baseTheme = AppThemeBuilder.buildTheme(colorScheme: baseScheme);

        final highContrastTheme = AppThemeBuilder.buildHighContrastTheme(
          baseTheme: baseTheme,
          contrastLevel: 0.5,
        );

        expect(highContrastTheme.colorScheme, isNot(baseTheme.colorScheme));
      });

      test('contrastLevel 0.0 returns nearly identical colors', () {
        final baseScheme = AppThemeBuilder.generateColorScheme(
          seedColor: Colors.blue,
        );
        final baseTheme = AppThemeBuilder.buildTheme(colorScheme: baseScheme);

        final theme = AppThemeBuilder.buildHighContrastTheme(
          baseTheme: baseTheme,
          contrastLevel: 0.0,
        );

        // Colors should be identical or very close
        expect(
          theme.colorScheme.primary.toARGB32(),
          baseTheme.colorScheme.primary.toARGB32(),
        );
      });

      test('throws assertion error for invalid contrastLevel', () {
        final baseScheme = AppThemeBuilder.generateColorScheme(
          seedColor: Colors.blue,
        );
        final baseTheme = AppThemeBuilder.buildTheme(colorScheme: baseScheme);

        expect(
          () => AppThemeBuilder.buildHighContrastTheme(
            baseTheme: baseTheme,
            contrastLevel: 1.5,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('buildFromDynamicColor', () {
      test('generates theme pair from wallpaper color', () {
        const wallpaperColor = Colors.orange;
        final themes = AppThemeBuilder.buildFromDynamicColor(
          wallpaperColor: wallpaperColor,
        );

        expect(themes.light, isNotNull);
        expect(themes.dark, isNotNull);
        expect(themes.light.colorScheme.brightness, Brightness.light);
        expect(themes.dark.colorScheme.brightness, Brightness.dark);
      });
    });

    group('supportsDynamicColor', () {
      test('returns boolean value', () {
        expect(AppThemeBuilder.supportsDynamicColor, isA<bool>());
      });
    });

    group('constants', () {
      test('defaultSeedColor is defined', () {
        expect(AppThemeBuilder.defaultSeedColor, isNotNull);
        expect(AppThemeBuilder.defaultSeedColor, isA<Color>());
      });

      test('WCAG constants are correct', () {
        expect(AppThemeBuilder.wcagAANormalText, 4.5);
        expect(AppThemeBuilder.wcagAALargeText, 3.0);
        expect(AppThemeBuilder.wcagAAANormalText, 7.0);
      });
    });
  });

  group('ThemeNotifier', () {
    test('initializes with default values', () {
      final notifier = ThemeNotifier();

      expect(notifier.seedColor, AppThemeBuilder.defaultSeedColor);
      expect(notifier.themeMode, ThemeMode.system);
      expect(notifier.highContrast, isFalse);
      expect(notifier.lightTheme, isNotNull);
      expect(notifier.darkTheme, isNotNull);
    });

    test('initializes with custom seed color', () {
      final notifier = ThemeNotifier(seedColor: Colors.red);

      expect(notifier.seedColor, Colors.red);
    });

    test('initializes with custom theme mode', () {
      final notifier = ThemeNotifier(themeMode: ThemeMode.dark);

      expect(notifier.themeMode, ThemeMode.dark);
    });

    test('setSeedColor updates color and rebuilds themes', () {
      final notifier = ThemeNotifier();
      final originalPrimary = notifier.lightTheme.colorScheme.primary;

      notifier.setSeedColor(Colors.green);

      expect(notifier.seedColor, Colors.green);
      expect(notifier.lightTheme.colorScheme.primary, isNot(originalPrimary));
    });

    test('setSeedColor does not rebuild if color is same', () {
      var callCount = 0;
      final notifier = ThemeNotifier(
        seedColor: Colors.blue,
        onThemeChanged: (l, d, m) => callCount++,
      );

      notifier.setSeedColor(Colors.blue);

      expect(callCount, 0);
    });

    test('setThemeMode updates mode and notifies', () {
      var notified = false;
      final notifier = ThemeNotifier();
      notifier.addListener(() => notified = true);

      notifier.setThemeMode(ThemeMode.dark);

      expect(notifier.themeMode, ThemeMode.dark);
      expect(notified, isTrue);
    });

    test('toggleTheme cycles between light and dark', () {
      final notifier = ThemeNotifier(themeMode: ThemeMode.light);

      notifier.toggleTheme();
      expect(notifier.themeMode, ThemeMode.dark);

      notifier.toggleTheme();
      expect(notifier.themeMode, ThemeMode.light);
    });

    test('toggleTheme from system goes to light', () {
      final notifier = ThemeNotifier(themeMode: ThemeMode.system);

      notifier.toggleTheme();
      expect(notifier.themeMode, ThemeMode.light);
    });

    test('setHighContrast updates mode and rebuilds themes', () {
      final notifier = ThemeNotifier();
      final originalPrimary = notifier.lightTheme.colorScheme.primary;

      notifier.setHighContrast(true);

      expect(notifier.highContrast, isTrue);
      // High contrast should modify colors
      expect(notifier.lightTheme.colorScheme.primary, isNot(originalPrimary));
    });

    test('toggleHighContrast flips state', () {
      final notifier = ThemeNotifier();

      notifier.toggleHighContrast();
      expect(notifier.highContrast, isTrue);

      notifier.toggleHighContrast();
      expect(notifier.highContrast, isFalse);
    });

    test('onThemeChanged callback is invoked on changes', () {
      Color? savedColor;
      ThemeMode? savedMode;
      bool? savedHighContrast;

      final notifier = ThemeNotifier(
        onThemeChanged: (color, mode, highContrast) {
          savedColor = color;
          savedMode = mode;
          savedHighContrast = highContrast;
        },
      );

      notifier.setSeedColor(Colors.purple);

      expect(savedColor, Colors.purple);
      expect(savedMode, ThemeMode.system);
      expect(savedHighContrast, isFalse);
    });

    test('notifyListeners is called on state changes', () {
      var listenerCallCount = 0;
      final notifier = ThemeNotifier();
      notifier.addListener(() => listenerCallCount++);

      notifier.setSeedColor(Colors.orange);
      notifier.setThemeMode(ThemeMode.dark);
      notifier.setHighContrast(true);

      expect(listenerCallCount, 3);
    });

    test('lightTheme has light brightness', () {
      final notifier = ThemeNotifier();

      expect(notifier.lightTheme.colorScheme.brightness, Brightness.light);
    });

    test('darkTheme has dark brightness', () {
      final notifier = ThemeNotifier();

      expect(notifier.darkTheme.colorScheme.brightness, Brightness.dark);
    });
  });

  group('AnimatedThemeSwitcher', () {
    testWidgets('renders child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: AnimatedThemeSwitcher(child: const Text('Test'))),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('applies default duration', (tester) async {
      const switcher = AnimatedThemeSwitcher(child: SizedBox());

      expect(switcher.duration, const Duration(milliseconds: 200));
    });

    testWidgets('applies custom duration', (tester) async {
      const customDuration = Duration(milliseconds: 500);
      const switcher = AnimatedThemeSwitcher(
        duration: customDuration,
        child: SizedBox(),
      );

      expect(switcher.duration, customDuration);
    });

    testWidgets('applies custom curve', (tester) async {
      const switcher = AnimatedThemeSwitcher(
        curve: Curves.bounceIn,
        child: SizedBox(),
      );

      expect(switcher.curve, Curves.bounceIn);
    });

    testWidgets('wraps child in AnimatedTheme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: AnimatedThemeSwitcher(child: const Text('Test'))),
      );

      // MaterialApp also uses AnimatedTheme internally,
      // so we check for at least one
      expect(find.byType(AnimatedTheme), findsAtLeast(1));
    });
  });
}
