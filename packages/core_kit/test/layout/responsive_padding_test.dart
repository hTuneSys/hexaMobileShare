// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('ResponsivePadding', () {
    Widget buildTestWidget({
      required double screenWidth,
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? mobilePadding,
      EdgeInsetsGeometry? tabletPadding,
      EdgeInsetsGeometry? desktopPadding,
      double mobileBreakpoint = ResponsiveBreakpoints.mobile,
      double tabletBreakpoint = ResponsiveBreakpoints.tablet,
    }) {
      return MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(size: Size(screenWidth, 800)),
          child: ResponsivePadding(
            padding: padding,
            mobilePadding: mobilePadding,
            tabletPadding: tabletPadding,
            desktopPadding: desktopPadding,
            mobileBreakpoint: mobileBreakpoint,
            tabletBreakpoint: tabletBreakpoint,
            child: const Text('Test Content'),
          ),
        ),
      );
    }

    group('Breakpoint Detection', () {
      testWidgets('applies mobile padding for width < 600', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            screenWidth: 400,
            mobilePadding: const EdgeInsets.all(8),
            tabletPadding: const EdgeInsets.all(16),
            desktopPadding: const EdgeInsets.all(24),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.all(8));
      });

      testWidgets('applies tablet padding for 600 <= width < 1024', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            screenWidth: 800,
            mobilePadding: const EdgeInsets.all(8),
            tabletPadding: const EdgeInsets.all(16),
            desktopPadding: const EdgeInsets.all(24),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.all(16));
      });

      testWidgets('applies desktop padding for width >= 1024', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            screenWidth: 1200,
            mobilePadding: const EdgeInsets.all(8),
            tabletPadding: const EdgeInsets.all(16),
            desktopPadding: const EdgeInsets.all(24),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.all(24));
      });

      testWidgets('applies tablet padding at exactly 600 width', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            screenWidth: 600,
            mobilePadding: const EdgeInsets.all(8),
            tabletPadding: const EdgeInsets.all(16),
            desktopPadding: const EdgeInsets.all(24),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.all(16));
      });

      testWidgets('applies desktop padding at exactly 1024 width', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            screenWidth: 1024,
            mobilePadding: const EdgeInsets.all(8),
            tabletPadding: const EdgeInsets.all(16),
            desktopPadding: const EdgeInsets.all(24),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.all(24));
      });
    });

    group('Custom Breakpoints', () {
      testWidgets('respects custom mobile breakpoint', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            screenWidth: 500,
            mobileBreakpoint: 400, // Custom: < 400 is mobile
            mobilePadding: const EdgeInsets.all(8),
            tabletPadding: const EdgeInsets.all(16),
            desktopPadding: const EdgeInsets.all(24),
          ),
        );

        // 500 >= 400, so it should be tablet
        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.all(16));
      });

      testWidgets('respects custom tablet breakpoint', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            screenWidth: 900,
            tabletBreakpoint: 800, // Custom: >= 800 is desktop
            mobilePadding: const EdgeInsets.all(8),
            tabletPadding: const EdgeInsets.all(16),
            desktopPadding: const EdgeInsets.all(24),
          ),
        );

        // 900 >= 800, so it should be desktop
        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.all(24));
      });
    });

    group('Fallback Behavior', () {
      testWidgets('falls back to padding when breakpoint padding is null', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            screenWidth: 400,
            padding: const EdgeInsets.all(12),
            mobilePadding: null,
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.all(12));
      });

      testWidgets('uses EdgeInsets.zero when no padding is provided', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(screenWidth: 400, padding: null, mobilePadding: null),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, EdgeInsets.zero);
      });
    });

    group('Named Constructors', () {
      testWidgets('ResponsivePadding.all applies same padding all sides', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(400, 800)),
              child: ResponsivePadding.all(
                mobile: 8,
                tablet: 16,
                desktop: 24,
                child: const Text('Test'),
              ),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.all(8));
      });

      testWidgets('ResponsivePadding.symmetric applies h/v padding', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(800, 800)),
              child: ResponsivePadding.symmetric(
                mobileHorizontal: 8,
                mobileVertical: 4,
                tabletHorizontal: 16,
                tabletVertical: 8,
                desktopHorizontal: 24,
                desktopVertical: 12,
                child: const Text('Test'),
              ),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(
          padding.padding,
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        );
      });

      testWidgets('ResponsivePadding.horizontal applies only h padding', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(1200, 800)),
              child: ResponsivePadding.horizontal(
                mobile: 8,
                tablet: 16,
                desktop: 24,
                child: const Text('Test'),
              ),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.symmetric(horizontal: 24));
      });

      testWidgets('ResponsivePadding.vertical applies only v padding', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(400, 800)),
              child: ResponsivePadding.vertical(
                mobile: 8,
                tablet: 16,
                desktop: 24,
                child: const Text('Test'),
              ),
            ),
          ),
        );

        final padding = tester.widget<Padding>(find.byType(Padding).first);
        expect(padding.padding, const EdgeInsets.symmetric(vertical: 8));
      });
    });

    group('Child Rendering', () {
      testWidgets('renders child widget correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(400, 800)),
              child: ResponsivePadding(
                mobilePadding: const EdgeInsets.all(8),
                child: const Text('Test Content'),
              ),
            ),
          ),
        );

        expect(find.text('Test Content'), findsOneWidget);
      });
    });

    group('DeviceType enum', () {
      test('DeviceType has correct values', () {
        expect(DeviceType.values, contains(DeviceType.mobile));
        expect(DeviceType.values, contains(DeviceType.tablet));
        expect(DeviceType.values, contains(DeviceType.desktop));
        expect(DeviceType.values.length, 3);
      });
    });

    group('ResponsiveBreakpoints', () {
      test('has correct default values', () {
        expect(ResponsiveBreakpoints.mobile, 600.0);
        expect(ResponsiveBreakpoints.tablet, 1024.0);
      });
    });
  });
}
