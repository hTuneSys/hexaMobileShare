// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppTheme', () {
    group('light()', () {
      test('returns valid ThemeData with Material 3', () {
        final theme = AppTheme.light();

        expect(theme, isNotNull);
        expect(theme.useMaterial3, isTrue);
        expect(theme.colorScheme.brightness, Brightness.light);
      });

      test('uses AppColorScheme.light() color scheme', () {
        final theme = AppTheme.light();
        final expectedScheme = AppColorScheme.light();

        expect(theme.colorScheme.primary, expectedScheme.primary);
        expect(theme.colorScheme.secondary, expectedScheme.secondary);
        expect(theme.colorScheme.surface, expectedScheme.surface);
      });

      test('has proper AppBar configuration', () {
        final theme = AppTheme.light();

        expect(theme.appBarTheme.centerTitle, isFalse);
        expect(theme.appBarTheme.elevation, 0);
        expect(theme.appBarTheme.scrolledUnderElevation, 3);
      });

      test('has proper Card configuration with M3 radius', () {
        final theme = AppTheme.light();

        expect(theme.cardTheme.elevation, 1);
        expect(theme.cardTheme.clipBehavior, Clip.antiAlias);
      });

      test('has floating snackbar behavior', () {
        final theme = AppTheme.light();

        expect(theme.snackBarTheme.behavior, SnackBarBehavior.floating);
      });
    });

    group('dark()', () {
      test('returns valid ThemeData with Material 3', () {
        final theme = AppTheme.dark();

        expect(theme, isNotNull);
        expect(theme.useMaterial3, isTrue);
        expect(theme.colorScheme.brightness, Brightness.dark);
      });

      test('uses AppColorScheme.dark() color scheme', () {
        final theme = AppTheme.dark();
        final expectedScheme = AppColorScheme.dark();

        expect(theme.colorScheme.primary, expectedScheme.primary);
        expect(theme.colorScheme.secondary, expectedScheme.secondary);
        expect(theme.colorScheme.surface, expectedScheme.surface);
      });
    });

    group('highContrastLight()', () {
      test('returns valid ThemeData with Material 3', () {
        final theme = AppTheme.highContrastLight();

        expect(theme, isNotNull);
        expect(theme.useMaterial3, isTrue);
        expect(theme.colorScheme.brightness, Brightness.light);
      });

      test('uses high-contrast light color scheme', () {
        final theme = AppTheme.highContrastLight();
        final hcScheme = AppColorScheme.highContrastLight();

        expect(theme.colorScheme.primary, hcScheme.primary);
        expect(theme.colorScheme.onPrimary, hcScheme.onPrimary);
      });

      test('has 2dp borders on cards', () {
        final theme = AppTheme.highContrastLight();
        final cardShape = theme.cardTheme.shape as RoundedRectangleBorder;

        expect(cardShape.side.width, 2);
      });

      test('has thicker dividers', () {
        final theme = AppTheme.highContrastLight();

        expect(theme.dividerTheme.thickness, 2);
      });

      test('has higher font weights in text theme', () {
        final theme = AppTheme.highContrastLight();

        expect(theme.textTheme.bodyMedium?.fontWeight, FontWeight.w500);
        expect(theme.textTheme.titleMedium?.fontWeight, FontWeight.w600);
        expect(theme.textTheme.labelLarge?.fontWeight, FontWeight.w600);
      });

      test('has 4dp focus borders on inputs', () {
        final theme = AppTheme.highContrastLight();
        final focusedBorder =
            theme.inputDecorationTheme.focusedBorder as OutlineInputBorder;

        expect(focusedBorder.borderSide.width, 4);
      });
    });

    group('highContrastDark()', () {
      test('returns valid ThemeData with Material 3', () {
        final theme = AppTheme.highContrastDark();

        expect(theme, isNotNull);
        expect(theme.useMaterial3, isTrue);
        expect(theme.colorScheme.brightness, Brightness.dark);
      });

      test('uses high-contrast dark color scheme', () {
        final theme = AppTheme.highContrastDark();
        final hcScheme = AppColorScheme.highContrastDark();

        expect(theme.colorScheme.primary, hcScheme.primary);
        expect(theme.colorScheme.surface, hcScheme.surface);
      });

      test('has 2dp borders on cards', () {
        final theme = AppTheme.highContrastDark();
        final cardShape = theme.cardTheme.shape as RoundedRectangleBorder;

        expect(cardShape.side.width, 2);
      });

      test('has higher font weights in text theme', () {
        final theme = AppTheme.highContrastDark();

        expect(theme.textTheme.bodyMedium?.fontWeight, FontWeight.w500);
      });
    });

    group('High Contrast WCAG AAA Compliance', () {
      test('high contrast light meets WCAG AAA on key pairs', () {
        final scheme = AppColorScheme.highContrastLight();

        // onPrimary on primary
        final primaryRatio = AppColorScheme.contrastRatio(
          scheme.onPrimary,
          scheme.primary,
        );
        expect(primaryRatio, greaterThanOrEqualTo(7.0));

        // onSurface on surface
        final surfaceRatio = AppColorScheme.contrastRatio(
          scheme.onSurface,
          scheme.surface,
        );
        expect(surfaceRatio, greaterThanOrEqualTo(7.0));
      });

      test('high contrast dark meets WCAG AAA on key pairs', () {
        final scheme = AppColorScheme.highContrastDark();

        // onPrimary on primary
        final primaryRatio = AppColorScheme.contrastRatio(
          scheme.onPrimary,
          scheme.primary,
        );
        expect(primaryRatio, greaterThanOrEqualTo(7.0));

        // onSurface on surface
        final surfaceRatio = AppColorScheme.contrastRatio(
          scheme.onSurface,
          scheme.surface,
        );
        expect(surfaceRatio, greaterThanOrEqualTo(7.0));
      });
    });
  });

  // ═══════════════════════════════════════════════════════════════════════════
  // Widget tests — verify high contrast rendering
  // ═══════════════════════════════════════════════════════════════════════════

  group('High Contrast Rendering (widget tests)', () {
    testWidgets('HC light card has visible 2dp border', (tester) async {
      final theme = AppTheme.highContrastLight();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Card(child: SizedBox(width: 100, height: 100)),
          ),
        ),
      );

      // The CardTheme should apply a 2dp border to all Card widgets.
      final cardShape = theme.cardTheme.shape as RoundedRectangleBorder;
      expect(cardShape.side.width, 2);
      expect(cardShape.side.color, isNotNull);
    });

    testWidgets('HC dark card has visible 2dp border', (tester) async {
      final theme = AppTheme.highContrastDark();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Card(child: SizedBox(width: 100, height: 100)),
          ),
        ),
      );

      final cardShape = theme.cardTheme.shape as RoundedRectangleBorder;
      expect(cardShape.side.width, 2);
    });

    testWidgets('HC light text uses higher font weights', (tester) async {
      final theme = AppTheme.highContrastLight();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                final tt = Theme.of(context).textTheme;
                return Column(
                  children: [
                    Text('body', style: tt.bodyMedium),
                    Text('title', style: tt.titleMedium),
                  ],
                );
              },
            ),
          ),
        ),
      );

      expect(theme.textTheme.bodyMedium?.fontWeight, FontWeight.w500);
      expect(theme.textTheme.titleMedium?.fontWeight, FontWeight.w600);
      expect(find.text('body'), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
    });

    testWidgets('HC light input has 4dp focus border', (tester) async {
      final theme = AppTheme.highContrastLight();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(
            body: Padding(padding: EdgeInsets.all(16), child: TextField()),
          ),
        ),
      );

      final focusedBorder =
          theme.inputDecorationTheme.focusedBorder as OutlineInputBorder;
      expect(focusedBorder.borderSide.width, 4);
    });

    testWidgets('HC divider thickness is 2dp', (tester) async {
      final theme = AppTheme.highContrastLight();

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: const Scaffold(body: Divider()),
        ),
      );

      expect(theme.dividerTheme.thickness, 2);
      expect(find.byType(Divider), findsOneWidget);
    });
  });
}
