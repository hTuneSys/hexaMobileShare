// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
// import 'package:widgetbook/widgetbook.dart' as widgetbook;
import 'package:core_kit/widgets/buttons/app_fab.dart';

// 1. Default FAB - Standard size
@widgetbook.UseCase(name: 'Default', type: AppFab)
Widget appFabDefault(BuildContext context) {
  return Center(
    child: AppFab(icon: Icons.add, onPressed: () {}),
  );
}

// 2. All Sizes - Show size variants
@widgetbook.UseCase(name: 'Sizes', type: AppFab)
Widget appFabSizes(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        AppFab.small(icon: Icons.filter_list, onPressed: () {}),
        AppFab(icon: Icons.add, onPressed: () {}),
        AppFab.large(icon: Icons.camera_alt, onPressed: () {}),
        AppFab.extended(icon: Icons.edit, label: 'Compose', onPressed: () {}),
      ],
    ),
  );
}

// 3. Extended FAB Variants
@widgetbook.UseCase(name: 'Extended Variants', type: AppFab)
Widget appFabExtendedVariants(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppFab.extended(icon: Icons.edit, label: 'Edit', onPressed: () {}),
        const SizedBox(height: 12),
        AppFab.extended(
          icon: Icons.download,
          label: 'Download',
          trailingIcon: Icons.arrow_forward,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        AppFab.extended(
          icon: Icons.share,
          label: 'Share a long descriptive label',
          onPressed: () {},
        ),
      ],
    ),
  );
}

// 4. States
@widgetbook.UseCase(name: 'States', type: AppFab)
Widget appFabStates(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 16,
      alignment: WrapAlignment.center,
      children: [
        AppFab(icon: Icons.add, onPressed: () {}),
        const AppFab(icon: Icons.add, onPressed: null), // Disabled
        const _LoadingFab(),
      ],
    ),
  );
}

// 5. Theme Variations
@widgetbook.UseCase(name: 'Theme Variations', type: AppFab)
Widget appFabThemeVariations(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Theme(
          data: ThemeData.light(useMaterial3: true),
          child: Wrap(
            spacing: 16,
            alignment: WrapAlignment.center,
            children: [
              AppFab(icon: Icons.add, onPressed: () {}),
              AppFab(
                icon: Icons.add,
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Theme(
          data: ThemeData.dark(useMaterial3: true),
          child: Wrap(
            spacing: 16,
            alignment: WrapAlignment.center,
            children: [
              AppFab(icon: Icons.add, onPressed: () {}),
              AppFab(
                icon: Icons.add,
                foregroundColor: Colors.black,
                backgroundColor: Colors.yellow,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// 6. Interactive Playground
@widgetbook.UseCase(name: 'Playground (Static)', type: AppFab)
Widget appFabPlayground(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppFab(icon: Icons.add, onPressed: () {}),
        const SizedBox(height: 12),
        AppFab.small(icon: Icons.filter_list, onPressed: () {}),
        const SizedBox(height: 12),
        AppFab.large(icon: Icons.camera_alt, onPressed: () {}),
        const SizedBox(height: 12),
        AppFab.extended(icon: Icons.edit, label: 'Compose', onPressed: () {}),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Collapsed vs Expanded', type: AppFab)
Widget appFabCollapsedExpanded(BuildContext context) {
  return Center(child: _SwitchableDemo());
}

class _SwitchableDemo extends StatefulWidget {
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
        const SizedBox(height: 12),
        Center(
          child: ElevatedButton(
            onPressed: () => setState(() => _extended = !_extended),
            child: Text(_extended ? 'Collapse' : 'Expand'),
          ),
        ),
      ],
    );
  }
}

@widgetbook.UseCase(name: 'Hide on Scroll', type: AppFab)
Widget appFabHideOnScroll(BuildContext context) {
  final controller = ScrollController();
  return Center(
    child: SizedBox(
      height: 240,
      child: Stack(
        children: [
          ListView.builder(
            controller: controller,
            itemCount: 30,
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
  );
}

// Helper: loading state demo
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
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      heroTag: 'loading-fab',
      iconWrapper: (icon) => RotationTransition(turns: _rotation, child: icon),
    );
  }
}

// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT
