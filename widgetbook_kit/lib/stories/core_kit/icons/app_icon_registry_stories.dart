// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/layout/gap.dart';
import 'package:core_kit/theme/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/icons/app_icon_registry.dart';

// Helper widget to display an icon from the registry
class _AppIconDemo extends StatelessWidget {
  final String iconName;
  final AppIconVariant variant;
  final double size;
  final Color? color;

  const _AppIconDemo({
    required this.iconName,
    this.variant = AppIconVariant.outlined,
    this.size = 24,
    this.color,
  });

  static void registerDemoIcons() {
    // Register some icons if they aren't already
    // This is a bit of a hack for the story, ideally this happens at app startup
    final registry = AppIconRegistry.instance;
    if (registry.getIcon('home').codePoint == 0xe000) {
      // Check if fallback (assuming fallback is set) or just re-register
      registry.registerMaterialIcon(
        name: 'home',
        defaultIcon: Icons.home_outlined,
        variants: {
          AppIconVariant.outlined: Icons.home_outlined,
          AppIconVariant.filled: Icons.home,
        },
      );
      registry.registerMaterialIcon(
        name: 'settings',
        defaultIcon: Icons.settings_outlined,
        variants: {
          AppIconVariant.outlined: Icons.settings_outlined,
          AppIconVariant.filled: Icons.settings,
        },
      );
      registry.registerAlias('gear', 'settings');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Ensure we have some icons registered for the demo
    registerDemoIcons();

    final iconData = AppIconRegistry.instance.getIcon(
      iconName,
      variant: variant,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(iconData, size: size, color: color),
        const VGap.sm(),
        Text('Name: $iconName', style: Theme.of(context).textTheme.bodySmall),
        Text(
          'Variant: ${variant.name}',
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}

// Helper for the Browser story
class _AppIconBrowser extends StatelessWidget {
  const _AppIconBrowser();

  @override
  Widget build(BuildContext context) {
    // Force registration
    _AppIconDemo.registerDemoIcons();

    final icons = AppIconRegistry.instance.getAllIcons();

    return ListView.builder(
      itemCount: icons.length,
      itemBuilder: (context, index) {
        final def = icons[index];
        return ExpansionTile(
          title: Text(def.name, style: Theme.of(context).textTheme.bodyMedium),
          leading: Icon(def.defaultIcon),
          childrenPadding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Wrap(
              spacing: AppSpacing.md,
              children: AppIconVariant.values.map((v) {
                return Column(
                  children: [
                    Icon(def.getVariant(v)),
                    Text(v.name, style: Theme.of(context).textTheme.labelSmall),
                  ],
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

@widgetbook.UseCase(name: 'Interactive Playground', type: AppIconRegistry)
Widget appIconRegistryUseCases(BuildContext context) {
  return Center(
    child: _AppIconDemo(
      iconName: context.knobs.string(
        label: 'Icon Name',
        initialValue: 'home',
        description: 'Try "home", "settings", "gear" (alias)',
      ),
      variant: context.knobs.object.dropdown<AppIconVariant>(
        label: 'Variant',
        options: AppIconVariant.values,
        initialOption: AppIconVariant.outlined,
        labelBuilder: (value) => value.name,
      ),
      size: context.knobs.double.slider(
        label: 'Size',
        initialValue: 48,
        min: 16,
        max: 128,
      ),
      color: context.knobs.color(
        label: 'Color',
        initialValue: Theme.of(context).colorScheme.primary,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Default Icon (Outlined)', type: AppIconRegistry)
Widget defaultIconStory(BuildContext context) {
  return const Center(
    child: _AppIconDemo(iconName: 'home', variant: AppIconVariant.outlined),
  );
}

@widgetbook.UseCase(name: 'Filled Variant', type: AppIconRegistry)
Widget filledVariantStory(BuildContext context) {
  return const Center(
    child: _AppIconDemo(iconName: 'home', variant: AppIconVariant.filled),
  );
}

@widgetbook.UseCase(
  name: 'Aliased Icon (Gear -> Settings)',
  type: AppIconRegistry,
)
Widget aliasedIconStory(BuildContext context) {
  return const Center(
    child: _AppIconDemo(iconName: 'gear', variant: AppIconVariant.filled),
  );
}

@widgetbook.UseCase(name: 'Fallback Icon', type: AppIconRegistry)
Widget fallbackIconStory(BuildContext context) {
  return const Center(child: _AppIconDemo(iconName: 'non_existent_icon'));
}

@widgetbook.UseCase(name: 'Icon Browser', type: AppIconRegistry)
Widget appIconRegistryBrowser(BuildContext context) {
  return const _AppIconBrowser();
}
