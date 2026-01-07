// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/widgets/chips/app_filter_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppFilterChip', () {
    testWidgets('renders with label only', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(label: 'Test Filter', onSelected: (_) {}),
          ),
        ),
      );

      expect(find.text('Test Filter'), findsOneWidget);
    });

    testWidgets('renders in unselected state by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(label: 'Test Filter', onSelected: (_) {}),
          ),
        ),
      );

      final filterChip = tester.widget<FilterChip>(find.byType(FilterChip));
      expect(filterChip.selected, isFalse);
    });

    testWidgets('renders in selected state when specified', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              selected: true,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      final filterChip = tester.widget<FilterChip>(find.byType(FilterChip));
      expect(filterChip.selected, isTrue);
    });

    testWidgets('shows checkmark when selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              selected: true,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      // Check that checkmark icon is present (manually added as avatar)
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('does not show checkmark when unselected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              selected: false,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      // Checkmark should not be visible in unselected state
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('calls onSelected with true when tapped while unselected', (
      WidgetTester tester,
    ) async {
      bool? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              selected: false,
              onSelected: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppFilterChip));
      await tester.pump();

      expect(selectedValue, isTrue);
    });

    testWidgets('calls onSelected with false when tapped while selected', (
      WidgetTester tester,
    ) async {
      bool? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              selected: true,
              onSelected: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppFilterChip));
      await tester.pump();

      expect(selectedValue, isFalse);
    });

    testWidgets('does not call onSelected when disabled', (
      WidgetTester tester,
    ) async {
      bool? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              enabled: false,
              onSelected: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppFilterChip));
      await tester.pump();

      expect(selectedValue, isNull);
    });

    testWidgets('renders with custom icon when unselected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              icon: Icons.star,
              selected: false,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('replaces custom icon with checkmark when selected', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              icon: Icons.star,
              selected: true,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNothing);
    });

    testWidgets('renders with avatar in both states', (
      WidgetTester tester,
    ) async {
      const avatar = CircleAvatar(child: Text('A'));

      // Unselected state
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              avatar: avatar,
              selected: false,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byWidget(avatar), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);

      // Selected state
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              avatar: avatar,
              selected: true,
              onSelected: (_) {},
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byWidget(avatar), findsOneWidget);
      // Checkmark is hidden when avatar is present
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('avatar takes precedence over icon', (
      WidgetTester tester,
    ) async {
      const avatar = CircleAvatar(child: Text('A'));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              icon: Icons.star,
              avatar: avatar,
              selected: false,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byWidget(avatar), findsOneWidget);
      expect(find.byIcon(Icons.star), findsNothing);
    });

    testWidgets('applies custom selected color', (WidgetTester tester) async {
      const customColor = Colors.purple;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              selected: true,
              selectedColor: customColor,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      final filterChip = tester.widget<FilterChip>(find.byType(FilterChip));
      expect(filterChip.selectedColor, equals(customColor));
    });

    testWidgets('applies custom checkmark color', (WidgetTester tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              selected: true,
              checkmarkColor: customColor,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      final filterChip = tester.widget<FilterChip>(find.byType(FilterChip));
      expect(filterChip.checkmarkColor, equals(customColor));
    });

    testWidgets('applies custom label style', (WidgetTester tester) async {
      const customStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              labelStyle: customStyle,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('Test Filter'));
      expect(textWidget.style?.fontSize, equals(20));
      expect(textWidget.style?.fontWeight, equals(FontWeight.bold));
    });

    testWidgets('renders with custom elevation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              elevation: 4.0,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      final filterChip = tester.widget<FilterChip>(find.byType(FilterChip));
      expect(filterChip.elevation, equals(4.0));
    });

    testWidgets('renders with custom shape', (WidgetTester tester) async {
      const customShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              shape: customShape,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      final filterChip = tester.widget<FilterChip>(find.byType(FilterChip));
      expect(filterChip.shape, equals(customShape));
    });

    testWidgets('renders with tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              tooltip: 'Filter tooltip',
              onSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(Tooltip), findsOneWidget);

      final tooltip = tester.widget<Tooltip>(find.byType(Tooltip));
      expect(tooltip.message, equals('Filter tooltip'));
    });

    testWidgets('applies disabled opacity when not enabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              enabled: false,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      final opacity = tester.widget<Opacity>(find.byType(Opacity));
      expect(opacity.opacity, equals(0.38));
    });

    testWidgets('supports keyboard focus', (WidgetTester tester) async {
      final focusNode = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppFilterChip(
              label: 'Test Filter',
              focusNode: focusNode,
              autofocus: true,
              onSelected: (_) {},
            ),
          ),
        ),
      );

      await tester.pump();

      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets('works in filter group', (WidgetTester tester) async {
      final selectedFilters = <String>{};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return Wrap(
                  spacing: 8,
                  children: [
                    AppFilterChip(
                      label: 'Electronics',
                      selected: selectedFilters.contains('electronics'),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedFilters.add('electronics');
                          } else {
                            selectedFilters.remove('electronics');
                          }
                        });
                      },
                    ),
                    AppFilterChip(
                      label: 'Clothing',
                      selected: selectedFilters.contains('clothing'),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedFilters.add('clothing');
                          } else {
                            selectedFilters.remove('clothing');
                          }
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Initially no filters selected
      expect(selectedFilters, isEmpty);

      // Tap first chip
      await tester.tap(find.text('Electronics'));
      await tester.pumpAndSettle();

      expect(selectedFilters, contains('electronics'));
      expect(selectedFilters, isNot(contains('clothing')));

      // Tap second chip
      await tester.tap(find.text('Clothing'));
      await tester.pumpAndSettle();

      expect(selectedFilters, contains('electronics'));
      expect(selectedFilters, contains('clothing'));

      // Untap first chip
      await tester.tap(find.text('Electronics'));
      await tester.pumpAndSettle();

      expect(selectedFilters, isNot(contains('electronics')));
      expect(selectedFilters, contains('clothing'));
    });
  });
}
