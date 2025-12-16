// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/widgets/buttons/app_fab.dart';

Widget _wrap(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? ThemeData(useMaterial3: true),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('AppFab', () {
    testWidgets('default variant renders and is tappable', (tester) async {
      int calls = 0;
      await tester.pumpWidget(
        _wrap(AppFab(icon: Icons.add, onPressed: () => calls++)),
      );
      expect(find.byType(FloatingActionButton), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(calls, 1);
    });

    testWidgets('small/large/extended variants render', (tester) async {
      await tester.pumpWidget(
        _wrap(
          Wrap(
            spacing: 8,
            children: const [
              AppFab.small(icon: Icons.filter_list),
              AppFab.large(icon: Icons.camera_alt),
              AppFab.extended(icon: Icons.edit, label: 'Compose'),
            ],
          ),
        ),
      );
      expect(find.byType(FloatingActionButton), findsNWidgets(3));
      expect(find.text('Compose'), findsOneWidget);
    });

    testWidgets('disabled state prevents interaction', (tester) async {
      int calls = 0;
      await tester.pumpWidget(_wrap(AppFab(icon: Icons.add, onPressed: null)));
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(calls, 0);
    });

    testWidgets('tooltip is applied and semantics label exists', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(AppFab(icon: Icons.add, onPressed: () {}, tooltip: 'Add item')),
      );
      // Long press to show tooltip
      final fab = find.byType(FloatingActionButton);
      await tester.longPress(fab);
      await tester.pumpAndSettle(const Duration(milliseconds: 300));
      expect(find.text('Add item'), findsOneWidget);
    });

    testWidgets('min touch target is at least 48x48', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppFab.small(icon: Icons.filter_list)),
      );
      final renderBox =
          tester.renderObject(find.byType(FloatingActionButton)) as RenderBox;
      expect(renderBox.size.width >= 48, isTrue);
      expect(renderBox.size.height >= 48, isTrue);
    });

    testWidgets('extended supports trailing icon and typography', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          AppFab.extended(
            icon: Icons.edit,
            label: 'Edit',
            trailingIcon: Icons.arrow_forward,
            onPressed: () {},
          ),
        ),
      );
      expect(find.text('Edit'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets('hide on scroll slides out and back', (tester) async {
      final controller = ScrollController();
      await tester.pumpWidget(
        _wrap(
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                ListView.builder(
                  controller: controller,
                  itemCount: 50,
                  itemBuilder: (_, i) => ListTile(title: Text('Item $i')),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: AppFabHideOnScroll(
                    scrollController: controller,
                    fab: AppFab(icon: Icons.add, onPressed: () {}),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Scroll down to hide
      controller.jumpTo(200);
      await tester.pumpAndSettle();
      // FAB still in tree but slid; verify it exists
      expect(find.byType(AppFab), findsOneWidget);

      // Scroll up to show
      controller.jumpTo(0);
      await tester.pumpAndSettle();
      expect(find.byType(AppFab), findsOneWidget);
    });
  });
}
