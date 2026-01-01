// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// Helper widget for chip deletion functionality
class _ChipWrapper extends StatefulWidget {
  const _ChipWrapper({required this.builder});

  final Widget Function(
    BuildContext context,
    bool isVisible,
    void Function(bool) setVisible,
  )
  builder;

  @override
  State<_ChipWrapper> createState() => _ChipWrapperState();
}

class _ChipWrapperState extends State<_ChipWrapper> {
  bool _isVisible = true;

  void _setVisible(bool value) {
    setState(() {
      _isVisible = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _isVisible, _setVisible);
  }
}

// Helper widget for multiple chips in Interactive Playground
class _PlaygroundMultipleWrapper extends StatefulWidget {
  const _PlaygroundMultipleWrapper({required this.chipCount});

  final int chipCount;

  @override
  State<_PlaygroundMultipleWrapper> createState() =>
      _PlaygroundMultipleWrapperState();
}

class _PlaygroundMultipleWrapperState
    extends State<_PlaygroundMultipleWrapper> {
  late List<bool> _visibleChips;

  @override
  void initState() {
    super.initState();
    _visibleChips = List.filled(10, true);
  }

  @override
  void didUpdateWidget(_PlaygroundMultipleWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.chipCount != widget.chipCount) {
      _visibleChips = List.filled(10, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = context.knobs.string(
      label: 'Label',
      initialValue: 'John Doe',
    );
    final hasAvatar = context.knobs.boolean(
      label: 'Has Avatar',
      initialValue: true,
    );
    final avatarType = context.knobs.object.dropdown(
      label: 'Avatar Type',
      options: ['initials', 'icon', 'none'],
      labelBuilder: (value) => value,
    );
    final hasDelete = context.knobs.boolean(
      label: 'Has Delete Button',
      initialValue: true,
    );
    final selected = context.knobs.boolean(
      label: 'Selected',
      initialValue: false,
    );
    final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
    final customBackground = context.knobs.boolean(
      label: 'Custom Background',
      initialValue: false,
    );
    final backgroundColor = customBackground
        ? context.knobs.colorOrNull(label: 'Background Color')
        : null;
    final customSelectedColor = context.knobs.boolean(
      label: 'Custom Selected Color',
      initialValue: false,
    );
    final selectedColor = customSelectedColor
        ? context.knobs.colorOrNull(label: 'Selected Color')
        : null;
    final customDeleteColor = context.knobs.boolean(
      label: 'Custom Delete Color',
      initialValue: false,
    );
    final deleteIconColor = customDeleteColor
        ? context.knobs.colorOrNull(label: 'Delete Icon Color')
        : null;
    final hasTooltip = context.knobs.boolean(
      label: 'Has Tooltip',
      initialValue: false,
    );
    final elevation = context.knobs.double.slider(
      label: 'Elevation',
      initialValue: 0,
      min: 0,
      max: 8,
    );

    Widget? getAvatar() {
      if (!hasAvatar) return null;

      switch (avatarType) {
        case 'initials':
          return const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              'JD',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          );
        case 'icon':
          return const CircleAvatar(
            backgroundColor: Colors.purple,
            child: Icon(Icons.person, size: 16, color: Colors.white),
          );
        default:
          return null;
      }
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List.generate(widget.chipCount, (index) {
            if (!_visibleChips[index]) return const SizedBox.shrink();

            return AppInputChip(
              label: '$label ${index + 1}',
              avatar: getAvatar(),
              onDeleted: hasDelete
                  ? () {
                      setState(() {
                        _visibleChips[index] = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Deleted: $label ${index + 1}')),
                      );
                    }
                  : null,
              onTap: () {},
              selected: selected,
              enabled: enabled,
              backgroundColor: backgroundColor,
              selectedColor: selectedColor,
              deleteIconColor: deleteIconColor,
              elevation: elevation,
              tooltip: hasTooltip ? 'Tooltip: $label ${index + 1}' : null,
              deleteButtonTooltipMessage: hasDelete
                  ? 'Remove $label ${index + 1}'
                  : null,
            );
          }),
        ),
      ),
    );
  }
}

