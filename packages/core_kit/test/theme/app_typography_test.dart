// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/theme/app_typography.dart';

void main() {
  group('AppTypography', () {
    group('textTheme()', () {
      test('returns complete Material Design 3 text theme', () {
        final theme = AppTypography.textTheme();

        expect(theme.displayLarge, isNotNull);
        expect(theme.displayMedium, isNotNull);
        expect(theme.displaySmall, isNotNull);
        expect(theme.headlineLarge, isNotNull);
        expect(theme.headlineMedium, isNotNull);
        expect(theme.headlineSmall, isNotNull);
        expect(theme.titleLarge, isNotNull);
        expect(theme.titleMedium, isNotNull);
        expect(theme.titleSmall, isNotNull);
        expect(theme.bodyLarge, isNotNull);
        expect(theme.bodyMedium, isNotNull);
        expect(theme.bodySmall, isNotNull);
        expect(theme.labelLarge, isNotNull);
        expect(theme.labelMedium, isNotNull);
        expect(theme.labelSmall, isNotNull);
      });

      test('display styles have correct font sizes', () {
        final theme = AppTypography.textTheme();

        expect(theme.displayLarge!.fontSize, equals(57));
        expect(theme.displayMedium!.fontSize, equals(45));
        expect(theme.displaySmall!.fontSize, equals(36));
      });

      test('headline styles have correct font sizes', () {
        final theme = AppTypography.textTheme();

        expect(theme.headlineLarge!.fontSize, equals(32));
        expect(theme.headlineMedium!.fontSize, equals(28));
        expect(theme.headlineSmall!.fontSize, equals(24));
      });

      test('title styles have correct font sizes', () {
        final theme = AppTypography.textTheme();

        expect(theme.titleLarge!.fontSize, equals(22));
        expect(theme.titleMedium!.fontSize, equals(16));
        expect(theme.titleSmall!.fontSize, equals(14));
      });

      test('body styles have correct font sizes', () {
        final theme = AppTypography.textTheme();

        expect(theme.bodyLarge!.fontSize, equals(16));
        expect(theme.bodyMedium!.fontSize, equals(14));
        expect(theme.bodySmall!.fontSize, equals(12));
      });

      test('label styles have correct font sizes', () {
        final theme = AppTypography.textTheme();

        expect(theme.labelLarge!.fontSize, equals(14));
        expect(theme.labelMedium!.fontSize, equals(12));
        expect(theme.labelSmall!.fontSize, equals(11));
      });

      test('all styles use Roboto font family', () {
        final theme = AppTypography.textTheme();

        expect(theme.displayLarge!.fontFamily, equals('Roboto'));
        expect(theme.headlineMedium!.fontFamily, equals('Roboto'));
        expect(theme.titleSmall!.fontFamily, equals('Roboto'));
        expect(theme.bodyLarge!.fontFamily, equals('Roboto'));
        expect(theme.labelMedium!.fontFamily, equals('Roboto'));
      });

      test('body text meets minimum accessibility size (12sp)', () {
        final theme = AppTypography.textTheme();

        expect(theme.bodySmall!.fontSize, greaterThanOrEqualTo(12));
        expect(theme.labelSmall!.fontSize, greaterThanOrEqualTo(11));
      });
    });

    group('Text Style Modification Helpers', () {
      test('bold() applies bold font weight', () {
        const baseStyle = TextStyle(fontSize: 16);
        final boldStyle = AppTypography.bold(baseStyle);

        expect(boldStyle.fontWeight, equals(FontWeight.w700));
        expect(boldStyle.fontSize, equals(16)); // Preserves other properties
      });

      test('bold() handles null input', () {
        final boldStyle = AppTypography.bold(null);

        expect(boldStyle, isNotNull);
        expect(boldStyle.fontWeight, isNull);
      });

      test('italic() applies italic font style', () {
        const baseStyle = TextStyle(fontSize: 16);
        final italicStyle = AppTypography.italic(baseStyle);

        expect(italicStyle.fontStyle, equals(FontStyle.italic));
        expect(italicStyle.fontSize, equals(16)); // Preserves other properties
      });

      test('italic() handles null input', () {
        final italicStyle = AppTypography.italic(null);

        expect(italicStyle, isNotNull);
        expect(italicStyle.fontStyle, isNull);
      });

      test('withColor() applies specified color', () {
        const baseStyle = TextStyle(fontSize: 16);
        final coloredStyle = AppTypography.withColor(baseStyle, Colors.blue);

        expect(coloredStyle.color, equals(Colors.blue));
        expect(coloredStyle.fontSize, equals(16)); // Preserves other properties
      });

      test('withColor() handles null input', () {
        final coloredStyle = AppTypography.withColor(null, Colors.red);

        expect(coloredStyle.color, equals(Colors.red));
      });

      test('withSize() applies specified font size', () {
        const baseStyle = TextStyle(fontSize: 16);
        final sizedStyle = AppTypography.withSize(baseStyle, 24);

        expect(sizedStyle.fontSize, equals(24));
      });

      test('withSize() handles null input', () {
        final sizedStyle = AppTypography.withSize(null, 20);

        expect(sizedStyle.fontSize, equals(20));
      });

      test('withLineHeight() applies specified line height', () {
        const baseStyle = TextStyle(fontSize: 16);
        final lineHeightStyle = AppTypography.withLineHeight(baseStyle, 1.8);

        expect(lineHeightStyle.height, equals(1.8));
        expect(lineHeightStyle.fontSize, equals(16));
      });

      test('withLineHeight() handles null input', () {
        final lineHeightStyle = AppTypography.withLineHeight(null, 2.0);

        expect(lineHeightStyle.height, equals(2.0));
      });

      test('withLetterSpacing() applies specified letter spacing', () {
        const baseStyle = TextStyle(fontSize: 16);
        final spacedStyle = AppTypography.withLetterSpacing(baseStyle, 1.5);

        expect(spacedStyle.letterSpacing, equals(1.5));
        expect(spacedStyle.fontSize, equals(16));
      });

      test('withLetterSpacing() handles null input', () {
        final spacedStyle = AppTypography.withLetterSpacing(null, 2.0);

        expect(spacedStyle.letterSpacing, equals(2.0));
      });
    });

    group('Responsive Text Scaling', () {
      testWidgets('responsive() scales down on small devices', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(400, 800)),
              child: Builder(
                builder: (context) {
                  const baseStyle = TextStyle(fontSize: 20);
                  final responsiveStyle = AppTypography.responsive(
                    baseStyle,
                    context,
                  );

                  return Text('Test', style: responsiveStyle);
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Test'));
        // 20 * 0.9 = 18
        expect(text.style!.fontSize, equals(18.0));
      });

      testWidgets('responsive() maintains size on medium devices', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(700, 800)),
              child: Builder(
                builder: (context) {
                  const baseStyle = TextStyle(fontSize: 20);
                  final responsiveStyle = AppTypography.responsive(
                    baseStyle,
                    context,
                  );

                  return Text('Test', style: responsiveStyle);
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Test'));
        // 20 * 1.0 = 20
        expect(text.style!.fontSize, equals(20.0));
      });

      testWidgets('responsive() scales up on large devices', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: MediaQuery(
              data: const MediaQueryData(size: Size(1000, 800)),
              child: Builder(
                builder: (context) {
                  const baseStyle = TextStyle(fontSize: 20);
                  final responsiveStyle = AppTypography.responsive(
                    baseStyle,
                    context,
                  );

                  return Text('Test', style: responsiveStyle);
                },
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Test'));
        // 20 * 1.1 = 22
        expect(text.style!.fontSize, equals(22.0));
      });

      testWidgets('responsive() handles null input', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final responsiveStyle = AppTypography.responsive(null, context);

                return Text('Test', style: responsiveStyle);
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Test'));
        expect(text.style, isNotNull);
      });

      test('scale() applies custom scale factor', () {
        const baseStyle = TextStyle(fontSize: 16);
        final scaledStyle = AppTypography.scale(baseStyle, 1.5);

        expect(scaledStyle.fontSize, equals(24.0)); // 16 * 1.5 = 24
      });

      test('scale() handles null input', () {
        final scaledStyle = AppTypography.scale(null, 2.0);

        expect(scaledStyle, isNotNull);
      });

      test('scale() preserves other properties', () {
        const baseStyle = TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        );
        final scaledStyle = AppTypography.scale(baseStyle, 2.0);

        expect(scaledStyle.fontSize, equals(32.0)); // 16 * 2.0 = 32
        expect(scaledStyle.fontWeight, equals(FontWeight.bold));
        expect(scaledStyle.color, equals(Colors.red));
      });
    });

    group('Common Pattern Helpers', () {
      testWidgets('linkStyle() returns styled text for links', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final linkStyle = AppTypography.linkStyle(context);

                return Text('Click here', style: linkStyle);
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Click here'));
        expect(text.style!.decoration, equals(TextDecoration.underline));
        expect(text.style!.decorationColor, isNotNull);
      });

      testWidgets('errorStyle() returns error colored text', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final errorStyle = AppTypography.errorStyle(context);

                return Text('Error message', style: errorStyle);
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Error message'));
        expect(text.style!.color, isNotNull);
      });

      testWidgets('successStyle() returns success colored text', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final successStyle = AppTypography.successStyle(context);

                return Text('Success message', style: successStyle);
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Success message'));
        expect(text.style!.color, equals(const Color(0xFF4CAF50)));
      });

      testWidgets('warningStyle() returns warning colored text', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final warningStyle = AppTypography.warningStyle(context);

                return Text('Warning message', style: warningStyle);
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Warning message'));
        expect(text.style!.color, equals(const Color(0xFFFF9800)));
      });

      testWidgets('hintStyle() returns styled hint text', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final hintStyle = AppTypography.hintStyle(context);

                return Text('Hint text', style: hintStyle);
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Hint text'));
        expect(text.style!.color, isNotNull);
        expect(text.style!.color!.a, closeTo(0.6, 0.01));
      });

      testWidgets('disabledStyle() returns styled disabled text', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final disabledStyle = AppTypography.disabledStyle(context);

                return Text('Disabled text', style: disabledStyle);
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Disabled text'));
        expect(text.style!.color, isNotNull);
        expect(text.style!.color!.a, closeTo(0.38, 0.01));
      });

      testWidgets('codeStyle() returns monospace styled text', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final codeStyle = AppTypography.codeStyle(context);

                return Text('const x = 42;', style: codeStyle);
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('const x = 42;'));
        expect(text.style!.fontFamily, equals('monospace'));
        expect(text.style!.backgroundColor, isNotNull);
      });
    });

    group('Combined Usage', () {
      test('multiple modifiers can be chained', () {
        const baseStyle = TextStyle(fontSize: 16);
        final modifiedStyle = AppTypography.bold(
          AppTypography.italic(AppTypography.withColor(baseStyle, Colors.blue)),
        );

        expect(modifiedStyle.fontWeight, equals(FontWeight.w700));
        expect(modifiedStyle.fontStyle, equals(FontStyle.italic));
        expect(modifiedStyle.color, equals(Colors.blue));
        expect(modifiedStyle.fontSize, equals(16));
      });

      testWidgets('helpers work with theme text styles', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final theme = Theme.of(context).textTheme;
                final styledText = AppTypography.bold(
                  AppTypography.withColor(theme.bodyLarge, Colors.red),
                );

                return Text('Styled text', style: styledText);
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.text('Styled text'));
        expect(text.style!.fontWeight, equals(FontWeight.w700));
        expect(text.style!.color, equals(Colors.red));
      });
    });
  });
}
