// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Clean up after each test to prevent timer leaks
  tearDown(() {
    AppToast.clearAll();
  });

  group('AppToast', () {
    group('Enum values', () {
      test('ToastPosition has correct values', () {
        expect(ToastPosition.values.length, equals(3));
        expect(ToastPosition.values, contains(ToastPosition.top));
        expect(ToastPosition.values, contains(ToastPosition.center));
        expect(ToastPosition.values, contains(ToastPosition.bottom));
      });

      test('ToastType has correct values', () {
        expect(ToastType.values.length, equals(5));
        expect(ToastType.values, contains(ToastType.neutral));
        expect(ToastType.values, contains(ToastType.success));
        expect(ToastType.values, contains(ToastType.error));
        expect(ToastType.values, contains(ToastType.warning));
        expect(ToastType.values, contains(ToastType.info));
      });
    });

    group('Static methods', () {
      testWidgets('show() displays toast overlay', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(context, message: 'Test message');
                    },
                    child: const Text('Show Toast'),
                  );
                },
              ),
            ),
          ),
        );

        // Tap button to show toast
        await tester.tap(find.text('Show Toast'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        // Verify toast is displayed
        expect(find.text('Test message'), findsOneWidget);

        // Clean up
        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('success() displays toast with check icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.success(context, message: 'Success message');
                    },
                    child: const Text('Show Success'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Success'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Success message'), findsOneWidget);
        expect(find.byIcon(Icons.check_circle), findsOneWidget);

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('error() displays toast with error icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.error(context, message: 'Error message');
                    },
                    child: const Text('Show Error'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Error'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Error message'), findsOneWidget);
        expect(find.byIcon(Icons.error), findsOneWidget);

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('warning() displays toast with warning icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.warning(context, message: 'Warning message');
                    },
                    child: const Text('Show Warning'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Warning'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Warning message'), findsOneWidget);
        expect(find.byIcon(Icons.warning), findsOneWidget);

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('info() displays toast with info icon', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.info(context, message: 'Info message');
                    },
                    child: const Text('Show Info'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show Info'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Info message'), findsOneWidget);
        expect(find.byIcon(Icons.info), findsOneWidget);

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('clearAll() removes current toast', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(
                        context,
                        message: 'Test toast',
                        duration: const Duration(seconds: 5),
                      );
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('Test toast'), findsOneWidget);

        // Clear all toasts
        AppToast.clearAll();
        await tester.pump();

        expect(find.text('Test toast'), findsNothing);
      });
    });

    group('Toast positioning', () {
      testWidgets('displays at top position', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(
                        context,
                        message: 'Top toast',
                        position: ToastPosition.top,
                      );
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final positioned = tester.widget<Positioned>(
          find.ancestor(
            of: find.text('Top toast'),
            matching: find.byType(Positioned),
          ),
        );

        expect(positioned.top, equals(80));
        expect(positioned.bottom, isNull);

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('displays at center position', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(
                        context,
                        message: 'Center toast',
                        position: ToastPosition.center,
                      );
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final positioned = tester.widget<Positioned>(
          find.ancestor(
            of: find.text('Center toast'),
            matching: find.byType(Positioned),
          ),
        );

        expect(positioned.top, isNull);
        expect(positioned.bottom, isNull);

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('displays at bottom position (default)', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(
                        context,
                        message: 'Bottom toast',
                        position: ToastPosition.bottom,
                      );
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final positioned = tester.widget<Positioned>(
          find.ancestor(
            of: find.text('Bottom toast'),
            matching: find.byType(Positioned),
          ),
        );

        expect(positioned.top, isNull);
        expect(positioned.bottom, equals(80));

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });
    });

    group('Toast appearance', () {
      testWidgets('displays with icon when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(
                        context,
                        message: 'With icon',
                        icon: Icons.check,
                      );
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(Icons.check), findsOneWidget);

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('displays without icon when not provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(context, message: 'No icon');
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text('No icon'), findsOneWidget);
        expect(find.byType(Icon), findsNothing);

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('respects max width constraint', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(context, message: 'Test toast');
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final container = tester.widget<Container>(
          find.ancestor(
            of: find.text('Test toast'),
            matching: find.byType(Container),
          ),
        );

        expect(container.constraints?.maxWidth, equals(320));

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('respects min height constraint', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(context, message: 'Test');
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final container = tester.widget<Container>(
          find.ancestor(
            of: find.text('Test'),
            matching: find.byType(Container),
          ),
        );

        expect(container.constraints?.minHeight, equals(40));

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('handles long message text', (tester) async {
        const longMessage =
            'This is a very long toast message that should wrap properly '
            'within the maximum width constraint of the toast container';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(context, message: longMessage);
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text(longMessage), findsOneWidget);

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });
    });

    group('Custom styling', () {
      testWidgets('applies custom background color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(
                        context,
                        message: 'Custom color',
                        backgroundColor: Colors.purple,
                      );
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final container = tester.widget<Container>(
          find.ancestor(
            of: find.text('Custom color'),
            matching: find.byType(Container),
          ),
        );

        expect(
          (container.decoration as BoxDecoration).color,
          equals(Colors.purple),
        );

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });

      testWidgets('applies custom text color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      AppToast.show(
                        context,
                        message: 'Custom text',
                        textColor: Colors.yellow,
                      );
                    },
                    child: const Text('Show'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Show'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final text = tester.widget<Text>(find.text('Custom text'));
        expect(text.style?.color, equals(Colors.yellow));

        AppToast.clearAll();
        await tester.pumpAndSettle();
      });
    });
  });
}
