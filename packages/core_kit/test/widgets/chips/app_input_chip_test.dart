// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

Widget _wrap(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? ThemeData(useMaterial3: true),
  home: Scaffold(body: Center(child: child)),
);

void main() {
  group('AppInputChip', () {
    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(_wrap(const AppInputChip(label: 'Test Chip')));

      expect(find.text('Test Chip'), findsOneWidget);
    });

    testWidgets('renders with avatar', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AppInputChip(
            label: 'John Doe',
            avatar: CircleAvatar(child: Text('JD')),
          ),
        ),
      );

      expect(find.text('John Doe'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('delete button appears when onDeleted is provided', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(AppInputChip(label: 'Deletable', onDeleted: () {})),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    testWidgets('delete button is hidden when onDeleted is null', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(const AppInputChip(label: 'Not Deletable')),
      );

      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('onDeleted callback fires when delete button tapped', (
      tester,
    ) async {
      int deleteCalls = 0;
      await tester.pumpWidget(
        _wrap(AppInputChip(label: 'Delete Me', onDeleted: () => deleteCalls++)),
      );

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(deleteCalls, 1);
    });

    testWidgets('onTap callback fires when chip is tapped', (tester) async {
      int tapCalls = 0;
      await tester.pumpWidget(
        _wrap(AppInputChip(label: 'Tap Me', onTap: () => tapCalls++)),
      );

      await tester.tap(find.text('Tap Me'));
      await tester.pumpAndSettle();

      expect(tapCalls, 1);
    });

    testWidgets('onTap does not fire when tapping delete button', (
      tester,
    ) async {
      int tapCalls = 0;
      int deleteCalls = 0;

      await tester.pumpWidget(
        _wrap(
          AppInputChip(
            label: 'Test Chip',
            onTap: () => tapCalls++,
            onDeleted: () => deleteCalls++,
          ),
        ),
      );

      // Tap the delete button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(deleteCalls, 1);
      expect(tapCalls, 0); // Should not be called
    });

    testWidgets('selected state changes appearance', (tester) async {
      // Unselected
      await tester.pumpWidget(
        _wrap(const AppInputChip(label: 'Unselected', selected: false)),
      );

      final unselectedMaterial = tester
          .widgetList<Material>(find.byType(Material))
          .last;
      final unselectedColor = unselectedMaterial.color;

      // Selected
      await tester.pumpWidget(
        _wrap(const AppInputChip(label: 'Selected', selected: true)),
      );

      final selectedMaterial = tester
          .widgetList<Material>(find.byType(Material))
          .last;
      final selectedColor = selectedMaterial.color;

      // Colors should be different
      expect(selectedColor, isNot(equals(unselectedColor)));
    });

    testWidgets('disabled state prevents interaction', (tester) async {
      int tapCalls = 0;
      int deleteCalls = 0;

      await tester.pumpWidget(
        _wrap(
          AppInputChip(
            label: 'Disabled',
            enabled: false,
            onTap: () => tapCalls++,
            onDeleted: () => deleteCalls++,
          ),
        ),
      );

      // Try to tap the chip
      await tester.tap(find.text('Disabled'));
      await tester.pumpAndSettle();

      // Try to tap the delete button
      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(tapCalls, 0);
      expect(deleteCalls, 0);
    });

    testWidgets('disabled state reduces opacity', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppInputChip(label: 'Disabled', enabled: false, onDeleted: () {}),
        ),
      );

      final material = tester.widgetList<Material>(find.byType(Material)).last;
      final color = material.color!;

      // Check that opacity is reduced (should be 0.38)
      expect(color.a, closeTo(0.38, 0.01));
    });

    testWidgets('custom background color is applied', (tester) async {
      const customColor = Colors.blue;

      await tester.pumpWidget(
        _wrap(
          const AppInputChip(
            label: 'Custom Color',
            backgroundColor: customColor,
          ),
        ),
      );

      final material = tester.widgetList<Material>(find.byType(Material)).last;
      expect(material.color, customColor);
    });

    testWidgets('custom selected color is applied', (tester) async {
      const customSelectedColor = Colors.purple;

      await tester.pumpWidget(
        _wrap(
          const AppInputChip(
            label: 'Custom Selected',
            selected: true,
            selectedColor: customSelectedColor,
          ),
        ),
      );

      final material = tester.widgetList<Material>(find.byType(Material)).last;
      expect(material.color, customSelectedColor);
    });

    testWidgets('custom delete icon color is applied', (tester) async {
      const customIconColor = Colors.red;

      await tester.pumpWidget(
        _wrap(
          AppInputChip(
            label: 'Custom Icon Color',
            deleteIconColor: customIconColor,
            onDeleted: () {},
          ),
        ),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.close));
      expect(icon.color, customIconColor);
    });

    testWidgets('tooltip is displayed on chip', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AppInputChip(
            label: 'With Tooltip',
            tooltip: 'This is a tooltip',
          ),
        ),
      );

      expect(find.byType(Tooltip), findsOneWidget);

      // Long press to show tooltip
      await tester.longPress(find.text('With Tooltip'));
      await tester.pumpAndSettle();

      expect(find.text('This is a tooltip'), findsOneWidget);
    });

    testWidgets('delete button has default tooltip', (tester) async {
      await tester.pumpWidget(
        _wrap(AppInputChip(label: 'Test', onDeleted: () {})),
      );

      // Long press the delete button to show tooltip
      await tester.longPress(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Delete'), findsOneWidget);
    });

    testWidgets('delete button has custom tooltip', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppInputChip(
            label: 'Test',
            onDeleted: () {},
            deleteButtonTooltipMessage: 'Remove this item',
          ),
        ),
      );

      // Long press the delete button to show tooltip
      await tester.longPress(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.text('Remove this item'), findsOneWidget);
    });

    testWidgets('chip has correct height constraint', (tester) async {
      await tester.pumpWidget(_wrap(const AppInputChip(label: 'Height Test')));

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(InkWell),
          matching: find.byType(Container),
        ),
      );

      expect(container.constraints?.minHeight, 32.0);
    });

    testWidgets('chip with avatar has correct padding', (tester) async {
      await tester.pumpWidget(
        _wrap(
          AppInputChip(
            label: 'With Avatar',
            avatar: const CircleAvatar(child: Text('A')),
            onDeleted: () {},
          ),
        ),
      );

      final containers = tester.widgetList<Container>(
        find.descendant(
          of: find.byType(InkWell),
          matching: find.byType(Container),
        ),
      );

      // Find the container with padding
      final containerWithPadding = containers.firstWhere(
        (c) => c.padding != null,
      );

      final padding = containerWithPadding.padding as EdgeInsets;
      expect(padding.left, 4.0); // Reduced padding with avatar
    });

    testWidgets('chip without avatar has correct padding', (tester) async {
      await tester.pumpWidget(
        _wrap(AppInputChip(label: 'No Avatar', onDeleted: () {})),
      );

      final containers = tester.widgetList<Container>(
        find.descendant(
          of: find.byType(InkWell),
          matching: find.byType(Container),
        ),
      );

      // Find the container with padding
      final containerWithPadding = containers.firstWhere(
        (c) => c.padding != null,
      );

      final padding = containerWithPadding.padding as EdgeInsets;
      expect(padding.left, 12.0); // Standard padding without avatar
    });

    testWidgets('custom padding is applied', (tester) async {
      const customPadding = EdgeInsets.all(20.0);

      await tester.pumpWidget(
        _wrap(
          const AppInputChip(label: 'Custom Padding', padding: customPadding),
        ),
      );

      final containers = tester.widgetList<Container>(
        find.descendant(
          of: find.byType(InkWell),
          matching: find.byType(Container),
        ),
      );

      // Find the container with padding
      final containerWithPadding = containers.firstWhere(
        (c) => c.padding != null,
      );

      expect(containerWithPadding.padding, customPadding);
    });

    testWidgets('custom elevation is applied', (tester) async {
      const customElevation = 4.0;

      await tester.pumpWidget(
        _wrap(
          const AppInputChip(
            label: 'Custom Elevation',
            elevation: customElevation,
          ),
        ),
      );

      final material = tester.widgetList<Material>(find.byType(Material)).last;
      expect(material.elevation, customElevation);
    });

    testWidgets('default elevation is 0', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppInputChip(label: 'Default Elevation')),
      );

      final material = tester.widgetList<Material>(find.byType(Material)).last;
      expect(material.elevation, 0.0);
    });

    testWidgets('chip has rounded corners', (tester) async {
      await tester.pumpWidget(_wrap(const AppInputChip(label: 'Rounded')));

      final material = tester.widgetList<Material>(find.byType(Material)).last;
      final shape = material.shape as RoundedRectangleBorder?;

      expect(shape?.borderRadius, BorderRadius.circular(8.0));
    });

    testWidgets('chip has border in unselected state', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppInputChip(label: 'Unselected', selected: false)),
      );

      final material = tester.widgetList<Material>(find.byType(Material)).last;
      final shape = material.shape as RoundedRectangleBorder?;

      expect(shape?.side.width, 1.0);
    });

    testWidgets('chip has no border in selected state', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppInputChip(label: 'Selected', selected: true)),
      );

      final material = tester.widgetList<Material>(find.byType(Material)).last;
      final shape = material.shape as RoundedRectangleBorder?;

      expect(shape?.side.color, Colors.transparent);
    });

    testWidgets('multiple chips can be rendered together', (tester) async {
      await tester.pumpWidget(
        _wrap(
          Wrap(
            spacing: 8.0,
            children: [
              AppInputChip(label: 'Chip 1', onDeleted: () {}),
              AppInputChip(label: 'Chip 2', onDeleted: () {}),
              AppInputChip(label: 'Chip 3', onDeleted: () {}),
            ],
          ),
        ),
      );

      expect(find.text('Chip 1'), findsOneWidget);
      expect(find.text('Chip 2'), findsOneWidget);
      expect(find.text('Chip 3'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNWidgets(3));
    });

    testWidgets('avatar size is correct', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const AppInputChip(
            label: 'Avatar Size',
            avatar: CircleAvatar(child: Text('A')),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(
        find
            .descendant(of: find.byType(Row), matching: find.byType(SizedBox))
            .first,
      );

      expect(sizedBox.width, 24.0);
      expect(sizedBox.height, 24.0);
    });

    testWidgets('delete icon size is correct', (tester) async {
      await tester.pumpWidget(
        _wrap(AppInputChip(label: 'Delete Icon Size', onDeleted: () {})),
      );

      final icon = tester.widget<Icon>(find.byIcon(Icons.close));
      expect(icon.size, 18.0);
    });

    testWidgets('label uses correct text style', (tester) async {
      await tester.pumpWidget(
        _wrap(const AppInputChip(label: 'Text Style Test')),
      );

      final text = tester.widget<Text>(find.text('Text Style Test'));
      // labelLarge is the default M3 style for chips
      expect(text.style, isNotNull);
    });

    testWidgets('custom label style is applied', (tester) async {
      const customStyle = TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      );

      await tester.pumpWidget(
        _wrap(
          const AppInputChip(label: 'Custom Style', labelStyle: customStyle),
        ),
      );

      final text = tester.widget<Text>(find.text('Custom Style'));
      expect(text.style?.fontSize, 20.0);
      expect(text.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('label truncates with ellipsis for long text', (tester) async {
      await tester.pumpWidget(
        _wrap(
          SizedBox(
            width: 100,
            child: AppInputChip(
              label: 'This is a very long label that should truncate',
              onDeleted: () {},
            ),
          ),
        ),
      );

      final text = tester.widget<Text>(
        find.text('This is a very long label that should truncate'),
      );
      expect(text.overflow, TextOverflow.ellipsis);
    });
  });
}
