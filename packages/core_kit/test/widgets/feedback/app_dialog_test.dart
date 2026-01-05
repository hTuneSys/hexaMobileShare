// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppDialog', () {
    testWidgets('displays dialog with title and content', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: 'Test Title',
                      content: 'Test content',
                      actions: [
                        AppDialogAction(
                          label: 'OK',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                  },
                  child: const Text('Show Dialog'),
                );
              },
            ),
          ),
        ),
      );

      // Tap button to show dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify dialog is shown with title and content
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test content'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);
    });

    testWidgets('displays dialog with icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: 'Warning',
                      icon: const Icon(Icons.warning_amber_outlined),
                      content: 'This is a warning message',
                      actions: [
                        AppDialogAction(
                          label: 'OK',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
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

      // Verify icon is displayed
      expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);
      expect(find.text('Warning'), findsOneWidget);
    });

    testWidgets('calls action callback when action button is pressed', (
      WidgetTester tester,
    ) async {
      bool actionCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: 'Confirm Action',
                      content: 'Are you sure you want to proceed?',
                      actions: [
                        AppDialogAction(
                          label: 'Cancel',
                          isSecondary: true,
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                        AppDialogAction(
                          label: 'Proceed',
                          onPressed: () {
                            actionCalled = true;
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
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

      // Tap proceed button
      await tester.tap(find.text('Proceed'));
      await tester.pumpAndSettle();

      // Verify callback was called
      expect(actionCalled, isTrue);
    });

    testWidgets('dismisses dialog on backdrop tap when dismissible', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: 'Dialog',
                      content: 'Content',
                      isDismissible: true,
                      actions: [
                        AppDialogAction(
                          label: 'OK',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
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

      // Verify dialog is shown
      expect(find.text('Dialog'), findsOneWidget);

      // Tap outside dialog (backdrop)
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Verify dialog is dismissed
      expect(find.text('Dialog'), findsNothing);
    });

    testWidgets('does not dismiss on backdrop tap when not dismissible', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: 'Dialog',
                      content: 'Content',
                      isDismissible: false,
                      actions: [
                        AppDialogAction(
                          label: 'OK',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
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

      // Verify dialog is shown
      expect(find.text('Dialog'), findsOneWidget);

      // Tap outside dialog (backdrop)
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      // Verify dialog is still shown
      expect(find.text('Dialog'), findsOneWidget);
    });

    testWidgets('displays multiple actions correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: 'Multiple Actions',
                      content: 'Choose an action',
                      actions: [
                        AppDialogAction(
                          label: 'Cancel',
                          isSecondary: true,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        AppDialogAction(
                          label: 'Save',
                          onPressed: () => Navigator.of(context).pop(true),
                        ),
                        AppDialogAction(
                          label: 'Delete',
                          isDestructive: true,
                          onPressed: () => Navigator.of(context).pop(false),
                        ),
                      ],
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

      // Verify all actions are displayed
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('uses custom content builder', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: 'Custom Content',
                      contentBuilder: (context) => const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Custom content line 1'),
                          Text('Custom content line 2'),
                        ],
                      ),
                      actions: [
                        AppDialogAction(
                          label: 'OK',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
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

      // Verify custom content is displayed
      expect(find.text('Custom content line 1'), findsOneWidget);
      expect(find.text('Custom content line 2'), findsOneWidget);
    });

    testWidgets('renders full-screen variant', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: 'Full Screen Dialog',
                      content: 'This is a full-screen dialog',
                      isFullScreen: true,
                      actions: [
                        AppDialogAction(
                          label: 'Close',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
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

      // Verify full-screen dialog elements
      expect(find.byType(Scaffold), findsNWidgets(2)); // Original + dialog
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('handles scrollable content', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: 'Scrollable Content',
                      content: 'Line 1\n' * 100, // Long content
                      scrollable: true,
                      actions: [
                        AppDialogAction(
                          label: 'OK',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
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

      // Verify scrollable content
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('dismisses on escape key when dismissible', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppDialog.show(
                      context: context,
                      title: 'Dialog',
                      content: 'Press Escape to dismiss',
                      isDismissible: true,
                      actions: [
                        AppDialogAction(
                          label: 'OK',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
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

      // Verify dialog is shown
      expect(find.text('Dialog'), findsOneWidget);

      // Simulate Escape key press
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();

      // Verify dialog is dismissed
      expect(find.text('Dialog'), findsNothing);
    });
  });

  group('AppDialogAction', () {
    test('creates action with required parameters', () {
      final action = AppDialogAction(label: 'Test', onPressed: () {});

      expect(action.label, 'Test');
      expect(action.onPressed, isNotNull);
      expect(action.isSecondary, false);
      expect(action.isDestructive, false);
    });

    test('creates secondary action', () {
      final action = AppDialogAction(
        label: 'Cancel',
        onPressed: () {},
        isSecondary: true,
      );

      expect(action.isSecondary, true);
      expect(action.isDestructive, false);
    });

    test('creates destructive action', () {
      final action = AppDialogAction(
        label: 'Delete',
        onPressed: () {},
        isDestructive: true,
      );

      expect(action.isSecondary, false);
      expect(action.isDestructive, true);
    });

    test('throws assertion error when both secondary and destructive', () {
      expect(
        () => AppDialogAction(
          label: 'Invalid',
          onPressed: () {},
          isSecondary: true,
          isDestructive: true,
        ),
        throwsAssertionError,
      );
    });
  });
}
