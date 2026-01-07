// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Expose ALL AppInputChip properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppInputChip)
Widget appInputChipPlayground(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'John Doe');

  final hasAvatar = context.knobs.boolean(
    label: 'Has Avatar',
    initialValue: true,
  );

  final avatarType = context.knobs.object.dropdown(
    label: 'Avatar Type',
    options: const ['initials', 'icon', 'image'],
    labelBuilder: (value) => value,
  );

  final hasDelete = context.knobs.boolean(
    label: 'Has Delete Button',
    initialValue: true,
  );

  final hasTap = context.knobs.boolean(
    label: 'Has Tap Handler',
    initialValue: false,
  );

  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );

  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  final hasCustomColors = context.knobs.boolean(
    label: 'Custom Colors',
    initialValue: false,
  );

  final backgroundColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Background Color',
          initialValue: Colors.blue[50],
        )
      : null;

  final selectedColor = hasCustomColors && selected
      ? context.knobs.colorOrNull(
          label: 'Selected Color',
          initialValue: Colors.blue,
        )
      : null;

  final deleteIconColor = hasCustomColors && hasDelete
      ? context.knobs.colorOrNull(
          label: 'Delete Icon Color',
          initialValue: Colors.red,
        )
      : null;

  final elevation = context.knobs.double.slider(
    label: 'Elevation',
    initialValue: 0,
    min: 0,
    max: 12,
  );

  final hasTooltip = context.knobs.boolean(
    label: 'Has Tooltip',
    initialValue: false,
  );

  final tooltip = hasTooltip
      ? context.knobs.string(label: 'Tooltip', initialValue: 'Input chip')
      : null;

  final deleteTooltip = hasTooltip && hasDelete
      ? context.knobs.string(label: 'Delete Tooltip', initialValue: 'Remove')
      : null;

  Widget? getAvatar() {
    if (!hasAvatar) return null;

    switch (avatarType) {
      case 'initials':
        return CircleAvatar(
          radius: 12,
          backgroundColor: Colors.grey[300],
          child: Text(
            label.isNotEmpty ? label[0].toUpperCase() : 'A',
            style: const TextStyle(fontSize: 10),
          ),
        );
      case 'icon':
        return CircleAvatar(
          radius: 12,
          backgroundColor: Colors.blue[100],
          child: const Icon(Icons.person, size: 14),
        );
      case 'image':
        return CircleAvatar(
          radius: 12,
          backgroundColor: Colors.grey[300],
          child: const Icon(Icons.image, size: 14),
        );
      default:
        return null;
    }
  }

  return Center(
    child: AppInputChip(
      label: label,
      avatar: getAvatar(),
      onDeleted: hasDelete ? () {} : null,
      onTap: hasTap ? () {} : null,
      selected: selected,
      enabled: enabled,
      backgroundColor: backgroundColor,
      selectedColor: selectedColor,
      deleteIconColor: deleteIconColor,
      elevation: elevation,
      tooltip: tooltip,
      deleteButtonTooltipMessage: deleteTooltip,
    ),
  );
}

/// Basic Input Chip - Simple chip with label only
@widgetbook.UseCase(name: 'Basic', type: AppInputChip)
Widget appInputChipBasic(BuildContext context) {
  return Center(
    child: AppInputChip(label: 'Tag', onDeleted: () {}),
  );
}

/// With Avatar - Chip with avatar (initials)
@widgetbook.UseCase(name: 'With Avatar', type: AppInputChip)
Widget appInputChipWithAvatar(BuildContext context) {
  return Center(
    child: AppInputChip(
      label: 'John Doe',
      avatar: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.grey[300],
        child: const Text('JD', style: TextStyle(fontSize: 10)),
      ),
      onDeleted: () {},
    ),
  );
}

/// With Icon Avatar - Chip with icon avatar
@widgetbook.UseCase(name: 'With Icon Avatar', type: AppInputChip)
Widget appInputChipWithIconAvatar(BuildContext context) {
  return Center(
    child: AppInputChip(
      label: 'Contact',
      avatar: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.blue[100],
        child: const Icon(Icons.person, size: 14),
      ),
      onDeleted: () {},
    ),
  );
}

/// Selected State - Chip in selected state
@widgetbook.UseCase(name: 'Selected State', type: AppInputChip)
Widget appInputChipSelected(BuildContext context) {
  return Center(
    child: AppInputChip(
      label: 'Selected Tag',
      selected: true,
      onDeleted: () {},
    ),
  );
}

/// Without Delete - Chip without delete button
@widgetbook.UseCase(name: 'Without Delete Button', type: AppInputChip)
Widget appInputChipWithoutDelete(BuildContext context) {
  return Center(
    child: AppInputChip(
      label: 'Read Only',
      avatar: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.lock, size: 14),
      ),
      onTap: () {},
    ),
  );
}

/// Disabled State - Non-interactive chip
@widgetbook.UseCase(name: 'Disabled State', type: AppInputChip)
Widget appInputChipDisabled(BuildContext context) {
  return Center(
    child: AppInputChip(
      label: 'Disabled',
      avatar: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.block, size: 14),
      ),
      enabled: false,
      onDeleted: () {},
    ),
  );
}

/// Custom Colors - Chip with custom styling
@widgetbook.UseCase(name: 'Custom Colors', type: AppInputChip)
Widget appInputChipCustomColors(BuildContext context) {
  return Center(
    child: AppInputChip(
      label: 'Custom',
      avatar: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.purple[100],
        child: const Icon(Icons.palette, size: 14),
      ),
      backgroundColor: Colors.purple[50],
      selectedColor: Colors.purple[200],
      deleteIconColor: Colors.purple,
      selected: true,
      onDeleted: () {},
    ),
  );
}

/// With Elevation - Chip with shadow
@widgetbook.UseCase(name: 'With Elevation', type: AppInputChip)
Widget appInputChipWithElevation(BuildContext context) {
  return Center(
    child: AppInputChip(label: 'Elevated', elevation: 4, onDeleted: () {}),
  );
}

/// Deletable Example - Interactive deletion demo
@widgetbook.UseCase(name: 'Deletable (Interactive)', type: AppInputChip)
Widget appInputChipDeletable(BuildContext context) {
  return const Center(child: _DeletableChipDemo());
}

class _DeletableChipDemo extends StatefulWidget {
  const _DeletableChipDemo();

  @override
  State<_DeletableChipDemo> createState() => _DeletableChipDemoState();
}

class _DeletableChipDemoState extends State<_DeletableChipDemo> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isVisible)
          AppInputChip(
            label: 'Click X to Delete',
            avatar: CircleAvatar(
              radius: 12,
              backgroundColor: Colors.red[100],
              child: const Icon(Icons.delete, size: 14),
            ),
            onDeleted: () {
              setState(() {
                _isVisible = false;
              });
            },
          )
        else
          Column(
            children: [
              const Text(
                'Chip deleted!',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isVisible = true;
                  });
                },
                child: const Text('Restore'),
              ),
            ],
          ),
      ],
    );
  }
}
