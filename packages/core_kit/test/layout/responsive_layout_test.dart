// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  // ===========================================================================
  // Helper: wraps a widget with MaterialApp + MediaQuery at the given size
  // ===========================================================================
  Widget buildTestWidget({
    required double screenWidth,
    double screenHeight = 800,
    required Widget child,
  }) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: Size(screenWidth, screenHeight)),
        child: Scaffold(body: child),
      ),
    );
  }

  // ===========================================================================
  // AppBreakpoints
  // ===========================================================================
  group('AppBreakpoints', () {
    group('fromWidth', () {
      test('returns compact for width 0', () {
        expect(AppBreakpoints.fromWidth(0), WindowSizeClass.compact);
      });

      test('returns compact for width 599', () {
        expect(AppBreakpoints.fromWidth(599), WindowSizeClass.compact);
      });

      test('returns medium for width 600', () {
        expect(AppBreakpoints.fromWidth(600), WindowSizeClass.medium);
      });

      test('returns medium for width 839', () {
        expect(AppBreakpoints.fromWidth(839), WindowSizeClass.medium);
      });

      test('returns expanded for width 840', () {
        expect(AppBreakpoints.fromWidth(840), WindowSizeClass.expanded);
      });

      test('returns expanded for width 1199', () {
        expect(AppBreakpoints.fromWidth(1199), WindowSizeClass.expanded);
      });

      test('returns large for width 1200', () {
        expect(AppBreakpoints.fromWidth(1200), WindowSizeClass.large);
      });

      test('returns large for width 1599', () {
        expect(AppBreakpoints.fromWidth(1599), WindowSizeClass.large);
      });

      test('returns extraLarge for width 1600', () {
        expect(AppBreakpoints.fromWidth(1600), WindowSizeClass.extraLarge);
      });

      test('returns extraLarge for width 2560', () {
        expect(AppBreakpoints.fromWidth(2560), WindowSizeClass.extraLarge);
      });
    });

    group('convenience helpers', () {
      test('isMobile returns true for width < 600', () {
        expect(AppBreakpoints.isMobile(599), isTrue);
        expect(AppBreakpoints.isMobile(0), isTrue);
      });

      test('isMobile returns false for width >= 600', () {
        expect(AppBreakpoints.isMobile(600), isFalse);
        expect(AppBreakpoints.isMobile(1200), isFalse);
      });

      test('isTablet returns true for 600 <= width < 840', () {
        expect(AppBreakpoints.isTablet(600), isTrue);
        expect(AppBreakpoints.isTablet(839), isTrue);
      });

      test('isTablet returns false outside range', () {
        expect(AppBreakpoints.isTablet(599), isFalse);
        expect(AppBreakpoints.isTablet(840), isFalse);
      });

      test('isDesktop returns true for width >= 840', () {
        expect(AppBreakpoints.isDesktop(840), isTrue);
        expect(AppBreakpoints.isDesktop(1200), isTrue);
        expect(AppBreakpoints.isDesktop(1600), isTrue);
        expect(AppBreakpoints.isDesktop(2560), isTrue);
      });

      test('isDesktop returns false for width < 840', () {
        expect(AppBreakpoints.isDesktop(839), isFalse);
        expect(AppBreakpoints.isDesktop(600), isFalse);
      });
    });

    test('breakpoint constants match M3 spec', () {
      expect(AppBreakpoints.compact, 0);
      expect(AppBreakpoints.medium, 600);
      expect(AppBreakpoints.expanded, 840);
      expect(AppBreakpoints.large, 1200);
      expect(AppBreakpoints.extraLarge, 1600);
    });

    test('content width constants match M3 spec', () {
      expect(AppBreakpoints.maxContentMedium, 600);
      expect(AppBreakpoints.maxContentExpanded, 840);
    });

    group('AppLayoutGrid', () {
      test('margin returns 16 for compact, 24 otherwise', () {
        expect(AppLayoutGrid.margin(WindowSizeClass.compact), 16.0);
        expect(AppLayoutGrid.margin(WindowSizeClass.medium), 24.0);
        expect(AppLayoutGrid.margin(WindowSizeClass.expanded), 24.0);
      });

      test('gutter returns 16 for compact, 24 otherwise', () {
        expect(AppLayoutGrid.gutter(WindowSizeClass.compact), 16.0);
        expect(AppLayoutGrid.gutter(WindowSizeClass.medium), 24.0);
        expect(AppLayoutGrid.gutter(WindowSizeClass.expanded), 24.0);
      });

      test('columns returns 4 for compact, 12 otherwise', () {
        expect(AppLayoutGrid.columns(WindowSizeClass.compact), 4);
        expect(AppLayoutGrid.columns(WindowSizeClass.medium), 12);
        expect(AppLayoutGrid.columns(WindowSizeClass.expanded), 12);
      });
    });
  });

  // ===========================================================================
  // WindowSizeClass
  // ===========================================================================
  group('WindowSizeClass', () {
    test('has 5 values matching M3 spec', () {
      expect(WindowSizeClass.values.length, 5);
    });

    test('values are in order from smallest to largest', () {
      expect(
        WindowSizeClass.compact.index < WindowSizeClass.medium.index,
        isTrue,
      );
      expect(
        WindowSizeClass.medium.index < WindowSizeClass.expanded.index,
        isTrue,
      );
      expect(
        WindowSizeClass.expanded.index < WindowSizeClass.large.index,
        isTrue,
      );
      expect(
        WindowSizeClass.large.index < WindowSizeClass.extraLarge.index,
        isTrue,
      );
    });
  });

  // ===========================================================================
  // CustomBreakpoints
  // ===========================================================================
  group('CustomBreakpoints', () {
    test('uses default M3 breakpoints when no args provided', () {
      const custom = CustomBreakpoints();
      expect(custom.medium, AppBreakpoints.medium);
      expect(custom.expanded, AppBreakpoints.expanded);
      expect(custom.large, AppBreakpoints.large);
      expect(custom.extraLarge, AppBreakpoints.extraLarge);
    });

    test('resolves from custom breakpoints', () {
      const custom = CustomBreakpoints(
        medium: 480,
        expanded: 768,
        large: 1024,
        extraLarge: 1440,
      );

      expect(custom.fromWidth(400), WindowSizeClass.compact);
      expect(custom.fromWidth(480), WindowSizeClass.medium);
      expect(custom.fromWidth(768), WindowSizeClass.expanded);
      expect(custom.fromWidth(1024), WindowSizeClass.large);
      expect(custom.fromWidth(1440), WindowSizeClass.extraLarge);
    });
  });

  // ===========================================================================
  // ResponsiveBuilder
  // ===========================================================================
  group('ResponsiveBuilder', () {
    testWidgets('renders compact widget on small screen', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: const ResponsiveBuilder(
            compact: Text('compact'),
            medium: Text('medium'),
            expanded: Text('expanded'),
          ),
        ),
      );

      expect(find.text('compact'), findsOneWidget);
      expect(find.text('medium'), findsNothing);
    });

    testWidgets('renders medium widget on medium screen', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: const ResponsiveBuilder(
            compact: Text('compact'),
            medium: Text('medium'),
            expanded: Text('expanded'),
          ),
        ),
      );

      expect(find.text('medium'), findsOneWidget);
      expect(find.text('compact'), findsNothing);
    });

    testWidgets('renders expanded widget on expanded screen', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 900,
          child: const ResponsiveBuilder(
            compact: Text('compact'),
            medium: Text('medium'),
            expanded: Text('expanded'),
          ),
        ),
      );

      expect(find.text('expanded'), findsOneWidget);
    });

    testWidgets('falls back to compact when medium not provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: const ResponsiveBuilder(compact: Text('compact')),
        ),
      );

      expect(find.text('compact'), findsOneWidget);
    });

    testWidgets('falls back to medium when expanded not provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 900,
          child: const ResponsiveBuilder(
            compact: Text('compact'),
            medium: Text('medium'),
          ),
        ),
      );

      expect(find.text('medium'), findsOneWidget);
    });

    testWidgets('uses builder callback when provided', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: ResponsiveBuilder(
            builder: (context, sizeClass) {
              return Text('class: $sizeClass');
            },
          ),
        ),
      );

      expect(find.text('class: WindowSizeClass.compact'), findsOneWidget);
    });

    testWidgets('builder takes priority over named slots', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: ResponsiveBuilder(
            builder: (context, sizeClass) => const Text('builder'),
            compact: const Text('compact'),
          ),
        ),
      );

      expect(find.text('builder'), findsOneWidget);
      expect(find.text('compact'), findsNothing);
    });

    testWidgets('renders large widget on large screen', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 1300,
          child: const ResponsiveBuilder(
            compact: Text('compact'),
            large: Text('large'),
          ),
        ),
      );

      expect(find.text('large'), findsOneWidget);
    });

    testWidgets('renders extraLarge widget on extra large screen', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 1700,
          child: const ResponsiveBuilder(
            compact: Text('compact'),
            extraLarge: Text('extraLarge'),
          ),
        ),
      );

      expect(find.text('extraLarge'), findsOneWidget);
    });
  });

  // ===========================================================================
  // ResponsiveValue
  // ===========================================================================
  group('ResponsiveValue', () {
    testWidgets('resolves compact value on small screen', (tester) async {
      int? resolved;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: Builder(
            builder: (context) {
              resolved = const ResponsiveValue<int>(
                compact: 1,
                medium: 2,
                expanded: 3,
              ).resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolved, 1);
    });

    testWidgets('resolves medium value on medium screen', (tester) async {
      int? resolved;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: Builder(
            builder: (context) {
              resolved = const ResponsiveValue<int>(
                compact: 1,
                medium: 2,
                expanded: 3,
              ).resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolved, 2);
    });

    testWidgets('cascades to compact when medium not provided', (tester) async {
      int? resolved;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: Builder(
            builder: (context) {
              resolved = const ResponsiveValue<int>(
                compact: 1,
              ).resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(resolved, 1);
    });

    test('resolveForClass works without context', () {
      const value = ResponsiveValue<String>(
        compact: 'small',
        medium: 'medium',
        expanded: 'big',
      );

      expect(value.resolveForClass(WindowSizeClass.compact), 'small');
      expect(value.resolveForClass(WindowSizeClass.medium), 'medium');
      expect(value.resolveForClass(WindowSizeClass.expanded), 'big');
      expect(value.resolveForClass(WindowSizeClass.large), 'big');
      expect(value.resolveForClass(WindowSizeClass.extraLarge), 'big');
    });

    test('cascade fallback works correctly', () {
      const value = ResponsiveValue<int>(compact: 1, expanded: 3);

      expect(value.resolveForClass(WindowSizeClass.compact), 1);
      expect(value.resolveForClass(WindowSizeClass.medium), 1);
      expect(value.resolveForClass(WindowSizeClass.expanded), 3);
      expect(value.resolveForClass(WindowSizeClass.large), 3);
      expect(value.resolveForClass(WindowSizeClass.extraLarge), 3);
    });
  });

  // ===========================================================================
  // ResponsiveGridView
  // ===========================================================================
  group('ResponsiveGridView', () {
    testWidgets('renders with default 2 columns on compact', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: ResponsiveGridView(
            children: List.generate(
              4,
              (i) => Container(key: ValueKey(i), color: Colors.blue),
            ),
          ),
        ),
      );

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
    });

    testWidgets('renders with 3 columns on medium', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: ResponsiveGridView(
            children: List.generate(
              6,
              (i) => Container(key: ValueKey(i), color: Colors.blue),
            ),
          ),
        ),
      );

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 3);
    });

    testWidgets('renders with 4 columns on expanded', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 900,
          child: ResponsiveGridView(
            children: List.generate(
              8,
              (i) => Container(key: ValueKey(i), color: Colors.blue),
            ),
          ),
        ),
      );

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 4);
    });

    testWidgets('uses AppSpacing.md as default spacing', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: ResponsiveGridView(children: [Container(color: Colors.blue)]),
        ),
      );

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisSpacing, AppSpacing.md);
      expect(delegate.mainAxisSpacing, AppSpacing.md);
    });

    testWidgets('supports custom spacing', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: ResponsiveGridView(
            spacing: AppSpacing.lg,
            runSpacing: AppSpacing.sm,
            children: [Container(color: Colors.blue)],
          ),
        ),
      );

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisSpacing, AppSpacing.lg);
      expect(delegate.mainAxisSpacing, AppSpacing.sm);
    });

    testWidgets('supports custom column counts', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: ResponsiveGridView(
            compactColumns: 1,
            children: [Container(color: Colors.blue)],
          ),
        ),
      );

      final gridView = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          gridView.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 1);
    });
  });

  // ===========================================================================
  // ResponsiveLayout
  // ===========================================================================
  group('ResponsiveLayout', () {
    testWidgets('renders compact layout on small screen', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: ResponsiveLayout(
            compact: const Text('compact'),
            medium: const Text('medium'),
            expanded: const Text('expanded'),
          ),
        ),
      );

      expect(find.text('compact'), findsOneWidget);
    });

    testWidgets('renders medium layout on medium screen', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: ResponsiveLayout(
            compact: const Text('compact'),
            medium: const Text('medium'),
          ),
        ),
      );

      expect(find.text('medium'), findsOneWidget);
    });

    testWidgets('falls back to compact when medium not provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: const ResponsiveLayout(compact: Text('compact')),
        ),
      );

      expect(find.text('compact'), findsOneWidget);
    });

    testWidgets('renders expanded layout on large screen', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 1300,
          child: ResponsiveLayout(
            compact: const Text('compact'),
            expanded: const Text('expanded'),
          ),
        ),
      );

      expect(find.text('expanded'), findsOneWidget);
    });
  });

  // ===========================================================================
  // ScreenMetrics
  // ===========================================================================
  group('ScreenMetrics', () {
    test('calculates diagonal correctly', () {
      const metrics = ScreenMetrics(
        width: 300,
        height: 400,
        orientation: Orientation.portrait,
        windowSizeClass: WindowSizeClass.compact,
      );

      expect(metrics.diagonal, 500);
    });

    test('isPortrait returns true for portrait orientation', () {
      const metrics = ScreenMetrics(
        width: 400,
        height: 800,
        orientation: Orientation.portrait,
        windowSizeClass: WindowSizeClass.compact,
      );

      expect(metrics.isPortrait, isTrue);
      expect(metrics.isLandscape, isFalse);
    });

    test('isLandscape returns true for landscape orientation', () {
      const metrics = ScreenMetrics(
        width: 800,
        height: 400,
        orientation: Orientation.landscape,
        windowSizeClass: WindowSizeClass.medium,
      );

      expect(metrics.isLandscape, isTrue);
      expect(metrics.isPortrait, isFalse);
    });

    test('isMobile/isTablet/isDesktop delegate to AppBreakpoints', () {
      const mobile = ScreenMetrics(
        width: 400,
        height: 800,
        orientation: Orientation.portrait,
        windowSizeClass: WindowSizeClass.compact,
      );
      expect(mobile.isMobile, isTrue);
      expect(mobile.isTablet, isFalse);
      expect(mobile.isDesktop, isFalse);

      const tablet = ScreenMetrics(
        width: 800,
        height: 1200,
        orientation: Orientation.portrait,
        windowSizeClass: WindowSizeClass.expanded,
      );
      expect(tablet.isMobile, isFalse);
      expect(tablet.isTablet, isTrue);
      expect(tablet.isDesktop, isFalse);

      const desktop = ScreenMetrics(
        width: 1400,
        height: 900,
        orientation: Orientation.landscape,
        windowSizeClass: WindowSizeClass.large,
      );
      expect(desktop.isMobile, isFalse);
      expect(desktop.isTablet, isFalse);
      expect(desktop.isDesktop, isTrue);
    });

    test('equality works correctly', () {
      const a = ScreenMetrics(
        width: 400,
        height: 800,
        orientation: Orientation.portrait,
        windowSizeClass: WindowSizeClass.compact,
      );
      const b = ScreenMetrics(
        width: 400,
        height: 800,
        orientation: Orientation.portrait,
        windowSizeClass: WindowSizeClass.compact,
      );
      const c = ScreenMetrics(
        width: 500,
        height: 800,
        orientation: Orientation.portrait,
        windowSizeClass: WindowSizeClass.compact,
      );

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
      expect(a.hashCode, b.hashCode);
    });

    test('toString includes dimensions and class', () {
      const metrics = ScreenMetrics(
        width: 400,
        height: 800,
        orientation: Orientation.portrait,
        windowSizeClass: WindowSizeClass.compact,
      );

      final str = metrics.toString();
      expect(str, contains('400'));
      expect(str, contains('800'));
      expect(str, contains('compact'));
    });
  });

  // ===========================================================================
  // ScreenSizeProvider
  // ===========================================================================
  group('ScreenSizeProvider', () {
    testWidgets('provides correct metrics to descendants', (tester) async {
      ScreenMetrics? result;

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: ScreenSizeProvider(
              child: Builder(
                builder: (context) {
                  result = ScreenSizeProvider.of(context);
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      );

      expect(result, isNotNull);
      expect(result!.width, 400);
      expect(result!.height, 800);
      expect(result!.windowSizeClass, WindowSizeClass.compact);
    });

    testWidgets('maybeOf returns null without provider', (tester) async {
      ScreenMetrics? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              result = ScreenSizeProvider.maybeOf(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, isNull);
    });

    testWidgets('updates when screen size changes', (tester) async {
      ScreenMetrics? result;

      Widget buildWithWidth(double width) {
        return MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(size: Size(width, 800)),
            child: ScreenSizeProvider(
              child: Builder(
                builder: (context) {
                  result = ScreenSizeProvider.of(context);
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        );
      }

      await tester.pumpWidget(buildWithWidth(400));
      expect(result!.windowSizeClass, WindowSizeClass.compact);

      await tester.pumpWidget(buildWithWidth(700));
      expect(result!.windowSizeClass, WindowSizeClass.medium);

      await tester.pumpWidget(buildWithWidth(900));
      expect(result!.windowSizeClass, WindowSizeClass.expanded);
    });
  });

  // ===========================================================================
  // AppOrientationBuilder
  // ===========================================================================
  group('AppOrientationBuilder', () {
    testWidgets('renders portrait widget in portrait mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: const AppOrientationBuilder(
              portrait: Text('portrait'),
              landscape: Text('landscape'),
            ),
          ),
        ),
      );

      expect(find.text('portrait'), findsOneWidget);
      expect(find.text('landscape'), findsNothing);
    });

    testWidgets('renders landscape widget in landscape mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 400)),
            child: const AppOrientationBuilder(
              portrait: Text('portrait'),
              landscape: Text('landscape'),
            ),
          ),
        ),
      );

      expect(find.text('landscape'), findsOneWidget);
      expect(find.text('portrait'), findsNothing);
    });

    testWidgets('falls back to portrait when landscape not provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 400)),
            child: const AppOrientationBuilder(portrait: Text('portrait')),
          ),
        ),
      );

      expect(find.text('portrait'), findsOneWidget);
    });

    testWidgets('builder provides orientation and sizeClass', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(400, 800)),
            child: AppOrientationBuilder(
              builder: (context, orientation, sizeClass) {
                return Text('$orientation $sizeClass');
              },
            ),
          ),
        ),
      );

      expect(
        find.text('Orientation.portrait WindowSizeClass.compact'),
        findsOneWidget,
      );
    });
  });

  // ===========================================================================
  // MaxWidthContainer
  // ===========================================================================
  group('MaxWidthContainer', () {
    testWidgets('constrains child width', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 1600,
          child: const MaxWidthContainer(maxWidth: 800, child: Placeholder()),
        ),
      );

      final constrainedBox = tester.widget<ConstrainedBox>(
        find.descendant(
          of: find.byType(MaxWidthContainer),
          matching: find.byType(ConstrainedBox),
        ),
      );
      expect(constrainedBox.constraints.maxWidth, 800);
    });

    testWidgets('centers child by default', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 1600,
          child: const MaxWidthContainer(maxWidth: 800, child: Placeholder()),
        ),
      );

      final align = tester.widget<Align>(find.byType(Align));
      expect(align.alignment, Alignment.topCenter);
    });

    testWidgets('aligns left when center is false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 1600,
          child: const MaxWidthContainer(
            maxWidth: 800,
            center: false,
            child: Placeholder(),
          ),
        ),
      );

      final align = tester.widget<Align>(find.byType(Align));
      expect(align.alignment, Alignment.topLeft);
    });

    testWidgets('narrow constructor uses 600dp max', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 1600,
          child: const MaxWidthContainer.narrow(child: Placeholder()),
        ),
      );

      final constrainedBox = tester.widget<ConstrainedBox>(
        find.descendant(
          of: find.byType(MaxWidthContainer),
          matching: find.byType(ConstrainedBox),
        ),
      );
      expect(constrainedBox.constraints.maxWidth, 600);
    });

    testWidgets('standard constructor uses 840dp max', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 1600,
          child: const MaxWidthContainer.standard(child: Placeholder()),
        ),
      );

      final constrainedBox = tester.widget<ConstrainedBox>(
        find.descendant(
          of: find.byType(MaxWidthContainer),
          matching: find.byType(ConstrainedBox),
        ),
      );
      expect(constrainedBox.constraints.maxWidth, 840);
    });
  });

  // ===========================================================================
  // ViewportHelpers
  // ===========================================================================
  group('ViewportHelpers', () {
    testWidgets('isPhone returns true for compact width', (tester) async {
      bool? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: Builder(
            builder: (context) {
              result = ViewportHelpers.isPhone(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, isTrue);
    });

    testWidgets('isPhone returns false for medium width', (tester) async {
      bool? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: Builder(
            builder: (context) {
              result = ViewportHelpers.isPhone(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, isFalse);
    });

    testWidgets('isTablet returns true for medium/expanded width', (
      tester,
    ) async {
      bool? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 900,
          child: Builder(
            builder: (context) {
              result = ViewportHelpers.isTablet(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, isTrue);
    });

    testWidgets('isDesktop returns true for expanded+ width', (tester) async {
      bool? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 900,
          child: Builder(
            builder: (context) {
              result = ViewportHelpers.isDesktop(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, isTrue);
    });

    testWidgets('isLandscape returns true for landscape', (tester) async {
      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 400)),
            child: Scaffold(
              body: Builder(
                builder: (context) {
                  result = ViewportHelpers.isLandscape(context);
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      );

      expect(result, isTrue);
    });

    testWidgets('isPortrait returns true for portrait', (tester) async {
      bool? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          screenHeight: 800,
          child: Builder(
            builder: (context) {
              result = ViewportHelpers.isPortrait(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, isTrue);
    });
  });

  // ===========================================================================
  // ResponsiveExtension
  // ===========================================================================
  group('ResponsiveExtension', () {
    testWidgets('windowSizeClass returns correct class', (tester) async {
      WindowSizeClass? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: Builder(
            builder: (context) {
              result = context.windowSizeClass;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, WindowSizeClass.medium);
    });

    testWidgets('isMobile/isTablet/isDesktop work correctly', (tester) async {
      bool? mobile;
      bool? tablet;
      bool? desktop;

      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: Builder(
            builder: (context) {
              mobile = context.isMobile;
              tablet = context.isTablet;
              desktop = context.isDesktop;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      // 700 is Tablet (600-839)
      expect(mobile, isFalse);
      expect(tablet, isTrue);
      expect(desktop, isFalse);
    });

    testWidgets('screenWidth and screenHeight return correct values', (
      tester,
    ) async {
      double? width;
      double? height;

      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 375,
          screenHeight: 812,
          child: Builder(
            builder: (context) {
              width = context.screenWidth;
              height = context.screenHeight;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(width, 375);
      expect(height, 812);
    });

    testWidgets('responsiveValue resolves correctly', (tester) async {
      int? result;

      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: Builder(
            builder: (context) {
              result = context.responsiveValue<int>(
                compact: 1,
                medium: 2,
                expanded: 3,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, 2);
    });

    testWidgets('screenMetrics works without ScreenSizeProvider', (
      tester,
    ) async {
      ScreenMetrics? metrics;

      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          screenHeight: 800,
          child: Builder(
            builder: (context) {
              metrics = context.screenMetrics;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(metrics, isNotNull);
      expect(metrics!.width, 400);
      expect(metrics!.height, 800);
      expect(metrics!.windowSizeClass, WindowSizeClass.compact);
    });

    testWidgets('screenMetrics uses ScreenSizeProvider when available', (
      tester,
    ) async {
      ScreenMetrics? metrics;

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(700, 1000)),
            child: ScreenSizeProvider(
              child: Scaffold(
                body: Builder(
                  builder: (context) {
                    metrics = context.screenMetrics;
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ),
      );

      expect(metrics, isNotNull);
      expect(metrics!.width, 700);
      expect(metrics!.windowSizeClass, WindowSizeClass.medium);
    });
  });

  // ===========================================================================
  // ResponsiveThemeExtension
  // ===========================================================================
  group('ResponsiveThemeExtension', () {
    testWidgets('responsiveSpacing scales for compact', (tester) async {
      double? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: Builder(
            builder: (context) {
              result = Theme.of(context).responsiveSpacing(context, 16);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      // Compact: 1.0x, 16 * 1.0 = 16, rounded to 4dp = 16
      expect(result, 16);
    });

    testWidgets('responsiveSpacing scales for expanded', (tester) async {
      double? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 900,
          child: Builder(
            builder: (context) {
              result = Theme.of(context).responsiveSpacing(context, 16);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      // Expanded: 1.25x, 16 * 1.25 = 20, rounded to 4dp = 20
      expect(result, 20);
    });

    testWidgets('responsiveSpacing scales for large', (tester) async {
      double? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 1300,
          child: Builder(
            builder: (context) {
              result = Theme.of(context).responsiveSpacing(context, 16);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      // Large: 1.5x, 16 * 1.5 = 24, rounded to 4dp = 24
      expect(result, 24);
    });

    testWidgets('responsiveTextStyle scales font size', (tester) async {
      TextStyle? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: Builder(
            builder: (context) {
              const baseStyle = TextStyle(fontSize: 16);
              result = Theme.of(
                context,
              ).responsiveTextStyle(context, baseStyle);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      // Compact: 0.9x, 16 * 0.9 = 14.4
      expect(result!.fontSize, closeTo(14.4, 0.01));
    });

    testWidgets('responsiveTextStyle returns null for null input', (
      tester,
    ) async {
      TextStyle? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: Builder(
            builder: (context) {
              result = Theme.of(context).responsiveTextStyle(context, null);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, isNull);
    });

    testWidgets('responsiveIconSize delegates to ResponsiveIconSize', (
      tester,
    ) async {
      double? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: Builder(
            builder: (context) {
              result = Theme.of(context).responsiveIconSize(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      // base=24, compact factor=0.83, 24*0.83 ≈ 19.92
      expect(result, closeTo(19.92, 0.1));
    });
  });

  // ===========================================================================
  // ResponsiveIconSize
  // ===========================================================================
  group('ResponsiveIconSize', () {
    testWidgets('returns compact size on small screen', (tester) async {
      double? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: Builder(
            builder: (context) {
              result = ResponsiveIconSize.resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, ResponsiveIconSize.defaultCompact);
    });

    testWidgets('returns medium size on medium screen', (tester) async {
      double? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 700,
          child: Builder(
            builder: (context) {
              result = ResponsiveIconSize.resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, ResponsiveIconSize.defaultMedium);
    });

    testWidgets('returns expanded size on expanded screen', (tester) async {
      double? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 900,
          child: Builder(
            builder: (context) {
              result = ResponsiveIconSize.resolve(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, ResponsiveIconSize.defaultExpanded);
    });

    testWidgets('supports custom sizes', (tester) async {
      double? result;
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: Builder(
            builder: (context) {
              result = ResponsiveIconSize.resolve(
                context,
                compact: 16,
                medium: 20,
                expanded: 24,
              );
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(result, 16);
    });
  });
  // ===========================================================================
  // AppLayoutGridContainer
  // ===========================================================================
  group('AppLayoutGridContainer', () {
    testWidgets('applies M3 margins by default', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 400,
          child: const AppLayoutGridContainer(child: Placeholder()),
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(16.0));
    });

    testWidgets('applies standard M3 margins for expanded', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          screenWidth: 900,
          child: const AppLayoutGridContainer(child: Placeholder()),
        ),
      );

      final padding = tester.widget<Padding>(find.byType(Padding));
      expect(padding.padding, const EdgeInsets.all(24.0));
    });
  });
}
