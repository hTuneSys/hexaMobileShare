// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppTextTheme', () {
    group('merge', () {
      test('merges two TextThemes correctly', () {
        const baseTheme = TextTheme(
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        );

        const overrideTheme = TextTheme(
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        );

        final merged = AppTextTheme.merge(baseTheme, overrideTheme);

        // Override values should take precedence
        expect(merged.bodyLarge?.fontSize, 18);
        expect(merged.bodyLarge?.fontWeight, FontWeight.w600);

        // Base values should remain for non-overridden styles
        expect(merged.titleLarge?.fontSize, 22);
        expect(merged.titleLarge?.fontWeight, FontWeight.w400);
      });

      test('handles null values correctly', () {
        const baseTheme = TextTheme(bodyLarge: TextStyle(fontSize: 16));

        const overrideTheme = TextTheme();

        final merged = AppTextTheme.merge(baseTheme, overrideTheme);

        // Base values should remain when override is null
        expect(merged.bodyLarge?.fontSize, 16);
      });
    });

    group('responsive', () {
      testWidgets('scales text for small screens correctly', (tester) async {
        // Force small screen size (< 600px) BEFORE pumpWidget
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final responsiveTheme = AppTextTheme.responsive(context);
                final baseTheme = Theme.of(context).textTheme;

                // Small screens should have 0.9x scale
                final expectedSize =
                    (baseTheme.bodyLarge?.fontSize ?? 16) * 0.9;
                final actualSize = responsiveTheme.bodyLarge?.fontSize;

                expect(actualSize, closeTo(expectedSize, 0.1));

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('scales text for medium screens correctly', (tester) async {
        // Force medium screen size (600-1200px) BEFORE pumpWidget
        tester.view.physicalSize = const Size(800, 1200);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final responsiveTheme = AppTextTheme.responsive(context);
                final baseTheme = Theme.of(context).textTheme;

                // Medium screens should have 1.0x scale
                final expectedSize = baseTheme.bodyLarge?.fontSize ?? 16;
                final actualSize = responsiveTheme.bodyLarge?.fontSize;

                expect(actualSize, closeTo(expectedSize, 0.1));

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('scales text for large screens correctly', (tester) async {
        // Force large screen size (> 1200px) BEFORE pumpWidget
        tester.view.physicalSize = const Size(1400, 1000);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final responsiveTheme = AppTextTheme.responsive(context);
                final baseTheme = Theme.of(context).textTheme;

                // Large screens should have 1.1x scale
                final expectedSize =
                    (baseTheme.bodyLarge?.fontSize ?? 16) * 1.1;
                final actualSize = responsiveTheme.bodyLarge?.fontSize;

                expect(actualSize, closeTo(expectedSize, 0.1));

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('respects custom scale factor', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final responsiveTheme = AppTextTheme.responsive(
                  context,
                  scaleFactor: 1.5,
                );
                final baseTheme = Theme.of(context).textTheme;

                // Should apply custom scale factor
                final actualSize = responsiveTheme.bodyLarge?.fontSize;
                final baseSize = baseTheme.bodyLarge?.fontSize ?? 16;

                // Verify scale factor is applied
                expect(actualSize, greaterThan(baseSize));

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });
    });

    group('withFontFamily', () {
      test('applies font family to all text styles', () {
        const baseTheme = TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 22),
        );

        final customTheme = AppTextTheme.withFontFamily(
          baseTheme,
          'CustomFont',
        );

        expect(customTheme.bodyLarge?.fontFamily, 'CustomFont');
        expect(customTheme.titleLarge?.fontFamily, 'CustomFont');
      });

      test('preserves other style properties', () {
        const baseTheme = TextTheme(
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        );

        final customTheme = AppTextTheme.withFontFamily(
          baseTheme,
          'CustomFont',
        );

        expect(customTheme.bodyLarge?.fontSize, 16);
        expect(customTheme.bodyLarge?.fontWeight, FontWeight.bold);
      });
    });

    group('withColor', () {
      test('applies color to all text styles', () {
        const baseTheme = TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 22),
        );

        final coloredTheme = AppTextTheme.withColor(baseTheme, Colors.blue);

        expect(coloredTheme.bodyLarge?.color, Colors.blue);
        expect(coloredTheme.titleLarge?.color, Colors.blue);
      });

      test('preserves other style properties', () {
        const baseTheme = TextTheme(
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        );

        final coloredTheme = AppTextTheme.withColor(baseTheme, Colors.red);

        expect(coloredTheme.bodyLarge?.fontSize, 16);
        expect(coloredTheme.bodyLarge?.fontWeight, FontWeight.bold);
      });
    });

    group('debugStyles', () {
      testWidgets('returns all text theme styles', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final styles = AppTextTheme.debugStyles(context);

                // Check all expected style names are present
                expect(styles.containsKey('displayLarge'), true);
                expect(styles.containsKey('displayMedium'), true);
                expect(styles.containsKey('displaySmall'), true);
                expect(styles.containsKey('headlineLarge'), true);
                expect(styles.containsKey('headlineMedium'), true);
                expect(styles.containsKey('headlineSmall'), true);
                expect(styles.containsKey('titleLarge'), true);
                expect(styles.containsKey('titleMedium'), true);
                expect(styles.containsKey('titleSmall'), true);
                expect(styles.containsKey('bodyLarge'), true);
                expect(styles.containsKey('bodyMedium'), true);
                expect(styles.containsKey('bodySmall'), true);
                expect(styles.containsKey('labelLarge'), true);
                expect(styles.containsKey('labelMedium'), true);
                expect(styles.containsKey('labelSmall'), true);

                // Verify we have exactly 15 styles
                expect(styles.length, 15);

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('returns valid TextStyle objects', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final styles = AppTextTheme.debugStyles(context);

                // All styles should be non-null and have valid properties
                for (final entry in styles.entries) {
                  expect(entry.value, isNotNull);
                  expect(entry.value?.fontSize, isNotNull);
                  expect(entry.value?.fontSize, greaterThan(0));
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });
    });

    group('scaleStyle', () {
      test('scales font size correctly', () {
        const baseStyle = TextStyle(fontSize: 16);
        final scaledStyle = AppTextTheme.scaleStyle(baseStyle, 1.5);

        expect(scaledStyle.fontSize, 24); // 16 * 1.5
      });

      test('preserves other style properties', () {
        const baseStyle = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        );
        final scaledStyle = AppTextTheme.scaleStyle(baseStyle, 2.0);

        expect(scaledStyle.fontSize, 32);
        expect(scaledStyle.fontWeight, FontWeight.bold);
        expect(scaledStyle.color, Colors.blue);
      });

      test('handles null font size', () {
        const baseStyle = TextStyle();
        final scaledStyle = AppTextTheme.scaleStyle(baseStyle, 1.5);

        // Should use default size of 14.0
        expect(scaledStyle.fontSize, 21); // 14 * 1.5
      });
    });

    group('bold', () {
      test('makes text bold', () {
        const baseStyle = TextStyle(fontSize: 16);
        final boldStyle = AppTextTheme.bold(baseStyle);

        expect(boldStyle.fontWeight, FontWeight.bold);
      });

      test('preserves other style properties', () {
        const baseStyle = TextStyle(
          fontSize: 16,
          color: Colors.blue,
          fontStyle: FontStyle.italic,
        );
        final boldStyle = AppTextTheme.bold(baseStyle);

        expect(boldStyle.fontSize, 16);
        expect(boldStyle.color, Colors.blue);
        expect(boldStyle.fontStyle, FontStyle.italic);
      });
    });

    group('italic', () {
      test('makes text italic', () {
        const baseStyle = TextStyle(fontSize: 16);
        final italicStyle = AppTextTheme.italic(baseStyle);

        expect(italicStyle.fontStyle, FontStyle.italic);
      });

      test('preserves other style properties', () {
        const baseStyle = TextStyle(
          fontSize: 16,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        );
        final italicStyle = AppTextTheme.italic(baseStyle);

        expect(italicStyle.fontSize, 16);
        expect(italicStyle.color, Colors.blue);
        expect(italicStyle.fontWeight, FontWeight.bold);
      });
    });
  });

  group('TextThemeContext extension', () {
    testWidgets('provides quick access to TextTheme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              final textTheme = context.textTheme;
              final themeTextTheme = Theme.of(context).textTheme;

              // Should return the same TextTheme
              expect(textTheme, themeTextTheme);
              expect(textTheme.bodyLarge, themeTextTheme.bodyLarge);

              return const SizedBox.shrink();
            },
          ),
        ),
      );
    });
  });

  group('TextThemeExtensions', () {
    group('withScale', () {
      test('scales all text styles', () {
        const baseTheme = TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 22),
        );

        final scaledTheme = baseTheme.withScale(1.5);

        expect(scaledTheme.bodyLarge?.fontSize, 24); // 16 * 1.5
        expect(scaledTheme.titleLarge?.fontSize, 33); // 22 * 1.5
      });
    });

    group('withColor', () {
      test('applies color to all styles', () {
        const baseTheme = TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 22),
        );

        final coloredTheme = baseTheme.withColor(Colors.red);

        expect(coloredTheme.bodyLarge?.color, Colors.red);
        expect(coloredTheme.titleLarge?.color, Colors.red);
      });
    });

    group('withFontFamily', () {
      test('applies font family to all styles', () {
        const baseTheme = TextTheme(
          bodyLarge: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 22),
        );

        final customTheme = baseTheme.withFontFamily('CustomFont');

        expect(customTheme.bodyLarge?.fontFamily, 'CustomFont');
        expect(customTheme.titleLarge?.fontFamily, 'CustomFont');
      });
    });
  });
}
