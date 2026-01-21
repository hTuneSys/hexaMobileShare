// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/theme/app_shadows.dart';

void main() {
  group('AppShadows', () {
    // ==================== Shadow Level Tests ====================

    group('Shadow Levels', () {
      test('none should be empty list', () {
        expect(AppShadows.none, isEmpty);
      });

      test('sm should have 2 shadows (Level 1)', () {
        expect(AppShadows.sm, hasLength(2));
        expect(AppShadows.sm[0].offset, const Offset(0, 1));
        expect(AppShadows.sm[0].blurRadius, 2);
      });

      test('md should have 2 shadows (Level 2)', () {
        expect(AppShadows.md, hasLength(2));
        expect(AppShadows.md[1].offset, const Offset(0, 2));
        expect(AppShadows.md[1].blurRadius, 6);
      });

      test('lg should have 2 shadows (Level 3)', () {
        expect(AppShadows.lg, hasLength(2));
        expect(AppShadows.lg[1].offset, const Offset(0, 4));
        expect(AppShadows.lg[1].blurRadius, 8);
      });

      test('xl should have 2 shadows (Level 4)', () {
        expect(AppShadows.xl, hasLength(2));
        expect(AppShadows.xl[1].offset, const Offset(0, 8));
        expect(AppShadows.xl[1].blurRadius, 12);
      });

      test('xxl should have 2 shadows (Level 5)', () {
        expect(AppShadows.xxl, hasLength(2));
        expect(AppShadows.xxl[1].offset, const Offset(0, 12));
        expect(AppShadows.xxl[1].blurRadius, 16);
      });
    });

    // ==================== Elevation Helper Tests ====================

    group('Elevation Helpers', () {
      test('forLevel returns correct shadows for each level', () {
        expect(AppShadows.forLevel(0), equals(AppShadows.none));
        expect(AppShadows.forLevel(1), equals(AppShadows.sm));
        expect(AppShadows.forLevel(2), equals(AppShadows.md));
        expect(AppShadows.forLevel(3), equals(AppShadows.lg));
        expect(AppShadows.forLevel(4), equals(AppShadows.xl));
        expect(AppShadows.forLevel(5), equals(AppShadows.xxl));
      });

      test('forLevel returns none for invalid levels', () {
        expect(AppShadows.forLevel(-1), equals(AppShadows.none));
        expect(AppShadows.forLevel(6), equals(AppShadows.none));
        expect(AppShadows.forLevel(100), equals(AppShadows.none));
      });

      test('levelName returns correct names', () {
        expect(AppShadows.levelName(0), 'none');
        expect(AppShadows.levelName(1), 'sm');
        expect(AppShadows.levelName(2), 'md');
        expect(AppShadows.levelName(3), 'lg');
        expect(AppShadows.levelName(4), 'xl');
        expect(AppShadows.levelName(5), 'xxl');
      });

      test('levelName returns none for invalid levels', () {
        expect(AppShadows.levelName(-1), 'none');
        expect(AppShadows.levelName(6), 'none');
        expect(AppShadows.levelName(100), 'none');
      });
    });

    // ==================== M3 Surface Tint Tests ====================

    group('M3 Surface Tint', () {
      testWidgets('getSurfaceTint returns transparent for level 0', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            home: Builder(
              builder: (context) {
                final tint = AppShadows.getSurfaceTint(context, 0);
                expect(tint, Colors.transparent);
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('getSurfaceTint returns transparent for invalid levels', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            home: Builder(
              builder: (context) {
                expect(
                  AppShadows.getSurfaceTint(context, -1),
                  Colors.transparent,
                );
                expect(
                  AppShadows.getSurfaceTint(context, 6),
                  Colors.transparent,
                );
                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets(
        'getSurfaceTint returns primary color with opacity in light mode',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData.light(useMaterial3: true),
              home: Builder(
                builder: (context) {
                  final tint = AppShadows.getSurfaceTint(context, 3);

                  // Verify opacity is applied (Level 3 light mode = 8%)
                  expect(tint.a, closeTo(0.08, 0.001));

                  // Verify tint is not transparent
                  expect(tint, isNot(Colors.transparent));

                  return const SizedBox();
                },
              ),
            ),
          );
        },
      );

      testWidgets('getSurfaceTint has higher opacity in dark mode', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(useMaterial3: true),
            home: Builder(
              builder: (context) {
                final tint = AppShadows.getSurfaceTint(context, 3);

                // Level 3 dark mode should have 12% opacity
                expect(tint.a, closeTo(0.12, 0.001));

                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('getSurfaceTint opacity increases with level', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            home: Builder(
              builder: (context) {
                final tint1 = AppShadows.getSurfaceTint(context, 1);
                final tint2 = AppShadows.getSurfaceTint(context, 2);
                final tint3 = AppShadows.getSurfaceTint(context, 3);

                // Opacity should increase: Level 1 < Level 2 < Level 3
                expect(tint1.a, lessThan(tint2.a));
                expect(tint2.a, lessThan(tint3.a));

                return const SizedBox();
              },
            ),
          ),
        );
      });
    });

    // ==================== BoxDecoration Helper Tests ====================

    group('BoxDecoration Helpers', () {
      testWidgets('decorationWithTint combines shadows and tint', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            home: Builder(
              builder: (context) {
                final decoration = AppShadows.decorationWithTint(
                  context: context,
                  level: 3,
                );

                // Verify shadows are applied
                expect(decoration.boxShadow, isNotNull);
                expect(decoration.boxShadow, equals(AppShadows.lg));

                // Verify color is applied (blended with tint)
                expect(decoration.color, isNotNull);

                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('decorationWithTint uses custom background color', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            home: Builder(
              builder: (context) {
                const customColor = Colors.amber;
                final decoration = AppShadows.decorationWithTint(
                  context: context,
                  level: 2,
                  backgroundColor: customColor,
                );

                // Color should be blended with tint, not exactly custom color
                expect(decoration.color, isNot(customColor));
                expect(decoration.color, isNotNull);

                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('decorationWithTint applies border radius', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            home: Builder(
              builder: (context) {
                final borderRadius = BorderRadius.circular(16);
                final decoration = AppShadows.decorationWithTint(
                  context: context,
                  level: 2,
                  borderRadius: borderRadius,
                );

                expect(decoration.borderRadius, equals(borderRadius));

                return const SizedBox();
              },
            ),
          ),
        );
      });

      testWidgets('decorationWithTint uses surface color by default', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            home: Builder(
              builder: (context) {
                final decoration = AppShadows.decorationWithTint(
                  context: context,
                  level: 1,
                );

                // Color should be based on surface color (blended with tint)
                expect(decoration.color, isNotNull);

                return const SizedBox();
              },
            ),
          ),
        );
      });
    });

    // ==================== Animation Helper Tests ====================

    group('Animation Helpers', () {
      test('lerpLevel interpolates between shadow levels', () {
        // Lerp from Level 1 to Level 3 at 50%
        final interpolated = AppShadows.lerpLevel(1, 3, 0.5);

        expect(interpolated, isNotEmpty);
        expect(interpolated.length, 2);

        // Shadow should be between sm and lg
        final startOffset = AppShadows.sm[1].offset;
        final endOffset = AppShadows.lg[1].offset;
        final interpolatedOffset = interpolated[1].offset;

        expect(interpolatedOffset.dy, greaterThan(startOffset.dy));
        expect(interpolatedOffset.dy, lessThan(endOffset.dy));
      });

      test('lerpLevel returns start shadows when t = 0', () {
        final result = AppShadows.lerpLevel(1, 3, 0.0);
        expect(result, equals(AppShadows.sm));
      });

      test('lerpLevel returns end shadows when t = 1', () {
        final result = AppShadows.lerpLevel(1, 3, 1.0);
        expect(result, equals(AppShadows.lg));
      });

      test('lerpLevel clamps t to 0.0-1.0 range', () {
        // t < 0 should be clamped to 0
        final underflow = AppShadows.lerpLevel(1, 3, -0.5);
        expect(underflow, equals(AppShadows.sm));

        // t > 1 should be clamped to 1
        final overflow = AppShadows.lerpLevel(1, 3, 1.5);
        expect(overflow, equals(AppShadows.lg));
      });

      test('lerpLevel returns start when levels are equal', () {
        final result = AppShadows.lerpLevel(2, 2, 0.5);
        expect(result, equals(AppShadows.md));
      });

      test('lerpLevel handles invalid levels gracefully', () {
        // Invalid levels default to none
        final result = AppShadows.lerpLevel(-1, 10, 0.5);
        expect(result, equals(AppShadows.none));
      });

      test('lerpLevel interpolates shadow properties correctly', () {
        final result = AppShadows.lerpLevel(0, 5, 0.5);

        // Should have shadows (interpolated between none and xxl)
        expect(result, isNotEmpty);
      });
    });

    // ==================== Integration Tests ====================

    group('Integration', () {
      testWidgets('Full elevation workflow with widget', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Center(
                    child: Container(
                      width: 200,
                      height: 150,
                      decoration: AppShadows.decorationWithTint(
                        context: context,
                        level: 3,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(child: Text('Elevated Card')),
                    ),
                  );
                },
              ),
            ),
          ),
        );

        // Verify widget renders without errors
        expect(find.text('Elevated Card'), findsOneWidget);
      });

      testWidgets('Theme switching maintains elevation', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: ThemeMode.light,
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Container(
                    decoration: AppShadows.decorationWithTint(
                      context: context,
                      level: 2,
                    ),
                  );
                },
              ),
            ),
          ),
        );

        // Should render in light mode
        await tester.pumpAndSettle();

        // Switch to dark mode
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: ThemeMode.dark,
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Container(
                    decoration: AppShadows.decorationWithTint(
                      context: context,
                      level: 2,
                    ),
                  );
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();
        // Should render in dark mode without errors
      });
    });
  });
}
