// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Expose ALL Gap component properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: Gap)
Widget gapInteractivePlayground(BuildContext context) {
  // Knob for selecting preset size or custom size
  final usePreset = context.knobs.boolean(
    label: 'Use Preset Size',
    initialValue: true,
  );

  final presetSize = context.knobs.object.dropdown(
    label: 'Preset Size',
    options: const ['xs', 'sm', 'md', 'lg', 'xl', 'xxl'],
    labelBuilder: (value) => value,
  );

  final customSize = context.knobs.double.slider(
    label: 'Custom Size (dp)',
    initialValue: 16,
    min: 0,
    max: 100,
  );

  final layoutDirection = context.knobs.object.dropdown(
    label: 'Layout Direction',
    options: const ['Column', 'Row'],
    labelBuilder: (value) => value,
  );

  // Create Gap based on selection
  final gap = usePreset
      ? switch (presetSize) {
          'xs' => const Gap.xs(),
          'sm' => const Gap.sm(),
          'md' => const Gap.md(),
          'lg' => const Gap.lg(),
          'xl' => const Gap.xl(),
          'xxl' => const Gap.xxl(),
          _ => const Gap.md(),
        }
      : Gap(customSize);

  // Display Gap in selected layout direction
  if (layoutDirection == 'Column') {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 50,
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
            child: const Text('First', style: TextStyle(color: Colors.white)),
          ),
          gap,
          Container(
            width: 100,
            height: 50,
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.center,
            child: const Text('Second', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  } else {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 60,
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.center,
            child: const Text('First', style: TextStyle(color: Colors.white)),
          ),
          gap,
          Container(
            width: 80,
            height: 60,
            color: Theme.of(context).colorScheme.secondary,
            alignment: Alignment.center,
            child: const Text('Second', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

/// Column Spacing Demo - Shows Gap in vertical layout
@widgetbook.UseCase(name: 'Column Spacing', type: Gap)
Widget gapColumnSpacing(BuildContext context) {
  final gapSize = context.knobs.object.dropdown(
    label: 'Gap Size',
    options: const ['xs', 'sm', 'md', 'lg', 'xl'],
    labelBuilder: (value) => value,
  );

  final gap = switch (gapSize) {
    'xs' => const Gap.xs(),
    'sm' => const Gap.sm(),
    'md' => const Gap.md(),
    'lg' => const Gap.lg(),
    'xl' => const Gap.xl(),
    _ => const Gap.md(),
  };

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('First Item', style: Theme.of(context).textTheme.titleLarge),
        gap,
        Text('Second Item', style: Theme.of(context).textTheme.titleLarge),
        gap,
        Text('Third Item', style: Theme.of(context).textTheme.titleLarge),
      ],
    ),
  );
}

/// Row Spacing Demo - Shows Gap in horizontal layout
@widgetbook.UseCase(name: 'Row Spacing', type: Gap)
Widget gapRowSpacing(BuildContext context) {
  final gapSize = context.knobs.object.dropdown(
    label: 'Gap Size',
    options: const ['xs', 'sm', 'md', 'lg', 'xl'],
    labelBuilder: (value) => value,
  );

  final gap = switch (gapSize) {
    'xs' => const Gap.xs(),
    'sm' => const Gap.sm(),
    'md' => const Gap.md(),
    'lg' => const Gap.lg(),
    'xl' => const Gap.xl(),
    _ => const Gap.md(),
  };

  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
        gap,
        Icon(Icons.favorite, color: Theme.of(context).colorScheme.secondary),
        gap,
        Icon(Icons.thumb_up, color: Theme.of(context).colorScheme.tertiary),
      ],
    ),
  );
}

/// Size Variants Comparison - Shows all Gap sizes
@widgetbook.UseCase(name: 'Size Variants', type: Gap)
Widget gapSizeVariants(BuildContext context) {
  final showXS = context.knobs.boolean(
    label: 'Show XS (4dp)',
    initialValue: true,
  );
  final showSM = context.knobs.boolean(
    label: 'Show SM (8dp)',
    initialValue: true,
  );
  final showMD = context.knobs.boolean(
    label: 'Show MD (16dp)',
    initialValue: true,
  );
  final showLG = context.knobs.boolean(
    label: 'Show LG (24dp)',
    initialValue: true,
  );
  final showXL = context.knobs.boolean(
    label: 'Show XL (32dp)',
    initialValue: true,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showXS) ...[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Gap.xs(),
                const Text('Gap.xs() - 4dp'),
              ],
            ),
            const VGap.lg(),
          ],
          if (showSM) ...[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Gap.sm(),
                const Text('Gap.sm() - 8dp'),
              ],
            ),
            const VGap.lg(),
          ],
          if (showMD) ...[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Gap.md(),
                const Text('Gap.md() - 16dp'),
              ],
            ),
            const VGap.lg(),
          ],
          if (showLG) ...[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Gap.lg(),
                const Text('Gap.lg() - 24dp'),
              ],
            ),
            const VGap.lg(),
          ],
          if (showXL) ...[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Gap.xl(),
                const Text('Gap.xl() - 32dp'),
              ],
            ),
          ],
        ],
      ),
    ),
  );
}

