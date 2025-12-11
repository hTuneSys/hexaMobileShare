// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/buttons/app_icon_button.dart';

@widgetbook.UseCase(name: 'Default', type: AppIconButton)
Widget appIconButtonDefault(BuildContext context) {
  return Center(
    child: AppIconButton(
      icon: context.knobs.object.dropdown(
        label: 'Icon',
        options: const [Icons.search, Icons.menu, Icons.favorite, Icons.share],
        labelBuilder: (icon) => icon.toString(),
      ),
      onPressed: () {},
      tooltip: context.knobs.string(label: 'Tooltip', initialValue: 'Action'),
    ),
  );
}

@widgetbook.UseCase(name: 'All Variants', type: AppIconButton)
Widget appIconButtonAllVariants(BuildContext context) {
  const icon = Icons.search;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppIconButton(icon: icon, tooltip: 'Standard', onPressed: () {}),
      const SizedBox(width: 16),
      AppIconButton.filled(icon: icon, tooltip: 'Filled', onPressed: () {}),
      const SizedBox(width: 16),
      AppIconButton.filledTonal(
        icon: icon,
        tooltip: 'Filled Tonal',
        onPressed: () {},
      ),
      const SizedBox(width: 16),
      AppIconButton.outlined(icon: icon, tooltip: 'Outlined', onPressed: () {}),
    ],
  );
}

@widgetbook.UseCase(name: 'Common Icons', type: AppIconButton)
Widget appIconButtonCommonIcons(BuildContext context) {
  Widget group(String title, List<IconData> icons) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title),
      const SizedBox(height: 8),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: icons
            .map(
              (i) => AppIconButton(icon: i, tooltip: title, onPressed: () {}),
            )
            .toList(),
      ),
    ],
  );

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        group('Navigation', const [
          Icons.arrow_back,
          Icons.close,
          Icons.menu,
          Icons.more_vert,
        ]),
        const SizedBox(height: 16),
        group('Actions', const [
          Icons.search,
          Icons.filter_list,
          Icons.settings,
          Icons.refresh,
        ]),
        const SizedBox(height: 16),
        group('Content', const [
          Icons.favorite_border,
          Icons.share,
          Icons.bookmark_border,
          Icons.edit,
        ]),
        const SizedBox(height: 16),
        group('Media', const [
          Icons.play_arrow,
          Icons.pause,
          Icons.skip_next,
          Icons.volume_up,
        ]),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'States', type: AppIconButton)
Widget appIconButtonStates(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppIconButton(
        icon: Icons.favorite_border,
        tooltip: 'Enabled',
        onPressed: () {},
      ),
      const SizedBox(width: 16),
      const AppIconButton(
        icon: Icons.delete,
        tooltip: 'Disabled',
        onPressed: null,
      ),
      const SizedBox(width: 16),
      AppIconButton(
        icon: Icons.favorite,
        tooltip: 'Selected',
        onPressed: () {},
        isSelected: true,
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Sizes', type: AppIconButton)
Widget appIconButtonSizes(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppIconButton(
        icon: Icons.search,
        tooltip: 'Small',
        onPressed: () {},
        iconSize: 20,
      ),
      const SizedBox(width: 16),
      AppIconButton(
        icon: Icons.search,
        tooltip: 'Default',
        onPressed: () {},
        iconSize: 24,
      ),
      const SizedBox(width: 16),
      AppIconButton(
        icon: Icons.search,
        tooltip: 'Large',
        onPressed: () {},
        iconSize: 32,
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Toggle Button', type: AppIconButton)
Widget appIconButtonToggle(BuildContext context) {
  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppIconButton(
        icon: selected ? Icons.favorite : Icons.favorite_border,
        tooltip: 'Favorite',
        isSelected: selected,
        onPressed: () {},
      ),
      const SizedBox(width: 16),
      AppIconButton(
        icon: selected ? Icons.bookmark : Icons.bookmark_border,
        tooltip: 'Bookmark',
        isSelected: selected,
        onPressed: () {},
      ),
      const SizedBox(width: 16),
      AppIconButton(
        icon: selected ? Icons.visibility : Icons.visibility_off,
        tooltip: 'Visibility',
        isSelected: selected,
        onPressed: () {},
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Theme Variations', type: AppIconButton)
Widget appIconButtonTheme(BuildContext context) {
  final dark = context.knobs.boolean(label: 'Dark mode', initialValue: false);
  final colorOverride = context.knobs.color(label: 'Custom icon color');
  final ThemeData theme = dark
      ? ThemeData.dark(useMaterial3: true)
      : ThemeData.light(useMaterial3: true);

  return Theme(
    data: theme,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIconButton(
          icon: Icons.settings,
          tooltip: 'Standard',
          onPressed: () {},
          color: colorOverride,
        ),
        const SizedBox(width: 16),
        AppIconButton.filled(
          icon: Icons.toggle_on,
          tooltip: 'Filled',
          onPressed: () {},
          color: colorOverride,
        ),
        const SizedBox(width: 16),
        AppIconButton.filledTonal(
          icon: Icons.toggle_on,
          tooltip: 'Tonal',
          onPressed: () {},
          color: colorOverride,
        ),
        const SizedBox(width: 16),
        AppIconButton.outlined(
          icon: Icons.tune,
          tooltip: 'Outlined',
          onPressed: () {},
          color: colorOverride,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Interactive Playground', type: AppIconButton)
Widget appIconButtonPlayground(BuildContext context) {
  final variant = context.knobs.object.dropdown(
    label: 'Variant',
    options: const ['standard', 'filled', 'filledTonal', 'outlined'],
    labelBuilder: (v) => v,
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );
  final size = context.knobs.double.slider(
    label: 'Icon size',
    initialValue: 24,
    min: 16,
    max: 40,
  );
  final color = context.knobs.color(label: 'Icon color');
  final icon = context.knobs.object.dropdown(
    label: 'Icon',
    options: const [
      Icons.search,
      Icons.menu,
      Icons.favorite,
      Icons.share,
      Icons.edit,
      Icons.delete,
    ],
    labelBuilder: (icon) => icon.toString(),
  );

  AppIconButton build() => switch (variant) {
    'filled' => AppIconButton.filled(
      icon: icon,
      tooltip: 'Playground',
      onPressed: enabled ? () {} : null,
      isSelected: selected,
      iconSize: size,
      color: color,
    ),
    'filledTonal' => AppIconButton.filledTonal(
      icon: icon,
      tooltip: 'Playground',
      onPressed: enabled ? () {} : null,
      isSelected: selected,
      iconSize: size,
      color: color,
    ),
    'outlined' => AppIconButton.outlined(
      icon: icon,
      tooltip: 'Playground',
      onPressed: enabled ? () {} : null,
      isSelected: selected,
      iconSize: size,
      color: color,
    ),
    _ => AppIconButton(
      icon: icon,
      tooltip: 'Playground',
      onPressed: enabled ? () {} : null,
      isSelected: selected,
      iconSize: size,
      color: color,
    ),
  };

  return Center(child: build());
}
