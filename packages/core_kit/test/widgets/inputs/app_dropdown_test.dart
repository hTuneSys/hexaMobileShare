// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppDropdown', () {
    // =========================================================================
    // Unit Tests - Logic and State
    // =========================================================================

    group('Unit Tests', () {
      test('AppDropdownItem equality works correctly', () {
        const item1 = AppDropdownItem(value: 'test', label: 'Test');
        const item2 = AppDropdownItem(value: 'test', label: 'Test');
        const item3 = AppDropdownItem(value: 'other', label: 'Other');

        expect(item1, equals(item2));
        expect(item1, isNot(equals(item3)));
      });

      test('AppDropdownItem hashCode is consistent', () {
        const item1 = AppDropdownItem(value: 'test', label: 'Test');
        const item2 = AppDropdownItem(value: 'test', label: 'Test');

        expect(item1.hashCode, equals(item2.hashCode));
      });

      test('AppDropdownItem toString returns correct format', () {
        const item = AppDropdownItem(value: 'test', label: 'Test Label');

        expect(item.toString(), contains('test'));
        expect(item.toString(), contains('Test Label'));
      });
    });

    // =========================================================================
    // Widget Tests - UI and Interaction
    // =========================================================================

    group('Widget Tests', () {
      testWidgets('renders with basic configuration', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppDropdown<String>(
                items: const ['Option 1', 'Option 2', 'Option 3'],
                itemLabelBuilder: (item) => item,
                label: 'Test Label',
                hint: 'Test Hint',
              ),
            ),
          ),
        );

        expect(find.text('Test Label'), findsWidgets);
        expect(find.text('Test Hint'), findsWidgets);
      });

      testWidgets('displays selected value', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppDropdown<String>(
                items: const ['Option 1', 'Option 2', 'Option 3'],
                value: 'Option 2',
                itemLabelBuilder: (item) => item,
                label: 'Select',
              ),
            ),
          ),
        );

        expect(find.text('Option 2'), findsWidgets);
      });

      testWidgets('onChanged callback is triggered on selection', (
        tester,
      ) async {
        String? selectedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppDropdown<String>(
                items: const ['Option 1', 'Option 2', 'Option 3'],
                itemLabelBuilder: (item) => item,
                label: 'Select',
                onChanged: (value) {
                  selectedValue = value;
                },
              ),
            ),
          ),
        );

        // Tap on the dropdown to open menu
        await tester.tap(find.byType(DropdownMenu<String>));
        await tester.pumpAndSettle();

        // Select an option
        await tester.tap(find.text('Option 2').last);
        await tester.pumpAndSettle();

        expect(selectedValue, equals('Option 2'));
      });

      testWidgets('displays helper text when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppDropdown<String>(
                items: const ['Option 1', 'Option 2'],
                itemLabelBuilder: (item) => item,
                label: 'Select',
                helperText: 'This is helper text',
              ),
            ),
          ),
        );

        expect(find.text('This is helper text'), findsOneWidget);
      });

      testWidgets('displays error text when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppDropdown<String>(
                items: const ['Option 1', 'Option 2'],
                itemLabelBuilder: (item) => item,
                label: 'Select',
                errorText: 'This field is required',
              ),
            ),
          ),
        );

        expect(find.text('This field is required'), findsOneWidget);
      });

      testWidgets('does not display helper text when error text is present', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppDropdown<String>(
                items: const ['Option 1', 'Option 2'],
                itemLabelBuilder: (item) => item,
                label: 'Select',
                helperText: 'Helper text',
                errorText: 'Error text',
              ),
            ),
          ),
        );

        expect(find.text('Error text'), findsOneWidget);
        expect(find.text('Helper text'), findsNothing);
      });

      testWidgets('disabled state prevents interaction', (tester) async {
        String? selectedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppDropdown<String>(
                items: const ['Option 1', 'Option 2', 'Option 3'],
                itemLabelBuilder: (item) => item,
                label: 'Select',
                enabled: false,
                onChanged: (value) {
                  selectedValue = value;
                },
              ),
            ),
          ),
        );

        // Try to tap on the disabled dropdown
        await tester.tap(find.byType(DropdownMenu<String>));
        await tester.pumpAndSettle();

        expect(selectedValue, isNull);
      });

      testWidgets('renders with leading icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppDropdown<String>(
                items: const ['Option 1', 'Option 2'],
                itemLabelBuilder: (item) => item,
                label: 'Select',
                leadingIcon: Icons.person,
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.person), findsWidgets);
      });

      testWidgets(
        'search functionality is enabled with withSearch constructor',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: AppDropdown<String>.withSearch(
                  items: const ['Apple', 'Banana', 'Cherry', 'Date'],
                  itemLabelBuilder: (item) => item,
                  label: 'Select Fruit',
                ),
              ),
            ),
          );

          // Dropdown should render
          expect(find.byType(DropdownMenu<String>), findsOneWidget);
        },
      );

      testWidgets('works with custom objects', (tester) async {
        final items = [
          const AppDropdownItem(value: '1', label: 'Item 1', icon: Icons.home),
          const AppDropdownItem(value: '2', label: 'Item 2', icon: Icons.work),
          const AppDropdownItem(
            value: '3',
            label: 'Item 3',
            icon: Icons.school,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) => AppDropdown<AppDropdownItem<String>>(
                  items: items,
                  itemLabelBuilder: (item) => item.label,
                  customItemBuilder: (item) => item.buildWidget(context),
                  label: 'Select',
                ),
              ),
            ),
          ),
        );

        expect(find.text('Item 1'), findsOneWidget);
      });

      testWidgets('null value shows hint text', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppDropdown<String>(
                items: const ['Option 1', 'Option 2'],
                value: null,
                itemLabelBuilder: (item) => item,
                label: 'Select',
                hint: 'Choose an option',
              ),
            ),
          ),
        );

        expect(find.text('Choose an option'), findsOneWidget);
      });

      testWidgets('respects custom width', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppDropdown<String>(
                items: const ['Option 1', 'Option 2'],
                itemLabelBuilder: (item) => item,
                label: 'Select',
                width: 200,
              ),
            ),
          ),
        );

        final dropdownMenu = tester.widget<DropdownMenu<String>>(
          find.byType(DropdownMenu<String>),
        );
        expect(dropdownMenu.width, equals(200));
      });
    });

    // =========================================================================
    // AppDropdownItem Widget Builder Tests
    // =========================================================================

    group('AppDropdownItem Widget Builder', () {
      testWidgets('builds widget with icon', (tester) async {
        const item = AppDropdownItem(
          value: 'test',
          label: 'Test Item',
          icon: Icons.star,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) => item.buildWidget(context)),
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.text('Test Item'), findsOneWidget);
      });

      testWidgets('builds widget with subtitle', (tester) async {
        const item = AppDropdownItem(
          value: 'test',
          label: 'Test Item',
          subtitle: 'This is a subtitle',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) => item.buildWidget(context)),
            ),
          ),
        );

        expect(find.text('Test Item'), findsOneWidget);
        expect(find.text('This is a subtitle'), findsOneWidget);
      });

      testWidgets('builds widget with icon and subtitle', (tester) async {
        const item = AppDropdownItem(
          value: 'test',
          label: 'Test Item',
          icon: Icons.star,
          subtitle: 'This is a subtitle',
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(builder: (context) => item.buildWidget(context)),
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.text('Test Item'), findsOneWidget);
        expect(find.text('This is a subtitle'), findsOneWidget);
      });
    });
  });
}
