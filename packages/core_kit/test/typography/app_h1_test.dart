// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppH1', () {
    group('Rendering', () {
      testWidgets('renders with correct text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH1('Test Heading'))),
        );

        expect(find.text('Test Heading'), findsOneWidget);
      });

      testWidgets('uses headlineLarge text style', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH1('Test Heading'))),
        );

        final textWidget = tester.widget<Text>(find.text('Test Heading'));
        final theme = Theme.of(tester.element(find.byType(Scaffold)));

        expect(
          textWidget.style?.fontSize,
          theme.textTheme.headlineLarge?.fontSize,
        );
      });
    });

    group('Color Override', () {
      testWidgets('applies custom color when specified', (tester) async {
        const customColor = Colors.blue;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppH1('Colored Heading', color: customColor)),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Colored Heading'));
        expect(textWidget.style?.color, customColor);
      });

      testWidgets('uses default theme color when not specified', (
        tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH1('Default Color'))),
        );

        final textWidget = tester.widget<Text>(find.text('Default Color'));
        final theme = Theme.of(tester.element(find.byType(Scaffold)));

        // When no custom color is specified, it should use theme's headlineLarge color
        expect(textWidget.style?.color, theme.textTheme.headlineLarge?.color);
      });
    });

    group('Font Weight', () {
      testWidgets('applies custom font weight when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH1('Bold Heading', fontWeight: FontWeight.bold),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Bold Heading'));
        expect(textWidget.style?.fontWeight, FontWeight.bold);
      });

      testWidgets('uses default font weight when not specified', (
        tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH1('Normal Weight'))),
        );

        final textWidget = tester.widget<Text>(find.text('Normal Weight'));
        final theme = Theme.of(tester.element(find.byType(Scaffold)));
        // Should use theme default from headlineLarge
        expect(
          textWidget.style?.fontWeight,
          theme.textTheme.headlineLarge?.fontWeight,
        );
      });
    });

    group('Text Alignment', () {
      testWidgets('applies center alignment when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH1('Centered', textAlign: TextAlign.center),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Centered'));
        expect(textWidget.textAlign, TextAlign.center);
      });

      testWidgets('applies right alignment when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH1('Right Aligned', textAlign: TextAlign.right),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Right Aligned'));
        expect(textWidget.textAlign, TextAlign.right);
      });

      testWidgets('uses default alignment when not specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH1('Default Alignment'))),
        );

        final textWidget = tester.widget<Text>(find.text('Default Alignment'));
        expect(textWidget.textAlign, isNull);
      });
    });

    group('Max Lines and Overflow', () {
      testWidgets('applies maxLines when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 100,
                child: AppH1(
                  'Very Long Heading Text That Should Be Truncated',
                  maxLines: 1,
                ),
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(
          find.text('Very Long Heading Text That Should Be Truncated'),
        );
        expect(textWidget.maxLines, 1);
      });

      testWidgets('applies ellipsis overflow when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 100,
                child: AppH1('Long Text', overflow: TextOverflow.ellipsis),
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Long Text'));
        expect(textWidget.overflow, TextOverflow.ellipsis);
      });

      testWidgets('applies fade overflow when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH1('Fading Text', overflow: TextOverflow.fade),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Fading Text'));
        expect(textWidget.overflow, TextOverflow.fade);
      });
    });

    group('Accessibility', () {
      testWidgets('has Semantics wrapper with header property', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH1('Accessible Heading'))),
        );

        // Verify Semantics widget exists
        expect(find.byType(Semantics), findsWidgets);

        // Find the Semantics widget that is a direct parent of our Text widget
        final semanticsWidget = tester.widget<Semantics>(
          find
              .ancestor(
                of: find.text('Accessible Heading'),
                matching: find.byType(Semantics),
              )
              .first,
        );

        // Verify it has the header property set to true
        expect(semanticsWidget.properties.header, isTrue);
      });

      testWidgets('text is findable for screen readers', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH1('Screen Reader Text'))),
        );

        expect(find.text('Screen Reader Text'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles empty string', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH1(''))),
        );

        expect(find.text(''), findsOneWidget);
      });

      testWidgets('handles very long text', (tester) async {
        final longText = 'A' * 500;

        await tester.pumpWidget(
          MaterialApp(home: Scaffold(body: AppH1(longText))),
        );

        expect(find.text(longText), findsOneWidget);
      });

      testWidgets('handles special characters', (tester) async {
        const specialText = '!@#\$%^&*()_+-=[]{}|;:,.<>?/~`';

        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH1(specialText))),
        );

        expect(find.text(specialText), findsOneWidget);
      });

      testWidgets('handles emojis and unicode', (tester) async {
        const emojiText = '🚀 Hello World 你好 مرحبا';

        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH1(emojiText))),
        );

        expect(find.text(emojiText), findsOneWidget);
      });
    });

    group('Multiple Properties', () {
      testWidgets('applies all properties together', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 200,
                child: AppH1(
                  'Complete Heading',
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Complete Heading'));
        expect(textWidget.style?.color, Colors.red);
        expect(textWidget.style?.fontWeight, FontWeight.bold);
        expect(textWidget.textAlign, TextAlign.center);
        expect(textWidget.maxLines, 2);
        expect(textWidget.overflow, TextOverflow.ellipsis);
      });
    });
  });
}
