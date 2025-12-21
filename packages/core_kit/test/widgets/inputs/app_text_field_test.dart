// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTextField', () {
    testWidgets('renders with label and hint', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(label: 'Test Label', hint: 'Test Hint'),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Test Hint'), findsOneWidget);
    });

    testWidgets('displays helper text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'Field',
              helperText: 'This is helper text',
            ),
          ),
        ),
      );

      expect(find.text('This is helper text'), findsOneWidget);
    });

    testWidgets('displays error text in error state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(label: 'Field', errorText: 'This is an error'),
          ),
        ),
      );

      expect(find.text('This is an error'), findsOneWidget);
    });

    testWidgets('calls onChanged when text changes', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'Field',
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Test Value');
      expect(changedValue, 'Test Value');
    });

    testWidgets('calls onSubmitted when submitted', (tester) async {
      String? submittedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'Field',
              onSubmitted: (value) => submittedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Submit Test');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(submittedValue, 'Submit Test');
    });

    testWidgets('displays prefix icon', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(label: 'Field', prefixIcon: Icons.search),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('displays suffix icon and handles tap', (tester) async {
      bool suffixTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'Field',
              suffixIcon: Icons.clear,
              onSuffixIconTap: () => suffixTapped = true,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.clear), findsOneWidget);

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      expect(suffixTapped, true);
    });

    testWidgets('obscures text when obscureText is true', (tester) async {
      final controller = TextEditingController(text: 'password123');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(
              controller: controller,
              label: 'Password',
              obscureText: true,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, true);
    });

    testWidgets('is disabled when enabled is false', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(label: 'Disabled Field', enabled: false),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, false);
    });

    testWidgets('is read-only when readOnly is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(label: 'Read-only Field', readOnly: true),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.readOnly, true);
    });

    testWidgets('enforces maxLength', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextField(label: 'Field', maxLength: 5)),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLength, 5);
    });

    testWidgets('uses controller with initial text', (tester) async {
      final controller = TextEditingController(text: 'Initial Text');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(label: 'Field', controller: controller),
          ),
        ),
      );

      expect(controller.text, 'Initial Text');
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, 'Initial Text');
    });

    testWidgets('autofocuses when autofocus is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextField(label: 'Field', autofocus: true)),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofocus, true);
    });

    testWidgets('calls onFocusChange when focus changes', (tester) async {
      bool? hasFocus;
      final focusNode1 = FocusNode();
      final focusNode2 = FocusNode();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppTextField(
                  label: 'Field 1',
                  focusNode: focusNode1,
                  onFocusChange: (focused) => hasFocus = focused,
                ),
                AppTextField(label: 'Field 2', focusNode: focusNode2),
              ],
            ),
          ),
        ),
      );

      // Request focus on first field
      focusNode1.requestFocus();
      await tester.pump();
      expect(hasFocus, true);

      // Request focus on second field
      focusNode2.requestFocus();
      await tester.pump();
      expect(hasFocus, false);
    });
  });

  group('AppTextField.multiline', () {
    testWidgets('creates multiline text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextField.multiline(label: 'Description')),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.maxLines, 5);
      expect(textField.minLines, 3);
      expect(textField.keyboardType, TextInputType.multiline);
    });
  });

  group('AppTextField.numeric', () {
    testWidgets('creates numeric text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextField.numeric(label: 'Age')),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.number);
      expect(textField.maxLines, 1);
    });

    testWidgets('applies numeric input formatters', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField.numeric(
              label: 'Age',
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.inputFormatters, isNotEmpty);
    });
  });

  group('AppTextField.email', () {
    testWidgets('creates email text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextField.email(label: 'Email')),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.emailAddress);
      expect(textField.autofillHints, contains(AutofillHints.email));
    });
  });

  group('AppTextField.phone', () {
    testWidgets('creates phone text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextField.phone(label: 'Phone')),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.phone);
      expect(textField.autofillHints, contains(AutofillHints.telephoneNumber));
    });
  });

  group('AppTextField.url', () {
    testWidgets('creates URL text field', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextField.url(label: 'Website')),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.keyboardType, TextInputType.url);
      expect(textField.autofillHints, contains(AutofillHints.url));
    });
  });

  group('AppTextField Material Design 3 styling', () {
    testWidgets('applies correct border radius', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextField(label: 'Field')),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      final decoration = textField.decoration as InputDecoration;
      final border = decoration.border as OutlineInputBorder;

      expect(border.borderRadius, BorderRadius.circular(4.0));
    });

    testWidgets('applies correct content padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppTextField(label: 'Field')),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      final decoration = textField.decoration as InputDecoration;

      expect(
        decoration.contentPadding,
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      );
    });

    testWidgets('hides character counter when showCharacterCounter is false', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppTextField(
              label: 'Field',
              maxLength: 10,
              showCharacterCounter: false,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      final decoration = textField.decoration as InputDecoration;

      expect(decoration.counterText, '');
    });
  });

  group('AppTextField controller integration', () {
    testWidgets('uses provided controller', (tester) async {
      final controller = TextEditingController(text: 'Initial');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(controller: controller, label: 'Field'),
          ),
        ),
      );

      expect(find.text('Initial'), findsOneWidget);
      expect(controller.text, 'Initial');
    });

    testWidgets('updates controller when text changes', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppTextField(controller: controller, label: 'Field'),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'New Text');
      expect(controller.text, 'New Text');
    });
  });
}
