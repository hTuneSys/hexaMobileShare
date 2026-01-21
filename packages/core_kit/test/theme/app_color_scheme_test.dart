// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppColorScheme', () {
    group('Light Theme', () {
      testWidgets('light() returns valid ColorScheme', (tester) async {
        final colorScheme = AppColorScheme.light();

        expect(colorScheme, isNotNull);
        expect(colorScheme.brightness, Brightness.light);
      });

      testWidgets('light() has all required M3 colors defined', (tester) async {
        final colorScheme = AppColorScheme.light();

        // Primary family
        expect(colorScheme.primary, isNotNull);
        expect(colorScheme.onPrimary, isNotNull);
        expect(colorScheme.primaryContainer, isNotNull);
        expect(colorScheme.onPrimaryContainer, isNotNull);

        // Secondary family
        expect(colorScheme.secondary, isNotNull);
        expect(colorScheme.onSecondary, isNotNull);
        expect(colorScheme.secondaryContainer, isNotNull);
        expect(colorScheme.onSecondaryContainer, isNotNull);

        // Tertiary family
        expect(colorScheme.tertiary, isNotNull);
        expect(colorScheme.onTertiary, isNotNull);
        expect(colorScheme.tertiaryContainer, isNotNull);
        expect(colorScheme.onTertiaryContainer, isNotNull);

        // Error family
        expect(colorScheme.error, isNotNull);
        expect(colorScheme.onError, isNotNull);
        expect(colorScheme.errorContainer, isNotNull);
        expect(colorScheme.onErrorContainer, isNotNull);
      });

      testWidgets('light() has all M3 surface variants', (tester) async {
        final colorScheme = AppColorScheme.light();

        expect(colorScheme.surface, isNotNull);
        expect(colorScheme.onSurface, isNotNull);
        expect(colorScheme.surfaceBright, isNotNull);
        expect(colorScheme.surfaceDim, isNotNull);
        expect(colorScheme.surfaceContainer, isNotNull);
        expect(colorScheme.surfaceContainerLow, isNotNull);
        expect(colorScheme.surfaceContainerLowest, isNotNull);
        expect(colorScheme.surfaceContainerHigh, isNotNull);
        expect(colorScheme.surfaceContainerHighest, isNotNull);
      });

      testWidgets('light() has outline colors', (tester) async {
        final colorScheme = AppColorScheme.light();

        expect(colorScheme.outline, isNotNull);
        expect(colorScheme.outlineVariant, isNotNull);
      });
    });

    group('Dark Theme', () {
      testWidgets('dark() returns valid ColorScheme', (tester) async {
        final colorScheme = AppColorScheme.dark();

        expect(colorScheme, isNotNull);
        expect(colorScheme.brightness, Brightness.dark);
      });

      testWidgets('dark() has all required M3 colors defined', (tester) async {
        final colorScheme = AppColorScheme.dark();

        // Primary family
        expect(colorScheme.primary, isNotNull);
        expect(colorScheme.onPrimary, isNotNull);
        expect(colorScheme.primaryContainer, isNotNull);
        expect(colorScheme.onPrimaryContainer, isNotNull);

        // Secondary family
        expect(colorScheme.secondary, isNotNull);
        expect(colorScheme.onSecondary, isNotNull);
        expect(colorScheme.secondaryContainer, isNotNull);
        expect(colorScheme.onSecondaryContainer, isNotNull);

        // Tertiary family
        expect(colorScheme.tertiary, isNotNull);
        expect(colorScheme.onTertiary, isNotNull);
        expect(colorScheme.tertiaryContainer, isNotNull);
        expect(colorScheme.onTertiaryContainer, isNotNull);

        // Error family
        expect(colorScheme.error, isNotNull);
        expect(colorScheme.onError, isNotNull);
        expect(colorScheme.errorContainer, isNotNull);
        expect(colorScheme.onErrorContainer, isNotNull);
      });

      testWidgets('dark() has all M3 surface variants', (tester) async {
        final colorScheme = AppColorScheme.dark();

        expect(colorScheme.surface, isNotNull);
        expect(colorScheme.onSurface, isNotNull);
        expect(colorScheme.surfaceBright, isNotNull);
        expect(colorScheme.surfaceDim, isNotNull);
        expect(colorScheme.surfaceContainer, isNotNull);
        expect(colorScheme.surfaceContainerLow, isNotNull);
        expect(colorScheme.surfaceContainerLowest, isNotNull);
        expect(colorScheme.surfaceContainerHigh, isNotNull);
        expect(colorScheme.surfaceContainerHighest, isNotNull);
      });
    });

    group('CustomColors Extension', () {
      group('Light Theme', () {
        testWidgets('has success colors defined', (tester) async {
          final colorScheme = AppColorScheme.light();

          expect(colorScheme.success, isNotNull);
          expect(colorScheme.onSuccess, isNotNull);
          expect(colorScheme.successContainer, isNotNull);
          expect(colorScheme.onSuccessContainer, isNotNull);
        });

        testWidgets('has warning colors defined', (tester) async {
          final colorScheme = AppColorScheme.light();

          expect(colorScheme.warning, isNotNull);
          expect(colorScheme.onWarning, isNotNull);
          expect(colorScheme.warningContainer, isNotNull);
          expect(colorScheme.onWarningContainer, isNotNull);
        });

        testWidgets('has info colors defined', (tester) async {
          final colorScheme = AppColorScheme.light();

          expect(colorScheme.info, isNotNull);
          expect(colorScheme.onInfo, isNotNull);
          expect(colorScheme.infoContainer, isNotNull);
          expect(colorScheme.onInfoContainer, isNotNull);
        });
      });

      group('Dark Theme', () {
        testWidgets('has success colors defined', (tester) async {
          final colorScheme = AppColorScheme.dark();

          expect(colorScheme.success, isNotNull);
          expect(colorScheme.onSuccess, isNotNull);
          expect(colorScheme.successContainer, isNotNull);
          expect(colorScheme.onSuccessContainer, isNotNull);
        });

        testWidgets('has warning colors defined', (tester) async {
          final colorScheme = AppColorScheme.dark();

          expect(colorScheme.warning, isNotNull);
          expect(colorScheme.onWarning, isNotNull);
          expect(colorScheme.warningContainer, isNotNull);
          expect(colorScheme.onWarningContainer, isNotNull);
        });

        testWidgets('has info colors defined', (tester) async {
          final colorScheme = AppColorScheme.dark();

          expect(colorScheme.info, isNotNull);
          expect(colorScheme.onInfo, isNotNull);
          expect(colorScheme.infoContainer, isNotNull);
          expect(colorScheme.onInfoContainer, isNotNull);
        });
      });

      testWidgets('semantic colors differ between light and dark', (
        tester,
      ) async {
        final light = AppColorScheme.light();
        final dark = AppColorScheme.dark();

        expect(light.success, isNot(equals(dark.success)));
        expect(light.warning, isNot(equals(dark.warning)));
        expect(light.info, isNot(equals(dark.info)));
      });
    });

    group('Color Utility Methods', () {
      testWidgets('lighten() increases color lightness', (tester) async {
        const baseColor = Color(0xFF0000FF); // Blue
        final lightened = AppColorScheme.lighten(baseColor, 0.2);

        final baseHSL = HSLColor.fromColor(baseColor);
        final lightenedHSL = HSLColor.fromColor(lightened);

        expect(lightenedHSL.lightness, greaterThan(baseHSL.lightness));
      });

      testWidgets('lighten() with 0 amount returns similar color', (
        tester,
      ) async {
        const baseColor = Color(0xFF00FF00); // Green
        final result = AppColorScheme.lighten(baseColor, 0.0);

        expect(result.toARGB32(), equals(baseColor.toARGB32()));
      });

      testWidgets('darken() decreases color lightness', (tester) async {
        const baseColor = Color(0xFF0000FF); // Blue
        final darkened = AppColorScheme.darken(baseColor, 0.2);

        final baseHSL = HSLColor.fromColor(baseColor);
        final darkenedHSL = HSLColor.fromColor(darkened);

        expect(darkenedHSL.lightness, lessThan(baseHSL.lightness));
      });

      testWidgets('darken() with 0 amount returns similar color', (
        tester,
      ) async {
        const baseColor = Color(0xFFFF0000); // Red
        final result = AppColorScheme.darken(baseColor, 0.0);

        expect(result.toARGB32(), equals(baseColor.toARGB32()));
      });

      testWidgets('withOpacityValue() applies correct opacity', (tester) async {
        const baseColor = Color(0xFF0000FF); // Blue (fully opaque)
        final withOpacity = AppColorScheme.withOpacityValue(baseColor, 0.5);

        expect(
          withOpacity.a,
          closeTo(0.5, 0.01),
        ); // Allow small precision difference
        expect(
          (withOpacity.r * 255.0).round(),
          equals((baseColor.r * 255.0).round()),
        );
        expect(
          (withOpacity.g * 255.0).round(),
          equals((baseColor.g * 255.0).round()),
        );
        expect(
          (withOpacity.b * 255.0).round(),
          equals((baseColor.b * 255.0).round()),
        );
      });

      testWidgets('withOpacityValue() with 1.0 keeps color opaque', (
        tester,
      ) async {
        const baseColor = Color(0xFF00FF00); // Green
        final result = AppColorScheme.withOpacityValue(baseColor, 1.0);

        expect(result.a, equals(1.0));
      });

      testWidgets('withOpacityValue() with 0.0 makes color transparent', (
        tester,
      ) async {
        const baseColor = Color(0xFFFF0000); // Red
        final result = AppColorScheme.withOpacityValue(baseColor, 0.0);

        expect(result.a, equals(0.0));
      });
    });

    group('Contrast Ratio Calculations', () {
      testWidgets(
        'contrastRatio() calculates maximum contrast for black/white',
        (tester) async {
          final ratio = AppColorScheme.contrastRatio(
            Colors.black,
            Colors.white,
          );

          expect(ratio, closeTo(21.0, 0.1)); // Maximum contrast
        },
      );

      testWidgets(
        'contrastRatio() calculates minimum contrast for same colors',
        (tester) async {
          final ratio = AppColorScheme.contrastRatio(Colors.blue, Colors.blue);

          expect(ratio, equals(1.0)); // No contrast
        },
      );

      testWidgets('contrastRatio() is symmetric', (tester) async {
        const fg = Color(0xFF0000FF);
        const bg = Color(0xFFFFFFFF);

        final ratio1 = AppColorScheme.contrastRatio(fg, bg);
        final ratio2 = AppColorScheme.contrastRatio(bg, fg);

        expect(ratio1, equals(ratio2));
      });

      testWidgets('primary/onPrimary meets WCAG AA standard (light)', (
        tester,
      ) async {
        final colorScheme = AppColorScheme.light();
        final ratio = AppColorScheme.contrastRatio(
          colorScheme.onPrimary,
          colorScheme.primary,
        );

        expect(ratio, greaterThanOrEqualTo(4.5)); // WCAG AA minimum
      });

      testWidgets('primary/onPrimary meets WCAG AA standard (dark)', (
        tester,
      ) async {
        final colorScheme = AppColorScheme.dark();
        final ratio = AppColorScheme.contrastRatio(
          colorScheme.onPrimary,
          colorScheme.primary,
        );

        expect(ratio, greaterThanOrEqualTo(4.5)); // WCAG AA minimum
      });

      testWidgets('error/onError meets WCAG AA standard (light)', (
        tester,
      ) async {
        final colorScheme = AppColorScheme.light();
        final ratio = AppColorScheme.contrastRatio(
          colorScheme.onError,
          colorScheme.error,
        );

        expect(ratio, greaterThanOrEqualTo(4.5)); // WCAG AA minimum
      });

      testWidgets('success/onSuccess meets WCAG AA standard (light)', (
        tester,
      ) async {
        final colorScheme = AppColorScheme.light();
        final ratio = AppColorScheme.contrastRatio(
          colorScheme.onSuccess,
          colorScheme.success,
        );

        expect(ratio, greaterThanOrEqualTo(4.5)); // WCAG AA minimum
      });
    });

    group('Theme Integration', () {
      testWidgets('light() works with ThemeData', (tester) async {
        final theme = ThemeData(
          colorScheme: AppColorScheme.light(),
          useMaterial3: true,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: const Scaffold(body: Text('Test')),
          ),
        );

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('dark() works with ThemeData', (tester) async {
        final theme = ThemeData(
          colorScheme: AppColorScheme.dark(),
          useMaterial3: true,
        );

        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: const Scaffold(body: Text('Test')),
          ),
        );

        expect(find.text('Test'), findsOneWidget);
      });
    });
  });
}
