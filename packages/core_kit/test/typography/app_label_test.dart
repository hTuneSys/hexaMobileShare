// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/typography/app_label.dart';

void main() {
  group('AppLabel Tests', () {
    testWidgets('AppLabel renders with default text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppLabel('Test label'))),
      );

      expect(find.text('Test label'), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('AppLabel.large uses labelLarge style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppLabel.large('Large label'))),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final textTheme = Theme.of(tester.element(find.byType(Text))).textTheme;

      expect(textWidget.style?.fontSize, textTheme.labelLarge?.fontSize);
      expect(textWidget.style?.fontWeight, textTheme.labelLarge?.fontWeight);
      expect(find.text('Large label'), findsOneWidget);
    });

    testWidgets('AppLabel.medium uses labelMedium style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppLabel.medium('Medium label')),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final textTheme = Theme.of(tester.element(find.byType(Text))).textTheme;

      expect(textWidget.style?.fontSize, textTheme.labelMedium?.fontSize);
      expect(textWidget.style?.fontWeight, textTheme.labelMedium?.fontWeight);
      expect(find.text('Medium label'), findsOneWidget);
    });

    testWidgets('AppLabel.small uses labelSmall style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppLabel.small('Small label'))),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final textTheme = Theme.of(tester.element(find.byType(Text))).textTheme;

      expect(textWidget.style?.fontSize, textTheme.labelSmall?.fontSize);
      expect(textWidget.style?.fontWeight, textTheme.labelSmall?.fontWeight);
      expect(find.text('Small label'), findsOneWidget);
    });

    testWidgets('AppLabel applies custom color', (tester) async {
      const customColor = Colors.blue;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppLabel('Colored label', color: customColor)),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, customColor);
    });

    testWidgets('AppLabel applies custom font weight', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLabel('Bold label', fontWeight: FontWeight.bold),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('AppLabel applies text alignment', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLabel('Centered label', textAlign: TextAlign.center),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.textAlign, TextAlign.center);
    });

    testWidgets('AppLabel applies maxLines', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppLabel('Label with max lines', maxLines: 2)),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.maxLines, 2);
    });

    testWidgets('AppLabel applies overflow', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLabel(
              'Label with overflow',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('AppLabel applies softWrap', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLabel('Label with no soft wrap', softWrap: false),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.softWrap, false);
    });

    testWidgets('AppLabel applies text direction', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLabel(
              'Label with RTL direction',
              textDirection: TextDirection.rtl,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.textDirection, TextDirection.rtl);
    });

    testWidgets('AppLabel applies semantics label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLabel(
              'Label with semantics',
              semanticsLabel: 'Custom semantics label',
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.semanticsLabel, 'Custom semantics label');
    });

    testWidgets('AppLabel applies uppercase transformation', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppLabel('button text', uppercase: true)),
        ),
      );

      // Should display as uppercase
      expect(find.text('BUTTON TEXT'), findsOneWidget);
      expect(find.text('button text'), findsNothing);
    });

    testWidgets('AppLabel does not transform to uppercase by default', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppLabel('button text'))),
      );

      // Should display as provided (not uppercase)
      expect(find.text('button text'), findsOneWidget);
      expect(find.text('BUTTON TEXT'), findsNothing);
    });

    testWidgets('AppLabel uppercase works with all variants', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                AppLabel.large('large', uppercase: true),
                AppLabel.medium('medium', uppercase: true),
                AppLabel.small('small', uppercase: true),
              ],
            ),
          ),
        ),
      );

      expect(find.text('LARGE'), findsOneWidget);
      expect(find.text('MEDIUM'), findsOneWidget);
      expect(find.text('SMALL'), findsOneWidget);
    });

    testWidgets('AppLabel combines multiple properties correctly', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLabel.medium(
              'submit',
              color: Colors.red,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.fade,
              uppercase: true,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.style?.color, Colors.red);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.textAlign, TextAlign.right);
      expect(textWidget.maxLines, 1);
      expect(textWidget.overflow, TextOverflow.fade);
      expect(find.text('SUBMIT'), findsOneWidget);
    });

    testWidgets('AppLabel default constructor uses medium variant', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppLabel('Default variant label')),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      final textTheme = Theme.of(tester.element(find.byType(Text))).textTheme;

      // Default constructor should use labelMedium style
      expect(textWidget.style?.fontSize, textTheme.labelMedium?.fontSize);
    });

    testWidgets('AppLabel works correctly in button context', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButton(
              onPressed: () {},
              child: const AppLabel.large('Continue'),
            ),
          ),
        ),
      );

      expect(find.text('Continue'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('AppLabel works correctly in chip context', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: Chip(label: AppLabel.small('New'))),
        ),
      );

      expect(find.text('New'), findsOneWidget);
      expect(find.byType(Chip), findsOneWidget);
    });

    testWidgets('AppLabel preserves original text in semanticsLabel', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppLabel(
              'submit',
              uppercase: true,
              semanticsLabel: 'Submit button',
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.byType(Text));
      // Display text should be uppercase
      expect(find.text('SUBMIT'), findsOneWidget);
      // But semantics label should be as provided
      expect(textWidget.semanticsLabel, 'Submit button');
    });

    testWidgets('AppLabel handles empty string', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppLabel(''))),
      );

      expect(find.byType(Text), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.data, '');
    });

    testWidgets('AppLabel handles very long text', (tester) async {
      const longText =
          'This is a very long label text that should be '
          'handled properly by the component regardless of its length';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 100,
              child: AppLabel(
                longText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
      final textWidget = tester.widget<Text>(find.byType(Text));
      expect(textWidget.maxLines, 2);
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('AppLabel uppercase handles special characters', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppLabel('hello@world.com', uppercase: true)),
        ),
      );

      expect(find.text('HELLO@WORLD.COM'), findsOneWidget);
    });

    testWidgets('AppLabel uppercase handles numbers', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppLabel('item 123', uppercase: true)),
        ),
      );

      expect(find.text('ITEM 123'), findsOneWidget);
    });
  });
}
