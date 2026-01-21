// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Expose ALL component properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppOverline)
Widget appOverlinePlayground(BuildContext context) {
  // Knobs for all AppOverline properties
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Category Label',
  );

  final hasCustomColor = context.knobs.boolean(
    label: 'Use Custom Color',
    initialValue: false,
  );

  final customColor = context.knobs.colorOrNull(
    label: 'Custom Color',
    initialValue: null,
  );

  final textAlign = context.knobs.object.dropdown(
    label: 'Text Align',
    options: ['start', 'center', 'end', 'justify'],
  );

  // Map string to TextAlign enum
  final alignValue = switch (textAlign) {
    'start' => TextAlign.start,
    'center' => TextAlign.center,
    'end' => TextAlign.end,
    'justify' => TextAlign.justify,
    _ => TextAlign.start,
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: AppOverline(
        text,
        color: hasCustomColor ? customColor : null,
        textAlign: alignValue,
      ),
    ),
  );
}

/// Default Overline - Basic overline with default styling
@widgetbook.UseCase(name: 'Default Overline', type: AppOverline)
Widget appOverlineDefault(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: AppOverline('Technology'),
    ),
  );
}

/// Above Headline - Common pattern showing overline above main headline
@widgetbook.UseCase(name: 'Above Headline', type: AppOverline)
Widget appOverlineAboveHeadline(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppOverline('Business'),
          const VGap.sm(),
          Text(
            'Market reaches new heights',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const VGap.sm(),
          Text(
            'Stocks soar to record levels as investors show confidence in economic recovery.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    ),
  );
}

/// Category Labels - Different category examples
@widgetbook.UseCase(name: 'Category Labels', type: AppOverline)
Widget appOverlineCategoryLabels(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Wrap(
        spacing: AppSpacing.md,
        runSpacing: AppSpacing.md,
        children: const [
          AppOverline('Technology'),
          AppOverline('Business'),
          AppOverline('Sports'),
          AppOverline('Entertainment'),
          AppOverline('Science'),
          AppOverline('Politics'),
        ],
      ),
    ),
  );
}

/// Color Variations - Overline with different color emphasis
@widgetbook.UseCase(name: 'Color Variations', type: AppOverline)
Widget appOverlineColorVariations(BuildContext context) {
  final theme = Theme.of(context);

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppOverline('Default (onSurfaceVariant)'),
          const VGap.md(),
          AppOverline('Primary Color', color: theme.colorScheme.primary),
          const VGap.md(),
          AppOverline('Secondary Color', color: theme.colorScheme.secondary),
          const VGap.md(),
          AppOverline('Tertiary Color', color: theme.colorScheme.tertiary),
          const VGap.md(),
          AppOverline('Error Color', color: theme.colorScheme.error),
        ],
      ),
    ),
  );
}

/// Step Indicators - Shows step progression labels
@widgetbook.UseCase(name: 'Step Indicators', type: AppOverline)
Widget appOverlineStepIndicators(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppOverline('Step 1'),
          const VGap.sm(),
          Text(
            'Create your account',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const VGap.lg(),
          const AppOverline('Step 2'),
          const VGap.sm(),
          Text(
            'Verify your email',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const VGap.lg(),
          const AppOverline('Step 3'),
          const VGap.sm(),
          Text(
            'Complete your profile',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    ),
  );
}

/// Text Alignment - Different alignment options
@widgetbook.UseCase(name: 'Text Alignment', type: AppOverline)
Widget appOverlineTextAlignment(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            AppOverline('Start Aligned', textAlign: TextAlign.start),
            VGap.md(),
            AppOverline('Center Aligned', textAlign: TextAlign.center),
            VGap.md(),
            AppOverline('End Aligned', textAlign: TextAlign.end),
          ],
        ),
      ),
    ),
  );
}

/// Content Card Example - Real-world usage in content cards
@widgetbook.UseCase(name: 'Content Card Example', type: AppOverline)
Widget appOverlineContentCard(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppOverline('Featured Article'),
            const VGap.sm(),
            Text(
              'The Future of Mobile Development',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const VGap.sm(),
            Text(
              'Exploring the latest trends and technologies shaping the mobile landscape.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const VGap.md(),
            TextButton(onPressed: () {}, child: const Text('Read More')),
          ],
        ),
      ),
    ),
  );
}

/// News Article Layout - Editorial-style layout with overline
@widgetbook.UseCase(name: 'News Article Layout', type: AppOverline)
Widget appOverlineNewsArticle(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppOverline(
            'Technology',
            color: Theme.of(context).colorScheme.primary,
          ),
          const VGap.sm(),
          Text(
            'AI Revolution Transforms Industry',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const VGap.sm(),
          Text(
            'By John Doe • 2 hours ago',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const VGap.md(),
          Text(
            'Artificial intelligence continues to reshape how we work and live, with new breakthroughs emerging daily. Industry leaders predict unprecedented changes ahead as AI capabilities expand exponentially.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    ),
  );
}

/// Multiple Cards with Overlines - Grid layout showing multiple cards
@widgetbook.UseCase(name: 'Multiple Cards Grid', type: AppOverline)
Widget appOverlineMultipleCards(BuildContext context) {
  final categories = ['Technology', 'Business', 'Sports', 'Science'];
  final titles = [
    'Innovation Drives Progress',
    'Markets Show Growth',
    'Team Wins Championship',
    'Discovery Announced',
  ];

  return SingleChildScrollView(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: List.generate(4, (index) {
        return SizedBox(
          width: 180,
          child: AppCard(
            padding: const EdgeInsets.all(AppSpacing.sm + AppSpacing.xs),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppOverline(categories[index]),
                const VGap.sm(),
                Text(
                  titles[index],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}
