// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppTabs', () {
    testWidgets('renders with correct number of tabs', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Tab 1'),
                AppTabItem(label: 'Tab 2'),
                AppTabItem(label: 'Tab 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Tab 1'), findsOneWidget);
      expect(find.text('Tab 2'), findsOneWidget);
      expect(find.text('Tab 3'), findsOneWidget);
    });

    testWidgets('shows icons when variant is iconAndText', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Home', icon: Icons.home),
                AppTabItem(label: 'Search', icon: Icons.search),
              ],
              variant: AppTabVariant.iconAndText,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('shows only icons when variant is iconOnly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Home', icon: Icons.home),
                AppTabItem(label: 'Search', icon: Icons.search),
              ],
              variant: AppTabVariant.iconOnly,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      // Labels should not be visible in iconOnly mode
      expect(find.text('Home'), findsNothing);
      expect(find.text('Search'), findsNothing);
    });

    testWidgets('shows only text when variant is textOnly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Home', icon: Icons.home),
                AppTabItem(label: 'Search', icon: Icons.search),
              ],
              variant: AppTabVariant.textOnly,
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      // Icons should not be visible in textOnly mode
      expect(find.byIcon(Icons.home), findsNothing);
      expect(find.byIcon(Icons.search), findsNothing);
    });

    testWidgets('calls onTabSelected when tab is tapped', (
      WidgetTester tester,
    ) async {
      int? selectedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Tab 1'),
                AppTabItem(label: 'Tab 2'),
                AppTabItem(label: 'Tab 3'),
              ],
              onTabSelected: (index) {
                selectedIndex = index;
              },
            ),
          ),
        ),
      );

      // Tap second tab
      await tester.tap(find.text('Tab 2'));
      await tester.pumpAndSettle();

      expect(selectedIndex, equals(1));
    });

    testWidgets('displays badge when badgeCount > 0', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Tab 1', badgeCount: 0),
                AppTabItem(label: 'Tab 2', badgeCount: 5),
                AppTabItem(label: 'Tab 3', badgeCount: 100),
              ],
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.text('99+'), findsOneWidget);
    });

    testWidgets('does not display badge when badgeCount is 0', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Tab 1', badgeCount: 0),
                AppTabItem(label: 'Tab 2', badgeCount: 0),
              ],
            ),
          ),
        ),
      );

      // Should not find any badge containers
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Container &&
              widget.decoration is BoxDecoration &&
              (widget.decoration as BoxDecoration).color != null,
        ),
        findsNothing,
      );
    });

    testWidgets('respects selectedIndex prop', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Tab 1'),
                AppTabItem(label: 'Tab 2'),
                AppTabItem(label: 'Tab 3'),
              ],
              selectedIndex: 1,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify second tab is selected (we can check this through TabController)
      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.controller?.index, equals(1));
    });

    testWidgets('uses custom indicator color when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Tab 1'),
                AppTabItem(label: 'Tab 2'),
              ],
              indicatorColor: Colors.green,
            ),
          ),
        ),
      );

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.indicatorColor, equals(Colors.green));
    });

    testWidgets('shows underline indicator by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Tab 1'),
                AppTabItem(label: 'Tab 2'),
              ],
            ),
          ),
        ),
      );

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.indicatorWeight, equals(2.0));
    });

    testWidgets('shows pill indicator when indicatorStyle is pill', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Tab 1'),
                AppTabItem(label: 'Tab 2'),
              ],
              indicatorStyle: AppTabIndicatorStyle.pill,
            ),
          ),
        ),
      );

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.indicator, isA<BoxDecoration>());
      expect(tabBar.indicatorWeight, equals(0.0));
    });

    testWidgets('is scrollable when isScrollable is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Tab 1'),
                AppTabItem(label: 'Tab 2'),
                AppTabItem(label: 'Tab 3'),
              ],
              isScrollable: true,
            ),
          ),
        ),
      );

      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(tabBar.isScrollable, isTrue);
    });

    testWidgets('has semantic labels for accessibility', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(
                  label: 'Home',
                  icon: Icons.home,
                  semanticLabel: 'Home tab',
                ),
                AppTabItem(
                  label: 'Search',
                  icon: Icons.search,
                  semanticLabel: 'Search tab',
                ),
              ],
            ),
          ),
        ),
      );

      // Find all Semantics widgets
      final semanticsWidgets = find.byType(Semantics);
      expect(semanticsWidgets, findsWidgets);

      // Verify semantic labels are set correctly
      final semanticsElements = tester.widgetList<Semantics>(semanticsWidgets);
      final labels = semanticsElements
          .map((s) => s.properties.label)
          .where((l) => l != null && l.isNotEmpty)
          .toList();

      expect(labels.contains('Home tab'), isTrue);
      expect(labels.contains('Search tab'), isTrue);
    });

    testWidgets('animates indicator when tab changes', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: const [
                AppTabItem(label: 'Tab 1'),
                AppTabItem(label: 'Tab 2'),
                AppTabItem(label: 'Tab 3'),
              ],
            ),
          ),
        ),
      );

      // Get initial controller state
      final tabBar = tester.widget<TabBar>(find.byType(TabBar));
      final initialIndex = tabBar.controller?.index;
      expect(initialIndex, equals(0));

      // Tap second tab
      await tester.tap(find.text('Tab 2'));
      await tester.pump(); // Start animation
      await tester.pump(const Duration(milliseconds: 125)); // Mid-animation
      await tester.pumpAndSettle(); // Complete animation

      // Verify tab changed
      final newTabBar = tester.widget<TabBar>(find.byType(TabBar));
      expect(newTabBar.controller?.index, equals(1));
    });

    test('AppTabItem can be created with required parameters', () {
      const tabItem = AppTabItem(label: 'Test');
      expect(tabItem.label, equals('Test'));
      expect(tabItem.icon, isNull);
      expect(tabItem.badgeCount, equals(0));
      expect(tabItem.semanticLabel, isNull);
    });

    test('AppTabItem can be created with all parameters', () {
      const tabItem = AppTabItem(
        label: 'Test',
        icon: Icons.home,
        badgeCount: 5,
        semanticLabel: 'Test label',
      );
      expect(tabItem.label, equals('Test'));
      expect(tabItem.icon, equals(Icons.home));
      expect(tabItem.badgeCount, equals(5));
      expect(tabItem.semanticLabel, equals('Test label'));
    });

    testWidgets('asserts when tabs length is less than 2', (
      WidgetTester tester,
    ) async {
      expect(
        () => AppTabs(tabs: const [AppTabItem(label: 'Tab 1')]),
        throwsAssertionError,
      );
    });

    testWidgets('asserts when tabs length is greater than 6 (non-scrollable)', (
      WidgetTester tester,
    ) async {
      expect(
        () => AppTabs(
          tabs: const [
            AppTabItem(label: 'Tab 1'),
            AppTabItem(label: 'Tab 2'),
            AppTabItem(label: 'Tab 3'),
            AppTabItem(label: 'Tab 4'),
            AppTabItem(label: 'Tab 5'),
            AppTabItem(label: 'Tab 6'),
            AppTabItem(label: 'Tab 7'),
          ],
          isScrollable: false,
        ),
        throwsAssertionError,
      );
    });

    testWidgets('allows more than 6 tabs when scrollable', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTabs(
              tabs: List.generate(
                12,
                (index) => AppTabItem(label: 'Tab ${index + 1}'),
              ),
              isScrollable: true,
            ),
          ),
        ),
      );

      expect(find.byType(AppTabs), findsOneWidget);
      expect(find.byType(Tab), findsNWidgets(12));
    });

    testWidgets('asserts when selectedIndex is out of range', (
      WidgetTester tester,
    ) async {
      expect(
        () => AppTabs(
          tabs: const [
            AppTabItem(label: 'Tab 1'),
            AppTabItem(label: 'Tab 2'),
          ],
          selectedIndex: 5,
        ),
        throwsAssertionError,
      );
    });
  });
}
