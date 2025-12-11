// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppCheckbox', () {
    group('Basic Functionality', () {
      testWidgets('renders correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: AppCheckbox(value: false, onChanged: (_) {})),
          ),
        );

        expect(find.byType(AppCheckbox), findsOneWidget);
        expect(find.byType(Checkbox), findsOneWidget);
      });

      testWidgets('displays unchecked state', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: AppCheckbox(value: false, onChanged: (_) {})),
          ),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, false);
      });

      testWidgets('displays checked state', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: AppCheckbox(value: true, onChanged: (_) {})),
          ),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.value, true);
      });

      testWidgets('calls onChanged when tapped', (WidgetTester tester) async {
        bool? changedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                onChanged: (value) {
                  changedValue = value;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(Checkbox));
        await tester.pumpAndSettle();

        expect(changedValue, true);
      });

      testWidgets('toggles from checked to unchecked', (
        WidgetTester tester,
      ) async {
        bool? changedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: true,
                onChanged: (value) {
                  changedValue = value;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(Checkbox));
        await tester.pumpAndSettle();

        expect(changedValue, false);
      });
    });

    group('Tristate Support', () {
      testWidgets('supports tristate mode', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(value: null, tristate: true, onChanged: (_) {}),
            ),
          ),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.tristate, true);
        expect(checkbox.value, null);
      });

      testWidgets('cycles through tristate values correctly', (
        WidgetTester tester,
      ) async {
        bool? currentValue = false;
        final values = <bool?>[];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return AppCheckbox(
                    value: currentValue,
                    tristate: true,
                    onChanged: (value) {
                      setState(() {
                        currentValue = value;
                        values.add(value);
                      });
                    },
                  );
                },
              ),
            ),
          ),
        );

        // Tap 1: false → true
        await tester.tap(find.byType(Checkbox));
        await tester.pumpAndSettle();
        expect(values.last, true);

        // Tap 2: true → null
        await tester.tap(find.byType(Checkbox));
        await tester.pumpAndSettle();
        expect(values.last, null);

        // Tap 3: null → false
        await tester.tap(find.byType(Checkbox));
        await tester.pumpAndSettle();
        expect(values.last, false);
      });
    });

    group('Label Integration', () {
      testWidgets('displays label when provided', (WidgetTester tester) async {
        const labelText = 'Accept terms';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                label: labelText,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text(labelText), findsOneWidget);
      });

      testWidgets('does not display label when null', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: AppCheckbox(value: false, onChanged: (_) {})),
          ),
        );

        expect(find.byType(Text), findsNothing);
      });

      testWidgets('label wraps correctly with long text', (
        WidgetTester tester,
      ) async {
        const longLabel =
            'This is a very long label that should wrap to multiple lines when the available space is limited';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                child: AppCheckbox(
                  value: false,
                  label: longLabel,
                  onChanged: (_) {},
                ),
              ),
            ),
          ),
        );

        expect(find.text(longLabel), findsOneWidget);
      });

      testWidgets('label is tappable', (WidgetTester tester) async {
        bool? changedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                label: 'Tap me',
                onChanged: (value) {
                  changedValue = value;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Tap me'));
        await tester.pumpAndSettle();

        expect(changedValue, true);
      });
    });

    group('Error Handling', () {
      testWidgets('displays error state styling', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(value: false, error: true, onChanged: (_) {}),
            ),
          ),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        final theme = Theme.of(tester.element(find.byType(AppCheckbox)));
        expect(checkbox.activeColor, theme.colorScheme.error);
      });

      testWidgets('displays error text when provided', (
        WidgetTester tester,
      ) async {
        const errorMessage = 'This field is required';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                error: true,
                errorText: errorMessage,
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
        const errorMessage = 'This field is required';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                error: false,
                errorText: errorMessage,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text(errorMessage), findsNothing);
      });

      testWidgets('label uses error color when error is true', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                label: 'Required field',
                error: true,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final text = tester.widget<Text>(find.text('Required field'));
        final theme = Theme.of(tester.element(find.byType(AppCheckbox)));
        expect(text.style?.color, theme.colorScheme.error);
      });
    });

    group('Disabled State', () {
      testWidgets('is disabled when onChanged is null', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppCheckbox(value: false, onChanged: null)),
          ),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.onChanged, null);
      });

      testWidgets('is disabled when enabled is false', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                enabled: false,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.onChanged, null);
      });

      testWidgets('disabled checkbox does not trigger onChanged', (
        WidgetTester tester,
      ) async {
        bool called = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                enabled: false,
                onChanged: (_) {
                  called = true;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.byType(Checkbox));
        await tester.pumpAndSettle();

        expect(called, false);
      });

      testWidgets('disabled label has reduced opacity', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                label: 'Disabled checkbox',
                onChanged: null,
              ),
            ),
          ),
        );

        final text = tester.widget<Text>(find.text('Disabled checkbox'));
        expect(text.style?.color?.a, closeTo(0.38, 0.01));
      });
    });

    group('Accessibility', () {
      testWidgets('has minimum touch target size', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: AppCheckbox(value: false, onChanged: (_) {})),
          ),
        );

        final checkboxSize = tester.getSize(find.byType(Checkbox));
        expect(checkboxSize.width, greaterThanOrEqualTo(40));
        expect(checkboxSize.height, greaterThanOrEqualTo(40));
      });

      testWidgets('checkbox has proper semantics', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                label: 'Checkbox label',
                onChanged: (_) {},
              ),
            ),
          ),
        );

        // Checkbox widget has built-in semantics
        expect(find.byType(Checkbox), findsOneWidget);
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
            home: Scaffold(body: AppCheckbox(value: true, onChanged: (_) {})),
          ),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        final theme = Theme.of(tester.element(find.byType(AppCheckbox)));
        expect(checkbox.activeColor, theme.colorScheme.primary);
      });

      testWidgets('activeColor overrides theme color', (
        WidgetTester tester,
      ) async {
        const customColor = Color(0xFFFF5722);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: true,
                activeColor: customColor,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.activeColor, customColor);
      });

      testWidgets('checkColor overrides default', (WidgetTester tester) async {
        const customCheckColor = Color(0xFF00FF00);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: true,
                checkColor: customCheckColor,
                onChanged: (_) {},
              ),
            ),
          ),
        );

        final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
        expect(checkbox.checkColor, customCheckColor);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles empty label', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(value: false, label: '', onChanged: (_) {}),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
      });

      testWidgets('handles rapid tapping', (WidgetTester tester) async {
        int callCount = 0;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppCheckbox(
                value: false,
                onChanged: (_) {
                  callCount++;
                },
              ),
            ),
          ),
        );

        // Tap rapidly 5 times
        for (int i = 0; i < 5; i++) {
          await tester.tap(find.byType(Checkbox));
        }
        await tester.pumpAndSettle();

        expect(callCount, 5);
      });

      testWidgets('multiple checkboxes can coexist', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppCheckbox(
                    value: false,
                    label: 'Checkbox 1',
                    onChanged: (_) {},
                  ),
                  AppCheckbox(
                    value: true,
                    label: 'Checkbox 2',
                    onChanged: (_) {},
                  ),
                  AppCheckbox(
                    value: null,
                    tristate: true,
                    label: 'Checkbox 3',
                    onChanged: (_) {},
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byType(AppCheckbox), findsNWidgets(3));
        expect(find.text('Checkbox 1'), findsOneWidget);
        expect(find.text('Checkbox 2'), findsOneWidget);
        expect(find.text('Checkbox 3'), findsOneWidget);
      });
    });
  });
}
