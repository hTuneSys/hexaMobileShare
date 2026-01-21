// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppOverline', () {
    group('Rendering', () {
      testWidgets('renders text in uppercase', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppOverline('technology'))),
        );

        expect(find.text('TECHNOLOGY'), findsOneWidget);
        expect(find.text('technology'), findsNothing);
      });

      testWidgets('renders with correct default styling', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppOverline('Test'))),
        );

        final text = tester.widget<Text>(find.byType(Text));
        expect(text.data, 'TEST');
        expect(text.textAlign, TextAlign.start);
      });

      testWidgets('displays uppercase text even when already uppercase', (
        tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppOverline('ALREADY UPPERCASE')),
          ),
        );

        expect(find.text('ALREADY UPPERCASE'), findsOneWidget);
      });

      testWidgets('handles empty string', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppOverline(''))),
        );

        final text = tester.widget<Text>(find.byType(Text));
        expect(text.data, '');
      });

      testWidgets('handles special characters and numbers', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppOverline('step 1-2-3!'))),
        );

        expect(find.text('STEP 1-2-3!'), findsOneWidget);
      });
    });

    group('Color', () {
      testWidgets('uses onSurfaceVariant color by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
            home: const Scaffold(body: AppOverline('Test')),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.byType(Text));
        final theme = ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        );

        expect(text.style?.color, theme.colorScheme.onSurfaceVariant);
      });

      testWidgets('applies custom color when provided', (tester) async {
        const customColor = Colors.red;

        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppOverline('Test', color: customColor)),
          ),
        );

        final text = tester.widget<Text>(find.byType(Text));
        expect(text.style?.color, customColor);
      });

      testWidgets('applies primary color correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            ),
            home: Builder(
              builder: (context) {
                return Scaffold(
                  body: AppOverline(
                    'Test',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        final text = tester.widget<Text>(find.byType(Text));
        final theme = ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        );

        expect(text.style?.color, theme.colorScheme.primary);
      });
    });

    group('Text Alignment', () {
      testWidgets('defaults to TextAlign.start', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppOverline('Test'))),
        );

        final text = tester.widget<Text>(find.byType(Text));
        expect(text.textAlign, TextAlign.start);
      });

      testWidgets('applies TextAlign.center correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppOverline('Test', textAlign: TextAlign.center),
            ),
          ),
        );

        final text = tester.widget<Text>(find.byType(Text));
        expect(text.textAlign, TextAlign.center);
      });

      testWidgets('applies TextAlign.end correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppOverline('Test', textAlign: TextAlign.end)),
          ),
        );

        final text = tester.widget<Text>(find.byType(Text));
        expect(text.textAlign, TextAlign.end);
      });

      testWidgets('applies TextAlign.justify correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppOverline('Test', textAlign: TextAlign.justify),
            ),
          ),
        );

        final text = tester.widget<Text>(find.byType(Text));
        expect(text.textAlign, TextAlign.justify);
      });
    });

    group('Typography', () {
      testWidgets('uses labelSmall text style', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(
                labelSmall: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            home: const Scaffold(body: AppOverline('Test')),
          ),
        );

        final text = tester.widget<Text>(find.byType(Text));
        expect(text.style?.fontSize, 11);
        expect(text.style?.fontWeight, FontWeight.w500);
      });

      testWidgets('respects theme text style', (tester) async {
        const customFontSize = 14.0;

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              textTheme: const TextTheme(
                labelSmall: TextStyle(fontSize: customFontSize),
              ),
            ),
            home: const Scaffold(body: AppOverline('Test')),
          ),
        );

        final text = tester.widget<Text>(find.byType(Text));
        expect(text.style?.fontSize, customFontSize);
      });
    });

    group('Common Use Cases', () {
      testWidgets('works above headline in column layout', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppOverline('Business'),
                      const VGap.sm(),
                      Text(
                        'Main Headline',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        expect(find.text('BUSINESS'), findsOneWidget);
        expect(find.text('Main Headline'), findsOneWidget);
      });

      testWidgets('works as category label in card', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppCard(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppOverline('Technology'),
                    VGap.sm(),
                    Text('Article Title'),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.text('TECHNOLOGY'), findsOneWidget);
        expect(find.text('Article Title'), findsOneWidget);
        expect(find.byType(AppCard), findsOneWidget);
      });

      testWidgets('works as step indicator', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppOverline('Step 1'),
                      const VGap.sm(),
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );

        expect(find.text('STEP 1'), findsOneWidget);
        expect(find.text('Create Account'), findsOneWidget);
      });

      testWidgets('renders multiple overlines in wrap layout', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: Wrap(
                spacing: 16,
                children: [
                  AppOverline('Tech'),
                  AppOverline('Business'),
                  AppOverline('Sports'),
                ],
              ),
            ),
          ),
        );

        expect(find.text('TECH'), findsOneWidget);
        expect(find.text('BUSINESS'), findsOneWidget);
        expect(find.text('SPORTS'), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('maintains semantic text for screen readers', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppOverline('technology'))),
        );

        // Verify that the uppercase transformation is visual only
        // The actual text data should be uppercase
        final text = tester.widget<Text>(find.byType(Text));
        expect(text.data, 'TECHNOLOGY');
      });

      testWidgets('is accessible when used with Semantics', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Semantics(
                label: 'Category: Technology',
                child: const AppOverline('technology'),
              ),
            ),
          ),
        );

        // MaterialApp creates multiple Semantics widgets, so we check for the text instead
        expect(find.text('TECHNOLOGY'), findsOneWidget);
        // Verify the Semantics wrapper exists with our custom label
        final semanticsDebugString = tester
            .getSemantics(find.text('TECHNOLOGY'))
            .toString();
        expect(semanticsDebugString.contains('Category: Technology'), isTrue);
      });
    });

    group('Material Design 3 Compliance', () {
      testWidgets('uses proper MD3 text style', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(useMaterial3: true),
            home: const Scaffold(body: AppOverline('Test')),
          ),
        );

        final text = tester.widget<Text>(find.byType(Text));
        expect(text.style, isNotNull);
      });

      testWidgets('adapts to theme changes', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(useMaterial3: true),
            home: const Scaffold(body: AppOverline('Test')),
          ),
        );

        expect(find.text('TEST'), findsOneWidget);

        // Rebuild with dark theme
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(useMaterial3: true),
            home: const Scaffold(body: AppOverline('Test')),
          ),
        );

        await tester.pumpAndSettle();
        expect(find.text('TEST'), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles multiline text', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 50,
                child: AppOverline('very long text that wraps'),
              ),
            ),
          ),
        );

        expect(find.text('VERY LONG TEXT THAT WRAPS'), findsOneWidget);
      });

      testWidgets('handles unicode characters', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppOverline('café'))),
        );

        expect(find.text('CAFÉ'), findsOneWidget);
      });

      testWidgets('handles emoji correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: AppOverline('test 🎉'))),
        );

        expect(find.text('TEST 🎉'), findsOneWidget);
      });
    });
  });
}
