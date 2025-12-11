// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/widgets/surfaces/app_card.dart';

void main() {
  group('AppCard Tests', () {
    testWidgets('AppCard default variant renders correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppCard(child: const Text('Default Card'))),
        ),
      );

      final cardFinder = find.byType(Card);
      expect(cardFinder, findsOneWidget);

      final Card card = tester.widget(cardFinder);
      expect(card.elevation, 1.0);
      expect(card.clipBehavior, Clip.hardEdge);
      expect(find.text('Default Card'), findsOneWidget);
    });

    testWidgets('AppCard.flat variant has 0 elevation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppCard.flat(child: const Text('Flat Card'))),
        ),
      );

      final Card card = tester.widget(find.byType(Card));
      expect(card.elevation, 0.0);
    });

    testWidgets('AppCard.elevated variant has 3 elevation', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard.elevated(child: const Text('Elevated Card')),
          ),
        ),
      );

      final Card card = tester.widget(find.byType(Card));
      expect(card.elevation, 3.0);
    });

    testWidgets('AppCard.outlined variant has border and 0 elevation', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard.outlined(child: const Text('Outlined Card')),
          ),
        ),
      );

      final Card card = tester.widget(find.byType(Card));
      expect(card.elevation, 0.0);

      final shape = card.shape as RoundedRectangleBorder;
      expect(shape.side.style, BorderStyle.solid);
    });

    testWidgets('AppCard handles onTap interaction', (tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard(
              onTap: () {
                tapped = true;
              },
              child: const Text('Tappable Card'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppCard));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
      // Ensure InkWell is present
      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('AppCard applies custom properties correctly', (tester) async {
      const customPadding = EdgeInsets.all(20);
      const customColor = Colors.red;
      const customRadius = BorderRadius.all(Radius.circular(20));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard(
              padding: customPadding,
              color: customColor,
              borderRadius: customRadius,
              child: const Text('Custom Card'),
            ),
          ),
        ),
      );

      final Card card = tester.widget(find.byType(Card));
      expect(card.color, customColor);

      // Find the Padding that directly wraps the text "Custom Card"
      // Note: There might be other paddings (e.g. Card margin), so we target the specific one.
      final paddingFinder = find
          .ancestor(
            of: find.text('Custom Card'),
            matching: find.byType(Padding),
          )
          .first;

      final paddingWidget = tester.widget<Padding>(paddingFinder);
      expect(paddingWidget.padding, customPadding);

      final shape = card.shape as RoundedRectangleBorder;
      expect(shape.borderRadius, customRadius);
    });

    testWidgets('AppCard structure renders InkWell inside Card', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppCard(onTap: () {}, child: const Text('Structure Test')),
          ),
        ),
      );

      // Verify InkWell is a descendant of Card
      expect(
        find.descendant(of: find.byType(Card), matching: find.byType(InkWell)),
        findsOneWidget,
      );
    });
  });
}
