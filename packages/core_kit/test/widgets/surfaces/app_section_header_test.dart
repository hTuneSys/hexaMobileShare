// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/widgets/surfaces/app_section_header.dart';

void main() {
  group('AppSectionHeader Tests', () {
    // ==================== Basic Rendering Tests ====================

    testWidgets('renders with title only', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppSectionHeader(title: 'Section Title')),
        ),
      );

      expect(find.text('Section Title'), findsOneWidget);
    });

    testWidgets('renders with title and subtitle', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              subtitle: 'Section description text',
            ),
          ),
        ),
      );

      expect(find.text('Section Title'), findsOneWidget);
      expect(find.text('Section description text'), findsOneWidget);
    });

    testWidgets('renders uppercase title when isUpperCase is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(title: 'Section Title', isUpperCase: true),
          ),
        ),
      );

      expect(find.text('SECTION TITLE'), findsOneWidget);
      expect(find.text('Section Title'), findsNothing);
    });

    // ==================== Leading & Trailing Tests ====================

    testWidgets('renders with leading widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              leading: Icon(Icons.settings),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text('Section Title'), findsOneWidget);
    });

    testWidgets('renders with trailing widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              trailing: TextButton(
                onPressed: () {},
                child: const Text('Action'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Action'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('renders with both leading and trailing', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              leading: const Icon(Icons.notifications),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.notifications), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    // ==================== Divider Tests ====================

    testWidgets('does not show divider by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppSectionHeader(title: 'Section Title')),
        ),
      );

      expect(find.byType(Divider), findsNothing);
    });

    testWidgets('shows divider below when showDivider is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              showDivider: true,
              dividerPosition: DividerPosition.below,
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('shows divider above when dividerPosition is above', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              showDivider: true,
              dividerPosition: DividerPosition.above,
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('shows dividers both sides when dividerPosition is both', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              showDivider: true,
              dividerPosition: DividerPosition.both,
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('does not show divider when dividerPosition is none', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              showDivider: true,
              dividerPosition: DividerPosition.none,
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsNothing);
    });

    // ==================== Custom Styling Tests ====================

    testWidgets('applies custom padding', (tester) async {
      const customPadding = EdgeInsets.all(24);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              padding: customPadding,
            ),
          ),
        ),
      );

      final paddingFinder = find.ancestor(
        of: find.text('Section Title'),
        matching: find.byType(Padding),
      );

      expect(paddingFinder, findsWidgets);

      // Find the Padding that has our custom padding
      bool foundCustomPadding = false;
      for (final element in paddingFinder.evaluate()) {
        final widget = element.widget as Padding;
        if (widget.padding == customPadding) {
          foundCustomPadding = true;
          break;
        }
      }
      expect(foundCustomPadding, isTrue);
    });

    testWidgets('applies background color', (tester) async {
      const bgColor = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              backgroundColor: bgColor,
            ),
          ),
        ),
      );

      // Find ColoredBox widgets and check if any has our background color
      final coloredBoxFinder = find.byType(ColoredBox);
      expect(coloredBoxFinder, findsWidgets);

      bool foundBgColor = false;
      for (final element in coloredBoxFinder.evaluate()) {
        final coloredBox = element.widget as ColoredBox;
        if (coloredBox.color == bgColor) {
          foundBgColor = true;
          break;
        }
      }
      expect(foundBgColor, isTrue);
    });

    testWidgets('applies custom text style', (tester) async {
      const customStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              textStyle: customStyle,
            ),
          ),
        ),
      );

      final textFinder = find.text('Section Title');
      final textWidget = tester.widget<Text>(textFinder);

      expect(textWidget.style?.fontSize, 20);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.color, Colors.blue);
    });

    testWidgets('applies custom subtitle style', (tester) async {
      const customSubtitleStyle = TextStyle(
        fontSize: 14,
        fontStyle: FontStyle.italic,
        color: Colors.green,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              subtitle: 'Subtitle text',
              subtitleStyle: customSubtitleStyle,
            ),
          ),
        ),
      );

      final subtitleFinder = find.text('Subtitle text');
      final subtitleWidget = tester.widget<Text>(subtitleFinder);

      expect(subtitleWidget.style?.fontSize, 14);
      expect(subtitleWidget.style?.fontStyle, FontStyle.italic);
      expect(subtitleWidget.style?.color, Colors.green);
    });

    // ==================== Accessibility Tests ====================

    testWidgets('has correct semantics for accessibility', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppSectionHeader(title: 'Section Title')),
        ),
      );

      final semanticsFinder = find.byType(Semantics);
      expect(semanticsFinder, findsWidgets);

      // Find the Semantics widget that wraps our content
      final semanticsWidget = tester.widget<Semantics>(
        find
            .ancestor(
              of: find.text('Section Title'),
              matching: find.byType(Semantics),
            )
            .first,
      );

      expect(semanticsWidget.properties.header, isTrue);
    });

    testWidgets('includes subtitle in semantic label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              subtitle: 'Description',
            ),
          ),
        ),
      );

      final semanticsWidget = tester.widget<Semantics>(
        find
            .ancestor(
              of: find.text('Section Title'),
              matching: find.byType(Semantics),
            )
            .first,
      );

      expect(semanticsWidget.properties.label, 'Section Title, Description');
    });

    // ==================== Layout Tests ====================

    testWidgets('content is laid out in a Row', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              leading: Icon(Icons.star),
            ),
          ),
        ),
      );

      // Icon and text should be in a row
      final rowFinder = find.ancestor(
        of: find.byIcon(Icons.star),
        matching: find.byType(Row),
      );
      expect(rowFinder, findsOneWidget);
    });

    testWidgets('trailing action is tappable', (tester) async {
      bool actionTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              trailing: TextButton(
                onPressed: () {
                  actionTapped = true;
                },
                child: const Text('Tap Me'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pumpAndSettle();

      expect(actionTapped, isTrue);
    });

    // ==================== Min Height Tests ====================

    testWidgets('has minimum height of 48dp by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppSectionHeader(title: 'Section Title')),
        ),
      );

      final constrainedBoxFinder = find.byType(ConstrainedBox);
      expect(constrainedBoxFinder, findsWidgets);

      bool foundMinHeight = false;
      for (final element in constrainedBoxFinder.evaluate()) {
        final widget = element.widget as ConstrainedBox;
        if (widget.constraints.minHeight == 48.0) {
          foundMinHeight = true;
          break;
        }
      }
      expect(foundMinHeight, isTrue);
    });

    testWidgets('respects custom minHeight', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(title: 'Section Title', minHeight: 64.0),
          ),
        ),
      );

      final constrainedBoxFinder = find.byType(ConstrainedBox);
      expect(constrainedBoxFinder, findsWidgets);

      bool foundCustomHeight = false;
      for (final element in constrainedBoxFinder.evaluate()) {
        final widget = element.widget as ConstrainedBox;
        if (widget.constraints.minHeight == 64.0) {
          foundCustomHeight = true;
          break;
        }
      }
      expect(foundCustomHeight, isTrue);
    });

    // ==================== Divider Indent Tests ====================

    testWidgets('applies divider indent', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              showDivider: true,
              dividerIndent: 16.0,
            ),
          ),
        ),
      );

      final dividerFinder = find.byType(Divider);
      expect(dividerFinder, findsOneWidget);

      final divider = tester.widget<Divider>(dividerFinder);
      expect(divider.indent, 16.0);
    });

    testWidgets('applies divider end indent', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppSectionHeader(
              title: 'Section Title',
              showDivider: true,
              dividerEndIndent: 16.0,
            ),
          ),
        ),
      );

      final dividerFinder = find.byType(Divider);
      expect(dividerFinder, findsOneWidget);

      final divider = tester.widget<Divider>(dividerFinder);
      expect(divider.endIndent, 16.0);
    });
  });

  // ==================== SectionHeaderDelegate Tests ====================

  group('SectionHeaderDelegate Tests', () {
    testWidgets('renders in SliverPersistentHeader', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: const SectionHeaderDelegate(
                    child: AppSectionHeader(
                      title: 'Sticky Section',
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const ListTile(title: Text('Item 1')),
                    const ListTile(title: Text('Item 2')),
                  ]),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Sticky Section'), findsOneWidget);
    });

    testWidgets('has correct min and max extent', (tester) async {
      const delegate = SectionHeaderDelegate(
        child: AppSectionHeader(title: 'Test'),
        height: 56.0,
      );

      expect(delegate.minExtent, 56.0);
      expect(delegate.maxExtent, 56.0);
    });

    testWidgets('shouldRebuild returns true when child changes', (
      tester,
    ) async {
      const delegate1 = SectionHeaderDelegate(
        child: AppSectionHeader(title: 'Test 1'),
      );

      const delegate2 = SectionHeaderDelegate(
        child: AppSectionHeader(title: 'Test 2'),
      );

      expect(delegate1.shouldRebuild(delegate2), isTrue);
    });

    testWidgets('shouldRebuild returns true when height changes', (
      tester,
    ) async {
      const delegate1 = SectionHeaderDelegate(
        child: AppSectionHeader(title: 'Test'),
        height: 48.0,
      );

      const delegate2 = SectionHeaderDelegate(
        child: AppSectionHeader(title: 'Test'),
        height: 56.0,
      );

      expect(delegate1.shouldRebuild(delegate2), isTrue);
    });
  });
}
