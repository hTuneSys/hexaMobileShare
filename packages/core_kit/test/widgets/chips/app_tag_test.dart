// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/widgets/chips/app_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTag', () {
    group('Basic Rendering', () {
      testWidgets('renders with required label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppTag(label: 'Test')),
          ),
        );

        expect(find.text('Test'), findsOneWidget);
      });

      testWidgets('renders without icon by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppTag(label: 'No Icon')),
          ),
        );

        expect(find.byType(Icon), findsNothing);
        expect(find.text('No Icon'), findsOneWidget);
      });

      testWidgets('renders with leading icon when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(label: 'With Icon', icon: Icons.star),
            ),
          ),
        );

        expect(find.byType(Icon), findsOneWidget);
        expect(find.byIcon(Icons.star), findsOneWidget);
        expect(find.text('With Icon'), findsOneWidget);
      });

      testWidgets('asserts label is not empty', (tester) async {
        expect(() => AppTag(label: ''), throwsAssertionError);
      });
    });

    group('Size Variants', () {
      testWidgets('small size has correct height', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(label: 'Small', size: AppTagSize.small),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Container),
          ),
        );
        expect(container.constraints?.maxHeight, 20.0);
      });

      testWidgets('medium size has correct height', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(label: 'Medium', size: AppTagSize.medium),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Container),
          ),
        );
        expect(container.constraints?.maxHeight, 24.0);
      });

      testWidgets('large size has correct height', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(label: 'Large', size: AppTagSize.large),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Container),
          ),
        );
        expect(container.constraints?.maxHeight, 32.0);
      });

      testWidgets('small size uses correct icon size', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(
                label: 'Small',
                icon: Icons.check,
                size: AppTagSize.small,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, 12.0);
      });

      testWidgets('medium size uses correct icon size', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(
                label: 'Medium',
                icon: Icons.check,
                size: AppTagSize.medium,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, 16.0);
      });

      testWidgets('large size uses correct icon size', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(
                label: 'Large',
                icon: Icons.check,
                size: AppTagSize.large,
              ),
            ),
          ),
        );

        final icon = tester.widget<Icon>(find.byType(Icon));
        expect(icon.size, 18.0);
      });
    });

    group('Color Variants', () {
      testWidgets('success variant renders correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(
                label: 'Success',
                colorVariant: AppTagColorVariant.success,
              ),
            ),
          ),
        );

        expect(find.text('Success'), findsOneWidget);
        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Container),
          ),
        );
        expect(container.decoration, isA<BoxDecoration>());
      });

      testWidgets('warning variant renders correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(
                label: 'Warning',
                colorVariant: AppTagColorVariant.warning,
              ),
            ),
          ),
        );

        expect(find.text('Warning'), findsOneWidget);
      });

      testWidgets('error variant renders correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(
                label: 'Error',
                colorVariant: AppTagColorVariant.error,
              ),
            ),
          ),
        );

        expect(find.text('Error'), findsOneWidget);
      });

      testWidgets('info variant renders correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(
                label: 'Info',
                colorVariant: AppTagColorVariant.info,
              ),
            ),
          ),
        );

        expect(find.text('Info'), findsOneWidget);
      });

      testWidgets('neutral variant renders correctly', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(
                label: 'Neutral',
                colorVariant: AppTagColorVariant.neutral,
              ),
            ),
          ),
        );

        expect(find.text('Neutral'), findsOneWidget);
      });
    });

    group('Style Variants', () {
      testWidgets('filled style has background color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTag(
                label: 'Filled',
                style: AppTagStyle.filled,
                backgroundColor: Colors.blue,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Container),
          ),
        );
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, Colors.blue);
        expect(decoration.border, isNull);
      });

      testWidgets('outlined style has border and no background', (
        tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(label: 'Outlined', style: AppTagStyle.outlined),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Container),
          ),
        );
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, Colors.transparent);
        expect(decoration.border, isNotNull);
      });
    });

    group('Custom Colors', () {
      testWidgets('uses custom background color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTag(label: 'Custom BG', backgroundColor: Colors.purple),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Container),
          ),
        );
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, Colors.purple);
      });

      testWidgets('uses custom text color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTag(label: 'Custom Text', textColor: Colors.yellow),
            ),
          ),
        );

        final text = tester.widget<Text>(find.text('Custom Text'));
        expect(text.style?.color, Colors.yellow);
      });

      testWidgets('custom colors override variant colors', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppTag(
                label: 'Override',
                colorVariant: AppTagColorVariant.success,
                backgroundColor: Colors.pink,
                textColor: Colors.white,
              ),
            ),
          ),
        );

        final container = tester.widget<Container>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Container),
          ),
        );
        final decoration = container.decoration as BoxDecoration;
        expect(decoration.color, Colors.pink);

        final text = tester.widget<Text>(find.text('Override'));
        expect(text.style?.color, Colors.white);
      });
    });

    group('Text Overflow', () {
      testWidgets('long text truncates with ellipsis', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 100,
                child: AppTag(
                  label: 'This is a very long label that should truncate',
                ),
              ),
            ),
          ),
        );

        final text = tester.widget<Text>(
          find.text('This is a very long label that should truncate'),
        );
        expect(text.maxLines, 1);
        expect(text.overflow, TextOverflow.ellipsis);
      });
    });

    group('Accessibility', () {
      testWidgets('has semantic label from text by default', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppTag(label: 'Accessible')),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Semantics),
          ),
        );
        expect(semantics.properties.label, 'Accessible');
        expect(semantics.properties.button, false);
      });

      testWidgets('uses custom semantic label when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppTag(label: 'New', semanticLabel: 'New item available'),
            ),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Semantics),
          ),
        );
        expect(semantics.properties.label, 'New item available');
      });

      testWidgets('is marked as non-interactive', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppTag(label: 'Non-interactive')),
          ),
        );

        final semantics = tester.widget<Semantics>(
          find.descendant(
            of: find.byType(AppTag),
            matching: find.byType(Semantics),
          ),
        );
        expect(semantics.properties.button, false);
      });
    });

    group('Theme Integration', () {
      testWidgets('uses theme colors for variants in light mode', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
            ),
            home: const Scaffold(
              body: AppTag(
                label: 'Themed',
                colorVariant: AppTagColorVariant.success,
              ),
            ),
          ),
        );

        expect(find.text('Themed'), findsOneWidget);
        expect(find.byType(AppTag), findsOneWidget);
      });

      testWidgets('uses theme colors for variants in dark mode', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
            home: const Scaffold(
              body: AppTag(
                label: 'Dark Themed',
                colorVariant: AppTagColorVariant.error,
              ),
            ),
          ),
        );

        expect(find.text('Dark Themed'), findsOneWidget);
        expect(find.byType(AppTag), findsOneWidget);
      });
    });

    group('RTL Support', () {
      testWidgets('renders correctly in RTL layout', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: AppTag(label: 'RTL Tag', icon: Icons.check),
              ),
            ),
          ),
        );

        expect(find.text('RTL Tag'), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles single character label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppTag(label: 'A')),
          ),
        );

        expect(find.text('A'), findsOneWidget);
      });

      testWidgets('handles emoji in label', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: AppTag(label: '🎉 Party')),
          ),
        );

        expect(find.text('🎉 Party'), findsOneWidget);
      });

      testWidgets('handles all size and color combinations', (tester) async {
        for (final size in AppTagSize.values) {
          for (final colorVariant in AppTagColorVariant.values) {
            await tester.pumpWidget(
              MaterialApp(
                home: Scaffold(
                  body: AppTag(
                    label: 'Test',
                    size: size,
                    colorVariant: colorVariant,
                  ),
                ),
              ),
            );

            expect(find.text('Test'), findsOneWidget);
            await tester.pumpAndSettle();
          }
        }
      });

      testWidgets('handles all style combinations', (tester) async {
        for (final style in AppTagStyle.values) {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                body: AppTag(label: 'Test', style: style),
              ),
            ),
          );

          expect(find.text('Test'), findsOneWidget);
          await tester.pumpAndSettle();
        }
      });
    });
  });
}
