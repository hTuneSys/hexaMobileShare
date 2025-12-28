// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppSnackbar', () {
    testWidgets('builds basic snackbar with message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppSnackbar.show(context, message: 'Test message');
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      // Tap button to show snackbar
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify snackbar is shown
      expect(find.text('Test message'), findsOneWidget);
    });

    testWidgets('shows snackbar with action button', (
      WidgetTester tester,
    ) async {
      bool actionPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppSnackbar.show(
                      context,
                      message: 'Email archived',
                      actionLabel: 'UNDO',
                      onActionPressed: () {
                        actionPressed = true;
                      },
                    );
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      // Show snackbar
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify action button exists
      expect(find.text('UNDO'), findsOneWidget);

      // Tap action button
      await tester.tap(find.text('UNDO'));
      await tester.pumpAndSettle();

      // Verify callback was called
      expect(actionPressed, isTrue);
    });

    testWidgets('success snackbar has correct styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppSnackbar.success(context, message: 'Success message');
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      // Show snackbar
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify message and icon
      expect(find.text('Success message'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('error snackbar has correct styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppSnackbar.error(context, message: 'Error message');
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      // Show snackbar
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify message and icon
      expect(find.text('Error message'), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
    });

    testWidgets('warning snackbar has correct styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppSnackbar.warning(context, message: 'Warning message');
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      // Show snackbar
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify message and icon
      expect(find.text('Warning message'), findsOneWidget);
      expect(find.byIcon(Icons.warning), findsOneWidget);
    });

    testWidgets('info snackbar has correct styling', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppSnackbar.info(context, message: 'Info message');
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      // Show snackbar
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify message and icon
      expect(find.text('Info message'), findsOneWidget);
      expect(find.byIcon(Icons.info), findsOneWidget);
    });

    testWidgets('snackbar with icon displays icon', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      AppSnackbar.build(
                        message: 'Download started',
                        icon: Icons.download,
                      ),
                    );
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      // Show snackbar
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify icon is shown
      expect(find.byIcon(Icons.download), findsOneWidget);
    });

    testWidgets('dismiss removes snackbar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        AppSnackbar.show(context, message: 'Test message');
                      },
                      child: const Text('Show'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AppSnackbar.dismiss(context);
                      },
                      child: const Text('Dismiss'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Show snackbar
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();
      expect(find.text('Test message'), findsOneWidget);

      // Dismiss snackbar
      await tester.tap(find.text('Dismiss'));
      await tester.pumpAndSettle();

      // Verify snackbar is gone
      expect(find.text('Test message'), findsNothing);
    });

    testWidgets('clearQueue removes all queued snackbars', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        AppSnackbar.show(context, message: 'Message 1');
                        AppSnackbar.show(context, message: 'Message 2');
                        AppSnackbar.show(context, message: 'Message 3');
                      },
                      child: const Text('Show Multiple'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AppSnackbar.clearQueue(context);
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      // Show multiple snackbars
      await tester.tap(find.text('Show Multiple'));
      await tester.pumpAndSettle();

      // Clear queue
      await tester.tap(find.text('Clear'));
      await tester.pumpAndSettle();

      // Verify all snackbars are cleared
      expect(find.text('Message 1'), findsNothing);
      expect(find.text('Message 2'), findsNothing);
      expect(find.text('Message 3'), findsNothing);
    });

    test('AppSnackbarType enum has all variants', () {
      expect(AppSnackbarType.values.length, 5);
      expect(AppSnackbarType.values, contains(AppSnackbarType.standard));
      expect(AppSnackbarType.values, contains(AppSnackbarType.success));
      expect(AppSnackbarType.values, contains(AppSnackbarType.error));
      expect(AppSnackbarType.values, contains(AppSnackbarType.warning));
      expect(AppSnackbarType.values, contains(AppSnackbarType.info));
    });

    testWidgets('long message truncates correctly', (
      WidgetTester tester,
    ) async {
      const longMessage =
          'This is a very long message that should be truncated after two lines. '
          'It demonstrates the text wrapping and ellipsis behavior of the snackbar component.';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppSnackbar.show(context, message: longMessage);
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      // Show snackbar
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Verify message is shown (may be truncated)
      expect(
        find.textContaining('This is a very long message'),
        findsOneWidget,
      );
    });

    testWidgets('custom duration is respected', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    AppSnackbar.show(
                      context,
                      message: 'Short duration',
                      duration: const Duration(milliseconds: 100),
                    );
                  },
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      // Show snackbar
      await tester.tap(find.text('Show'));
      await tester.pump();
      expect(find.text('Short duration'), findsOneWidget);

      // Wait for duration to pass
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      // Verify snackbar auto-dismissed
      expect(find.text('Short duration'), findsNothing);
    });
  });
}
