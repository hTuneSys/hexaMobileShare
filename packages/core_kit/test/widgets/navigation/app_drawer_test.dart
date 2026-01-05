// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppDrawer', () {
    testWidgets('renders with basic destinations', (WidgetTester tester) async {
      final scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: Container(),
            drawer: AppDrawer(
              destinations: const [
                AppDrawerDestination(icon: Icons.home, label: 'Home'),
                AppDrawerDestination(icon: Icons.settings, label: 'Settings'),
              ],
              selectedIndex: 0,
            ),
          ),
        ),
      );

      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('calls onDestinationSelected when item tapped', (
      WidgetTester tester,
    ) async {
      final scaffoldKey = GlobalKey<ScaffoldState>();
      int? selectedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: Container(),
            drawer: AppDrawer(
              destinations: const [
                AppDrawerDestination(icon: Icons.home, label: 'Home'),
                AppDrawerDestination(icon: Icons.settings, label: 'Settings'),
              ],
              selectedIndex: 0,
              onDestinationSelected: (index) {
                selectedIndex = index;
              },
            ),
          ),
        ),
      );

      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();

      expect(selectedIndex, equals(1));
    });

    testWidgets('renders header with user profile', (
      WidgetTester tester,
    ) async {
      final scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: Container(),
            drawer: AppDrawer(
              header: const AppDrawerHeader(
                avatar: CircleAvatar(child: Icon(Icons.person)),
                name: 'John Doe',
                email: 'john@example.com',
              ),
              destinations: const [
                AppDrawerDestination(icon: Icons.home, label: 'Home'),
              ],
              selectedIndex: 0,
            ),
          ),
        ),
      );

      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.text('john@example.com'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('displays badges on destinations', (WidgetTester tester) async {
      final scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: Container(),
            drawer: AppDrawer(
              destinations: const [
                AppDrawerDestination(icon: Icons.home, label: 'Home'),
                AppDrawerDestination(
                  icon: Icons.notifications,
                  label: 'Notifications',
                  badge: true,
                  badgeLabel: '5',
                ),
              ],
              selectedIndex: 0,
            ),
          ),
        ),
      );

      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('renders sections with titles', (WidgetTester tester) async {
      final scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: Container(),
            drawer: AppDrawer(
              destinations: const [],
              sections: const [
                AppDrawerSection(
                  title: 'Main',
                  startIndex: 0,
                  destinations: [
                    AppDrawerDestination(icon: Icons.home, label: 'Home'),
                  ],
                ),
              ],
              selectedIndex: 0,
            ),
          ),
        ),
      );

      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Main'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('expandable sections toggle visibility', (
      WidgetTester tester,
    ) async {
      final scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: Container(),
            drawer: AppDrawer(
              destinations: const [],
              sections: const [
                AppDrawerSection(
                  title: 'Expandable',
                  startIndex: 0,
                  isExpandable: true,
                  destinations: [
                    AppDrawerDestination(icon: Icons.home, label: 'Home'),
                  ],
                ),
              ],
              selectedIndex: 0,
            ),
          ),
        ),
      );

      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle();

      // Initially collapsed
      expect(find.text('Home'), findsNothing);

      // Tap to expand
      await tester.tap(find.text('Expandable'));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('renders footer content', (WidgetTester tester) async {
      final scaffoldKey = GlobalKey<ScaffoldState>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            key: scaffoldKey,
            body: Container(),
            drawer: AppDrawer(
              destinations: const [
                AppDrawerDestination(icon: Icons.home, label: 'Home'),
              ],
              selectedIndex: 0,
              footer: const Text('Footer Content'),
            ),
          ),
        ),
      );

      scaffoldKey.currentState!.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('Footer Content'), findsOneWidget);
    });
  });

  group('AppDrawerHeader', () {
    testWidgets('renders avatar, name, and email', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppDrawerHeader(
              avatar: CircleAvatar(child: Icon(Icons.person)),
              name: 'Test User',
              email: 'test@example.com',
            ),
          ),
        ),
      );

      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppDrawerHeader(
              avatar: const CircleAvatar(child: Icon(Icons.person)),
              name: 'Test User',
              email: 'test@example.com',
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppDrawerHeader));
      await tester.pumpAndSettle();

      expect(wasTapped, isTrue);
    });
  });

  group('AppDrawerDestination', () {
    test('creates destination with required properties', () {
      const destination = AppDrawerDestination(icon: Icons.home, label: 'Home');

      expect(destination.icon, equals(Icons.home));
      expect(destination.label, equals('Home'));
      expect(destination.enabled, isTrue);
      expect(destination.badge, isNull);
    });

    test('creates destination with optional properties', () {
      const destination = AppDrawerDestination(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: 'Home',
        badge: true,
        badgeLabel: '5',
        enabled: false,
      );

      expect(destination.selectedIcon, equals(Icons.home));
      expect(destination.badge, isTrue);
      expect(destination.badgeLabel, equals('5'));
      expect(destination.enabled, isFalse);
    });
  });

  group('AppDrawerSection', () {
    test('creates section with required properties', () {
      const section = AppDrawerSection(
        destinations: [AppDrawerDestination(icon: Icons.home, label: 'Home')],
        startIndex: 0,
      );

      expect(section.destinations.length, equals(1));
      expect(section.startIndex, equals(0));
      expect(section.hasDivider, isTrue);
      expect(section.isExpandable, isFalse);
    });
  });
}
