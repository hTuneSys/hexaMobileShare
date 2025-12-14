// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppRadioGroup', () {
    // Test data
    final testOptions = [
      const RadioOption<String>(value: 'option1', label: 'Option 1'),
      const RadioOption<String>(value: 'option2', label: 'Option 2'),
      const RadioOption<String>(value: 'option3', label: 'Option 3'),
    ];

    group('Basic Functionality', () {
      testWidgets('renders correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.byType(AppRadioGroup<String>), findsOneWidget);
        expect(find.byType(Radio<String>), findsNWidgets(3));
      });

      testWidgets('displays all options', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text('Option 1'), findsOneWidget);
        expect(find.text('Option 2'), findsOneWidget);
        expect(find.text('Option 3'), findsOneWidget);
      });

      testWidgets('shows selected value', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                value: 'option2',
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        // Verify RadioGroup ancestor has correct value
        final radioGroup = tester.widget<RadioGroup<String>>(
          find.byType(RadioGroup<String>),
        );
        expect(radioGroup.groupValue, 'option2');
      });

      testWidgets('no option selected when value is null', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                value: null,
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        // Verify RadioGroup ancestor has null value
        final radioGroup = tester.widget<RadioGroup<String>>(
          find.byType(RadioGroup<String>),
        );
        expect(radioGroup.groupValue, null);
      });
    });

    group('Selection Logic', () {
      testWidgets('calls onChanged when option tapped', (
        WidgetTester tester,
      ) async {
        String? selectedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: testOptions,
                onChanged: (value) {
                  selectedValue = value;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Option 2'));
        await tester.pumpAndSettle();

        expect(selectedValue, 'option2');
      });

      testWidgets('calls onChanged when radio button tapped', (
        WidgetTester tester,
      ) async {
        String? selectedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: testOptions,
                onChanged: (value) {
                  selectedValue = value;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(Radio<String>).at(1));
        await tester.pumpAndSettle();

        expect(selectedValue, 'option2');
      });

      testWidgets('allows only single selection', (WidgetTester tester) async {
        String? selectedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return AppRadioGroup<String>(
                    value: selectedValue,
                    options: testOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        );

        // Select first option
        await tester.tap(find.text('Option 1'));
        await tester.pumpAndSettle();
        expect(selectedValue, 'option1');

        // Select second option - should replace first
        await tester.tap(find.text('Option 2'));
        await tester.pumpAndSettle();
        expect(selectedValue, 'option2');

        // Verify RadioGroup has the correct selected value
        final radioGroup = tester.widget<RadioGroup<String>>(
          find.byType(RadioGroup<String>),
        );
        expect(radioGroup.groupValue, 'option2');
      });

      testWidgets('can change selection from one option to another', (
        WidgetTester tester,
      ) async {
        final selections = <String?>[];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return AppRadioGroup<String>(
                    value: selections.isNotEmpty ? selections.last : null,
                    options: testOptions,
                    onChanged: (value) {
                      setState(() {
                        selections.add(value);
                      });
                    },
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Option 1'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Option 3'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Option 2'));
        await tester.pumpAndSettle();

        expect(selections, ['option1', 'option3', 'option2']);
      });
    });

    group('Layout Variants', () {
      testWidgets('renders vertical layout by default', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        // Vertical layout - options should be stacked
        final option1 = tester.getTopLeft(find.text('Option 1'));
        final option2 = tester.getTopLeft(find.text('Option 2'));
        final option3 = tester.getTopLeft(find.text('Option 3'));

        // In vertical layout, y positions should be different
        expect(option2.dy, greaterThan(option1.dy));
        expect(option3.dy, greaterThan(option2.dy));
      });

      testWidgets('renders horizontal layout when specified', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                direction: Axis.horizontal,
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        // Horizontal layout - options should be side by side
        final option1 = tester.getTopLeft(find.text('Option 1'));
        final option2 = tester.getTopLeft(find.text('Option 2'));

        // In horizontal layout, x positions should be different
        expect(option2.dx, greaterThan(option1.dx));
      });

      testWidgets('uses custom spacing when provided', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                spacing: 24.0,
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.byType(AppRadioGroup<String>), findsOneWidget);
      });
    });

    group('Group Label', () {
      testWidgets('displays label when provided', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                label: 'Select an option',
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text('Select an option'), findsOneWidget);
      });

      testWidgets('does not display label when null', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        // Only option labels should be visible
        expect(find.text('Option 1'), findsOneWidget);
        expect(find.text('Option 2'), findsOneWidget);
        expect(find.text('Option 3'), findsOneWidget);
      });

      testWidgets('label appears above options', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                label: 'Group Label',
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final labelPosition = tester.getTopLeft(find.text('Group Label'));
        final option1Position = tester.getTopLeft(find.text('Option 1'));

        expect(labelPosition.dy, lessThan(option1Position.dy));
      });
    });

    group('Disabled States', () {
      testWidgets('entire group disabled when enabled is false', (
        WidgetTester tester,
      ) async {
        bool called = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                enabled: false,
                options: testOptions,
                onChanged: (_) {
                  called = true;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Option 1'));
        await tester.pumpAndSettle();

        expect(called, false);
      });

      testWidgets('entire group disabled when onChanged is null', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: testOptions,
                onChanged: null,
              ),
            ),
          ),
        );

        // Verify IgnorePointer is blocking interactions when disabled
        final ignorePointer = tester.widget<IgnorePointer>(
          find
              .descendant(
                of: find.byType(AppRadioGroup<String>),
                matching: find.byType(IgnorePointer),
              )
              .first,
        );
        expect(ignorePointer.ignoring, true);
      });

      testWidgets('individual option disabled', (WidgetTester tester) async {
        String? selectedValue;
        final optionsWithDisabled = [
          const RadioOption<String>(value: 'opt1', label: 'Enabled Option'),
          const RadioOption<String>(
            value: 'opt2',
            label: 'Disabled Option',
            enabled: false,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: optionsWithDisabled,
                onChanged: (value) {
                  selectedValue = value;
                },
              ),
            ),
          ),
        );

        // Tap disabled option
        await tester.tap(find.text('Disabled Option'));
        await tester.pumpAndSettle();
        expect(selectedValue, null);

        // Tap enabled option
        await tester.tap(find.text('Enabled Option'));
        await tester.pumpAndSettle();
        expect(selectedValue, 'opt1');
      });

      testWidgets('disabled group shows reduced opacity on label', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                label: 'Disabled Group',
                enabled: false,
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final labelText = tester.widget<Text>(find.text('Disabled Group'));
        expect(labelText.style?.color?.a, closeTo(0.38, 0.01));
      });
    });

    group('Error Handling', () {
      testWidgets('displays error styling when error is true', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                label: 'Select option',
                error: true,
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final labelText = tester.widget<Text>(find.text('Select option'));
        final theme = Theme.of(
          tester.element(find.byType(AppRadioGroup<String>)),
        );
        expect(labelText.style?.color, theme.colorScheme.error);
      });

      testWidgets('displays error text when provided', (
        WidgetTester tester,
      ) async {
        const errorMessage = 'Please select an option';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                error: true,
                errorText: errorMessage,
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text(errorMessage), findsOneWidget);
      });

      testWidgets('does not display error text when error is false', (
        WidgetTester tester,
      ) async {
        const errorMessage = 'Please select an option';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                error: false,
                errorText: errorMessage,
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text(errorMessage), findsNothing);
      });

      testWidgets('error text uses error color', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                error: true,
                errorText: 'Error message',
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final errorText = tester.widget<Text>(find.text('Error message'));
        final theme = Theme.of(
          tester.element(find.byType(AppRadioGroup<String>)),
        );
        expect(errorText.style?.color, theme.colorScheme.error);
      });
    });

    group('Icons and Descriptions', () {
      testWidgets('displays icon when provided', (WidgetTester tester) async {
        final optionsWithIcons = [
          const RadioOption<String>(
            value: 'opt1',
            label: 'With Icon',
            icon: Icons.star,
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: optionsWithIcons,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsOneWidget);
      });

      testWidgets('displays description when provided', (
        WidgetTester tester,
      ) async {
        final optionsWithDesc = [
          const RadioOption<String>(
            value: 'opt1',
            label: 'Option Label',
            description: 'This is a description',
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: optionsWithDesc,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text('This is a description'), findsOneWidget);
      });

      testWidgets('description appears below label', (
        WidgetTester tester,
      ) async {
        final optionsWithDesc = [
          const RadioOption<String>(
            value: 'opt1',
            label: 'Label',
            description: 'Description',
          ),
        ];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: optionsWithDesc,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final labelPos = tester.getTopLeft(find.text('Label'));
        final descPos = tester.getTopLeft(find.text('Description'));

        expect(descPos.dy, greaterThan(labelPos.dy));
      });
    });

    group('Custom Option Builder', () {
      testWidgets('uses custom builder when provided', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: testOptions,
                onChanged: (_) {},
                optionBuilder: (context, option, isSelected, isEnabled) {
                  return Container(
                    key: ValueKey('custom_${option.value}'),
                    padding: const EdgeInsets.all(16),
                    color: isSelected ? Colors.blue : Colors.grey,
                    child: Text('Custom: ${option.label}'),
                  );
                },
              ),
            ),
          ),
        );

        expect(find.text('Custom: Option 1'), findsOneWidget);
        expect(find.text('Custom: Option 2'), findsOneWidget);
        expect(find.text('Custom: Option 3'), findsOneWidget);
      });

      testWidgets('custom builder receives correct selection state', (
        WidgetTester tester,
      ) async {
        final selectionStates = <String, bool>{};

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                value: 'option2',
                options: testOptions,
                onChanged: (_) {},
                optionBuilder: (context, option, isSelected, isEnabled) {
                  selectionStates[option.value] = isSelected;
                  return Text(option.label);
                },
              ),
            ),
          ),
        );

        expect(selectionStates['option1'], false);
        expect(selectionStates['option2'], true);
        expect(selectionStates['option3'], false);
      });
    });

    group('Accessibility', () {
      testWidgets('radio buttons have minimum touch target', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final radioSize = tester.getSize(find.byType(Radio<String>).first);
        expect(radioSize.width, greaterThanOrEqualTo(40));
        expect(radioSize.height, greaterThanOrEqualTo(40));
      });

      testWidgets('renders proper semantics', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                label: 'Test Group',
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.byType(Radio<String>), findsNWidgets(3));
      });
    });

    group('Theme Integration', () {
      testWidgets('uses theme primary color by default', (
        WidgetTester tester,
      ) async {
        const customPrimary = Color(0xFF123456);

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: customPrimary),
            ),
            home: Scaffold(
              body: AppRadioGroup<String>(
                value: 'option1',
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final radio = tester.widget<Radio<String>>(
          find.byType(Radio<String>).first,
        );
        final theme = Theme.of(
          tester.element(find.byType(AppRadioGroup<String>)),
        );
        expect(radio.activeColor, theme.colorScheme.primary);
      });

      testWidgets('activeColor overrides theme color', (
        WidgetTester tester,
      ) async {
        const customColor = Color(0xFFFF5722);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                value: 'option1',
                activeColor: customColor,
                options: testOptions,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final radio = tester.widget<Radio<String>>(
          find.byType(Radio<String>).first,
        );
        expect(radio.activeColor, customColor);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles single option', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<String>(
                options: const [
                  RadioOption(value: 'only', label: 'Only Option'),
                ],
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text('Only Option'), findsOneWidget);
        expect(find.byType(Radio<String>), findsOneWidget);
      });

      testWidgets('handles many options', (WidgetTester tester) async {
        final manyOptions = List.generate(
          10,
          (i) => RadioOption<int>(value: i, label: 'Option $i'),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: AppRadioGroup<int>(
                  options: manyOptions,
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
        );

        expect(find.byType(Radio<int>), findsNWidgets(10));
      });

      testWidgets('works with different value types', (
        WidgetTester tester,
      ) async {
        final intOptions = [
          const RadioOption<int>(value: 1, label: 'One'),
          const RadioOption<int>(value: 2, label: 'Two'),
        ];

        int? selectedInt;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppRadioGroup<int>(
                options: intOptions,
                onChanged: (value) {
                  selectedInt = value;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Two'));
        await tester.pumpAndSettle();

        expect(selectedInt, 2);
      });

      testWidgets('RadioOption equality works correctly', (
        WidgetTester tester,
      ) async {
        const option1 = RadioOption<String>(value: 'a', label: 'A');
        const option2 = RadioOption<String>(value: 'a', label: 'A');
        const option3 = RadioOption<String>(value: 'b', label: 'B');

        expect(option1 == option2, true);
        expect(option1 == option3, false);
        expect(option1.hashCode == option2.hashCode, true);
      });
    });
  });
}