// 1. Interactive Playground - Single component with all features via knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppInputChip)
Widget appInputChipPlayground(BuildContext context) {
  final showMultiple = context.knobs.boolean(
    label: 'Show Multiple Chips',
    initialValue: false,
  );
  final chipCount = showMultiple
      ? context.knobs.int.slider(
          label: 'Chip Count',
          initialValue: 3,
          min: 1,
          max: 10,
        )
      : 1;

  if (showMultiple) {
    return _PlaygroundMultipleWrapper(chipCount: chipCount);
  }

  return _ChipWrapper(
    builder: (context, isVisible, setVisible) {
      final label = context.knobs.string(
        label: 'Label',
        initialValue: 'John Doe',
      );
      final hasAvatar = context.knobs.boolean(
        label: 'Has Avatar',
        initialValue: true,
      );
      final avatarType = context.knobs.object.dropdown(
        label: 'Avatar Type',
        options: ['initials', 'icon', 'none'],
        labelBuilder: (value) => value,
      );
      final hasDelete = context.knobs.boolean(
        label: 'Has Delete Button',
        initialValue: true,
      );
      final selected = context.knobs.boolean(
        label: 'Selected',
        initialValue: false,
      );
      final enabled = context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      );
      final customBackground = context.knobs.boolean(
        label: 'Custom Background',
        initialValue: false,
      );
      final backgroundColor = customBackground
          ? context.knobs.colorOrNull(label: 'Background Color')
          : null;
      final customSelectedColor = context.knobs.boolean(
        label: 'Custom Selected Color',
        initialValue: false,
      );
      final selectedColor = customSelectedColor
          ? context.knobs.colorOrNull(label: 'Selected Color')
          : null;
      final customDeleteColor = context.knobs.boolean(
        label: 'Custom Delete Color',
        initialValue: false,
      );
      final deleteIconColor = customDeleteColor
          ? context.knobs.colorOrNull(label: 'Delete Icon Color')
          : null;
      final hasTooltip = context.knobs.boolean(
        label: 'Has Tooltip',
        initialValue: false,
      );
      final elevation = context.knobs.double.slider(
        label: 'Elevation',
        initialValue: 0,
        min: 0,
        max: 8,
      );

      Widget? getAvatar() {
        if (!hasAvatar) return null;

        switch (avatarType) {
          case 'initials':
            return const CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                'JD',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            );
          case 'icon':
            return const CircleAvatar(
              backgroundColor: Colors.purple,
              child: Icon(Icons.person, size: 16, color: Colors.white),
            );
          default:
            return null;
        }
      }

      if (!isVisible) return const SizedBox.shrink();

      return Center(
        child: AppInputChip(
          label: label,
          avatar: getAvatar(),
          onDeleted: hasDelete
              ? () {
                  setVisible(false);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Deleted: $label')));
                }
              : null,
          onTap: () {},
          selected: selected,
          enabled: enabled,
          backgroundColor: backgroundColor,
          selectedColor: selectedColor,
          deleteIconColor: deleteIconColor,
          elevation: elevation,
          tooltip: hasTooltip ? 'Tooltip: $label' : null,
          deleteButtonTooltipMessage: hasDelete ? 'Remove $label' : null,
        ),
      );
    },
  );
}

// 2. With Avatar and Label - Single chip with avatar
@widgetbook.UseCase(name: 'With Avatar and Label', type: AppInputChip)
Widget appInputChipWithAvatar(BuildContext context) {
  return _ChipWrapper(
    builder: (context, isVisible, setVisible) {
      if (!isVisible) return const SizedBox.shrink();

      return Center(
        child: AppInputChip(
          label: 'John Doe',
          avatar: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              'JD',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          onDeleted: () {
            setVisible(false);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Deleted: John Doe')));
          },
          onTap: () {},
        ),
      );
    },
  );
}

// 3. With Delete Button - Single chip demonstrating delete functionality
@widgetbook.UseCase(name: 'With Delete Button', type: AppInputChip)
Widget appInputChipWithDelete(BuildContext context) {
  return _ChipWrapper(
    builder: (context, isVisible, setVisible) {
      if (!isVisible) return const SizedBox.shrink();

      return Center(
        child: AppInputChip(
          label: 'Removable Item',
          avatar: const CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.attach_file, size: 16, color: Colors.white),
          ),
          onDeleted: () {
            setVisible(false);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Chip deleted')));
          },
          deleteButtonTooltipMessage: 'Remove this item',
        ),
      );
    },
  );
}

// 4. File Attachment - Single chip representing a file
@widgetbook.UseCase(name: 'File Attachment', type: AppInputChip)
Widget appInputChipFileAttachment(BuildContext context) {
  return _ChipWrapper(
    builder: (context, isVisible, setVisible) {
      if (!isVisible) return const SizedBox.shrink();

      return Center(
        child: AppInputChip(
          label: 'document.pdf',
          avatar: const CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(Icons.picture_as_pdf, size: 16, color: Colors.white),
          ),
          onDeleted: () {
            setVisible(false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Deleted: document.pdf')),
            );
          },
          tooltip: '2.4 MB',
        ),
      );
    },
  );
}

