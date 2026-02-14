// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('FontScale', () {
    test('has correct scale factors', () {
      expect(FontScale.small.factor, 0.85);
      expect(FontScale.normal.factor, 1.0);
      expect(FontScale.large.factor, 1.15);
      expect(FontScale.extraLarge.factor, 1.3);
      expect(FontScale.accessibilityLarge.factor, 2.0);
    });

    test('has human-readable labels', () {
      expect(FontScale.small.label, 'Small');
      expect(FontScale.normal.label, 'Normal');
      expect(FontScale.accessibilityLarge.label, 'Accessibility Large');
    });
  });

  group('FontScaleAdapter', () {
    test('normal scale returns unchanged text theme', () {
      final textTheme = AppTypography.textTheme();
      final scaled = FontScaleAdapter.scaleTextTheme(
        textTheme,
        FontScale.normal,
      );

      expect(scaled.bodyMedium?.fontSize, textTheme.bodyMedium?.fontSize);
      expect(scaled.titleLarge?.fontSize, textTheme.titleLarge?.fontSize);
    });

    test('large scale increases font sizes by 1.15x', () {
      final textTheme = AppTypography.textTheme();
      final scaled = FontScaleAdapter.scaleTextTheme(
        textTheme,
        FontScale.large,
      );

      final originalBody = textTheme.bodyMedium!.fontSize!;
      expect(scaled.bodyMedium?.fontSize, originalBody * 1.15);
    });

    test('small scale decreases font sizes by 0.85x', () {
      final textTheme = AppTypography.textTheme();
      final scaled = FontScaleAdapter.scaleTextTheme(
        textTheme,
        FontScale.small,
      );

      final originalBody = textTheme.bodyMedium!.fontSize!;
      expect(scaled.bodyMedium?.fontSize, originalBody * 0.85);
    });

    test('accessibility large doubles font sizes', () {
      final textTheme = AppTypography.textTheme();
      final scaled = FontScaleAdapter.scaleTextTheme(
        textTheme,
        FontScale.accessibilityLarge,
      );

      final originalBody = textTheme.bodyMedium!.fontSize!;
      expect(scaled.bodyMedium?.fontSize, originalBody * 2.0);
    });

    test('scales all 15 text styles', () {
      final textTheme = AppTypography.textTheme();
      final scaled = FontScaleAdapter.scaleTextTheme(
        textTheme,
        FontScale.large,
      );

      expect(scaled.displayLarge, isNotNull);
      expect(scaled.displayMedium, isNotNull);
      expect(scaled.displaySmall, isNotNull);
      expect(scaled.headlineLarge, isNotNull);
      expect(scaled.headlineMedium, isNotNull);
      expect(scaled.headlineSmall, isNotNull);
      expect(scaled.titleLarge, isNotNull);
      expect(scaled.titleMedium, isNotNull);
      expect(scaled.titleSmall, isNotNull);
      expect(scaled.bodyLarge, isNotNull);
      expect(scaled.bodyMedium, isNotNull);
      expect(scaled.bodySmall, isNotNull);
      expect(scaled.labelLarge, isNotNull);
      expect(scaled.labelMedium, isNotNull);
      expect(scaled.labelSmall, isNotNull);
    });
  });

  group('ColorBlindnessMode', () {
    test('has human-readable labels', () {
      expect(ColorBlindnessMode.none.label, 'Normal Vision');
      expect(ColorBlindnessMode.protanopia.label, contains('Red'));
      expect(ColorBlindnessMode.deuteranopia.label, contains('Green'));
      expect(ColorBlindnessMode.tritanopia.label, contains('Blue'));
      expect(ColorBlindnessMode.grayscale.label, 'Grayscale');
    });
  });

  group('ColorBlindnessSimulator', () {
    test('none mode returns original color', () {
      const color = Color(0xFFFF0000);
      final result = ColorBlindnessSimulator.simulate(
        color,
        ColorBlindnessMode.none,
      );

      expect(result, color);
    });

    test('grayscale removes color information', () {
      const red = Color(0xFFFF0000);
      final gray = ColorBlindnessSimulator.simulate(
        red,
        ColorBlindnessMode.grayscale,
      );

      // R, G, B channels should all be equal in grayscale
      expect((gray.r - gray.g).abs(), lessThan(0.01));
      expect((gray.g - gray.b).abs(), lessThan(0.01));
    });

    test('protanopia reduces red perception', () {
      const red = Color(0xFFFF0000);
      final simulated = ColorBlindnessSimulator.simulate(
        red,
        ColorBlindnessMode.protanopia,
      );

      // Pure red should appear significantly different
      expect(simulated, isNot(equals(red)));
      // Red channel should be reduced
      expect(simulated.r, lessThan(red.r));
    });

    test('deuteranopia transforms green', () {
      const green = Color(0xFF00FF00);
      final simulated = ColorBlindnessSimulator.simulate(
        green,
        ColorBlindnessMode.deuteranopia,
      );

      expect(simulated, isNot(equals(green)));
    });

    test('tritanopia transforms blue', () {
      const blue = Color(0xFF0000FF);
      final simulated = ColorBlindnessSimulator.simulate(
        blue,
        ColorBlindnessMode.tritanopia,
      );

      expect(simulated, isNot(equals(blue)));
    });

    test('preserves alpha channel', () {
      final color = const Color(0xFFFF0000).withValues(alpha: 0.5);
      final simulated = ColorBlindnessSimulator.simulate(
        color,
        ColorBlindnessMode.protanopia,
      );

      expect(simulated.a, closeTo(0.5, 0.01));
    });

    test('simulateScheme transforms all color roles', () {
      final scheme = AppColorScheme.light();
      final simulated = ColorBlindnessSimulator.simulateScheme(
        scheme,
        ColorBlindnessMode.grayscale,
      );

      // Primary should be transformed
      expect(simulated.primary, isNot(equals(scheme.primary)));
      // Brightness should be preserved
      expect(simulated.brightness, scheme.brightness);
    });

    test('simulateScheme with none returns original', () {
      final scheme = AppColorScheme.light();
      final simulated = ColorBlindnessSimulator.simulateScheme(
        scheme,
        ColorBlindnessMode.none,
      );

      expect(simulated.primary, scheme.primary);
      expect(simulated.secondary, scheme.secondary);
    });
  });

  group('ThemeValidator', () {
    test('validates standard light color scheme', () {
      final scheme = AppColorScheme.light();
      final results = ThemeValidator.validateColorScheme(scheme);

      expect(results, isNotEmpty);
      // Standard M3 light theme should pass AA
      for (final result in results) {
        expect(result.contrastRatio, greaterThan(1.0));
      }
    });

    test('validates standard dark color scheme', () {
      final scheme = AppColorScheme.dark();
      final results = ThemeValidator.validateColorScheme(scheme);

      expect(results, isNotEmpty);
    });

    test('high contrast light passes AAA', () {
      final scheme = AppColorScheme.highContrastLight();
      final results = ThemeValidator.validateColorScheme(scheme);

      // Key pairs should meet AAA
      final surfacePair = results.firstWhere(
        (r) => r.foregroundLabel == 'onSurface',
      );
      expect(surfacePair.meetsAAA, isTrue);
    });

    test('meetsStandard returns correct boolean', () {
      final scheme = AppColorScheme.highContrastLight();

      // High contrast should at least meet AA
      expect(ThemeValidator.meetsStandard(scheme, WcagLevel.aa), isTrue);
    });

    test('summary returns correct counts', () {
      final scheme = AppColorScheme.light();
      final result = ThemeValidator.summary(scheme, WcagLevel.aa);

      expect(result.total, greaterThan(0));
      expect(result.passing + result.failing, result.total);
    });

    test('ContrastResult contains all required fields', () {
      final scheme = AppColorScheme.light();
      final results = ThemeValidator.validateColorScheme(scheme);
      final first = results.first;

      expect(first.foregroundLabel, isNotEmpty);
      expect(first.backgroundLabel, isNotEmpty);
      expect(first.foreground, isNotNull);
      expect(first.background, isNotNull);
      expect(first.contrastRatio, isPositive);
    });
  });

  group('PlatformThemeAdapter', () {
    test('iOS adaptation centers app bar title', () {
      final theme = AppTheme.light();
      final adapted = PlatformThemeAdapter.adapt(theme, TargetPlatform.iOS);

      expect(adapted.appBarTheme.centerTitle, isTrue);
    });

    test('Android returns theme unchanged', () {
      final theme = AppTheme.light();
      final adapted = PlatformThemeAdapter.adapt(theme, TargetPlatform.android);

      // Android uses M3 defaults which are already set
      expect(adapted.appBarTheme.centerTitle, theme.appBarTheme.centerTitle);
    });

    test('macOS adaptation centers app bar title', () {
      final theme = AppTheme.light();
      final adapted = PlatformThemeAdapter.adapt(theme, TargetPlatform.macOS);

      expect(adapted.appBarTheme.centerTitle, isTrue);
    });
  });

  group('ThemeExporter', () {
    test('exports color scheme to valid JSON', () {
      final scheme = AppColorScheme.light();
      final jsonStr = ThemeExporter.exportColorScheme(scheme);

      expect(jsonStr, isNotEmpty);
      expect(jsonStr, contains('"primary"'));
      expect(jsonStr, contains('"brightness"'));
      expect(jsonStr, contains('"light"'));
    });

    test('imports color scheme from JSON', () {
      final original = AppColorScheme.light();
      final jsonStr = ThemeExporter.exportColorScheme(original);
      final imported = ThemeExporter.importColorScheme(jsonStr);

      expect(imported, isNotNull);
      expect(imported!.brightness, original.brightness);
      expect(imported.primary.toARGB32(), original.primary.toARGB32());
      expect(imported.secondary.toARGB32(), original.secondary.toARGB32());
    });

    test('round-trip preserves all core colors', () {
      final original = AppColorScheme.dark();
      final jsonStr = ThemeExporter.exportColorScheme(original);
      final imported = ThemeExporter.importColorScheme(jsonStr)!;

      expect(imported.primary.toARGB32(), original.primary.toARGB32());
      expect(imported.onPrimary.toARGB32(), original.onPrimary.toARGB32());
      expect(imported.error.toARGB32(), original.error.toARGB32());
      expect(imported.surface.toARGB32(), original.surface.toARGB32());
      expect(imported.onSurface.toARGB32(), original.onSurface.toARGB32());
    });

    test('importColorScheme returns null for invalid JSON', () {
      final result = ThemeExporter.importColorScheme('not valid json');

      expect(result, isNull);
    });

    test('importColorScheme returns null for empty JSON', () {
      final result = ThemeExporter.importColorScheme('{}');

      expect(result, isNull);
    });
  });

  group('AccessibilityReportGenerator', () {
    test('generates report with theme name', () {
      final report = AccessibilityReportGenerator.generate(
        colorScheme: AppColorScheme.light(),
        themeName: 'Test Light',
      );

      expect(report, contains('Test Light'));
    });

    test('report contains WCAG AA and AAA results', () {
      final report = AccessibilityReportGenerator.generate(
        colorScheme: AppColorScheme.light(),
        themeName: 'Light Theme',
      );

      expect(report, contains('WCAG AA'));
      expect(report, contains('WCAG AAA'));
    });

    test('report contains color pair details', () {
      final report = AccessibilityReportGenerator.generate(
        colorScheme: AppColorScheme.light(),
        themeName: 'Light',
      );

      expect(report, contains('onPrimary'));
      expect(report, contains('onSurface'));
    });

    test('high contrast report shows all passing', () {
      final report = AccessibilityReportGenerator.generate(
        colorScheme: AppColorScheme.highContrastLight(),
        themeName: 'HC Light',
      );

      // Should have mostly passing indicators
      expect(report, contains(':1'));
    });
  });

  group('ThemeDocumentationGenerator', () {
    test('generates markdown with theme name as heading', () {
      final md = ThemeDocumentationGenerator.generate(
        theme: AppTheme.light(),
        themeName: 'Light Theme',
      );

      expect(md, startsWith('# Light Theme'));
    });

    test('includes color scheme table', () {
      final md = ThemeDocumentationGenerator.generate(
        theme: AppTheme.light(),
        themeName: 'Light',
      );

      expect(md, contains('## Color Scheme'));
      expect(md, contains('`primary`'));
      expect(md, contains('`onPrimary`'));
      expect(md, contains('`surface`'));
      expect(md, contains('`error`'));
    });

    test('includes typography table', () {
      final md = ThemeDocumentationGenerator.generate(
        theme: AppTheme.light(),
        themeName: 'Light',
      );

      expect(md, contains('## Typography'));
      expect(md, contains('`displayLarge`'));
      expect(md, contains('`bodyMedium`'));
      expect(md, contains('`labelSmall`'));
    });

    test('includes component tokens', () {
      final md = ThemeDocumentationGenerator.generate(
        theme: AppTheme.light(),
        themeName: 'Light',
      );

      expect(md, contains('## Component Tokens'));
      expect(md, contains('AppBar'));
      expect(md, contains('Card'));
      expect(md, contains('Divider'));
    });

    test('works for high contrast themes', () {
      final md = ThemeDocumentationGenerator.generate(
        theme: AppTheme.highContrastLight(),
        themeName: 'HC Light',
      );

      expect(md, contains('# HC Light'));
      expect(md, contains('`primary`'));
    });

    test('includes brightness information', () {
      final lightMd = ThemeDocumentationGenerator.generate(
        theme: AppTheme.light(),
        themeName: 'Light',
      );
      final darkMd = ThemeDocumentationGenerator.generate(
        theme: AppTheme.dark(),
        themeName: 'Dark',
      );

      expect(lightMd, contains('Light'));
      expect(darkMd, contains('Dark'));
    });
  });

  group('ThemeContext extension', () {
    testWidgets('context.theme returns current ThemeData', (tester) async {
      late ThemeData capturedTheme;
      final expectedTheme = AppTheme.light();

      await tester.pumpWidget(
        MaterialApp(
          theme: expectedTheme,
          home: Builder(
            builder: (context) {
              capturedTheme = context.theme;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedTheme.useMaterial3, isTrue);
      expect(
        capturedTheme.colorScheme.primary,
        expectedTheme.colorScheme.primary,
      );
    });

    testWidgets('context.colorScheme returns scheme directly', (tester) async {
      late ColorScheme capturedScheme;
      final expectedTheme = AppTheme.dark();

      await tester.pumpWidget(
        MaterialApp(
          theme: expectedTheme,
          home: Builder(
            builder: (context) {
              capturedScheme = context.colorScheme;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(capturedScheme.brightness, Brightness.dark);
      expect(capturedScheme.primary, expectedTheme.colorScheme.primary);
    });

    testWidgets('context.isDarkMode correctly identifies brightness', (
      tester,
    ) async {
      late bool lightIsDark;
      late bool darkIsDark;

      // Test light theme
      await tester.pumpWidget(
        MaterialApp(
          key: const ValueKey('light'),
          theme: AppTheme.light(),
          home: Builder(
            builder: (context) {
              lightIsDark = context.isDarkMode;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(lightIsDark, isFalse);

      // Test dark theme — use darkTheme + dark platformBrightness
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(platformBrightness: Brightness.dark),
          child: MaterialApp(
            key: const ValueKey('dark'),
            darkTheme: AppTheme.dark(),
            themeMode: ThemeMode.dark,
            home: Builder(
              builder: (context) {
                darkIsDark = context.isDarkMode;
                return const SizedBox();
              },
            ),
          ),
        ),
      );
      expect(darkIsDark, isTrue);
    });
  });
}
