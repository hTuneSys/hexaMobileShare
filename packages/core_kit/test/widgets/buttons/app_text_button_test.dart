// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppTextButton', () {
    group('Widget Structure', () {
      testWidgets('renders correctly with required parameters', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(label: 'Test Button', onPressed: () {}),
            ),
          ),
        );

        expect(find.text('Test Button'), findsOneWidget);
        expect(find.byType(TextButton), findsOneWidget);
      });

      testWidgets('delegates to AppButton.text() internally', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(label: 'Delegated', onPressed: () {}),
            ),
          ),
        );

        // Verify that a TextButton is created (which AppButton.text() uses)
        expect(find.byType(TextButton), findsOneWidget);
        expect(find.text('Delegated'), findsOneWidget);
      });

      testWidgets('displays label text correctly', (tester) async {
        const labelText = 'Custom Label';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(label: labelText, onPressed: () {}),
            ),
          ),
        );

        expect(find.text(labelText), findsOneWidget);
      });
    });

    group('States', () {
      testWidgets('is enabled when onPressed is provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(label: 'Enabled', onPressed: () {}),
            ),
          ),
        );

        final button = tester.widget<TextButton>(find.byType(TextButton));
        expect(button.onPressed, isNotNull);
      });

      testWidgets('is disabled when onPressed is null', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTextButton(label: 'Disabled', onPressed: null),
            ),
          ),
        );

        final button = tester.widget<TextButton>(find.byType(TextButton));
        expect(button.onPressed, isNull);
      });

      testWidgets('triggers onPressed callback when tapped', (tester) async {
        var callbackTriggered = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Tap Me',
                onPressed: () => callbackTriggered = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(TextButton));
        await tester.pump();

        expect(callbackTriggered, isTrue);
      });

      testWidgets('does not trigger callback when disabled', (tester) async {
        var callbackTriggered = false;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTextButton(label: 'Disabled', onPressed: null),
            ),
          ),
        );

        await tester.tap(find.byType(TextButton));
        await tester.pump();

        expect(callbackTriggered, isFalse);
      });
    });

    group('Loading State', () {
      testWidgets('displays circular progress indicator when loading', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Loading',
                isLoading: true,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Loading'), findsNothing);
      });

      testWidgets('disables button when loading', (tester) async {
        var callbackTriggered = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Loading',
                isLoading: true,
                onPressed: () => callbackTriggered = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(TextButton));
        await tester.pump();

        expect(callbackTriggered, isFalse);
      });

      testWidgets('shows label when not loading', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Submit',
                isLoading: false,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Submit'), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
    });

    group('Icon Support', () {
      testWidgets('displays icon when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'With Icon',
                icon: Icons.add,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.text('With Icon'), findsOneWidget);
      });

      testWidgets('does not display icon when not provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(label: 'No Icon', onPressed: () {}),
            ),
          ),
        );

        expect(find.byType(Icon), findsNothing);
        expect(find.text('No Icon'), findsOneWidget);
      });

      testWidgets('handles null icon parameter', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Null Icon',
                icon: null,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(Icon), findsNothing);
        expect(find.byType(TextButton), findsOneWidget);
      });
    });

    group('Icon + Loading Combination', () {
      testWidgets('shows loading indicator instead of icon when loading', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Loading',
                icon: Icons.save,
                isLoading: true,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byIcon(Icons.save), findsNothing);
      });

      testWidgets('shows icon when not loading', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Not Loading',
                icon: Icons.check,
                isLoading: false,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.check), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      });
    });

    group('Full Width', () {
      testWidgets('expands to fill parent width when fullWidth is true', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 300,
                child: AppTextButton(
                  label: 'Full Width',
                  fullWidth: true,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        // Find the SizedBox that wraps the button (created by fullWidth=true)
        final appTextButton = find.byType(AppTextButton);
        final sizedBoxes = find.descendant(
          of: appTextButton,
          matching: find.byType(SizedBox),
        );

        // Should have at least one SizedBox with infinite width
        final hasFullWidth = tester
            .widgetList<SizedBox>(sizedBoxes)
            .any((box) => box.width == double.infinity);
        expect(hasFullWidth, isTrue);
      });

      testWidgets('does not expand when fullWidth is false', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Normal Width',
                fullWidth: false,
                onPressed: () {},
              ),
            ),
          ),
        );

        // When fullWidth is false, SizedBox with infinity width should not exist
        final allSizedBoxes = tester.widgetList<SizedBox>(
          find.byType(SizedBox),
        );
        final hasInfiniteWidth = allSizedBoxes.any(
          (box) => box.width == double.infinity,
        );

        expect(hasInfiniteWidth, isFalse);
      });
    });

    group('Label Display', () {
      testWidgets('handles long label text', (tester) async {
        const longLabel =
            'This is a very long button label that might wrap or overflow';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                child: AppTextButton(label: longLabel, onPressed: () {}),
              ),
            ),
          ),
        );

        expect(find.text(longLabel), findsOneWidget);
      });

      testWidgets('handles empty label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(label: '', onPressed: () {}),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('has Semantics wrapper for enabled button', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(label: 'Accessible Button', onPressed: () {}),
            ),
          ),
        );

        // Verify Semantics widget exists
        expect(find.byType(Semantics), findsWidgets);

        // Verify the button is accessible and the label is present
        expect(find.text('Accessible Button'), findsOneWidget);
      });

      testWidgets('has Semantics wrapper for disabled button', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTextButton(label: 'Disabled Button', onPressed: null),
            ),
          ),
        );

        // Verify Semantics widget exists
        expect(find.byType(Semantics), findsWidgets);

        // Verify the button label is present
        expect(find.text('Disabled Button'), findsOneWidget);
      });

      testWidgets('has loading state in semantic label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Processing',
                isLoading: true,
                onPressed: () {},
              ),
            ),
          ),
        );

        // Find the AppButton's Semantics widget (which AppTextButton delegates to)
        final appButtonSemantics = tester.widget<Semantics>(
          find
              .descendant(
                of: find.byType(AppButton),
                matching: find.byType(Semantics),
              )
              .first,
        );

        expect(appButtonSemantics.properties.label, contains('loading'));
      });
    });

    group('Edge Cases', () {
      testWidgets('handles all parameters together', (tester) async {
        var callbackTriggered = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Complete Button',
                icon: Icons.check,
                fullWidth: true,
                isLoading: false,
                onPressed: () => callbackTriggered = true,
              ),
            ),
          ),
        );

        expect(find.text('Complete Button'), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);

        // Tap the AppTextButton widget directly
        await tester.tap(find.byType(AppTextButton));
        await tester.pump();

        expect(callbackTriggered, isTrue);
      });

      testWidgets('maintains loading state correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Loading Button',
                isLoading: true,
                onPressed: () {},
              ),
            ),
          ),
        );

        // Verify loading state shows indicator
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // Rebuild with non-loading state
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTextButton(
                label: 'Loading Button',
                isLoading: false,
                onPressed: () {},
              ),
            ),
          ),
        );
        await tester.pump();

        // Should now show label instead of loading indicator
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('Loading Button'), findsOneWidget);
      });
    });

    group('Delegation Verification', () {
      testWidgets('produces same output as AppButton.text()', (tester) async {
        // Build both versions side by side
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppTextButton(label: 'Test', onPressed: () {}),
                  AppButton.text(label: 'Test', onPressed: () {}),
                ],
              ),
            ),
          ),
        );

        // Both should produce TextButton widgets
        expect(find.byType(TextButton), findsNWidgets(2));

        // Both should have the same label
        expect(find.text('Test'), findsNWidgets(2));
      });

      testWidgets('delegates all parameters correctly', (tester) async {
        var textButtonCalled = false;
        var appButtonCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  AppTextButton(
                    label: 'TextButtonTest',
                    icon: Icons.star,
                    isLoading: false,
                    onPressed: () => textButtonCalled = true,
                  ),
                  AppButton.text(
                    label: 'AppButtonTest',
                    icon: Icons.star,
                    isLoading: false,
                    onPressed: () => appButtonCalled = true,
                  ),
                ],
              ),
            ),
          ),
        );

        // Tap the first button (AppTextButton) using its label
        await tester.tap(find.text('TextButtonTest'));
        await tester.pump();
        expect(textButtonCalled, isTrue);

        // Tap the second button (AppButton) using its label
        await tester.tap(find.text('AppButtonTest'));
        await tester.pump();
        expect(appButtonCalled, isTrue);

        // Both should have icons
        expect(find.byIcon(Icons.star), findsNWidgets(2));
      });
    });
  });
}
