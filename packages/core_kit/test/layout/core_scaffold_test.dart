// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CoreScaffold', () {
    Widget buildTestWidget({
      Widget? body,
      PreferredSizeWidget? appBar,
      Widget? bottomNavigationBar,
      Widget? floatingActionButton,
      Widget? drawer,
      Widget? endDrawer,
      Color? backgroundColor,
      bool useSafeArea = true,
      bool extendBody = false,
      bool extendBodyBehindAppBar = false,
      bool resizeToAvoidBottomInset = true,
    }) {
      return MaterialApp(
        home: CoreScaffold(
          body: body,
          appBar: appBar,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          drawer: drawer,
          endDrawer: endDrawer,
          backgroundColor: backgroundColor,
          useSafeArea: useSafeArea,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        ),
      );
    }

    group('Rendering', () {
      testWidgets('renders with default values', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(body: const Text('Test Content')),
        );

        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.text('Test Content'), findsOneWidget);
      });

      testWidgets('renders without body', (tester) async {
        await tester.pumpWidget(buildTestWidget());

        expect(find.byType(Scaffold), findsOneWidget);
      });

      testWidgets('applies MD3 surface color as default background', (
        tester,
      ) async {
        await tester.pumpWidget(buildTestWidget(body: const Text('Content')));

        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        final context = tester.element(find.byType(Scaffold));
        final theme = Theme.of(context);

        expect(scaffold.backgroundColor, equals(theme.colorScheme.surface));
      });

      testWidgets('applies custom background color', (tester) async {
        const customColor = Colors.red;

        await tester.pumpWidget(
          buildTestWidget(
            body: const Text('Content'),
            backgroundColor: customColor,
          ),
        );

        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        expect(scaffold.backgroundColor, equals(customColor));
      });
    });

    group('App Bar Integration', () {
      testWidgets('renders with app bar', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            appBar: AppBar(title: const Text('Test Title')),
            body: const Text('Content'),
          ),
        );

        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Test Title'), findsOneWidget);
      });

      testWidgets('renders with AppAppBar', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            appBar: const AppAppBar(title: 'App Bar Title'),
            body: const Text('Content'),
          ),
        );

        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('App Bar Title'), findsOneWidget);
      });
    });

    group('Bottom Navigation Integration', () {
      testWidgets('renders with bottom navigation bar', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            body: const Text('Content'),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        );

        expect(find.byType(BottomNavigationBar), findsOneWidget);
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Settings'), findsOneWidget);
      });
    });

    group('FAB Integration', () {
      testWidgets('renders with floating action button', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            body: const Text('Content'),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        );

        expect(find.byType(FloatingActionButton), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
      });

      testWidgets('renders with AppFab', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            body: const Text('Content'),
            floatingActionButton: AppFab(icon: Icons.add, onPressed: () {}),
          ),
        );

        expect(find.byType(AppFab), findsOneWidget);
      });
    });

    group('Drawer Integration', () {
      testWidgets('renders with drawer', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: CoreScaffold(
              appBar: AppBar(
                title: const Text('Title'),
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              ),
              drawer: const Drawer(child: Text('Drawer Content')),
              body: const Text('Content'),
            ),
          ),
        );

        // Open drawer via menu button
        await tester.tap(find.byIcon(Icons.menu));
        await tester.pumpAndSettle();

        expect(find.byType(Drawer), findsOneWidget);
        expect(find.text('Drawer Content'), findsOneWidget);
      });

      testWidgets('renders with end drawer', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: CoreScaffold(
              appBar: AppBar(
                title: const Text('Title'),
                actions: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu_open),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
                  ),
                ],
              ),
              endDrawer: const Drawer(child: Text('End Drawer Content')),
              body: const Text('Content'),
            ),
          ),
        );

        // Open end drawer via button
        await tester.tap(find.byIcon(Icons.menu_open));
        await tester.pumpAndSettle();

        expect(find.byType(Drawer), findsOneWidget);
        expect(find.text('End Drawer Content'), findsOneWidget);
      });
    });

    group('Safe Area', () {
      testWidgets('wraps body with SafeArea when useSafeArea is true', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(body: const Text('Content'), useSafeArea: true),
        );

        expect(find.byType(SafeArea), findsOneWidget);
      });

      testWidgets(
        'does not wrap body with SafeArea when useSafeArea is false',
        (tester) async {
          await tester.pumpWidget(
            buildTestWidget(body: const Text('Content'), useSafeArea: false),
          );

          // SafeArea should not be present in the widget tree
          // (SafeArea from MaterialApp may still exist, so we check for our
          // specific body wrapper)
          final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
          expect(scaffold.body, isA<Text>());
        },
      );

      testWidgets('disables top safe area when app bar is present', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            appBar: AppBar(title: const Text('Title')),
            body: const Text('Content'),
            useSafeArea: true,
          ),
        );

        // Find the SafeArea that contains our body Text widget
        final safeAreaFinder = find.ancestor(
          of: find.text('Content'),
          matching: find.byType(SafeArea),
        );
        final safeArea = tester.widget<SafeArea>(safeAreaFinder.first);
        expect(safeArea.top, isFalse);
      });

      testWidgets(
        'disables bottom safe area when bottom navigation is present',
        (tester) async {
          await tester.pumpWidget(
            buildTestWidget(
              body: const Text('Content'),
              bottomNavigationBar: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
              useSafeArea: true,
            ),
          );

          // Find the SafeArea that contains our body Text widget
          final safeAreaFinder = find.ancestor(
            of: find.text('Content'),
            matching: find.byType(SafeArea),
          );
          final safeArea = tester.widget<SafeArea>(safeAreaFinder.first);
          expect(safeArea.bottom, isFalse);
        },
      );
    });

    group('Scaffold Properties', () {
      testWidgets('applies extendBody property', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(body: const Text('Content'), extendBody: true),
        );

        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        expect(scaffold.extendBody, isTrue);
      });

      testWidgets('applies extendBodyBehindAppBar property', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            appBar: AppBar(title: const Text('Title')),
            body: const Text('Content'),
            extendBodyBehindAppBar: true,
          ),
        );

        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        expect(scaffold.extendBodyBehindAppBar, isTrue);
      });

      testWidgets('applies resizeToAvoidBottomInset property', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            body: const Text('Content'),
            resizeToAvoidBottomInset: false,
          ),
        );

        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        expect(scaffold.resizeToAvoidBottomInset, isFalse);
      });
    });

    group('Drawer Gestures', () {
      testWidgets('respects drawerEnableOpenDragGesture', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: CoreScaffold(
              appBar: AppBar(title: const Text('Title')),
              drawer: const Drawer(child: Text('Drawer')),
              body: const Text('Content'),
              drawerEnableOpenDragGesture: false,
            ),
          ),
        );

        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        expect(scaffold.drawerEnableOpenDragGesture, isFalse);
      });

      testWidgets('respects endDrawerEnableOpenDragGesture', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: CoreScaffold(
              appBar: AppBar(title: const Text('Title')),
              endDrawer: const Drawer(child: Text('End Drawer')),
              body: const Text('Content'),
              endDrawerEnableOpenDragGesture: false,
            ),
          ),
        );

        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        expect(scaffold.endDrawerEnableOpenDragGesture, isFalse);
      });
    });
  });
}
