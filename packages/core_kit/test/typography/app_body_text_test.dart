// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/typography/app_body_text.dart';

void main() {
  group('AppBodyText Tests', () {
    testWidgets('AppBodyText renders with default text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppBodyText('Test body text'))),
      );

      expect(find.text('Test body text'), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('AppBodyText.large uses bodyLarge style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppBodyText.large('Large text')),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final textTheme = Theme.of(tester.element(find.byType(Text))).textTheme;

      expect(textWidget.style?.fontSize, textTheme.bodyLarge?.fontSize);
      expect(textWidget.style?.fontWeight, textTheme.bodyLarge?.fontWeight);
      expect(find.text('Large text'), findsOneWidget);
    });

    testWidgets('AppBodyText.medium uses bodyMedium style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppBodyText.medium('Medium text')),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final textTheme = Theme.of(tester.element(find.byType(Text))).textTheme;

      expect(textWidget.style?.fontSize, textTheme.bodyMedium?.fontSize);
      expect(textWidget.style?.fontWeight, textTheme.bodyMedium?.fontWeight);
      expect(find.text('Medium text'), findsOneWidget);
    });

    testWidgets('AppBodyText.small uses bodySmall style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppBodyText.small('Small text')),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final textTheme = Theme.of(tester.element(find.byType(Text))).textTheme;

      expect(textWidget.style?.fontSize, textTheme.bodySmall?.fontSize);
      expect(textWidget.style?.fontWeight, textTheme.bodySmall?.fontWeight);
      expect(find.text('Small text'), findsOneWidget);
    });

    testWidgets('AppBodyText applies custom color', (tester) async {
      const customColor = Colors.blue;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppBodyText('Colored text', color: customColor)),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, customColor);
    });

    testWidgets('AppBodyText applies custom font weight', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBodyText('Bold text', fontWeight: FontWeight.bold),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('AppBodyText applies text alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBodyText('Centered text', textAlign: TextAlign.center),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('AppBodyText applies maxLines', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppBodyText('Text with max lines', maxLines: 2)),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.maxLines, 2);
    });

    testWidgets('AppBodyText applies overflow', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBodyText(
              'Text with overflow',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('AppBodyText applies softWrap', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBodyText('Text with no soft wrap', softWrap: false),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.softWrap, false);
    });

    testWidgets('AppBodyText applies text direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBodyText(
              'Text with RTL direction',
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.textDirection, TextDirection.rtl);
    });

    testWidgets('AppBodyText applies semantics label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBodyText(
              'Text with semantics',
              semanticsLabel: 'Custom semantics label',
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.semanticsLabel, 'Custom semantics label');
    });

    testWidgets('AppBodyText combines multiple properties correctly', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBodyText.medium(
              'Combined properties text',
              color: Colors.red,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.right,
              maxLines: 3,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, Colors.red);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.textAlign, TextAlign.right);
      expect(textWidget.maxLines, 3);
      expect(textWidget.overflow, TextOverflow.fade);
    });

    testWidgets('AppBodyText default constructor uses medium variant', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppBodyText('Default variant text')),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final textTheme = Theme.of(tester.element(find.byType(Text))).textTheme;

      // Default constructor should use bodyMedium style
      expect(textWidget.style?.fontSize, textTheme.bodyMedium?.fontSize);
    });
  });
}
