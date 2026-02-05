// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - MUST be first variant with ALL props as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppIcon)
Widget appIconInteractivePlayground(BuildContext context) {
  // Icon selection
  final iconOptions = {
    Icons.search: 'Search',
    Icons.favorite: 'Favorite',
    Icons.star: 'Star',
    Icons.settings: 'Settings',
    Icons.home: 'Home',
    Icons.person: 'Person',
    Icons.shopping_cart: 'Shopping Cart',
    Icons.notifications: 'Notifications',
    Icons.mail: 'Mail',
    Icons.delete: 'Delete',
    Icons.edit: 'Edit',
    Icons.add: 'Add',
    Icons.remove: 'Remove',
    Icons.check: 'Check',
    Icons.close: 'Close',
    Icons.error: 'Error',
    Icons.warning: 'Warning',
    Icons.info: 'Info',
  };

  final icon = context.knobs.object.dropdown(
    label: 'Icon',
    options: iconOptions.keys.toList(),
    labelBuilder: (icon) => iconOptions[icon] ?? 'Unknown',
  );

  // Size selection
  final sizeOption = context.knobs.object.dropdown(
    label: 'Size Preset',
    options: ['xs', 'sm', 'md', 'lg', 'xl', 'custom'],
    labelBuilder: (v) => v,
  );

  final customSize = context.knobs.double.slider(
    label: 'Custom Size',
    initialValue: 24,
    min: 12,
    max: 64,
  );

  // Color options
  final useSemanticColor = context.knobs.boolean(
    label: 'Use Semantic Color',
    initialValue: true,
  );

  final semanticColorOption = context.knobs.objectOrNull.dropdown(
    label: 'Semantic Color',
    options: [
      'primary',
      'onPrimary',
      'secondary',
      'onSecondary',
      'tertiary',
      'error',
      'onSurface',
      'onSurfaceVariant',
      'outline',
    ],
    labelBuilder: (v) => v,
  );

  final customColor = context.knobs.colorOrNull(label: 'Custom Color');

  // Accessibility
  final semanticLabel = context.knobs.stringOrNull(
    label: 'Semantic Label (a11y)',
    initialValue: null,
  );

  // Build icon based on selections
  final double? effectiveSize = switch (sizeOption) {
    'xs' => AppIconSize.xs,
    'sm' => AppIconSize.sm,
    'md' => AppIconSize.md,
    'lg' => AppIconSize.lg,
    'xl' => AppIconSize.xl,
    'custom' => customSize,
    _ => null,
  };

  AppIconSemanticColor? effectiveSemanticColor;
  if (useSemanticColor && semanticColorOption != null) {
    effectiveSemanticColor = switch (semanticColorOption) {
      'primary' => AppIconSemanticColor.primary,
      'onPrimary' => AppIconSemanticColor.onPrimary,
      'secondary' => AppIconSemanticColor.secondary,
      'onSecondary' => AppIconSemanticColor.onSecondary,
      'tertiary' => AppIconSemanticColor.tertiary,
      'error' => AppIconSemanticColor.error,
      'onSurface' => AppIconSemanticColor.onSurface,
      'onSurfaceVariant' => AppIconSemanticColor.onSurfaceVariant,
      'outline' => AppIconSemanticColor.outline,
      _ => null,
    };
  }

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcon(
          icon,
          size: effectiveSize,
          color: useSemanticColor ? null : customColor,
          semanticColor: effectiveSemanticColor,
          semanticLabel: semanticLabel,
        ),
        if (semanticLabel != null && semanticLabel.isNotEmpty) ...[
          Gap.md(),
          Container(
            padding: AppSpacing.edgeInsetsAllSm,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.accessibility_new,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Gap.xs(),
                Text(
                  'Screen Reader:',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Gap.xs(),
                Text(
                  '"$semanticLabel"',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}

/// All size variants demonstration
@widgetbook.UseCase(name: 'All Size Variants', type: AppIcon)
Widget appIconSizeVariants(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const AppIcon.xs(Icons.star),
                Gap.xs(),
                Text('XS (16)', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Gap.lg(),
            Column(
              children: [
                const AppIcon.sm(Icons.star),
                Gap.xs(),
                Text('SM (20)', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Gap.lg(),
            Column(
              children: [
                const AppIcon.md(Icons.star),
                Gap.xs(),
                Text('MD (24)', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Gap.lg(),
            Column(
              children: [
                const AppIcon.lg(Icons.star),
                Gap.xs(),
                Text('LG (32)', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Gap.lg(),
            Column(
              children: [
                const AppIcon.xl(Icons.star),
                Gap.xs(),
                Text('XL (48)', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

/// Semantic colors demonstration with interactive dropdown
@widgetbook.UseCase(name: 'Semantic Colors', type: AppIcon)
Widget appIconSemanticColors(BuildContext context) {
  final icon = context.knobs.object.dropdown(
    label: 'Icon',
    options: [
      Icons.circle,
      Icons.star,
      Icons.favorite,
      Icons.check_circle,
      Icons.info,
      Icons.warning,
      Icons.error,
    ],
    labelBuilder: _getIconName,
  );

  final size = context.knobs.object.dropdown(
    label: 'Size',
    options: [
      AppIconSize.xs,
      AppIconSize.sm,
      AppIconSize.md,
      AppIconSize.lg,
      AppIconSize.xl,
    ],
    labelBuilder: _getSizeName,
  );

  final semanticColorKey = context.knobs.object.dropdown(
    label: 'Semantic Color',
    options: AppIconSemanticColor.values.map((e) => e.name).toList(),
    labelBuilder: _formatSemanticColorName,
  );

  final semanticColor = AppIconSemanticColor.values.firstWhere(
    (e) => e.name == semanticColorKey,
    orElse: () => AppIconSemanticColor.primary,
  );

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppIcon(icon, size: size, semanticColor: semanticColor),
        Gap.md(),
        Text(
          _formatSemanticColorName(semanticColorKey),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    ),
  );
}

/// Helper: Get icon name for display
String _getIconName(IconData icon) {
  return switch (icon) {
    Icons.circle => 'Circle',
    Icons.star => 'Star',
    Icons.favorite => 'Favorite',
    Icons.check_circle => 'Check Circle',
    Icons.info => 'Info',
    Icons.warning => 'Warning',
    Icons.error => 'Error',
    _ => 'Icon',
  };
}

/// Helper: Get size name for display
String _getSizeName(double size) {
  return switch (size) {
    AppIconSize.xs => 'XS (16)',
    AppIconSize.sm => 'SM (20)',
    AppIconSize.md => 'MD (24)',
    AppIconSize.lg => 'LG (32)',
    AppIconSize.xl => 'XL (48)',
    _ => 'Size',
  };
}

/// Helper: Format semantic color name to human-readable format
String _formatSemanticColorName(String colorKey) {
  return colorKey
      .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}')
      .trim()
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
      .join(' ');
}

/// Common icons showcase
@widgetbook.UseCase(name: 'Common Icons Showcase', type: AppIcon)
Widget appIconCommonShowcase(BuildContext context) {
  Widget iconGroup(String title, List<IconData> icons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        Gap.sm(),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: icons.map((icon) => AppIcon(icon)).toList(),
        ),
        Gap.lg(),
      ],
    );
  }

  return SingleChildScrollView(
    padding: AppSpacing.edgeInsetsAllMd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        iconGroup('Navigation', [
          Icons.home,
          Icons.search,
          Icons.menu,
          Icons.arrow_back,
          Icons.arrow_forward,
          Icons.close,
          Icons.more_vert,
          Icons.more_horiz,
        ]),
        iconGroup('Actions', [
          Icons.add,
          Icons.remove,
          Icons.edit,
          Icons.delete,
          Icons.save,
          Icons.cancel,
          Icons.check,
          Icons.refresh,
        ]),
        iconGroup('Content', [
          Icons.favorite,
          Icons.favorite_border,
          Icons.star,
          Icons.star_border,
          Icons.share,
          Icons.bookmark,
          Icons.bookmark_border,
          Icons.thumb_up,
        ]),
        iconGroup('Communication', [
          Icons.mail,
          Icons.message,
          Icons.chat,
          Icons.call,
          Icons.notifications,
          Icons.person,
          Icons.group,
          Icons.send,
        ]),
        iconGroup('Media', [
          Icons.play_arrow,
          Icons.pause,
          Icons.stop,
          Icons.skip_next,
          Icons.skip_previous,
          Icons.volume_up,
          Icons.volume_off,
          Icons.music_note,
        ]),
        iconGroup('Status', [
          Icons.error,
          Icons.warning,
          Icons.info,
          Icons.check_circle,
          Icons.cancel,
          Icons.help,
          Icons.verified,
          Icons.new_releases,
        ]),
      ],
    ),
  );
}

/// Theme variations (light/dark)
@widgetbook.UseCase(name: 'Theme Variations', type: AppIcon)
Widget appIconThemeVariations(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Icons automatically adapt to theme',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Gap.lg(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppIcon(
              Icons.brightness_7,
              semanticColor: AppIconSemanticColor.primary,
            ),
            Gap.md(),
            const AppIcon(
              Icons.favorite,
              semanticColor: AppIconSemanticColor.error,
            ),
            Gap.md(),
            const AppIcon(
              Icons.star,
              semanticColor: AppIconSemanticColor.tertiary,
            ),
            Gap.md(),
            const AppIcon(
              Icons.settings,
              semanticColor: AppIconSemanticColor.onSurface,
            ),
          ],
        ),
        Gap.lg(),
        Text(
          'Toggle light/dark mode in Widgetbook addons',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}

/// Custom color override
@widgetbook.UseCase(name: 'Custom Color Override', type: AppIcon)
Widget appIconCustomColor(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Custom colors override semantic colors',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Gap.lg(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppIcon(Icons.favorite, color: Colors.red),
            Gap.md(),
            const AppIcon(Icons.star, color: Colors.amber),
            Gap.md(),
            const AppIcon(Icons.thumb_up, color: Colors.blue),
            Gap.md(),
            const AppIcon(Icons.eco, color: Colors.green),
            Gap.md(),
            const AppIcon(Icons.palette, color: Colors.purple),
          ],
        ),
      ],
    ),
  );
}

/// Accessibility demonstration
@widgetbook.UseCase(name: 'Accessibility Demo', type: AppIcon)
Widget appIconAccessibility(BuildContext context) {
  return SingleChildScrollView(
    padding: AppSpacing.edgeInsetsAllMd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icons with Semantic Labels',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Gap.md(),
        Text(
          'These icons have accessibility labels for screen readers:',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Gap.lg(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const AppIcon(Icons.search, semanticLabel: 'Search'),
                Gap.sm(),
                Text('Search', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Column(
              children: [
                const AppIcon(
                  Icons.error,
                  semanticColor: AppIconSemanticColor.error,
                  semanticLabel: 'Error indicator',
                ),
                Gap.sm(),
                Text('Error', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Column(
              children: [
                const AppIcon(
                  Icons.check_circle,
                  semanticColor: AppIconSemanticColor.primary,
                  semanticLabel: 'Success indicator',
                ),
                Gap.sm(),
                Text('Success', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
            Column(
              children: [
                const AppIcon(
                  Icons.info,
                  semanticColor: AppIconSemanticColor.onSurfaceVariant,
                  semanticLabel: 'Information icon',
                ),
                Gap.sm(),
                Text('Info', style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ],
        ),
        Gap.xl(),
        Container(
          padding: AppSpacing.edgeInsetsAllMd,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const AppIcon(
                    Icons.accessibility_new,
                    semanticColor: AppIconSemanticColor.primary,
                  ),
                  Gap.sm(),
                  Text(
                    'Accessibility Best Practices',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Gap.md(),
              Text(
                '• Always provide semantic labels for icons without text\n'
                '• Use semantic colors for proper contrast\n'
                '• Icons alone should not convey critical information\n'
                '• Test with screen readers (TalkBack, VoiceOver)',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Real-world usage examples
@widgetbook.UseCase(name: 'Real-world Examples', type: AppIcon)
Widget appIconRealWorldExamples(BuildContext context) {
  return SingleChildScrollView(
    padding: AppSpacing.edgeInsetsAllMd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Button Icons', style: Theme.of(context).textTheme.titleMedium),
        Gap.sm(),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const AppIcon.sm(Icons.add, semanticLabel: 'Add'),
              label: const Text('Add Item'),
            ),
            Gap.md(),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const AppIcon.sm(Icons.delete, semanticLabel: 'Delete'),
              label: const Text('Delete'),
            ),
          ],
        ),
        Gap.lg(),
        Text('List Tile Icons', style: Theme.of(context).textTheme.titleMedium),
        Gap.sm(),
        ListTile(
          leading: const AppIcon(
            Icons.person,
            semanticColor: AppIconSemanticColor.primary,
            semanticLabel: 'User profile',
          ),
          title: const Text('Profile'),
          trailing: const AppIcon(
            Icons.arrow_forward_ios,
            semanticColor: AppIconSemanticColor.onSurfaceVariant,
            semanticLabel: 'Navigate to profile',
          ),
        ),
        ListTile(
          leading: const AppIcon(
            Icons.settings,
            semanticColor: AppIconSemanticColor.onSurfaceVariant,
            semanticLabel: 'Settings',
          ),
          title: const Text('Settings'),
          trailing: const AppIcon(
            Icons.arrow_forward_ios,
            semanticColor: AppIconSemanticColor.onSurfaceVariant,
            semanticLabel: 'Navigate to settings',
          ),
        ),
        Gap.lg(),
        Text(
          'Form Field Icons',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Gap.sm(),
        TextField(
          decoration: InputDecoration(
            labelText: 'Search',
            prefixIcon: const AppIcon(
              Icons.search,
              semanticLabel: 'Search field',
            ),
            suffixIcon: IconButton(
              icon: const AppIcon.sm(
                Icons.clear,
                semanticLabel: 'Clear search',
              ),
              onPressed: () {},
            ),
          ),
        ),
        Gap.lg(),
        Text(
          'Status Indicators',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Gap.sm(),
        Row(
          children: [
            Chip(
              avatar: const AppIcon.xs(
                Icons.check_circle,
                semanticColor: AppIconSemanticColor.primary,
                semanticLabel: 'Active status',
              ),
              label: const Text('Active'),
            ),
            Gap.md(),
            Chip(
              avatar: const AppIcon.xs(
                Icons.error,
                semanticColor: AppIconSemanticColor.error,
                semanticLabel: 'Error status',
              ),
              label: const Text('Error'),
            ),
            Gap.md(),
            Chip(
              avatar: const AppIcon.xs(
                Icons.warning,
                color: Colors.orange,
                semanticLabel: 'Warning status',
              ),
              label: const Text('Warning'),
            ),
          ],
        ),
      ],
    ),
  );
}
