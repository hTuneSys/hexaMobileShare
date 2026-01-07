// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/buttons/app_fab.dart';

/// Interactive Playground - Expose ALL AppFab properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppFab)
Widget appFabPlayground(BuildContext context) {
  // Variant selection
  final variantOptions = ['default', 'small', 'large', 'extended'];
  final selectedVariant = context.knobs.object.dropdown(
    label: 'Variant',
    options: variantOptions,
    labelBuilder: (value) => value,
  );

  // Icon selection
  final icon = context.knobs.object.dropdown(
    label: 'Icon',
    options: const [
      Icons.add,
      Icons.edit,
      Icons.filter_list,
      Icons.camera_alt,
      Icons.share,
      Icons.download,
      Icons.upload,
    ],
    labelBuilder: (icon) => icon.toString(),
  );

  // Extended variant props
  final label = context.knobs.string(
    label: 'Label (extended only)',
    initialValue: 'Compose',
  );

  final hasTrailingIcon = context.knobs.boolean(
    label: 'Has Trailing Icon (extended only)',
    initialValue: false,
  );

  final trailingIcon = hasTrailingIcon
      ? context.knobs.object.dropdown(
          label: 'Trailing Icon',
          options: const [
            Icons.arrow_forward,
            Icons.arrow_drop_down,
            Icons.expand_more,
          ],
          labelBuilder: (icon) => icon.toString(),
        )
      : null;

  // Common props
  final isEnabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  final hasTooltip = context.knobs.boolean(
    label: 'Has Tooltip',
    initialValue: true,
  );

  final tooltip = hasTooltip
      ? context.knobs.string(label: 'Tooltip', initialValue: 'Action')
      : null;

  final hasCustomColors = context.knobs.boolean(
    label: 'Custom Colors',
    initialValue: false,
  );

  final backgroundColor = hasCustomColors
      ? context.knobs.colorOrNull(label: 'Background Color')
      : null;

  final foregroundColor = hasCustomColors
      ? context.knobs.colorOrNull(label: 'Foreground Color')
      : null;

  final elevation = context.knobs.double.slider(
    label: 'Elevation',
    initialValue: 6.0,
    min: 0,
    max: 24,
  );

  // Build appropriate variant
  Widget fab;
  switch (selectedVariant) {
    case 'small':
      fab = AppFab.small(
        icon: icon,
        onPressed: isEnabled ? () {} : null,
        tooltip: tooltip,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
      );
      break;
    case 'large':
      fab = AppFab.large(
        icon: icon,
        onPressed: isEnabled ? () {} : null,
        tooltip: tooltip,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
      );
      break;
    case 'extended':
      fab = AppFab.extended(
        icon: icon,
        label: label,
        trailingIcon: trailingIcon,
        onPressed: isEnabled ? () {} : null,
        tooltip: tooltip,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
      );
      break;
    default:
      fab = AppFab(
        icon: icon,
        onPressed: isEnabled ? () {} : null,
        tooltip: tooltip,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
      );
  }

  return Center(child: fab);
}

/// Default FAB - Standard 56x56 size
@widgetbook.UseCase(name: 'Default FAB', type: AppFab)
Widget appFabDefault(BuildContext context) {
  return Center(
    child: AppFab(icon: Icons.add, tooltip: 'Add', onPressed: () {}),
  );
}

/// Small FAB - Compact 40x40 size
@widgetbook.UseCase(name: 'Small FAB', type: AppFab)
Widget appFabSmall(BuildContext context) {
  return Center(
    child: AppFab.small(
      icon: Icons.filter_list,
      tooltip: 'Filter',
      onPressed: () {},
    ),
  );
}

/// Large FAB - Prominent 96x96 size
@widgetbook.UseCase(name: 'Large FAB', type: AppFab)
Widget appFabLarge(BuildContext context) {
  return Center(
    child: AppFab.large(
      icon: Icons.camera_alt,
      tooltip: 'Camera',
      onPressed: () {},
    ),
  );
}

/// Extended FAB - With label text
@widgetbook.UseCase(name: 'Extended FAB', type: AppFab)
Widget appFabExtended(BuildContext context) {
  return Center(
    child: AppFab.extended(
      icon: Icons.edit,
      label: 'Compose',
      tooltip: 'Compose new message',
      onPressed: () {},
    ),
  );
}

/// Extended with Trailing Icon - Label with leading and trailing icons
@widgetbook.UseCase(name: 'Extended with Trailing Icon', type: AppFab)
Widget appFabExtendedWithTrailingIcon(BuildContext context) {
  return Center(
    child: AppFab.extended(
      icon: Icons.download,
      label: 'Download',
      trailingIcon: Icons.arrow_forward,
      tooltip: 'Download file',
      onPressed: () {},
    ),
  );
}

/// Disabled State - FAB with null onPressed
@widgetbook.UseCase(name: 'Disabled State', type: AppFab)
Widget appFabDisabled(BuildContext context) {
  return const Center(
    child: AppFab(icon: Icons.add, tooltip: 'Disabled action', onPressed: null),
  );
}

/// Custom Colors - FAB with custom background and foreground colors
@widgetbook.UseCase(name: 'Custom Colors', type: AppFab)
Widget appFabCustomColors(BuildContext context) {
  return Center(
    child: AppFab(
      icon: Icons.favorite,
      tooltip: 'Like',
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white,
      onPressed: () {},
    ),
  );
}

/// Loading State - FAB with rotating icon animation
@widgetbook.UseCase(name: 'Loading State', type: AppFab)
Widget appFabLoading(BuildContext context) {
  return const Center(child: _LoadingFab());
}

/// Switchable FAB - Animated transition between default and extended
@widgetbook.UseCase(name: 'Switchable (Collapsed/Extended)', type: AppFab)
Widget appFabSwitchable(BuildContext context) {
  return const Center(child: _SwitchableDemo());
}

// Helper widgets

class _LoadingFab extends StatefulWidget {
  const _LoadingFab();

  @override
  State<_LoadingFab> createState() => _LoadingFabState();
}

class _LoadingFabState extends State<_LoadingFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
    _rotation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppFab(
      icon: Icons.sync,
      onPressed: () {},
      tooltip: 'Loading',
      iconWrapper: (icon) => RotationTransition(turns: _rotation, child: icon),
    );
  }
}

class _SwitchableDemo extends StatefulWidget {
  const _SwitchableDemo();

  @override
  State<_SwitchableDemo> createState() => _SwitchableDemoState();
}

class _SwitchableDemoState extends State<_SwitchableDemo> {
  bool _extended = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppFabSwitchable(
          isExtended: _extended,
          icon: Icons.edit,
          label: 'Compose',
          trailingIcon: Icons.arrow_forward,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => setState(() => _extended = !_extended),
          child: Text(_extended ? 'Collapse' : 'Expand'),
        ),
      ],
    );
  }
}
