// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/widgets/feedback/app_confirm_dialog.dart';

void main() {
  group('AppConfirmDialog', () {
    group('Basic Rendering', () {
      testWidgets('renders with title and message', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              onConfirm: () {},
            ),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.text('Test Message'), findsOneWidget);
      });

      testWidgets('renders confirm and cancel buttons', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              onConfirm: () {},
            ),
          ),
        );

        expect(find.text('Confirm'), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
      });

      testWidgets('applies custom button labels', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              confirmLabel: 'Delete',
              cancelLabel: 'Keep',
              onConfirm: () {},
            ),
          ),
        );

        expect(find.text('Delete'), findsOneWidget);
        expect(find.text('Keep'), findsOneWidget);
        expect(find.text('Confirm'), findsNothing);
        expect(find.text('Cancel'), findsNothing);
      });
    });

    group('Callback Functionality', () {
      testWidgets('onConfirm fires when confirm button tapped', (tester) async {
        bool confirmed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              onConfirm: () => confirmed = true,
            ),
          ),
        );

        await tester.tap(find.text('Confirm'));
        await tester.pumpAndSettle();

        expect(confirmed, isTrue);
      });

      testWidgets('onCancel fires when cancel button tapped', (tester) async {
        bool cancelled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              onConfirm: () {},
              onCancel: () => cancelled = true,
            ),
          ),
        );

        await tester.tap(find.text('Cancel'));
        await tester.pumpAndSettle();

        expect(cancelled, isTrue);
      });

      // Backdrop tap dismissal is handled by showDialog's barrierDismissible
      // and is tested in the Barrier Dismissal group below
    });

    group('Variant Behavior', () {
      testWidgets('destructive variant shows warning icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Delete Item',
              message: 'This cannot be undone',
              isDestructive: true,
              onConfirm: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.warning_rounded), findsOneWidget);
      });

      testWidgets('non-destructive variant does not show warning icon', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Save Changes',
              message: 'Save before leaving?',
              isDestructive: false,
              onConfirm: () {},
            ),
          ),
        );

        expect(find.byIcon(Icons.warning_rounded), findsNothing);
      });

      testWidgets('destructive variant uses error color for confirm button', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Delete Item',
              message: 'This cannot be undone',
              isDestructive: true,
              onConfirm: () {},
            ),
          ),
        );

        // Find the FilledButton (confirm button for destructive)
        final filledButton = tester.widget<FilledButton>(
          find.ancestor(
            of: find.text('Confirm'),
            matching: find.byType(FilledButton),
          ),
        );

        final theme = Theme.of(tester.element(find.byType(AppConfirmDialog)));

        // Verify error color is used
        expect(
          filledButton.style?.backgroundColor?.resolve({}),
          equals(theme.colorScheme.error),
        );
      });
    });

    group('Don\'t Ask Again Checkbox', () {
      testWidgets('checkbox shows when showDontAskAgain is true', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              showDontAskAgain: true,
              onConfirm: () {},
            ),
          ),
        );

        expect(find.text("Don't ask again"), findsOneWidget);
        expect(find.byType(CheckboxListTile), findsOneWidget);
      });

      testWidgets('checkbox does not show when showDontAskAgain is false', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              showDontAskAgain: false,
              onConfirm: () {},
            ),
          ),
        );

        expect(find.text("Don't ask again"), findsNothing);
        expect(find.byType(CheckboxListTile), findsNothing);
      });

      testWidgets('checkbox initial state matches isDontAskAgainChecked', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              showDontAskAgain: true,
              isDontAskAgainChecked: true,
              onConfirm: () {},
            ),
          ),
        );

        final checkbox = tester.widget<CheckboxListTile>(
          find.byType(CheckboxListTile),
        );

        expect(checkbox.value, isTrue);
      });

      testWidgets('onDontAskAgainChanged fires when checkbox tapped', (
        tester,
      ) async {
        bool? changedValue;

        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              showDontAskAgain: true,
              isDontAskAgainChecked: false,
              onDontAskAgainChanged: (value) => changedValue = value,
              onConfirm: () {},
            ),
          ),
        );

        await tester.tap(find.byType(CheckboxListTile));
        await tester.pumpAndSettle();

        expect(changedValue, isTrue);
      });

      testWidgets('checkbox is disabled when isLoading is true', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              showDontAskAgain: true,
              isLoading: true,
              onConfirm: () {},
            ),
          ),
        );

        final checkbox = tester.widget<CheckboxListTile>(
          find.byType(CheckboxListTile),
        );

        expect(checkbox.onChanged, isNull);
      });
    });

    group('Loading State', () {
      testWidgets('loading indicator shows when isLoading is true', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              isLoading: true,
              onConfirm: () {},
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('confirm button is disabled when isLoading is true', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              isLoading: true,
              onConfirm: () {},
            ),
          ),
        );

        // Find the FilledButton (non-destructive variant)
        final button = tester.widget<FilledButton>(find.byType(FilledButton));

        // Button should be disabled (onPressed is null)
        expect(button.onPressed, isNull);
      });

      testWidgets('cancel button is disabled when isLoading is true', (
        tester,
      ) async {
        bool cancelled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              isLoading: true,
              onConfirm: () {},
              onCancel: () => cancelled = true,
            ),
          ),
        );

        // Find cancel button (TextButton)
        final cancelButton = tester.widget<TextButton>(find.byType(TextButton));

        expect(cancelButton.onPressed, isNull);
        expect(cancelled, isFalse);
      });

      testWidgets('loading state on destructive variant shows indicator', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Delete Item',
              message: 'Please wait...',
              isDestructive: true,
              isLoading: true,
              onConfirm: () {},
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
    });

    group('Barrier Dismissal', () {
      testWidgets(
        'dialog dismisses on backdrop tap when barrierDismissible is true',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AppConfirmDialog(
                            title: 'Test Title',
                            message: 'Test Message',
                            barrierDismissible: true,
                            onConfirm: () {},
                          ),
                        );
                      },
                      child: const Text('Show Dialog'),
                    );
                  },
                ),
              ),
            ),
          );

          await tester.tap(find.text('Show Dialog'));
          await tester.pumpAndSettle();

          // Dialog should be visible
          expect(find.text('Test Title'), findsOneWidget);

          // Tap backdrop
          await tester.tapAt(const Offset(10, 10));
          await tester.pumpAndSettle();

          // Dialog should be dismissed
          expect(find.text('Test Title'), findsNothing);
        },
      );

      testWidgets(
        'dialog does not dismiss on backdrop tap when barrierDismissible is false',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AppConfirmDialog(
                            title: 'Test Title',
                            message: 'Test Message',
                            barrierDismissible: false,
                            onConfirm: () {},
                          ),
                        );
                      },
                      child: const Text('Show Dialog'),
                    );
                  },
                ),
              ),
            ),
          );

          await tester.tap(find.text('Show Dialog'));
          await tester.pumpAndSettle();

          // Dialog should be visible
          expect(find.text('Test Title'), findsOneWidget);

          // Try to tap backdrop
          await tester.tapAt(const Offset(10, 10));
          await tester.pumpAndSettle();

          // Dialog should still be visible
          expect(find.text('Test Title'), findsOneWidget);
        },
      );

      // When isLoading is true, the static show() method sets
      // barrierDismissible to false automatically, preventing dismissal
    });

    group('Accessibility', () {
      testWidgets('dialog has proper semantic structure', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              onConfirm: () {},
            ),
          ),
        );

        // AlertDialog provides semantic structure
        expect(find.byType(AlertDialog), findsOneWidget);
      });

      testWidgets('buttons have proper semantics', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppConfirmDialog(
              title: 'Test Title',
              message: 'Test Message',
              confirmLabel: 'Accept',
              cancelLabel: 'Decline',
              onConfirm: () {},
            ),
          ),
        );

        // Verify button labels are present and accessible
        expect(find.text('Accept'), findsOneWidget);
        expect(find.text('Decline'), findsOneWidget);
      });
    });

    group('Static show() Method', () {
      testWidgets('show() method displays dialog correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppConfirmDialog.show(
                        context: context,
                        title: 'Static Method Test',
                        message: 'Testing static show method',
                        onConfirm: () {},
                      );
                    },
                    child: const Text('Show Dialog'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('Static Method Test'), findsOneWidget);
        expect(find.text('Testing static show method'), findsOneWidget);
      });

      testWidgets('show() method respects all parameters', (tester) async {
        bool confirmed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppConfirmDialog.show(
                        context: context,
                        title: 'Delete Item',
                        message: 'This cannot be undone',
                        confirmLabel: 'Delete',
                        cancelLabel: 'Keep',
                        isDestructive: true,
                        onConfirm: () {
                          confirmed = true;
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: const Text('Show Dialog'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pumpAndSettle();

        // Verify parameters applied
        expect(find.text('Delete Item'), findsOneWidget);
        expect(find.text('This cannot be undone'), findsOneWidget);
        expect(find.text('Delete'), findsOneWidget);
        expect(find.text('Keep'), findsOneWidget);
        expect(find.byIcon(Icons.warning_rounded), findsOneWidget);

        // Tap confirm
        await tester.tap(find.text('Delete'));
        await tester.pumpAndSettle();

        expect(confirmed, isTrue);
      });
    });
  });
}
