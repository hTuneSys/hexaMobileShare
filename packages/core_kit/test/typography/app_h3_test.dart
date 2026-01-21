// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppH3', () {
    group('Rendering', () {
      testWidgets('renders with correct text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH3('Test Subsection'))),
        );

        expect(find.text('Test Subsection'), findsOneWidget);
      });

      testWidgets('uses headlineSmall text style', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH3('Test Subsection'))),
        );

        final textWidget = tester.widget<Text>(find.text('Test Subsection'));
        final theme = Theme.of(tester.element(find.byType(Scaffold)));

        expect(
          textWidget.style?.fontSize,
          theme.textTheme.headlineSmall?.fontSize,
        );
      });
    });

    group('Color Override', () {
      testWidgets('applies custom color when specified', (tester) async {
        const customColor = Colors.orange;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH3('Colored Subsection', color: customColor),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Colored Subsection'));
        expect(textWidget.style?.color, customColor);
      });
    });

    group('Font Weight', () {
      testWidgets('applies custom font weight when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH3('Bold Subsection', fontWeight: FontWeight.w700),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Bold Subsection'));
        expect(textWidget.style?.fontWeight, FontWeight.w700);
      });
    });

    group('Text Alignment', () {
      testWidgets('applies justify alignment when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH3('Justified', textAlign: TextAlign.justify),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Justified'));
        expect(textWidget.textAlign, TextAlign.justify);
      });
    });

    group('Max Lines and Overflow', () {
      testWidgets('applies maxLines when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 100,
                child: AppH3(
                  'Very Long Subsection Title That Should Be Truncated',
                  maxLines: 2,
                ),
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(
          find.text('Very Long Subsection Title That Should Be Truncated'),
        );
        expect(textWidget.maxLines, 2);
      });

      testWidgets('applies clip overflow when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH3('Clipped Text', overflow: TextOverflow.clip),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Clipped Text'));
        expect(textWidget.overflow, TextOverflow.clip);
      });
    });

    group('Accessibility', () {
      testWidgets('has Semantics wrapper with header property', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppH3('Accessible Subsection')),
          ),
        );

        expect(find.byType(Semantics), findsWidgets);

        final semanticsWidget = tester.widget<Semantics>(
          find
              .ancestor(
                of: find.text('Accessible Subsection'),
                matching: find.byType(Semantics),
              )
              .first,
        );

        expect(semanticsWidget.properties.header, isTrue);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles empty string', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH3(''))),
        );

        expect(find.text(''), findsOneWidget);
      });

      testWidgets('handles multiline text', (tester) async {
        const multilineText = 'Line 1\nLine 2\nLine 3';

        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH3(multilineText))),
        );

        expect(find.text(multilineText), findsOneWidget);
      });
    });

    group('Multiple Properties', () {
      testWidgets('applies all properties together', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH3(
                'Complete Subsection',
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.left,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(
          find.text('Complete Subsection'),
        );
        expect(textWidget.style?.color, Colors.teal);
        expect(textWidget.style?.fontWeight, FontWeight.bold);
        expect(textWidget.textAlign, TextAlign.left);
        expect(textWidget.maxLines, 3);
        expect(textWidget.overflow, TextOverflow.ellipsis);
      });
    });
  });
}