// 5. Selected State - Single chip in selected state
@widgetbook.UseCase(name: 'Selected State', type: AppInputChip)
Widget appInputChipSelected(BuildContext context) {
  return _ChipWrapper(
    builder: (context, isVisible, setVisible) {
      if (!isVisible) return const SizedBox.shrink();

      return Center(
        child: AppInputChip(
          label: 'Selected Chip',
          avatar: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              'S',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          selected: true,
          onDeleted: () {
            setVisible(false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Deleted: Selected Chip')),
            );
          },
          onTap: () {},
        ),
      );
    },
  );
}

// 6. Disabled State - Single chip in disabled state
@widgetbook.UseCase(name: 'Disabled State', type: AppInputChip)
Widget appInputChipDisabled(BuildContext context) {
  return Center(
    child: AppInputChip(
      label: 'Disabled Chip',
      avatar: const CircleAvatar(
        backgroundColor: Colors.grey,
        child: Text('D', style: TextStyle(fontSize: 12, color: Colors.white)),
      ),
      enabled: false,
      onDeleted: () {},
      onTap: () {},
    ),
  );
}

// 7. Custom Colors - Single chip with custom styling
@widgetbook.UseCase(name: 'Custom Colors', type: AppInputChip)
Widget appInputChipCustomColors(BuildContext context) {
  return _ChipWrapper(
    builder: (context, isVisible, setVisible) {
      if (!isVisible) return const SizedBox.shrink();

      return Center(
        child: AppInputChip(
          label: 'Custom Styled',
          backgroundColor: Colors.blue.shade100,
          deleteIconColor: Colors.red,
          avatar: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.star, size: 16, color: Colors.white),
          ),
          onDeleted: () {
            setVisible(false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Deleted: Custom Styled')),
            );
          },
        ),
      );
    },
  );
}

// 8. Chip Group - Multiple chips with adjustable count
@widgetbook.UseCase(name: 'Chip Group', type: AppInputChip)
Widget appInputChipGroup(BuildContext context) {
  final initialChipCount = context.knobs.int.slider(
    label: 'Initial Chip Count',
    initialValue: 3,
    min: 1,
    max: 10,
  );

  return _ChipGroupWrapper(initialChipCount: initialChipCount);
}

class _ChipGroupWrapper extends StatefulWidget {
  const _ChipGroupWrapper({required this.initialChipCount});

  final int initialChipCount;

  @override
  State<_ChipGroupWrapper> createState() => _ChipGroupWrapperState();
}

class _ChipGroupWrapperState extends State<_ChipGroupWrapper> {
  late List<bool> _visibleChips;

  @override
  void initState() {
    super.initState();
    _visibleChips = List.filled(10, true);
  }

  @override
  void didUpdateWidget(_ChipGroupWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialChipCount != widget.initialChipCount) {
      _visibleChips = List.filled(10, true);
    }
  }

  int get _visibleChipCount {
    return _visibleChips.take(widget.initialChipCount).where((v) => v).length;
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.teal,
      Colors.orange,
      Colors.purple,
      Colors.green,
      Colors.red,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
    ];

    final labels = [
      'flutter',
      'dart',
      'mobile',
      'ui',
      'design',
      'code',
      'app',
      'dev',
      'tech',
      'widget',
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Current Count: $_visibleChipCount',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(widget.initialChipCount, (index) {
                if (!_visibleChips[index]) return const SizedBox.shrink();

                return AppInputChip(
                  label: labels[index],
                  avatar: CircleAvatar(
                    backgroundColor: colors[index],
                    child: const Icon(Icons.tag, size: 16, color: Colors.white),
                  ),
                  onDeleted: () {
                    setState(() {
                      _visibleChips[index] = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Deleted tag: ${labels[index]}')),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// 9. Email Recipients - Single chip in email context
@widgetbook.UseCase(name: 'Email Recipients', type: AppInputChip)
Widget appInputChipEmailRecipients(BuildContext context) {
  return _ChipWrapper(
    builder: (context, isVisible, setVisible) {
      if (!isVisible) return const SizedBox.shrink();

      return Center(
        child: AppInputChip(
          label: 'john.doe@example.com',
          avatar: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              'JD',
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
          ),
          onDeleted: () {
            setVisible(false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Deleted: john.doe@example.com')),
            );
          },
          tooltip: 'John Doe',
        ),
      );
    },
  );
}
