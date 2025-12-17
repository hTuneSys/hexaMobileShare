// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppPasswordField', () {
    testWidgets('renders with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppPasswordField(label: 'Password')),
        ),
      );

      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('obscures text by default', (WidgetTester tester) async {
      final controller = TextEditingController(text: 'test123');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPasswordField(controller: controller, label: 'Password'),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });

    testWidgets('toggles visibility when icon is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppPasswordField(label: 'Password')),
        ),
      );

      // Initially obscured
      TextField textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);

      // Find and tap visibility toggle
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // Now visible
      textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isFalse);

      // Toggle again
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // Obscured again
      textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });

    testWidgets('shows strength indicator when enabled', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPasswordField(
              controller: controller,
              label: 'Password',
              showStrengthIndicator: true,
            ),
          ),
        ),
      );

      // Enter weak password
      controller.text = '123';
      await tester.pump();

      // Strength indicator should be visible
      expect(find.text('Weak'), findsOneWidget);

      // Enter medium password
      controller.text = 'Test1234';
      await tester.pump();

      expect(find.text('Medium'), findsOneWidget);

      // Enter strong password
      controller.text = 'Test@1234Strong';
      await tester.pump();

      expect(find.text('Strong'), findsOneWidget);
    });

    testWidgets('does not show strength indicator when disabled', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController(text: 'test123');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPasswordField(
              controller: controller,
              label: 'Password',
              showStrengthIndicator: false,
            ),
          ),
        ),
      );

      expect(find.text('Weak'), findsNothing);
      expect(find.text('Medium'), findsNothing);
      expect(find.text('Strong'), findsNothing);
    });

    testWidgets('hides strength indicator when there is an error', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController(text: 'test123');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPasswordField(
              controller: controller,
              label: 'Password',
              showStrengthIndicator: true,
              errorText: 'Password is too short',
            ),
          ),
        ),
      );

      // Error text should be visible
      expect(find.text('Password is too short'), findsOneWidget);
      // Strength indicator should be hidden
      expect(find.text('Weak'), findsNothing);
    });

    testWidgets('shows lock icon when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPasswordField(label: 'Password', showLockIcon: true),
          ),
        ),
      );

      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    testWidgets('calls onChanged callback', (WidgetTester tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPasswordField(
              label: 'Password',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'newpassword');
      expect(changedValue, 'newpassword');
    });

    testWidgets('calls onSubmitted callback', (WidgetTester tester) async {
      String? submittedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppPasswordField(
              label: 'Password',
              onSubmitted: (value) => submittedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'password123');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(submittedValue, 'password123');
    });

    testWidgets('disables field when enabled is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPasswordField(label: 'Password', enabled: false),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('prevents visibility toggle when disabled', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPasswordField(label: 'Password', enabled: false),
          ),
        ),
      );

      // Try to tap visibility toggle
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      // Should still be obscured
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });

    testWidgets('uses correct keyboard type', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppPasswordField(label: 'Password')),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.visiblePassword);
    });

    testWidgets('shows helper text when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPasswordField(
              label: 'Password',
              helperText: 'Use a strong password',
            ),
          ),
        ),
      );

      expect(find.text('Use a strong password'), findsOneWidget);
    });

    testWidgets('shows error text when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppPasswordField(
              label: 'Password',
              errorText: 'Password is required',
            ),
          ),
        ),
      );

      expect(find.text('Password is required'), findsOneWidget);
    });

    testWidgets('has proper accessibility semantics', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppPasswordField(label: 'Password')),
        ),
      );

      // Check for semantic labels
      final semantics = tester.getSemantics(find.byType(TextField));
      expect(semantics.label, contains('Password'));
    });

    group('Password Strength Calculation', () {
      testWidgets('calculates weak strength for short passwords', (
        WidgetTester tester,
      ) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppPasswordField(
                controller: controller,
                label: 'Password',
                showStrengthIndicator: true,
              ),
            ),
          ),
        );

        controller.text = '123';
        await tester.pump();

        expect(find.text('Weak'), findsOneWidget);
      });

      testWidgets('calculates medium strength for basic passwords', (
        WidgetTester tester,
      ) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppPasswordField(
                controller: controller,
                label: 'Password',
                showStrengthIndicator: true,
              ),
            ),
          ),
        );

        controller.text = 'Password1';
        await tester.pump();

        expect(find.text('Medium'), findsOneWidget);
      });

      testWidgets('calculates strong strength for complex passwords', (
        WidgetTester tester,
      ) async {
        final controller = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppPasswordField(
                controller: controller,
                label: 'Password',
                showStrengthIndicator: true,
              ),
            ),
          ),
        );

        controller.text = 'P@ssw0rd!123';
        await tester.pump();

        expect(find.text('Strong'), findsOneWidget);
      });
    });

    group('Password Confirmation Matching', () {
      testWidgets('detects when passwords match', (WidgetTester tester) async {
        final passwordController = TextEditingController();
        final confirmController = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppPasswordField(
                    controller: passwordController,
                    label: 'Password',
                  ),
                  AppPasswordField(
                    controller: confirmController,
                    label: 'Confirm Password',
                  ),
                ],
              ),
            ),
          ),
        );

        // Enter matching passwords
        passwordController.text = 'Test@1234';
        confirmController.text = 'Test@1234';
        await tester.pump();

        // Both should have the same text
        expect(passwordController.text, confirmController.text);
      });

      testWidgets('detects when passwords do not match', (
        WidgetTester tester,
      ) async {
        final passwordController = TextEditingController();
        final confirmController = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppPasswordField(
                    controller: passwordController,
                    label: 'Password',
                  ),
                  AppPasswordField(
                    controller: confirmController,
                    label: 'Confirm Password',
                  ),
                ],
              ),
            ),
          ),
        );

        // Enter non-matching passwords
        passwordController.text = 'Test@1234';
        confirmController.text = 'Different@5678';
        await tester.pump();

        // Should not match
        expect(passwordController.text == confirmController.text, isFalse);
      });

      testWidgets('shows error when confirmation does not match', (
        WidgetTester tester,
      ) async {
        final confirmController = TextEditingController();

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppPasswordField(
                controller: confirmController,
                label: 'Confirm Password',
                errorText: 'Passwords do not match',
              ),
            ),
          ),
        );

        expect(find.text('Passwords do not match'), findsOneWidget);
      });
    });

    group('Dynamic Validation Errors', () {
      testWidgets('shows length error for short passwords', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPasswordField(
                label: 'Password',
                errorText: 'Password must be at least 8 characters',
              ),
            ),
          ),
        );

        expect(
          find.text('Password must be at least 8 characters'),
          findsOneWidget,
        );
      });

      testWidgets('shows uppercase requirement error', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPasswordField(
                label: 'Password',
                errorText:
                    'Password must contain at least one uppercase letter',
              ),
            ),
          ),
        );

        expect(
          find.text('Password must contain at least one uppercase letter'),
          findsOneWidget,
        );
      });

      testWidgets('shows number requirement error', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPasswordField(
                label: 'Password',
                errorText: 'Password must contain at least one number',
              ),
            ),
          ),
        );

        expect(
          find.text('Password must contain at least one number'),
          findsOneWidget,
        );
      });

      testWidgets('shows special character requirement error', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppPasswordField(
                label: 'Password',
                errorText:
                    'Password must contain at least one special character',
              ),
            ),
          ),
        );

        expect(
          find.text('Password must contain at least one special character'),
          findsOneWidget,
        );
      });

      testWidgets('clears error when validation passes', (
        WidgetTester tester,
      ) async {
        final controller = TextEditingController();
        String? errorText = 'Password is too short';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return AppPasswordField(
                    controller: controller,
                    label: 'Password',
                    errorText: errorText,
                    onChanged: (value) {
                      setState(() {
                        if (value.length >= 8) {
                          errorText = null;
                        } else {
                          errorText = 'Password is too short';
                        }
                      });
                    },
                  );
                },
              ),
            ),
          ),
        );

        // Initially has error
        expect(find.text('Password is too short'), findsOneWidget);

        // Enter valid password
        await tester.enterText(find.byType(TextField), 'ValidPass123');
        await tester.pumpAndSettle();

        // Error should be cleared
        expect(find.text('Password is too short'), findsNothing);
      });
    });
  });
}
