// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/layout/app_sliver_scaffold.dart';
import 'package:core_kit/widgets/surfaces/app_section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSliverScaffold', () {
    testWidgets('renders SliverAppBar and content', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppSliverScaffold(
            title: Text('Test Title'),
            slivers: [SliverToBoxAdapter(child: Text('Content'))],
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('collapses on scroll', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AppSliverScaffold(
            title: const Text('Title'),
            expandedHeight: 200,
            collapsedHeight: 60,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      SizedBox(height: 50, child: Text('Item $index')),
                  childCount: 50,
                ),
              ),
            ],
          ),
        ),
      );

      // Initial state: expanded
      expect(find.text('Item 0'), findsOneWidget);

      // Scroll up
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -300));
      await tester.pumpAndSettle();

      // Should still be visible (pinned by default)
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('triggers onScroll callback', (tester) async {
      double? ratio;
      await tester.pumpWidget(
        MaterialApp(
          home: AppSliverScaffold(
            expandedHeight: 200,
            collapsedHeight: 100,
            onScroll: (r) => ratio = r,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(height: 50),
                  childCount: 50,
                ),
              ),
            ],
          ),
        ),
      );

      // Scroll by 50 pixels
      // Range = 200 - 100 = 100.
      // Offset 50 => Ratio 0.5.
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -50));
      await tester.pump();

      expect(ratio, isNotNull);
      expect(
        ratio,
        closeTo(0.5, 0.1),
      ); // Approximate due to physics/drag precision
    });

    testWidgets('triggers onRefresh', (tester) async {
      bool refreshed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: AppSliverScaffold(
            onRefresh: () async {
              refreshed = true;
            },
            slivers: const [SliverToBoxAdapter(child: SizedBox(height: 1000))],
          ),
        ),
      );

      // Pull down to refresh
      await tester.drag(find.byType(CustomScrollView), const Offset(0, 300));
      await tester.pumpAndSettle();

      expect(refreshed, isTrue);
    });

    testWidgets('SectionHeaderDelegate renders child', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: SectionHeaderDelegate(
                  child: Container(
                    color: Colors.grey[200],
                    child: const Center(child: Text('Sticky Header')),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Sticky Header'), findsOneWidget);
    });
  });
}
