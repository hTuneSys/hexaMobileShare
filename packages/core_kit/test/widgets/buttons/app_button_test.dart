// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppButton', () {
    group('Variants', () {
      testWidgets('renders filled button variant correctly', (tester) async {
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

      testWidgets('renders outlined button variant correctly', (tester) async {
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

      testWidgets('renders text button variant correctly', (tester) async {
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

      testWidgets('renders elevated button variant correctly', (tester) async {
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
    });

    group('Loading State', () {
      testWidgets('displays circular progress indicator when loading', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
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

      testWidgets('disables onPressed callback when loading', (tester) async {
        var callbackTriggered = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
                label: 'Loading',
                isLoading: true,
                onPressed: () => callbackTriggered = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(FilledButton));
        await tester.pump();

        expect(callbackTriggered, isFalse);
      });

      testWidgets('shows label when not loading', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
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

    group('Disabled State', () {
      testWidgets('is disabled when onPressed is null', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppButton.filled(label: 'Disabled', onPressed: null),
            ),
          ),
        );

        final button = tester.widget<FilledButton>(find.byType(FilledButton));
        expect(button.onPressed, isNull);
      });

      testWidgets('does not trigger callback when disabled', (tester) async {
        var callbackTriggered = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(label: 'Disabled', onPressed: null),
            ),
          ),
        );

        await tester.tap(find.byType(FilledButton));
        await tester.pump();

        expect(callbackTriggered, isFalse);
      });
    });

    group('Enabled State', () {
      testWidgets('triggers onPressed callback when tapped', (tester) async {
        var callbackTriggered = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
                label: 'Enabled',
                onPressed: () => callbackTriggered = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(FilledButton));
        await tester.pump();

        expect(callbackTriggered, isTrue);
      });

      testWidgets('is enabled when onPressed is provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(label: 'Enabled', onPressed: () {}),
            ),
          ),
        );

        final button = tester.widget<FilledButton>(find.byType(FilledButton));
        expect(button.onPressed, isNotNull);
      });
    });

    group('Icon Support', () {
      testWidgets('displays icon when provided for filled variant', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
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

      testWidgets('displays icon when provided for outlined variant', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.outlined(
                label: 'With Icon',
                icon: Icons.download,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.download), findsOneWidget);
        expect(find.text('With Icon'), findsOneWidget);
      });

      testWidgets('does not display icon when not provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(label: 'No Icon', onPressed: () {}),
            ),
          ),
        );

        expect(find.byType(Icon), findsNothing);
        expect(find.text('No Icon'), findsOneWidget);
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
                child: AppButton.filled(
                  label: 'Full Width',
                  fullWidth: true,
                  onPressed: () {},
                ),
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

      testWidgets('does not expand when fullWidth is false', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
                label: 'Normal Width',
                fullWidth: false,
                onPressed: () {},
              ),
            ),
          ),
        );

        final sizedBoxFinder = find.ancestor(
          of: find.byType(FilledButton),
          matching: find.byType(SizedBox),
        );

        // SizedBox should not exist when fullWidth is false
        expect(sizedBoxFinder, findsNothing);
      });
    });

    group('Label Display', () {
      testWidgets('displays label text correctly', (tester) async {
        const labelText = 'Test Label';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(label: labelText, onPressed: () {}),
            ),
          ),
        );

        expect(find.text(labelText), findsOneWidget);
      });

      testWidgets('handles long label text', (tester) async {
        const longLabel =
            'This is a very long button label that might wrap or overflow';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                child: AppButton.filled(label: longLabel, onPressed: () {}),
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
              body: AppButton.filled(label: '', onPressed: () {}),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('has proper semantic label for enabled button', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
                label: 'Accessible Button',
                onPressed: () {},
              ),
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(Semantics).first);
        expect(semantics.label, equals('Accessible Button'));
      });

      testWidgets('has proper semantic label for disabled button', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppButton.filled(label: 'Disabled Button', onPressed: null),
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(Semantics).first);
        expect(semantics.label, equals('Disabled Button'));
      });

      testWidgets('has loading state in semantic label', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
                label: 'Processing',
                isLoading: true,
                onPressed: () {},
              ),
            ),
          ),
        );

        final semantics = tester.getSemantics(find.byType(Semantics).first);
        expect(semantics.label, contains('loading'));
      });
    });

    group('Edge Cases', () {
      testWidgets('handles null icon parameter', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
                label: 'No Icon',
                icon: null,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(Icon), findsNothing);
        expect(find.byType(FilledButton), findsOneWidget);
      });

      testWidgets('handles all parameters together', (tester) async {
        var callbackTriggered = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
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

        await tester.tap(find.byType(FilledButton));
        await tester.pump();

        expect(callbackTriggered, isTrue);
      });

      testWidgets('switches from loading to non-loading state', (tester) async {
        var isLoading = true;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return AppButton.filled(
                    label: 'Toggle Loading',
                    isLoading: isLoading,
                    onPressed: () {
                      setState(() => isLoading = !isLoading);
                    },
                  );
                },
              ),
            ),
          ),
        );

        // Initially loading
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        // Tap button (won't trigger due to loading state)
        await tester.tap(find.byType(FilledButton));
        await tester.pumpAndSettle();

        // Should still be loading
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Variant Constructor', () {
      testWidgets('creates correct variant using main constructor', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(
                label: 'Default Variant',
                variant: AppButtonVariant.outlined,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.byType(OutlinedButton), findsOneWidget);
      });

      testWidgets('defaults to filled variant', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton(label: 'Default', onPressed: () {}),
            ),
          ),
        );

        expect(find.byType(FilledButton), findsOneWidget);
      });
    });
  });
}
