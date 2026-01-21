// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSpacing', () {
    group('spacing constants', () {
      test('should have correct values following 4dp grid', () {
        expect(AppSpacing.xs, 4.0);
        expect(AppSpacing.sm, 8.0);
        expect(AppSpacing.md, 16.0);
        expect(AppSpacing.lg, 24.0);
        expect(AppSpacing.xl, 32.0);
        expect(AppSpacing.xxl, 48.0);
        expect(AppSpacing.xxxl, 64.0);
      });

      test('should follow progression scale', () {
        expect(AppSpacing.sm, AppSpacing.xs * 2);
        expect(AppSpacing.md, AppSpacing.sm * 2);
        expect(AppSpacing.lg, AppSpacing.md * 1.5);
        expect(AppSpacing.xl, AppSpacing.lg * (4 / 3));
        expect(AppSpacing.xxl, AppSpacing.xl * 1.5);
      });
    });

    group('EdgeInsets helpers', () {
      test('edgeInsetsAll helpers should create correct padding', () {
        expect(AppSpacing.edgeInsetsAllXs, const EdgeInsets.all(4.0));
        expect(AppSpacing.edgeInsetsAllSm, const EdgeInsets.all(8.0));
        expect(AppSpacing.edgeInsetsAllMd, const EdgeInsets.all(16.0));
        expect(AppSpacing.edgeInsetsAllLg, const EdgeInsets.all(24.0));
        expect(AppSpacing.edgeInsetsAllXl, const EdgeInsets.all(32.0));
      });

      test('edgeInsetsH helpers should create horizontal padding', () {
        expect(
          AppSpacing.edgeInsetsHXs,
          const EdgeInsets.symmetric(horizontal: 4.0),
        );
        expect(
          AppSpacing.edgeInsetsHSm,
          const EdgeInsets.symmetric(horizontal: 8.0),
        );
        expect(
          AppSpacing.edgeInsetsHMd,
          const EdgeInsets.symmetric(horizontal: 16.0),
        );
        expect(
          AppSpacing.edgeInsetsHLg,
          const EdgeInsets.symmetric(horizontal: 24.0),
        );
      });

      test('edgeInsetsV helpers should create vertical padding', () {
        expect(
          AppSpacing.edgeInsetsVXs,
          const EdgeInsets.symmetric(vertical: 4.0),
        );
        expect(
          AppSpacing.edgeInsetsVSm,
          const EdgeInsets.symmetric(vertical: 8.0),
        );
        expect(
          AppSpacing.edgeInsetsVMd,
          const EdgeInsets.symmetric(vertical: 16.0),
        );
        expect(
          AppSpacing.edgeInsetsVLg,
          const EdgeInsets.symmetric(vertical: 24.0),
        );
      });
    });

    group('responsive spacing', () {
      testWidgets('should scale spacing for mobile devices', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(375, 812)),
              child: Builder(
                builder: (context) {
                  final spacing = AppSpacing.responsive(context, AppSpacing.md);
                  expect(spacing, 16.0); // 1.0x scale factor
                  return Container();
                },
              ),
            ),
          ),
        );
      });

      testWidgets('should scale spacing for tablet devices', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(768, 1024)),
              child: Builder(
                builder: (context) {
                  final spacing = AppSpacing.responsive(context, AppSpacing.md);
                  expect(spacing, 20.0); // 1.25x scale factor
                  return Container();
                },
              ),
            ),
          ),
        );
      });

      testWidgets('should scale spacing for desktop devices', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(1920, 1080)),
              child: Builder(
                builder: (context) {
                  final spacing = AppSpacing.responsive(context, AppSpacing.md);
                  expect(spacing, 24.0); // 1.5x scale factor
                  return Container();
                },
              ),
            ),
          ),
        );
      });

      testWidgets('should maintain 4dp grid after scaling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(768, 1024)),
              child: Builder(
                builder: (context) {
                  // Test various base values
                  final spacings = [
                    AppSpacing.responsive(context, AppSpacing.xs),
                    AppSpacing.responsive(context, AppSpacing.sm),
                    AppSpacing.responsive(context, AppSpacing.md),
                    AppSpacing.responsive(context, AppSpacing.lg),
                    AppSpacing.responsive(context, AppSpacing.xl),
                  ];

                  // All scaled values should be divisible by 4
                  for (final spacing in spacings) {
                    expect(
                      spacing % 4,
                      0.0,
                      reason: '$spacing is not on 4dp grid',
                    );
                  }

                  return Container();
                },
              ),
            ),
          ),
        );
      });

      testWidgets('should handle edge case at breakpoint boundaries', (
        tester,
      ) async {
        // Test at 599dp (mobile)
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(599, 812)),
              child: Builder(
                builder: (context) {
                  final spacing = AppSpacing.responsive(context, AppSpacing.md);
                  expect(spacing, 16.0); // Mobile scale
                  return Container();
                },
              ),
            ),
          ),
        );

        // Test at 600dp (tablet)
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(600, 1024)),
              child: Builder(
                builder: (context) {
                  final spacing = AppSpacing.responsive(context, AppSpacing.md);
                  expect(spacing, 20.0); // Tablet scale
                  return Container();
                },
              ),
            ),
          ),
        );

        // Test at 839dp (tablet)
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(839, 1024)),
              child: Builder(
                builder: (context) {
                  final spacing = AppSpacing.responsive(context, AppSpacing.md);
                  expect(spacing, 20.0); // Tablet scale
                  return Container();
                },
              ),
            ),
          ),
        );

        // Test at 840dp (desktop)
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(840, 1080)),
              child: Builder(
                builder: (context) {
                  final spacing = AppSpacing.responsive(context, AppSpacing.md);
                  expect(spacing, 24.0); // Desktop scale
                  return Container();
                },
              ),
            ),
          ),
        );
      });
    });

    group('Material Design 3 compliance', () {
      test('should use 4dp base unit', () {
        final spacings = [
          AppSpacing.xs,
          AppSpacing.sm,
          AppSpacing.md,
          AppSpacing.lg,
          AppSpacing.xl,
          AppSpacing.xxl,
          AppSpacing.xxxl,
        ];

        for (final spacing in spacings) {
          expect(spacing % 4, 0.0, reason: '$spacing is not divisible by 4');
        }
      });

      test('should provide minimum touch target spacing', () {
        // Material Design 3 recommends minimum 8dp spacing between touch targets
        expect(AppSpacing.sm, greaterThanOrEqualTo(8.0));
      });
    });
  });
}
