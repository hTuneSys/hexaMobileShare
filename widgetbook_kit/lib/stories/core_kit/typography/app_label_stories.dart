// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/typography/app_label.dart';
import 'package:core_kit/layout/gap.dart';
import 'package:core_kit/theme/app_spacing.dart';

/// Interactive playground for [AppLabel] widget.
///
/// Allows real-time testing of all component properties.
@widgetbook.UseCase(name: 'Interactive Playground', type: AppLabel)
Widget interactivePlayground(BuildContext context) {
  final variant = context.knobs.object.dropdown(
    label: 'Variant',
    options: ['large', 'medium', 'small'],
    labelBuilder: (value) => value,
  );

  final text = context.knobs.string(label: 'Text', initialValue: 'Submit');

  final uppercase = context.knobs.boolean(
    label: 'Uppercase',
    initialValue: false,
  );

  final colorOption = context.knobs.object.dropdown(
    label: 'Color',
    options: const [
      'default',
      'primary',
      'secondary',
      'error',
      'onPrimaryContainer',
      'onSurfaceVariant',
    ],
    labelBuilder: (value) => value,
  );

  final colorScheme = Theme.of(context).colorScheme;
  final color = switch (colorOption) {
    'primary' => colorScheme.primary,
    'secondary' => colorScheme.secondary,
    'error' => colorScheme.error,
    'onPrimaryContainer' => colorScheme.onPrimaryContainer,
    'onSurfaceVariant' => colorScheme.onSurfaceVariant,
    _ => null, // default uses theme's onSurface
  };

  final fontWeightOption = context.knobs.object.dropdown(
    label: 'Font Weight',
    options: const ['regular', 'medium', 'bold'],
    labelBuilder: (value) => value,
  );

  final fontWeight = switch (fontWeightOption) {
    'bold' => FontWeight.bold,
    'medium' => FontWeight.w500,
    _ => FontWeight.normal,
  };

  final textAlign = context.knobs.object.dropdown(
    label: 'Text Align',
    options: const ['left', 'center', 'right'],
    labelBuilder: (value) => value,
  );

  final maxLinesEnabled = context.knobs.boolean(
    label: 'Max Lines Enabled',
    initialValue: false,
  );

  final maxLines = maxLinesEnabled
      ? context.knobs.int.slider(
          label: 'Max Lines',
          initialValue: 1,
          min: 1,
          max: 3,
        )
      : null;

  final overflow = maxLinesEnabled
      ? context.knobs.object.dropdown(
          label: 'Overflow',
          options: const ['clip', 'ellipsis'],
          labelBuilder: (value) => value,
        )
      : 'clip';

  final alignment = switch (textAlign) {
    'center' => TextAlign.center,
    'right' => TextAlign.right,
    _ => TextAlign.left,
  };

  final overflowValue = switch (overflow) {
    'ellipsis' => TextOverflow.ellipsis,
    _ => TextOverflow.clip,
  };

  final widget = switch (variant) {
    'large' => AppLabel.large(
      text,
      color: color,
      fontWeight: fontWeight,
      textAlign: alignment,
      maxLines: maxLines,
      overflow: overflowValue,
      uppercase: uppercase,
    ),
    'small' => AppLabel.small(
      text,
      color: color,
      fontWeight: fontWeight,
      textAlign: alignment,
      maxLines: maxLines,
      overflow: overflowValue,
      uppercase: uppercase,
    ),
    _ => AppLabel.medium(
      text,
      color: color,
      fontWeight: fontWeight,
      textAlign: alignment,
      maxLines: maxLines,
      overflow: overflowValue,
      uppercase: uppercase,
    ),
  };

  return Center(
    child: Padding(padding: const EdgeInsets.all(AppSpacing.md), child: widget),
  );
}

/// Default label variant (medium).
@widgetbook.UseCase(name: 'Default (Medium)', type: AppLabel)
Widget defaultLabel(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: AppLabel('Submit'),
    ),
  );
}

/// All three label variants displayed together.
@widgetbook.UseCase(name: 'All Variants', type: AppLabel)
Widget allVariants(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabel.large('Large Label (14sp)'),
          VGap.md(),
          AppLabel.medium('Medium Label (12sp)'),
          VGap.md(),
          AppLabel.small('Small Label (11sp)'),
        ],
      ),
    ),
  );
}

