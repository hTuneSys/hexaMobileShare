// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders filled button correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.filled(label: 'Test Button', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('renders outlined button correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.outlined(label: 'Test Button', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('renders text button correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.text(label: 'Test Button', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('renders elevated button correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.elevated(label: 'Test Button', onPressed: () {}),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('renders button with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.filled(
              label: 'Test Button',
              icon: Icons.add,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('shows loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.filled(
              label: 'Test Button',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Test Button'), findsNothing);
    });

    testWidgets('button is disabled when onPressed is null', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppButton.filled(label: 'Test Button', onPressed: null),
          ),
        ),
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('button is disabled when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.filled(
              label: 'Test Button',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      final button = tester.widget<FilledButton>(find.byType(FilledButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('triggers onPressed callback when tapped', (
      WidgetTester tester,
    ) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.filled(
              label: 'Test Button',
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('renders full width button correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.filled(
              label: 'Test Button',
              fullWidth: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find.ancestor(
          of: find.byType(FilledButton),
          matching: find.byType(SizedBox),
        ),
      );

      expect(sizedBox.width, equals(double.infinity));
    });

    testWidgets('handles long text without overflow', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              child: AppButton.filled(
                label: 'This is a very long button label that might overflow',
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('has proper semantic labels for accessibility', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.filled(label: 'Test Button', onPressed: () {}),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(Semantics).first);
      expect(semantics.label, contains('Test Button'));
    });

    testWidgets('announces loading state to screen readers', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.filled(
              label: 'Submit',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.byType(Semantics).first);
      expect(semantics.label, contains('loading'));
    });

    testWidgets('minimum touch target size is enforced', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton.filled(label: 'Test', onPressed: () {}),
          ),
        ),
      );

      final buttonSize = tester.getSize(find.byType(FilledButton));
      // Minimum touch target should be at least 48dp in height
      expect(buttonSize.height, greaterThanOrEqualTo(48.0));
    });

    testWidgets('all variants work with icons', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppButton.filled(
                  label: 'Filled',
                  icon: Icons.check,
                  onPressed: () {},
                ),
                AppButton.outlined(
                  label: 'Outlined',
                  icon: Icons.check,
                  onPressed: () {},
                ),
                AppButton.text(
                  label: 'Text',
                  icon: Icons.check,
                  onPressed: () {},
                ),
                AppButton.elevated(
                  label: 'Elevated',
                  icon: Icons.check,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNWidgets(4));
    });

    test('AppButtonVariant enum has all expected values', () {
      expect(AppButtonVariant.values.length, equals(4));
      expect(AppButtonVariant.values, contains(AppButtonVariant.filled));
      expect(AppButtonVariant.values, contains(AppButtonVariant.outlined));
      expect(AppButtonVariant.values, contains(AppButtonVariant.text));
      expect(AppButtonVariant.values, contains(AppButtonVariant.elevated));
    });
  });
}
