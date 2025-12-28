// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppBadge', () {
    group('Badge Types', () {
      testWidgets('renders numeric badge correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 5, child: const Icon(Icons.notifications)),
            ),
          ),
        );

        expect(find.text('5'), findsOneWidget);
        expect(find.byIcon(Icons.notifications), findsOneWidget);
      });

      testWidgets('renders dot badge correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppBadge.dot(child: Icon(Icons.message))),
          ),
        );

        expect(find.byIcon(Icons.message), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
      });

      testWidgets('dot badge has no text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppBadge.dot(child: Icon(Icons.message))),
          ),
        );

        // Dot badge should not have any text
        expect(find.byType(Text), findsNothing);
      });
    });

    group('Count Display', () {
      testWidgets('displays single digit count correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 3, child: const Icon(Icons.mail)),
            ),
          ),
        );

        expect(find.text('3'), findsOneWidget);
      });

      testWidgets('displays double digit count correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 42, child: const Icon(Icons.chat)),
            ),
          ),
        );

        expect(find.text('42'), findsOneWidget);
      });

      testWidgets('displays count 99 exactly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 99, child: const Icon(Icons.notifications)),
            ),
          ),
        );

        expect(find.text('99'), findsOneWidget);
        expect(find.text('99+'), findsNothing);
      });
    });

    group('Max Count Overflow', () {
      testWidgets('displays 99+ for count of 100', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 100,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        expect(find.text('99+'), findsOneWidget);
        expect(find.text('100'), findsNothing);
      });

      testWidgets('displays 99+ for count of 999', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 999, child: const Icon(Icons.mail)),
            ),
          ),
        );

        expect(find.text('99+'), findsOneWidget);
      });

      testWidgets('displays 99+ for very large count', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 10000,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        expect(find.text('99+'), findsOneWidget);
      });
    });

    group('Positioning', () {
      testWidgets('positions badge at topEnd by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 5, child: const Icon(Icons.notifications)),
            ),
          ),
        );

        final positioned = tester.widget<Positioned>(
          find.descendant(
            of: find.byType(Stack),
            matching: find.byType(Positioned),
          ),
        );

        expect(positioned.top, isNotNull);
        expect(positioned.right, isNotNull);
      });

      testWidgets('positions badge at topStart', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 5,
                position: BadgePosition.topStart,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        final positioned = tester.widget<Positioned>(
          find.descendant(
            of: find.byType(Stack),
            matching: find.byType(Positioned),
          ),
        );

        expect(positioned.top, isNotNull);
        expect(positioned.left, isNotNull);
      });

      testWidgets('positions badge at bottomEnd', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 5,
                position: BadgePosition.bottomEnd,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        final positioned = tester.widget<Positioned>(
          find.descendant(
            of: find.byType(Stack),
            matching: find.byType(Positioned),
          ),
        );

        expect(positioned.bottom, isNotNull);
        expect(positioned.right, isNotNull);
      });

      testWidgets('positions badge at bottomStart', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 5,
                position: BadgePosition.bottomStart,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        final positioned = tester.widget<Positioned>(
          find.descendant(
            of: find.byType(Stack),
            matching: find.byType(Positioned),
          ),
        );

        expect(positioned.bottom, isNotNull);
        expect(positioned.left, isNotNull);
      });
    });

    group('Custom Offset', () {
      testWidgets('applies custom horizontal offset', (tester) async {
        const customOffset = Offset(10, 0);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 5,
                offset: customOffset,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        // Verify badge is rendered (offset is applied internally)
        expect(find.text('5'), findsOneWidget);
      });

      testWidgets('applies custom vertical offset', (tester) async {
        const customOffset = Offset(0, 15);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 5,
                offset: customOffset,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        expect(find.text('5'), findsOneWidget);
      });

      testWidgets('applies custom bidirectional offset', (tester) async {
        const customOffset = Offset(8, 12);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 5,
                offset: customOffset,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        expect(find.text('5'), findsOneWidget);
      });
    });

    group('Auto-Hide Behavior', () {
      testWidgets('hides badge when count is 0 and autoHide is true', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 0,
                autoHide: true,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        // Badge should be hidden, only child should be visible
        expect(find.text('0'), findsNothing);
        expect(find.byIcon(Icons.notifications), findsOneWidget);
      });

      testWidgets('shows badge when count is 0 and autoHide is false', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 0,
                autoHide: false,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        // Badge with 0 should be visible
        expect(find.text('0'), findsOneWidget);
      });

      testWidgets('shows badge when count is greater than 0', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 1,
                autoHide: true,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        expect(find.text('1'), findsOneWidget);
      });

      testWidgets('dot badge always shows regardless of autoHide', (
        tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppBadge.dot(child: Icon(Icons.message))),
          ),
        );

        // Dot badge should always be visible
        expect(find.byType(Container), findsWidgets);
      });
    });

    group('Size Variants', () {
      testWidgets('renders small badge by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 5, child: const Icon(Icons.notifications)),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Stack),
            matching: find.byType(Container),
          ),
        );

        final constraints = container.constraints;
        expect(constraints?.minHeight, equals(16.0));
      });

      testWidgets('renders large badge when isLarge is true', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 5,
                isLarge: true,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Stack),
            matching: find.byType(Container),
          ),
        );

        final constraints = container.constraints;
        expect(constraints?.minHeight, equals(20.0));
      });

      testWidgets('dot badge has fixed size', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppBadge.dot(child: Icon(Icons.message))),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Stack),
            matching: find.byType(Container),
          ),
        );

        expect(container.constraints?.maxWidth, equals(6.0));
        expect(container.constraints?.maxHeight, equals(6.0));
      });
    });

    group('Custom Colors', () {
      testWidgets('applies custom background color', (tester) async {
        const customColor = Colors.green;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 5,
                backgroundColor: customColor,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Stack),
            matching: find.byType(Container),
          ),
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(customColor));
      });

      testWidgets('applies custom text color', (tester) async {
        const customTextColor = Colors.yellow;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 5,
                textColor: customTextColor,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        final text = tester.widget<Text>(find.text('5'));
        expect(text.style?.color, equals(customTextColor));
      });

      testWidgets('uses theme colors by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                error: Colors.red,
                onError: Colors.white,
              ),
            ),
            home: Scaffold(
              body: AppBadge(count: 5, child: const Icon(Icons.notifications)),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(Stack),
            matching: find.byType(Container),
          ),
        );

        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, equals(Colors.red));
      });
    });

    group('Visibility', () {
      testWidgets('badge is visible when count > 0', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 3, child: const Icon(Icons.notifications)),
            ),
          ),
        );

        expect(find.text('3'), findsOneWidget);
      });

      testWidgets('badge uses Stack for overlay', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 5, child: const Icon(Icons.notifications)),
            ),
          ),
        );

        expect(find.byType(Stack), findsWidgets);
      });

      testWidgets('child widget is always rendered', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 0,
                autoHide: true,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        // Even when badge is hidden, child should be visible
        expect(find.byIcon(Icons.notifications), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('has semantic label for single notification', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 1, child: const Icon(Icons.notifications)),
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find
              .descendant(
                of: find.byType(Stack),
                matching: find.byType(Semantics),
              )
              .last,
        );

        expect(semantics.properties.label, contains('1 notification'));
      });

      testWidgets('has semantic label for multiple notifications', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 5, child: const Icon(Icons.notifications)),
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find
              .descendant(
                of: find.byType(Stack),
                matching: find.byType(Semantics),
              )
              .last,
        );

        expect(semantics.properties.label, contains('5 notifications'));
      });

      testWidgets('has semantic label for 99+ notifications', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 150,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find
              .descendant(
                of: find.byType(Stack),
                matching: find.byType(Semantics),
              )
              .last,
        );

        expect(semantics.properties.label, contains('More than 99'));
      });

      testWidgets('has semantic label for dot badge', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppBadge.dot(child: Icon(Icons.message))),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find
              .descendant(
                of: find.byType(Stack),
                matching: find.byType(Semantics),
              )
              .last,
        );

        expect(semantics.properties.label, contains('Status indicator'));
      });
    });

    group('Edge Cases', () {
      testWidgets('handles zero count correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 0,
                autoHide: false,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        expect(find.text('0'), findsOneWidget);
      });

      testWidgets('handles count boundary at 99/100', (tester) async {
        // Test 99
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(count: 99, child: const Icon(Icons.notifications)),
            ),
          ),
        );

        expect(find.text('99'), findsOneWidget);

        // Test 100
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 100,
                child: const Icon(Icons.notifications),
              ),
            ),
          ),
        );

        expect(find.text('99+'), findsOneWidget);
      });

      testWidgets('works with different child widget types', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 3,
                child: Container(width: 50, height: 50, color: Colors.blue),
              ),
            ),
          ),
        );

        expect(find.text('3'), findsOneWidget);
        expect(find.byType(Container), findsWidgets);
      });

      testWidgets('handles all parameters together', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppBadge(
                count: 42,
                position: BadgePosition.bottomStart,
                offset: const Offset(5, 5),
                autoHide: false,
                isLarge: true,
                backgroundColor: Colors.purple,
                textColor: Colors.white,
                child: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
        );

        expect(find.text('42'), findsOneWidget);
        expect(find.byIcon(Icons.shopping_cart), findsOneWidget);
      });
    });
  });
}
