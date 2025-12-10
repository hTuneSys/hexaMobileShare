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

    group('Icon + Loading Combination', () {
      testWidgets(
        'shows loading indicator instead of icon when loading (filled)',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: AppButton.filled(
                  label: 'Loading',
                  icon: Icons.add,
                  isLoading: true,
                  onPressed: () {},
                ),
              ),
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          expect(find.byIcon(Icons.add), findsNothing);
        },
      );

      testWidgets(
        'shows loading indicator instead of icon when loading (outlined)',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: AppButton.outlined(
                  label: 'Loading',
                  icon: Icons.download,
                  isLoading: true,
                  onPressed: () {},
                ),
              ),
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          expect(find.byIcon(Icons.download), findsNothing);
        },
      );

      testWidgets(
        'shows loading indicator instead of icon when loading (text)',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: AppButton.text(
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
        },
      );

      testWidgets(
        'shows loading indicator instead of icon when loading (elevated)',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: AppButton.elevated(
                  label: 'Loading',
                  icon: Icons.upload,
                  isLoading: true,
                  onPressed: () {},
                ),
              ),
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          expect(find.byIcon(Icons.upload), findsNothing);
        },
      );

      testWidgets('shows icon when not loading', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
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
                child: AppButton.filled(
                  label: 'Full Width',
                  fullWidth: true,
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        // Find the SizedBox that wraps the button (created by fullWidth=true)
        final appButton = find.byType(AppButton);
        final sizedBoxes = find.descendant(
          of: appButton,
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
              body: AppButton.filled(
                label: 'Normal Width',
                fullWidth: false,
                onPressed: () {},
              ),
            ),
          ),
        );

        // When fullWidth is false, SizedBox with infinity width should not exist
        // Find all SizedBox widgets and check none have infinite width
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
      testWidgets('has Semantics wrapper for enabled button', (tester) async {
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

        // Verify Semantics widget exists
        expect(find.byType(Semantics), findsWidgets);

        // Verify the button is accessible and the label is present
        expect(find.text('Accessible Button'), findsOneWidget);
      });

      testWidgets('has Semantics wrapper for disabled button', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppButton.filled(label: 'Disabled Button', onPressed: null),
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
              body: AppButton.filled(
                label: 'Processing',
                isLoading: true,
                onPressed: () {},
              ),
            ),
          ),
        );

        // Find the AppButton's Semantics widget (not Material button's semantics)
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

        // Tap the AppButton widget directly
        await tester.tap(find.byType(AppButton));
        await tester.pump();

        expect(callbackTriggered, isTrue);
      });

      testWidgets('maintains loading state correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppButton.filled(
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
              body: AppButton.filled(
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
