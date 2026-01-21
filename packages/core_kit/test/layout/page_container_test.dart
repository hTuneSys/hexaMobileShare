// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/layout/page_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PageContainer Tests', () {
    testWidgets('renders child correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PageContainer(child: Text('Test Content'))),
        ),
      );

      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('applies default max-width of 1200', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PageContainer(child: Text('Test'))),
        ),
      );

      // Find ConstrainedBox that is a descendant of PageContainer
      final constrainedBoxFinder = find.descendant(
        of: find.byType(PageContainer),
        matching: find.byType(ConstrainedBox),
      );

      expect(constrainedBoxFinder, findsOneWidget);

      final constrainedBox = tester.widget<ConstrainedBox>(
        constrainedBoxFinder,
      );
      expect(constrainedBox.constraints.maxWidth, 1200.0);
    });

    testWidgets('applies custom max-width', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PageContainer(maxWidth: 800, child: Text('Test')),
          ),
        ),
      );

      final constrainedBoxFinder = find.descendant(
        of: find.byType(PageContainer),
        matching: find.byType(ConstrainedBox),
      );

      final constrainedBox = tester.widget<ConstrainedBox>(
        constrainedBoxFinder,
      );
      expect(constrainedBox.constraints.maxWidth, 800.0);
    });

    testWidgets('PageContainer.fluid has no max-width constraint', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PageContainer.fluid(child: Text('Test'))),
        ),
      );

      // Should not have ConstrainedBox inside PageContainer when fluid
      final constrainedBoxFinder = find.descendant(
        of: find.byType(PageContainer),
        matching: find.byType(ConstrainedBox),
      );
      expect(constrainedBoxFinder, findsNothing);
    });

    testWidgets('PageContainer.narrow has 800dp max-width', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PageContainer.narrow(child: Text('Test'))),
        ),
      );

      final constrainedBoxFinder = find.descendant(
        of: find.byType(PageContainer),
        matching: find.byType(ConstrainedBox),
      );

      final constrainedBox = tester.widget<ConstrainedBox>(
        constrainedBoxFinder,
      );
      expect(constrainedBox.constraints.maxWidth, 800.0);
    });

    testWidgets('centers content when center is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PageContainer(center: true, child: Text('Test')),
          ),
        ),
      );

      // Find Align that is a descendant of PageContainer
      final alignFinder = find.descendant(
        of: find.byType(PageContainer),
        matching: find.byType(Align),
      );
      expect(alignFinder, findsOneWidget);

      // Verify it uses topCenter alignment
      final align = tester.widget<Align>(alignFinder);
      expect(align.alignment, Alignment.topCenter);
    });

    testWidgets('does not center content when center is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PageContainer(center: false, child: Text('Test')),
          ),
        ),
      );

      // Align should not be inside PageContainer
      final alignFinder = find.descendant(
        of: find.byType(PageContainer),
        matching: find.byType(Align),
      );
      expect(alignFinder, findsNothing);
    });

    testWidgets('applies SafeArea when useSafeArea is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PageContainer(useSafeArea: true, child: Text('Test')),
          ),
        ),
      );

      final safeAreaFinder = find.descendant(
        of: find.byType(PageContainer),
        matching: find.byType(SafeArea),
      );
      expect(safeAreaFinder, findsOneWidget);
    });

    testWidgets('does not apply SafeArea when useSafeArea is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PageContainer(useSafeArea: false, child: Text('Test')),
          ),
        ),
      );

      final safeAreaFinder = find.descendant(
        of: find.byType(PageContainer),
        matching: find.byType(SafeArea),
      );
      expect(safeAreaFinder, findsNothing);
    });

    testWidgets('applies custom padding override', (tester) async {
      const customPadding = EdgeInsets.all(32);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PageContainer(
              padding: customPadding,
              useSafeArea: false, // Disable SafeArea to simplify test
              child: Text('Test'),
            ),
          ),
        ),
      );

      // Find the Padding that directly wraps the Text child
      // The widget tree is: PageContainer > LayoutBuilder > ... > Padding > Text
      final paddingWidgets = tester.widgetList<Padding>(
        find.descendant(
          of: find.byType(PageContainer),
          matching: find.byType(Padding),
        ),
      );

      // Find the padding that has our custom value
      final customPaddingWidget = paddingWidgets.firstWhere(
        (p) => p.padding == customPadding,
        orElse: () => throw StateError('Custom padding not found'),
      );

      expect(customPaddingWidget.padding, customPadding);
    });

    group('Responsive padding tests', () {
      testWidgets('uses 16dp padding on mobile (< 600dp)', (tester) async {
        tester.view.physicalSize = const Size(400, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: PageContainer(
                maxWidth: null,
                useSafeArea: false,
                child: Text('Test'),
              ),
            ),
          ),
        );

        // Find all Padding widgets inside PageContainer
        final paddingWidgets = tester.widgetList<Padding>(
          find.descendant(
            of: find.byType(PageContainer),
            matching: find.byType(Padding),
          ),
        );

        // Find the padding with horizontal 16dp
        final expectedPadding = const EdgeInsets.symmetric(horizontal: 16.0);
        final mobilePadding = paddingWidgets.firstWhere(
          (p) => p.padding == expectedPadding,
          orElse: () => throw StateError('Mobile padding not found'),
        );

        expect(mobilePadding.padding, expectedPadding);

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      testWidgets('uses 24dp padding on tablet (600-840dp)', (tester) async {
        tester.view.physicalSize = const Size(700, 1000);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: PageContainer(
                maxWidth: null,
                useSafeArea: false,
                child: Text('Test'),
              ),
            ),
          ),
        );

        final paddingWidgets = tester.widgetList<Padding>(
          find.descendant(
            of: find.byType(PageContainer),
            matching: find.byType(Padding),
          ),
        );

        final expectedPadding = const EdgeInsets.symmetric(horizontal: 24.0);
        final tabletPadding = paddingWidgets.firstWhere(
          (p) => p.padding == expectedPadding,
          orElse: () => throw StateError('Tablet padding not found'),
        );

        expect(tabletPadding.padding, expectedPadding);

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      testWidgets('uses 32dp padding on desktop (> 840dp)', (tester) async {
        tester.view.physicalSize = const Size(1200, 800);
        tester.view.devicePixelRatio = 1.0;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: PageContainer(
                maxWidth: null,
                useSafeArea: false,
                child: Text('Test'),
              ),
            ),
          ),
        );

        final paddingWidgets = tester.widgetList<Padding>(
          find.descendant(
            of: find.byType(PageContainer),
            matching: find.byType(Padding),
          ),
        );

        final expectedPadding = const EdgeInsets.symmetric(horizontal: 32.0);
        final desktopPadding = paddingWidgets.firstWhere(
          (p) => p.padding == expectedPadding,
          orElse: () => throw StateError('Desktop padding not found'),
        );

        expect(desktopPadding.padding, expectedPadding);

        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });
    });

    testWidgets('SafeArea respects individual edge settings', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PageContainer(
              useSafeArea: true,
              safeAreaTop: false,
              safeAreaBottom: true,
              safeAreaLeft: false,
              safeAreaRight: true,
              child: Text('Test'),
            ),
          ),
        ),
      );

      final safeAreaFinder = find.descendant(
        of: find.byType(PageContainer),
        matching: find.byType(SafeArea),
      );

      final safeArea = tester.widget<SafeArea>(safeAreaFinder);
      expect(safeArea.top, false);
      expect(safeArea.bottom, true);
      expect(safeArea.left, false);
      expect(safeArea.right, true);
    });
  });
}
