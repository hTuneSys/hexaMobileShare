// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppH2', () {
    group('Rendering', () {
      testWidgets('renders with correct text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH2('Test Section'))),
        );

        expect(find.text('Test Section'), findsOneWidget);
      });

      testWidgets('uses headlineMedium text style', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH2('Test Section'))),
        );

        final textWidget = tester.widget<Text>(find.text('Test Section'));
        final theme = Theme.of(tester.element(find.byType(Scaffold)));

        expect(
          textWidget.style?.fontSize,
          theme.textTheme.headlineMedium?.fontSize,
        );
      });
    });

    group('Color Override', () {
      testWidgets('applies custom color when specified', (tester) async {
        const customColor = Colors.green;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppH2('Colored Section', color: customColor)),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Colored Section'));
        expect(textWidget.style?.color, customColor);
      });
    });

    group('Font Weight', () {
      testWidgets('applies custom font weight when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH2('Bold Section', fontWeight: FontWeight.w600),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Bold Section'));
        expect(textWidget.style?.fontWeight, FontWeight.w600);
      });
    });

    group('Text Alignment', () {
      testWidgets('applies center alignment when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH2('Centered', textAlign: TextAlign.center),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Centered'));
        expect(textWidget.textAlign, TextAlign.center);
      });
    });

    group('Max Lines and Overflow', () {
      testWidgets('applies maxLines when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 100,
                child: AppH2(
                  'Very Long Section Title That Should Be Truncated',
                  maxLines: 1,
                ),
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(
          find.text('Very Long Section Title That Should Be Truncated'),
        );
        expect(textWidget.maxLines, 1);
      });

      testWidgets('applies ellipsis overflow when specified', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH2('Long Text', overflow: TextOverflow.ellipsis),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Long Text'));
        expect(textWidget.overflow, TextOverflow.ellipsis);
      });
    });

    group('Accessibility', () {
      testWidgets('has Semantics wrapper with header property', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH2('Accessible Section'))),
        );

        expect(find.byType(Semantics), findsWidgets);

        final semanticsWidget = tester.widget<Semantics>(
          find
              .ancestor(
                of: find.text('Accessible Section'),
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
          const MaterialApp(home: Scaffold(body: AppH2(''))),
        );

        expect(find.text(''), findsOneWidget);
      });

      testWidgets('handles special characters and emojis', (tester) async {
        const mixedText = '📱 Settings & Privacy';

        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppH2(mixedText))),
        );

        expect(find.text(mixedText), findsOneWidget);
      });
    });

    group('Multiple Properties', () {
      testWidgets('applies all properties together', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppH2(
                'Complete Section',
                color: Colors.purple,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Complete Section'));
        expect(textWidget.style?.color, Colors.purple);
        expect(textWidget.style?.fontWeight, FontWeight.w500);
        expect(textWidget.textAlign, TextAlign.right);
        expect(textWidget.maxLines, 1);
        expect(textWidget.overflow, TextOverflow.fade);
      });
    });
  });
}
