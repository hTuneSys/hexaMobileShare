// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSearchField', () {
    testWidgets('renders with search icon and hint text', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppSearchField(hint: 'Search products...')),
        ),
      );

      // Verify search icon is displayed
      expect(find.byIcon(Icons.search), findsOneWidget);

      // Verify hint text is displayed
      expect(find.text('Search products...'), findsOneWidget);
    });

    testWidgets('displays default hint text when not provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppSearchField())),
      );

      // Verify default hint text
      expect(find.text('Search...'), findsOneWidget);
    });

    testWidgets('shows clear button when text is entered', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppSearchField(controller: controller)),
        ),
      );

      // Initially no clear button
      expect(find.byIcon(Icons.clear), findsNothing);

      // Enter text
      await tester.enterText(find.byType(TextField), 'test query');
      await tester.pump();

      // Clear button should appear
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('clears text when clear button is tapped', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController(text: 'initial text');
      String? lastSearchQuery;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSearchField(
              controller: controller,
              onSearchChanged: (query) {
                lastSearchQuery = query;
              },
            ),
          ),
        ),
      );

      // Verify initial text
      expect(controller.text, 'initial text');
      expect(find.byIcon(Icons.clear), findsOneWidget);

      // Tap clear button
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();

      // Verify text is cleared
      expect(controller.text, '');
      expect(find.byIcon(Icons.clear), findsNothing);
      expect(lastSearchQuery, '');
    });

    testWidgets('triggers onSearchChanged after debounce delay', (
      WidgetTester tester,
    ) async {
      final List<String> searchQueries = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSearchField(
              debounceDelay: 300,
              onSearchChanged: (query) {
                searchQueries.add(query);
              },
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'test');

      // Should not trigger immediately
      expect(searchQueries, isEmpty);

      // Wait for debounce delay
      await tester.pump(const Duration(milliseconds: 300));

      // Should trigger after debounce
      expect(searchQueries, ['test']);
    });

    testWidgets('debouncing cancels previous timer on new input', (
      WidgetTester tester,
    ) async {
      final List<String> searchQueries = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSearchField(
              debounceDelay: 300,
              onSearchChanged: (query) {
                searchQueries.add(query);
              },
            ),
          ),
        ),
      );

      // Enter text multiple times rapidly
      await tester.enterText(find.byType(TextField), 't');
      await tester.pump(const Duration(milliseconds: 100));

      await tester.enterText(find.byType(TextField), 'te');
      await tester.pump(const Duration(milliseconds: 100));

      await tester.enterText(find.byType(TextField), 'test');

      // Should not trigger for intermediate values
      expect(searchQueries, isEmpty);

      // Wait for debounce delay from last input
      await tester.pump(const Duration(milliseconds: 300));

      // Should only trigger for final value
      expect(searchQueries, ['test']);
    });

    testWidgets('triggers onSearchSubmitted immediately without debounce', (
      WidgetTester tester,
    ) async {
      String? submittedQuery;
      final List<String> changedQueries = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSearchField(
              debounceDelay: 300,
              onSearchChanged: (query) {
                changedQueries.add(query);
              },
              onSearchSubmitted: (query) {
                submittedQuery = query;
              },
            ),
          ),
        ),
      );

      // Enter text and submit
      await tester.enterText(find.byType(TextField), 'immediate search');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      // Should trigger submit immediately
      expect(submittedQuery, 'immediate search');

      // Should not have triggered debounced change yet
      expect(changedQueries, isEmpty);

      // Wait for debounce delay
      await tester.pump(const Duration(milliseconds: 300));

      // Now debounced change should not trigger (cancelled by submit)
      expect(changedQueries, isEmpty);
    });

    testWidgets('clears field on submit when clearOnSubmit is true', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSearchField(
              controller: controller,
              clearOnSubmit: true,
              onSearchSubmitted: (query) {},
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'test query');
      await tester.pump();

      expect(controller.text, 'test query');

      // Submit
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      // Should be cleared
      expect(controller.text, '');
    });

    testWidgets('does not clear field on submit when clearOnSubmit is false', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSearchField(
              controller: controller,
              clearOnSubmit: false,
              onSearchSubmitted: (query) {},
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'test query');
      await tester.pump();

      expect(controller.text, 'test query');

      // Submit
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      // Should not be cleared
      expect(controller.text, 'test query');
    });

    testWidgets('shows loading indicator when isLoading is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppSearchField(isLoading: true)),
        ),
      );

      // Verify loading indicator is displayed
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Clear button should not be visible
      expect(find.byIcon(Icons.clear), findsNothing);
    });

    testWidgets('loading indicator takes priority over clear button', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController(text: 'search query');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSearchField(controller: controller, isLoading: true),
          ),
        ),
      );

      // Loading indicator should be visible
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Clear button should not be visible even though text exists
      expect(find.byIcon(Icons.clear), findsNothing);
    });

    testWidgets('autofocus works when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppSearchField(autofocus: true)),
        ),
      );

      await tester.pump();

      // TextField should be focused
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.autofocus, isTrue);
    });

    testWidgets('disabled state prevents interaction', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppSearchField(enabled: false))),
      );

      // Verify field is disabled
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.enabled, isFalse);
    });

    testWidgets('uses custom debounce delay', (WidgetTester tester) async {
      final List<String> searchQueries = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSearchField(
              debounceDelay: 500,
              onSearchChanged: (query) {
                searchQueries.add(query);
              },
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'test');

      // Wait for 300ms (default delay)
      await tester.pump(const Duration(milliseconds: 300));

      // Should not trigger yet (using 500ms delay)
      expect(searchQueries, isEmpty);

      // Wait for remaining 200ms
      await tester.pump(const Duration(milliseconds: 200));

      // Should trigger now
      expect(searchQueries, ['test']);
    });

    testWidgets('disposes controller when internally created', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppSearchField())),
      );

      // Dispose widget
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));

      // Should not throw error (controller properly disposed)
      expect(tester.takeException(), isNull);
    });

    testWidgets('does not dispose external controller', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppSearchField(controller: controller)),
        ),
      );

      // Dispose widget
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));

      // External controller should still be usable
      expect(() => controller.text, returnsNormally);
      controller.dispose();
    });

    testWidgets('updates when controller changes', (WidgetTester tester) async {
      final controller1 = TextEditingController(text: 'first');
      final controller2 = TextEditingController(text: 'second');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppSearchField(controller: controller1)),
        ),
      );

      expect(find.text('first'), findsOneWidget);

      // Change controller
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppSearchField(controller: controller2)),
        ),
      );

      expect(find.text('second'), findsOneWidget);

      controller1.dispose();
      controller2.dispose();
    });
  });
}
