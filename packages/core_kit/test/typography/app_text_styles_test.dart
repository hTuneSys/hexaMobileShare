// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppTextStyles', () {
    // Helper to build widget with MaterialApp
    Widget buildTestWidget({required Widget child}) {
      return MaterialApp(home: Scaffold(body: child));
    }

    group('Semantic Presets', () {
      testWidgets('error style uses error color from theme', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.error(context);
                final theme = Theme.of(context);

                expect(style.color, equals(theme.colorScheme.error));
                expect(style.fontWeight, equals(FontWeight.w500));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('success style uses tertiary color from theme', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.success(context);
                final theme = Theme.of(context);

                expect(style.color, equals(theme.colorScheme.tertiary));
                expect(style.fontWeight, equals(FontWeight.w500));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('warning style uses tertiary container color', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.warning(context);
                final theme = Theme.of(context);

                expect(
                  style.color,
                  equals(theme.colorScheme.tertiaryContainer),
                );
                expect(style.fontWeight, equals(FontWeight.w500));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('info style uses primary color from theme', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.info(context);
                final theme = Theme.of(context);

                expect(style.color, equals(theme.colorScheme.primary));
                expect(style.fontWeight, equals(FontWeight.w500));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('link style has primary color and underline', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.link(context);
                final theme = Theme.of(context);

                expect(style.color, equals(theme.colorScheme.primary));
                expect(style.decoration, equals(TextDecoration.underline));
                expect(
                  style.decorationColor,
                  equals(theme.colorScheme.primary),
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('muted style has reduced opacity', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.muted(context);
                final theme = Theme.of(context);
                final expectedColor = theme.colorScheme.onSurface.withValues(
                  alpha: 0.6,
                );

                expect(style.color, equals(expectedColor));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });
    });

    group('Modification Helpers', () {
      testWidgets('bold applies bold font weight', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.bold(context);

                expect(style.fontWeight, equals(FontWeight.bold));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('bold applies to custom style', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final baseStyle = Theme.of(context).textTheme.headlineLarge!;
                final style = AppTextStyles.bold(context, style: baseStyle);

                expect(style.fontWeight, equals(FontWeight.bold));
                expect(style.fontSize, equals(baseStyle.fontSize));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('italic applies italic font style', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.italic(context);

                expect(style.fontStyle, equals(FontStyle.italic));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('underline applies underline decoration', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.underline(context);

                expect(style.decoration, equals(TextDecoration.underline));
                expect(style.decorationColor, isNotNull);
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('strikethrough applies line-through decoration', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.strikethrough(context);

                expect(style.decoration, equals(TextDecoration.lineThrough));
                expect(style.decorationColor, isNotNull);
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });
    });

    group('Color Helpers', () {
      test('withColor applies specified color to style', () {
        const baseStyle = TextStyle(fontSize: 16.0);
        const testColor = Colors.red;

        final result = AppTextStyles.withColor(baseStyle, testColor);

        expect(result.color, equals(testColor));
        expect(result.fontSize, equals(baseStyle.fontSize));
      });

      test('withOpacity applies specified opacity to color', () {
        const baseColor = Colors.blue;
        const baseStyle = TextStyle(color: baseColor, fontSize: 16.0);
        const opacity = 0.5;

        final result = AppTextStyles.withOpacity(baseStyle, opacity);

        expect(result.color, equals(baseColor.withValues(alpha: opacity)));
        expect(result.fontSize, equals(baseStyle.fontSize));
      });

      test('withOpacity handles null color gracefully', () {
        const baseStyle = TextStyle(fontSize: 16.0);
        const opacity = 0.5;

        final result = AppTextStyles.withOpacity(baseStyle, opacity);

        expect(result.color, isNull);
      });
    });

    group('Size Helpers', () {
      testWidgets('larger increases font size by default factor', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                const baseFontSize = 14.0;
                final baseStyle = Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: baseFontSize);
                final style = AppTextStyles.larger(context, style: baseStyle);

                expect(style.fontSize, equals(baseFontSize * 1.2));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('larger increases font size by custom factor', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                const baseFontSize = 14.0;
                const customFactor = 1.5;
                final baseStyle = Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: baseFontSize);
                final style = AppTextStyles.larger(
                  context,
                  style: baseStyle,
                  factor: customFactor,
                );

                expect(style.fontSize, equals(baseFontSize * customFactor));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('smaller decreases font size by default factor', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                const baseFontSize = 14.0;
                final baseStyle = Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: baseFontSize);
                final style = AppTextStyles.smaller(context, style: baseStyle);

                expect(style.fontSize, equals(baseFontSize * 0.85));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('smaller decreases font size by custom factor', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                const baseFontSize = 14.0;
                const customFactor = 0.7;
                final baseStyle = Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(fontSize: baseFontSize);
                final style = AppTextStyles.smaller(
                  context,
                  style: baseStyle,
                  factor: customFactor,
                );

                expect(style.fontSize, equals(baseFontSize * customFactor));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });
    });

    group('Special Styles', () {
      testWidgets('monospace applies monospace font family', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final style = AppTextStyles.monospace(context);

                expect(style.fontFamily, equals('monospace'));
                expect(style.fontFamilyFallback, isNotNull);
                expect(style.fontFamilyFallback, contains('Courier'));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      test('withLineHeight applies custom line height', () {
        const baseStyle = TextStyle(fontSize: 16.0);
        const lineHeight = 1.8;

        final result = AppTextStyles.withLineHeight(baseStyle, lineHeight);

        expect(result.height, equals(lineHeight));
        expect(result.fontSize, equals(baseStyle.fontSize));
      });

      test('withLetterSpacing applies custom letter spacing', () {
        const baseStyle = TextStyle(fontSize: 16.0);
        const spacing = 2.0;

        final result = AppTextStyles.withLetterSpacing(baseStyle, spacing);

        expect(result.letterSpacing, equals(spacing));
        expect(result.fontSize, equals(baseStyle.fontSize));
      });
    });

    group('Combined Usage', () {
      testWidgets('can combine bold with error style', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final errorStyle = AppTextStyles.error(context);
                final boldErrorStyle = AppTextStyles.bold(
                  context,
                  style: errorStyle,
                );

                expect(boldErrorStyle.fontWeight, equals(FontWeight.bold));
                expect(
                  boldErrorStyle.color,
                  equals(Theme.of(context).colorScheme.error),
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('can combine italic with muted style', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final mutedStyle = AppTextStyles.muted(context);
                final italicMutedStyle = AppTextStyles.italic(
                  context,
                  style: mutedStyle,
                );

                expect(italicMutedStyle.fontStyle, equals(FontStyle.italic));
                expect(italicMutedStyle.color?.a, equals(0.6));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('can combine larger with success style', (tester) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                final successStyle = AppTextStyles.success(context);
                final baseFontSize = successStyle.fontSize ?? 14.0;
                final largeSuccessStyle = AppTextStyles.larger(
                  context,
                  style: successStyle,
                );

                expect(largeSuccessStyle.fontSize, equals(baseFontSize * 1.2));
                expect(
                  largeSuccessStyle.color,
                  equals(Theme.of(context).colorScheme.tertiary),
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      test('can chain multiple style modifications', () {
        const baseStyle = TextStyle(fontSize: 14.0);
        const customColor = Colors.purple;

        final result = AppTextStyles.withLineHeight(
          AppTextStyles.withLetterSpacing(
            AppTextStyles.withColor(baseStyle, customColor),
            2.0,
          ),
          1.5,
        );

        expect(result.color, equals(customColor));
        expect(result.letterSpacing, equals(2.0));
        expect(result.height, equals(1.5));
        expect(result.fontSize, equals(baseStyle.fontSize));
      });
    });

    group('Widget Integration', () {
      testWidgets('error style renders correctly in Text widget', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                return Text(
                  'Error message',
                  style: AppTextStyles.error(context),
                );
              },
            ),
          ),
        );

        expect(find.text('Error message'), findsOneWidget);
      });

      testWidgets('success style renders correctly in Text widget', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                return Text(
                  'Success message',
                  style: AppTextStyles.success(context),
                );
              },
            ),
          ),
        );

        expect(find.text('Success message'), findsOneWidget);
      });

      testWidgets('link style renders correctly in Text widget', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                return Text('Click here', style: AppTextStyles.link(context));
              },
            ),
          ),
        );

        expect(find.text('Click here'), findsOneWidget);
      });

      testWidgets('monospace style renders correctly in Text widget', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                return Text(
                  'const value = 42;',
                  style: AppTextStyles.monospace(context),
                );
              },
            ),
          ),
        );

        expect(find.text('const value = 42;'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles null fontSize gracefully in size helpers', (
        tester,
      ) async {
        await tester.pumpWidget(
          buildTestWidget(
            child: Builder(
              builder: (context) {
                const baseStyle = TextStyle();
                final largerStyle = AppTextStyles.larger(
                  context,
                  style: baseStyle,
                );

                // Should use default 14.0 when fontSize is null
                expect(largerStyle.fontSize, equals(14.0 * 1.2));
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      test('withOpacity with 0.0 makes text fully transparent', () {
        const baseStyle = TextStyle(color: Colors.black, fontSize: 16.0);

        final result = AppTextStyles.withOpacity(baseStyle, 0.0);

        expect(result.color?.a, equals(0.0));
      });

      test('withOpacity with 1.0 maintains full opacity', () {
        const baseStyle = TextStyle(color: Colors.black, fontSize: 16.0);

        final result = AppTextStyles.withOpacity(baseStyle, 1.0);

        expect(result.color?.a, equals(1.0));
      });
    });
  });
}
