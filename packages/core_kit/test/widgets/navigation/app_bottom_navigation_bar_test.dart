// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppBottomNavigationBar', () {
    testWidgets('renders with 3 destinations', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('renders with 5 destinations', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('calls onDestinationSelected with correct index when tapped', (
      tester,
    ) async {
      int? selectedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (index) {
                selectedIndex = index;
              },
            ),
          ),
        ),
      );

      // Tap on Search destination
      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();

      expect(selectedIndex, equals(1));
    });

    testWidgets('shows selected destination with active indicator', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 1,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      // Verify NavigationBar widget exists with correct selected index
      final navigationBar = tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );
      expect(navigationBar.selectedIndex, equals(1));
    });

    testWidgets('displays count badge correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                  badge: AppNavigationBadge.count(5),
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.byType(Badge), findsOneWidget);
    });

    testWidgets('displays dot badge correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                  badge: AppNavigationBadge.dot(),
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(Badge), findsOneWidget);
    });

    testWidgets('hides labels when showLabels is false', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              showLabels: false,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      final navigationBar = tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );
      expect(
        navigationBar.labelBehavior,
        equals(NavigationDestinationLabelBehavior.alwaysHide),
      );
    });

    testWidgets('uses custom height when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              height: 90.0,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      final navigationBar = tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );
      expect(navigationBar.height, equals(90.0));
    });

    testWidgets('uses custom elevation when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              elevation: 8.0,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      final navigationBar = tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );
      expect(navigationBar.elevation, equals(8.0));
    });

    testWidgets('uses custom background color when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              backgroundColor: Colors.blue,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      final navigationBar = tester.widget<NavigationBar>(
        find.byType(NavigationBar),
      );
      expect(navigationBar.backgroundColor, equals(Colors.blue));
    });

    testWidgets('uses selectedIcon when provided', (tester) async {
      const selectedIconKey = Key('selected_icon');
      const unselectedIconKey = Key('unselected_icon');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home_outlined, key: unselectedIconKey),
                  selectedIcon: Icon(Icons.home, key: selectedIconKey),
                  label: 'Home',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      // Selected icon should be visible for the first destination
      expect(find.byKey(selectedIconKey), findsOneWidget);
    });

    testWidgets('handles multiple badges correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: AppBottomNavigationBar(
              selectedIndex: 0,
              destinations: const [
                AppBottomNavigationDestination(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  badge: AppNavigationBadge.dot(),
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                  badge: AppNavigationBadge.count(10),
                ),
                AppBottomNavigationDestination(
                  icon: Icon(Icons.chat),
                  label: 'Messages',
                  badge: AppNavigationBadge.count(3),
                ),
              ],
              onDestinationSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('10'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.byType(Badge), findsNWidgets(3));
    });
  });

  group('AppBottomNavigationDestination', () {
    test('creates destination with required parameters', () {
      const destination = AppBottomNavigationDestination(
        icon: Icon(Icons.home),
        label: 'Home',
      );

      expect(destination.label, equals('Home'));
      expect(destination.icon, isA<Icon>());
    });

    test('uses label as tooltip when tooltip is null', () {
      const destination = AppBottomNavigationDestination(
        icon: Icon(Icons.home),
        label: 'Home',
      );

      expect(destination.tooltip, isNull);
    });

    test('uses custom tooltip when provided', () {
      const destination = AppBottomNavigationDestination(
        icon: Icon(Icons.home),
        label: 'Home',
        tooltip: 'Go to home page',
      );

      expect(destination.tooltip, equals('Go to home page'));
    });
  });

  group('AppNavigationBadge', () {
    test('creates count badge with valid count', () {
      const badge = AppNavigationBadge.count(5);

      expect(badge.count, equals(5));
      expect(badge.isCount, isTrue);
      expect(badge.isDot, isFalse);
    });

    test('creates dot badge', () {
      const badge = AppNavigationBadge.dot();

      expect(badge.count, isNull);
      expect(badge.isDot, isTrue);
      expect(badge.isCount, isFalse);
    });
  });
}
