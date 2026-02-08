// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Explore AppIcons with full customization
@widgetbook.UseCase(name: 'Interactive Playground', type: AppIcons)
Widget appIconsPlayground(BuildContext context) {
  // Category selector
  final category = context.knobs.object.dropdown<String>(
    label: 'Icon Category',
    options: AppIcons.categoricalIcons.keys.toList(),
    labelBuilder: (value) => value,
  );

  // Icon selector based on category
  final iconName = _getIconsForCategory(category, context);

  // Size selector - using AppIconSizes system (MD3 standard)
  final sizeOptions = const [
    ('xs (16dp)', AppIconSizes.xs),
    ('sm (20dp)', AppIconSizes.sm),
    ('md (24dp)', AppIconSizes.md),
    ('lg (32dp)', AppIconSizes.lg),
    ('xl (48dp)', AppIconSizes.xl),
  ];

  final selectedSizeLabel = context.knobs.object.dropdown(
    label: 'Icon Size',
    options: sizeOptions.map((e) => e.$1).toList(),
    labelBuilder: (value) => value,
  );

  final size = sizeOptions.firstWhere((e) => e.$1 == selectedSizeLabel).$2;

  // Color selector
  final useCustomColor = context.knobs.boolean(
    label: 'Use Custom Color',
    initialValue: false,
  );

  final customColor = context.knobs.colorOrNull(
    label: 'Custom Color',
    initialValue: Colors.blue,
  );

  // Get the IconData based on selection
  final icon = AppIcons.allIcons[iconName] ?? AppIcons.home;

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: size, color: useCustomColor ? customColor : null),
        VGap.md(),
        AppBodyText.medium(iconName),
        AppBodyText.small('${size.toInt()}dp'),
      ],
    ),
  );
}

/// Navigation Icons - Common navigation and wayfinding icons
@widgetbook.UseCase(name: 'Navigation Icons', type: AppIcons)
Widget navigationIcons(BuildContext context) {
  return _buildCategorizedIconGrid(context, 'Navigation');
}

/// Action Icons - User actions and commands
@widgetbook.UseCase(name: 'Action Icons', type: AppIcons)
Widget actionIcons(BuildContext context) {
  return _buildCategorizedIconGrid(context, 'Actions');
}

/// Status Icons - Status indicators with semantic colors
@widgetbook.UseCase(name: 'Status Icons', type: AppIcons)
Widget statusIcons(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final icons = AppIcons.categoricalIcons['Status'] ?? {};

  return Padding(
    padding: AppSpacing.edgeInsetsAllMd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppH3('Status Icons'),
        VGap.md(),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            children: [
              _buildStatusIconCard(
                context,
                'check',
                icons['check']!,
                colorScheme.primary,
              ),
              _buildStatusIconCard(
                context,
                'success',
                icons['success']!,
                Colors.green,
              ),
              _buildStatusIconCard(
                context,
                'error',
                icons['error']!,
                colorScheme.error,
              ),
              _buildStatusIconCard(
                context,
                'warning',
                icons['warning']!,
                Colors.orange,
              ),
              _buildStatusIconCard(
                context,
                'info',
                icons['info']!,
                Colors.blue,
              ),
              _buildStatusIconCard(
                context,
                'help',
                icons['help']!,
                colorScheme.secondary,
              ),
              _buildStatusIconCard(
                context,
                'verified',
                icons['verified']!,
                Colors.blue,
              ),
              _buildStatusIconCard(
                context,
                'pending',
                icons['pending']!,
                Colors.amber,
              ),
              _buildStatusIconCard(
                context,
                'blocked',
                icons['blocked']!,
                colorScheme.error,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Content Icons - Content types and media
@widgetbook.UseCase(name: 'Content Icons', type: AppIcons)
Widget contentIcons(BuildContext context) {
  return _buildCategorizedIconGrid(context, 'Content');
}

/// Communication Icons - Communication and messaging
@widgetbook.UseCase(name: 'Communication Icons', type: AppIcons)
Widget communicationIcons(BuildContext context) {
  return _buildCategorizedIconGrid(context, 'Communication');
}

/// UI Control Icons - Interface controls and toggles
@widgetbook.UseCase(name: 'UI Control Icons', type: AppIcons)
Widget uiControlIcons(BuildContext context) {
  return _buildCategorizedIconGrid(context, 'UI Controls');
}

/// Icon Sizes Reference - Demonstrates proper Material Design 3 icon sizing
@widgetbook.UseCase(name: 'Icon Sizes Reference', type: AppIcons)
Widget iconSizesReference(BuildContext context) {
  final sizes = const [
    ('xs', AppIconSizes.xs),
    ('sm', AppIconSizes.sm),
    ('md', AppIconSizes.md),
    ('lg', AppIconSizes.lg),
    ('xl', AppIconSizes.xl),
  ];

  return Padding(
    padding: AppSpacing.edgeInsetsAllMd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppH3('Material Design 3 Icon Sizes'),
        VGap.sm(),
        AppBodyText.medium('Same icon (AppIcons.home) at different sizes'),
        VGap.lg(),
        Expanded(
          child: ListView.separated(
            itemCount: sizes.length,
            separatorBuilder: (context, index) => const Divider(height: 32),
            itemBuilder: (context, index) {
              final (label, size) = sizes[index];
              return Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppLabel.medium('AppIconSizes.$label'),
                        AppCaption(
                          text: '${size.toInt()}dp',
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ],
                    ),
                  ),
                  Icon(AppIcons.home, size: size),
                  HGap.md(),
                  Text(
                    'AppIcons.home',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

Widget _buildCategorizedIconGrid(BuildContext context, String category) {
  final iconMap = AppIcons.categoricalIcons[category] ?? {};
  final icons = iconMap.entries.map((e) => (e.key, e.value)).toList();

  return Padding(
    padding: AppSpacing.edgeInsetsAllMd,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppH3('$category Icons'),
        VGap.md(),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1,
            ),
            itemCount: icons.length,
            itemBuilder: (context, index) {
              final (name, icon) = icons[index];
              return _buildIconCard(context, name, icon);
            },
          ),
        ),
      ],
    ),
  );
}

Widget _buildIconCard(BuildContext context, String name, IconData icon) {
  return Card(
    child: Padding(
      padding: AppSpacing.edgeInsetsAllSm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: AppIconSizes.lg),
          VGap.sm(),
          AppBodyText.small(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    ),
  );
}

Widget _buildStatusIconCard(
  BuildContext context,
  String name,
  IconData icon,
  Color color,
) {
  return Card(
    child: Padding(
      padding: AppSpacing.edgeInsetsAllSm,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: AppIconSizes.lg, color: color),
          VGap.sm(),
          AppBodyText.small(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    ),
  );
}

String _getIconsForCategory(String category, BuildContext context) {
  final options =
      AppIcons.categoricalIcons[category]?.keys.toList() ?? ['home'];
  return context.knobs.object.dropdown<String>(
    label: 'Icon',
    options: options,
    labelBuilder: (value) => value,
  );
}
