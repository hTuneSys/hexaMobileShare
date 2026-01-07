// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/chips/app_filter_chip.dart';

/// Interactive Playground - Expose ALL AppFilterChip properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppFilterChip)
Widget appFilterChipPlayground(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Filter');

  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );

  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  final hasIcon = context.knobs.boolean(label: 'Has Icon', initialValue: false);

  final icon = hasIcon
      ? context.knobs.object.dropdown(
          label: 'Icon',
          options: const [
            Icons.filter_alt,
            Icons.category,
            Icons.star,
            Icons.favorite,
            Icons.local_offer,
          ],
          labelBuilder: (icon) => icon.toString().split('.').last,
        )
      : null;

  final hasAvatar = context.knobs.boolean(
    label: 'Has Avatar',
    initialValue: false,
  );

  final autofocus = context.knobs.boolean(
    label: 'Autofocus',
    initialValue: false,
  );

  final hasTooltip = context.knobs.boolean(
    label: 'Has Tooltip',
    initialValue: false,
  );

  final tooltip = hasTooltip
      ? context.knobs.string(label: 'Tooltip', initialValue: 'Filter option')
      : null;

  final hasCustomColors = context.knobs.boolean(
    label: 'Custom Colors',
    initialValue: false,
  );

  final selectedColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Selected Color',
          initialValue: Colors.blue,
        )
      : null;

  final unselectedColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Unselected Color',
          initialValue: Colors.grey,
        )
      : null;

  final checkmarkColor = hasCustomColors && selected
      ? context.knobs.colorOrNull(
          label: 'Checkmark Color',
          initialValue: Colors.white,
        )
      : null;

  return Center(
    child: AppFilterChip(
      label: label,
      selected: selected,
      enabled: enabled,
      icon: !hasAvatar ? icon : null,
      avatar: hasAvatar
          ? CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey[300],
              child: Text(
                label.isNotEmpty ? label[0].toUpperCase() : 'A',
                style: const TextStyle(fontSize: 10),
              ),
            )
          : null,
      autofocus: autofocus,
      tooltip: tooltip,
      selectedColor: selectedColor,
      unselectedColor: unselectedColor,
      checkmarkColor: checkmarkColor,
      onSelected: (value) {},
    ),
  );
}

/// Unselected State - Basic filter chip without selection
@widgetbook.UseCase(name: 'Unselected State', type: AppFilterChip)
Widget appFilterChipUnselected(BuildContext context) {
  return Center(
    child: AppFilterChip(
      label: 'Shoes',
      selected: false,
      onSelected: (selected) {},
    ),
  );
}

/// Selected State - Filter chip with checkmark
@widgetbook.UseCase(name: 'Selected State', type: AppFilterChip)
Widget appFilterChipSelected(BuildContext context) {
  return Center(
    child: AppFilterChip(
      label: 'Electronics',
      selected: true,
      onSelected: (selected) {},
    ),
  );
}

/// With Icon - Filter chip with custom icon (unselected)
@widgetbook.UseCase(name: 'With Icon', type: AppFilterChip)
Widget appFilterChipWithIcon(BuildContext context) {
  return Center(
    child: AppFilterChip(
      label: 'New Arrivals',
      icon: Icons.fiber_new,
      selected: false,
      onSelected: (selected) {},
    ),
  );
}

/// With Avatar - Filter chip with avatar image
@widgetbook.UseCase(name: 'With Avatar', type: AppFilterChip)
Widget appFilterChipWithAvatar(BuildContext context) {
  return Center(
    child: AppFilterChip(
      label: 'John Doe',
      avatar: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.grey[300],
        child: const Text('JD', style: TextStyle(fontSize: 10)),
      ),
      selected: false,
      onSelected: (selected) {},
    ),
  );
}

/// Disabled State - Non-interactive filter chip
@widgetbook.UseCase(name: 'Disabled State', type: AppFilterChip)
Widget appFilterChipDisabled(BuildContext context) {
  return Center(
    child: AppFilterChip(
      label: 'Disabled',
      selected: false,
      enabled: false,
      onSelected: (selected) {},
    ),
  );
}

/// Disabled Selected - Disabled chip in selected state
@widgetbook.UseCase(name: 'Disabled Selected', type: AppFilterChip)
Widget appFilterChipDisabledSelected(BuildContext context) {
  return Center(
    child: AppFilterChip(
      label: 'Disabled Selected',
      selected: true,
      enabled: false,
      onSelected: (selected) {},
    ),
  );
}

/// Custom Colors - Filter chip with custom colors
@widgetbook.UseCase(name: 'Custom Colors', type: AppFilterChip)
Widget appFilterChipCustomColors(BuildContext context) {
  return Center(
    child: AppFilterChip(
      label: 'Custom',
      icon: Icons.palette,
      selected: true,
      selectedColor: Colors.purple,
      checkmarkColor: Colors.white,
      onSelected: (selected) {},
    ),
  );
}

/// With Tooltip - Filter chip with hover tooltip
@widgetbook.UseCase(name: 'With Tooltip', type: AppFilterChip)
Widget appFilterChipWithTooltip(BuildContext context) {
  return Center(
    child: AppFilterChip(
      label: 'Hover Me',
      selected: false,
      tooltip: 'This is a filter option',
      onSelected: (selected) {},
    ),
  );
}

/// Interactive Toggle - Stateful filter chip example
@widgetbook.UseCase(name: 'Interactive Toggle', type: AppFilterChip)
Widget appFilterChipInteractive(BuildContext context) {
  return const Center(child: _InteractiveFilterChip());
}

class _InteractiveFilterChip extends StatefulWidget {
  const _InteractiveFilterChip();

  @override
  State<_InteractiveFilterChip> createState() => _InteractiveFilterChipState();
}

class _InteractiveFilterChipState extends State<_InteractiveFilterChip> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppFilterChip(
          label: 'Click to Toggle',
          icon: Icons.touch_app,
          selected: _isSelected,
          onSelected: (selected) {
            setState(() {
              _isSelected = selected;
            });
          },
        ),
        const SizedBox(height: 16),
        Text(
          _isSelected ? 'Selected' : 'Not Selected',
          style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
