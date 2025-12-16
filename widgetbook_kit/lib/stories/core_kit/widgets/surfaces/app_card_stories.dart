// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/surfaces/app_card.dart';
import 'package:core_kit/theme/app_spacing.dart';

@widgetbook.UseCase(name: 'Default', type: AppCard)
Widget appCardDefault(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Default Card (Level 1)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          const Text(
            'This is the default card variant with 1dp elevation and medium radius.',
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'All Variants', type: AppCard)
Widget appCardVariants(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      children: [
        _buildVariantExample(
          context,
          'Flat (Level 0)',
          AppCard.flat(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: const Text('Flat Card\nNo elevation, blends with surface'),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildVariantExample(
          context,
          'Default (Level 1)',
          AppCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: const Text('Default AppCard\nStandard 1dp elevation'),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildVariantExample(
          context,
          'Elevated (Level 2/3)',
          AppCard.elevated(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: const Text(
              'Elevated Card\nHigher elevation (3dp) for emphasis',
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _buildVariantExample(
          context,
          'Outlined (Level 0)',
          AppCard.outlined(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: const Text('Outlined Card\nBordered with no elevation'),
          ),
        ),
      ],
    ),
  );
}

Widget _buildVariantExample(BuildContext context, String title, Widget card) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(title, style: Theme.of(context).textTheme.labelLarge),
      const SizedBox(height: AppSpacing.xs),
      card,
    ],
  );
}

@widgetbook.UseCase(name: 'Interactive', type: AppCard)
Widget appCardInteractive(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppCard(
          onTap: () {},
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.touch_app),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Tappable Card',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'Tap this card to see the ripple effect. The ripple is clipped to the card shape.',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard.outlined(
          onTap: () {},
          padding: const EdgeInsets.all(AppSpacing.md),
          child: const SizedBox(
            width: double.infinity,
            child: Text('Tappable Outlined Card', textAlign: TextAlign.center),
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Content Types', type: AppCard)
Widget appCardContentTypes(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      children: [
        // List Card
        AppCard(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('List Tile within Card'),
                subtitle: const Text('Using ListTile for consistency'),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.description),
                title: const Text('Second Item'),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Media Card
        AppCard(
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Icon(Icons.image, size: 48, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Media Card',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    const Text(
                      'Card with an image (placeholder) and content below.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Elevation Levels', type: AppCard)
Widget appCardElevations(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      children: [
        for (final elevation in [0.0, 1.0, 3.0, 6.0, 8.0, 12.0])
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: AppCard(
              elevation: elevation,
              padding: const EdgeInsets.all(AppSpacing.md),
              child: SizedBox(
                width: double.infinity,
                child: Text('Elevation ${elevation.toInt()}'),
              ),
            ),
          ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Styling', type: AppCard)
Widget appCardCustom(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: AppCard(
      color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      padding: const EdgeInsets.all(24),
      elevation: 5,
      shadowColor: Colors.red.withValues(alpha: 0.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Custom Styled Card'),
          SizedBox(height: 8),
          Text('Custom color, radius, padding, and shadow.'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Interactive Playground', type: AppCard)
Widget appCardPlayground(BuildContext context) {
  final elevation = context.knobs.double.slider(
    label: 'Elevation',
    initialValue: 1,
    min: 0,
    max: 12,
  );

  final onTapEnabled = context.knobs.boolean(
    label: 'Enable onTap',
    initialValue: true,
  );

  final isOutlined = context.knobs.boolean(
    label: 'Is Outlined',
    initialValue: false,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: isOutlined
          ? AppCard.outlined(
              onTap: onTapEnabled ? () {} : null,
              padding: const EdgeInsets.all(AppSpacing.md),
              child: const Text('Playground Card (Outlined)'),
            )
          : AppCard(
              elevation: elevation,
              onTap: onTapEnabled ? () {} : null,
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text('Playground Card (Elev: $elevation)'),
            ),
    ),
  );
}