/// HGap Explicit Horizontal - Shows HGap for explicit horizontal control
@widgetbook.UseCase(name: 'HGap Horizontal', type: Gap)
Widget gapHGapDemo(BuildContext context) {
  final gapSize = context.knobs.object.dropdown(
    label: 'HGap Width',
    options: const ['xs', 'sm', 'md', 'lg', 'xl'],
    labelBuilder: (value) => value,
  );

  final gap = switch (gapSize) {
    'xs' => const HGap.xs(),
    'sm' => const HGap.sm(),
    'md' => const HGap.md(),
    'lg' => const HGap.lg(),
    'xl' => const HGap.xl(),
    _ => const HGap.md(),
  };

  return Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(icon: const Icon(Icons.home), onPressed: () {}),
        gap,
        IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        gap,
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
      ],
    ),
  );
}

/// VGap Explicit Vertical - Shows VGap for explicit vertical control
@widgetbook.UseCase(name: 'VGap Vertical', type: Gap)
Widget gapVGapDemo(BuildContext context) {
  final gapSize = context.knobs.object.dropdown(
    label: 'VGap Height',
    options: const ['xs', 'sm', 'md', 'lg', 'xl'],
    labelBuilder: (value) => value,
  );

  final gap = switch (gapSize) {
    'xs' => const VGap.xs(),
    'sm' => const VGap.sm(),
    'md' => const VGap.md(),
    'lg' => const VGap.lg(),
    'xl' => const VGap.xl(),
    _ => const VGap.lg(),
  };

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Header', style: Theme.of(context).textTheme.headlineSmall),
        gap,
        Text('Content goes here', style: Theme.of(context).textTheme.bodyLarge),
        gap,
        Text('Footer', style: Theme.of(context).textTheme.bodySmall),
      ],
    ),
  );
}

/// Form Layout Example - Real-world form with Gap spacing
@widgetbook.UseCase(name: 'Form Layout Example', type: Gap)
Widget gapFormExample(BuildContext context) {
  final fieldGapSize = context.knobs.object.dropdown(
    label: 'Field Gap Size',
    options: const ['xs', 'sm', 'md', 'lg'],
    labelBuilder: (value) => value,
  );

  final sectionGapSize = context.knobs.object.dropdown(
    label: 'Section Gap Size',
    options: const ['md', 'lg', 'xl', 'xxl'],
    labelBuilder: (value) => value,
  );

  final fieldGap = switch (fieldGapSize) {
    'xs' => const Gap.xs(),
    'sm' => const Gap.sm(),
    'md' => const Gap.md(),
    'lg' => const Gap.lg(),
    _ => const Gap.md(),
  };

  final sectionGap = switch (sectionGapSize) {
    'md' => const Gap.md(),
    'lg' => const Gap.lg(),
    'xl' => const Gap.xl(),
    'xxl' => const Gap.xxl(),
    _ => const Gap.xl(),
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sign Up Form',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Gap.lg(),
          const AppTextField(label: 'Full Name'),
          fieldGap,
          const AppTextField(label: 'Email'),
          fieldGap,
          const AppPasswordField(label: 'Password'),
          sectionGap,
          AppButton.filled(label: 'Sign Up', fullWidth: true, onPressed: () {}),
        ],
      ),
    ),
  );
}

/// SizedBox Comparison - Shows Gap vs SizedBox readability
@widgetbook.UseCase(name: 'Gap vs SizedBox', type: Gap)
Widget gapComparisonDemo(BuildContext context) {
  final gapSize = context.knobs.object.dropdown(
    label: 'Gap Size',
    options: const ['xs', 'sm', 'md', 'lg', 'xl'],
    labelBuilder: (value) => value,
  );

  final gap = switch (gapSize) {
    'xs' => const Gap.xs(),
    'sm' => const Gap.sm(),
    'md' => const Gap.md(),
    'lg' => const Gap.lg(),
    'xl' => const Gap.xl(),
    _ => const Gap.md(),
  };

  final sizedBoxHeight = switch (gapSize) {
    'xs' => AppSpacing.xs,
    'sm' => AppSpacing.sm,
    'md' => AppSpacing.md,
    'lg' => AppSpacing.lg,
    'xl' => AppSpacing.xl,
    _ => AppSpacing.md,
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Using Gap (Recommended):',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const VGap.sm(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('First item'),
              gap, // Clean and semantic
              const Text('Second item'),
              gap,
              const Text('Third item'),
            ],
          ),
          const VGap.xl(),
          Text(
            'Using SizedBox (Legacy):',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const VGap.sm(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('First item'),
              SizedBox(height: sizedBoxHeight), // More verbose
              const Text('Second item'),
              SizedBox(height: sizedBoxHeight),
              const Text('Third item'),
            ],
          ),
        ],
      ),
    ),
  );
}