/// Button label examples showing typical button text usage.
@widgetbook.UseCase(name: 'Button Labels', type: AppLabel)
Widget buttonLabels(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const AppLabel.large('Continue'),
          ),
          const VGap.md(),
          FilledButton(onPressed: () {}, child: const AppLabel.large('Submit')),
          const VGap.md(),
          OutlinedButton(
            onPressed: () {},
            child: const AppLabel.large('Cancel'),
          ),
          const VGap.md(),
          TextButton(
            onPressed: () {},
            child: AppLabel.large('Delete', color: colorScheme.error),
          ),
        ],
      ),
    ),
  );
}

/// Tab label examples showing typical tab text usage.
@widgetbook.UseCase(name: 'Tab Labels', type: AppLabel)
Widget tabLabels(BuildContext context) {
  return DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        bottom: const TabBar(
          tabs: [
            Tab(child: AppLabel.medium('Home')),
            Tab(child: AppLabel.medium('Profile')),
            Tab(child: AppLabel.medium('Settings')),
          ],
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: AppLabel('Swipe between tabs to see label styles'),
        ),
      ),
    ),
  );
}

/// Chip label examples showing typical chip text usage.
@widgetbook.UseCase(name: 'Chip Labels', type: AppLabel)
Widget chipLabels(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Wrap(
        spacing: AppSpacing.sm,
        runSpacing: AppSpacing.sm,
        children: [
          Chip(
            label: const AppLabel.small('New'),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          Chip(
            label: const AppLabel.small('Featured'),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
          Chip(
            label: const AppLabel.small('Sale'),
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
          ),
          InputChip(
            label: const AppLabel.small('Technology'),
            onPressed: () {},
          ),
          FilterChip(
            label: const AppLabel.small('Design'),
            selected: false,
            onSelected: (value) {},
          ),
        ],
      ),
    ),
  );
}

/// Form field label examples.
@widgetbook.UseCase(name: 'Form Field Labels', type: AppLabel)
Widget formFieldLabels(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabel.medium('Email Address'),
          VGap.xs(),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your email',
              border: OutlineInputBorder(),
            ),
          ),
          VGap.md(),
          AppLabel.medium('Password'),
          VGap.xs(),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Uppercase vs normal case comparison.
@widgetbook.UseCase(name: 'Uppercase Transformation', type: AppLabel)
Widget uppercaseComparison(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppLabel.large('Normal case button'),
          VGap.md(),
          AppLabel.large('Uppercase button', uppercase: true),
          VGap.lg(),
          FilledButton(onPressed: null, child: AppLabel.large('Continue')),
          VGap.md(),
          FilledButton(
            onPressed: null,
            child: AppLabel.large('Continue', uppercase: true),
          ),
        ],
      ),
    ),
  );
}

/// Label with semantic colors from Material Design 3.
@widgetbook.UseCase(name: 'Semantic Colors', type: AppLabel)
Widget semanticColors(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabel.large('Default color (uses theme)'),
          const VGap.md(),
          AppLabel.large('Primary color', color: colorScheme.primary),
          const VGap.md(),
          AppLabel.large('Secondary color', color: colorScheme.secondary),
          const VGap.md(),
          AppLabel.large('Error color', color: colorScheme.error),
          const VGap.md(),
          AppLabel.large(
            'On primary container',
            color: colorScheme.onPrimaryContainer,
          ),
        ],
      ),
    ),
  );
}

/// Label with different font weight variations.
@widgetbook.UseCase(name: 'Font Weight Variations', type: AppLabel)
Widget weightVariations(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppLabel.large('Regular weight (400)', fontWeight: FontWeight.normal),
          VGap.md(),
          AppLabel.large(
            'Medium weight (500 - default)',
            fontWeight: FontWeight.w500,
          ),
          VGap.md(),
          AppLabel.large('Bold weight (700)', fontWeight: FontWeight.bold),
        ],
      ),
    ),
  );
}

/// Label with text overflow handling.
@widgetbook.UseCase(name: 'Text Overflow', type: AppLabel)
Widget textOverflow(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: SizedBox(
        width: 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppLabel(
              'Very long label text that will overflow',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            VGap.md(),
            AppLabel(
              'Very long label text that will clip',
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
    ),
  );
}
