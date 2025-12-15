// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppListTile', () {
    testWidgets('renders with title only', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppListTile(title: 'Test Title')),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders with title and subtitle', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(title: 'Test Title', subtitle: 'Test Subtitle'),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets('renders with leading widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(leading: Icon(Icons.star), title: 'Test Title'),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              title: 'Test Title',
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('renders with all widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              leading: Icon(Icons.star),
              title: 'Test Title',
              subtitle: 'Test Subtitle',
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppListTile(title: 'Test Title', onTap: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.byType(AppListTile));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('calls onLongPress when long pressed', (
      WidgetTester tester,
    ) async {
      var longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppListTile(
              title: 'Test Title',
              onLongPress: () => longPressed = true,
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(AppListTile));
      await tester.pump();

      expect(longPressed, isTrue);
    });

    testWidgets('does not call onTap when disabled', (
      WidgetTester tester,
    ) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppListTile(
              title: 'Test Title',
              enabled: false,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppListTile));
      await tester.pump();

      expect(tapped, isFalse);
    });

    testWidgets('does not call onLongPress when disabled', (
      WidgetTester tester,
    ) async {
      var longPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppListTile(
              title: 'Test Title',
              enabled: false,
              onLongPress: () => longPressed = true,
            ),
          ),
        ),
      );

      await tester.longPress(find.byType(AppListTile));
      await tester.pump();

      expect(longPressed, isFalse);
    });

    testWidgets('displays selected state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(title: 'Test Title', selected: true),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.selected, isTrue);
    });

    testWidgets('applies dense mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppListTile(title: 'Test Title', dense: true)),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.dense, isTrue);
    });

    testWidgets('enables three-line mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              title: 'Test Title',
              subtitle: 'Test Title',
              isThreeLine: true,
            ),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.isThreeLine, isTrue);
    });

    testWidgets('applies custom content padding', (WidgetTester tester) async {
      const customPadding = EdgeInsets.all(24.0);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              title: 'Test Title',
              contentPadding: customPadding,
            ),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.contentPadding, customPadding);
    });

    testWidgets('applies custom tile color', (WidgetTester tester) async {
      const customColor = Colors.blue;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(title: 'Test Title', tileColor: customColor),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.tileColor, customColor);
    });

    testWidgets('applies custom selected tile color', (
      WidgetTester tester,
    ) async {
      const customColor = Colors.green;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              title: 'Test Title',
              selected: true,
              selectedTileColor: customColor,
            ),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.selectedTileColor, customColor);
    });

    testWidgets('uses default selected tile color from theme', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.light(secondaryContainer: Colors.purple),
          ),
          home: const Scaffold(
            body: AppListTile(title: 'Test Title', selected: true),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.selectedTileColor, Colors.purple);
    });

    testWidgets('applies custom shape', (WidgetTester tester) async {
      final customShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppListTile(title: 'Test Title', shape: customShape),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.shape, customShape);
    });

    testWidgets('applies custom visual density', (WidgetTester tester) async {
      const customDensity = VisualDensity.compact;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppListTile(
              title: 'Test Title',
              visualDensity: customDensity,
            ),
          ),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.visualDensity, customDensity);
    });

    testWidgets('applies default horizontal padding', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppListTile(title: 'Test Title')),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(
        listTile.contentPadding,
        const EdgeInsets.symmetric(horizontal: 16.0),
      );
    });

    testWidgets('ensures minimum touch target in dense mode', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppListTile(title: 'Test Title', dense: true)),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.minVerticalPadding, 4.0);
    });

    testWidgets('ensures minimum touch target in normal mode', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppListTile(title: 'Test Title')),
        ),
      );

      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.minVerticalPadding, 8.0);
    });

    testWidgets('works with complex leading widget', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppListTile(
              leading: Stack(
                children: const [
                  CircleAvatar(child: Icon(Icons.person)),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
              title: 'Test Title',
            ),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsNWidgets(2));
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('works with complex trailing widget', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppListTile(
              title: 'Test Title',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.favorite),
                  SizedBox(width: 8),
                  Icon(Icons.more_vert),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.favorite), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('works in ListView', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: const [
                AppListTile(title: 'Item 1'),
                AppListTile(title: 'Item 2'),
                AppListTile(title: 'Item 3'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('maintains accessibility in dense mode', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppListTile(title: 'Test Title', dense: true)),
        ),
      );

      // Verify that even in dense mode, the touch target is adequate
      final listTile = tester.widget<ListTile>(find.byType(ListTile));
      expect(listTile.dense, isTrue);
      expect(listTile.minVerticalPadding, 4.0);
    });
  });
}
