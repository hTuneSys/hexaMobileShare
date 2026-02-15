// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppScrollView', () {
    group('Basic Rendering', () {
      testWidgets('renders child content', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppScrollView(child: Text('Scroll Content'))),
          ),
        );

        expect(find.text('Scroll Content'), findsOneWidget);
        expect(find.byType(SingleChildScrollView), findsOneWidget);
      });

      testWidgets('renders with default settings', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppScrollView(child: SizedBox(height: 100))),
          ),
        );

        expect(find.byType(AppScrollView), findsOneWidget);
        expect(find.byType(SafeArea), findsOneWidget);
      });
    });

    group('Scroll Direction', () {
      testWidgets('defaults to vertical scrolling', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppScrollView(child: SizedBox(height: 100))),
          ),
        );

        final scrollView = tester.widget<SingleChildScrollView>(
          find.byType(SingleChildScrollView),
        );
        expect(scrollView.scrollDirection, Axis.vertical);
      });

      testWidgets('supports horizontal scrolling', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(width: 100),
              ),
            ),
          ),
        );

        final scrollView = tester.widget<SingleChildScrollView>(
          find.byType(SingleChildScrollView),
        );
        expect(scrollView.scrollDirection, Axis.horizontal);
      });
    });

    group('Scroll Physics', () {
      testWidgets('applies clamping physics by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppScrollView(child: SizedBox(height: 100))),
          ),
        );

        final scrollView = tester.widget<SingleChildScrollView>(
          find.byType(SingleChildScrollView),
        );
        expect(scrollView.physics, isA<ClampingScrollPhysics>());
      });

      testWidgets('applies bouncing physics', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                physics: AppScrollPhysicsType.bounce,
                child: SizedBox(height: 100),
              ),
            ),
          ),
        );

        final scrollView = tester.widget<SingleChildScrollView>(
          find.byType(SingleChildScrollView),
        );
        expect(scrollView.physics, isA<BouncingScrollPhysics>());
      });

      testWidgets('applies never scrollable physics', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                physics: AppScrollPhysicsType.never,
                child: SizedBox(height: 100),
              ),
            ),
          ),
        );

        final scrollView = tester.widget<SingleChildScrollView>(
          find.byType(SingleChildScrollView),
        );
        expect(scrollView.physics, isA<NeverScrollableScrollPhysics>());
      });

      testWidgets('applies always scrollable physics', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                physics: AppScrollPhysicsType.always,
                child: SizedBox(height: 100),
              ),
            ),
          ),
        );

        final scrollView = tester.widget<SingleChildScrollView>(
          find.byType(SingleChildScrollView),
        );
        expect(scrollView.physics, isA<AlwaysScrollableScrollPhysics>());
      });
    });

    group('Pull-to-Refresh', () {
      testWidgets('shows RefreshIndicator when enabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                enablePullToRefresh: true,
                onRefresh: () async {},
                child: const SizedBox(height: 100),
              ),
            ),
          ),
        );

        expect(find.byType(RefreshIndicator), findsOneWidget);
      });

      testWidgets('does not show RefreshIndicator when disabled', (
        tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppScrollView(child: SizedBox(height: 100))),
          ),
        );

        expect(find.byType(RefreshIndicator), findsNothing);
      });
    });

    group('Scroll-to-Top Button', () {
      testWidgets('does not show FAB initially', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                enableScrollToTop: true,
                child: Column(
                  children: List.generate(
                    50,
                    (i) => SizedBox(height: 60, child: Text('Item $i')),
                  ),
                ),
              ),
            ),
          ),
        );

        // FAB should have 0 opacity initially
        final opacity = tester.widget<AnimatedOpacity>(
          find.byType(AnimatedOpacity),
        );
        expect(opacity.opacity, 0.0);
      });

      testWidgets('shows FAB after scrolling past threshold', (tester) async {
        final controller = ScrollController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                enableScrollToTop: true,
                scrollToTopThreshold: 200.0,
                controller: controller,
                child: Column(
                  children: List.generate(
                    50,
                    (i) => SizedBox(height: 60, child: Text('Item $i')),
                  ),
                ),
              ),
            ),
          ),
        );

        // Scroll past threshold
        controller.jumpTo(250);
        await tester.pump();

        final opacity = tester.widget<AnimatedOpacity>(
          find.byType(AnimatedOpacity),
        );
        expect(opacity.opacity, 1.0);

        controller.dispose();
      });
    });

    group('Safe Area', () {
      testWidgets('wraps with SafeArea when enabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                handleSafeArea: true,
                child: SizedBox(height: 100),
              ),
            ),
          ),
        );

        expect(find.byType(SafeArea), findsOneWidget);
      });

      testWidgets('does not wrap with SafeArea when disabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                handleSafeArea: false,
                child: SizedBox(height: 100),
              ),
            ),
          ),
        );

        expect(find.byType(SafeArea), findsNothing);
      });
    });

    group('Accessibility', () {
      testWidgets('adds semantic label when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                semanticLabel: 'Scrollable content',
                child: SizedBox(height: 100),
              ),
            ),
          ),
        );

        expect(find.bySemanticsLabel('Scrollable content'), findsOneWidget);
      });

      testWidgets('does not add Semantics when label not provided', (
        tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppScrollView(child: SizedBox(height: 100))),
          ),
        );

        // Semantics from AppScrollView should not exist
        // (only framework Semantics should be present)
        expect(find.bySemanticsLabel('Scrollable content'), findsNothing);
      });
    });

    group('Controller', () {
      testWidgets('uses externally provided ScrollController', (tester) async {
        final controller = ScrollController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppScrollView(
                controller: controller,
                child: Column(
                  children: List.generate(
                    30,
                    (i) => SizedBox(height: 60, child: Text('Item $i')),
                  ),
                ),
              ),
            ),
          ),
        );

        // Verify we can control scroll from outside
        controller.jumpTo(100);
        await tester.pump();

        expect(controller.offset, 100.0);

        controller.dispose();
      });
    });
  });
}
