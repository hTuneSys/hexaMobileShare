// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/widgets/feedback/app_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppEmptyState', () {
    testWidgets('renders title and description correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppEmptyState(
              title: 'Empty Title',
              description: 'Empty Description',
            ),
          ),
        ),
      );

      expect(find.text('Empty Title'), findsOneWidget);
      expect(find.text('Empty Description'), findsOneWidget);
    });

    testWidgets('renders icon when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppEmptyState(title: 'Title', icon: Icons.search),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('renders illustration when provided (prioritizes over icon)', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppEmptyState(
              title: 'Title',
              icon: Icons.search,
              illustration: Text('Illustration Widget'),
            ),
          ),
        ),
      );

      expect(find.text('Illustration Widget'), findsOneWidget);
      expect(find.byIcon(Icons.search), findsNothing);
    });

    testWidgets('primary button triggers callback', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppEmptyState(
              title: 'Title',
              primaryButtonText: 'Primary Action',
              onPrimaryPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Primary Action'));
      expect(pressed, isTrue);
    });

    testWidgets('secondary button triggers callback', (tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppEmptyState(
              title: 'Title',
              secondaryButtonText: 'Secondary Action',
              onSecondaryPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Secondary Action'));
      expect(pressed, isTrue);
    });

    testWidgets('compact mode renders smaller illustration', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppEmptyState(
              title: 'Compact',
              illustration: SizedBox(),
              compact: true,
            ),
          ),
        ),
      );

      // We expect the first SizedBox (wrapping the illustration) to be 120x120
      // Note: The structure is Column -> [SizedBox(illustration), SizedBox(gap)...]
      // Getting the specific SizedBox might be tricky by type alone depending on impl details.
      // A more robust way is to check the SizedBox that is a direct child of Column and parent of illustration.
      // But for simplicity, we know implementation uses SizedBox(width: 120, height: 120, child: illustration)

      // Let's rely on finding by widget predicate for safety
      final illustrationContainer = find.ancestor(
        of: find.byType(SizedBox),
        matching: find.byWidgetPredicate(
          (widget) => widget is SizedBox && widget.width == 120.0,
        ),
      );

      expect(illustrationContainer, findsOneWidget);
    });
  });
}
