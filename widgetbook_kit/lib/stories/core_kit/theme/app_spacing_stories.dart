// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Spacing Scale', type: AppSpacing)
Widget spacingScale(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(24.0),
    children: [
      _SpacingItem(name: 'xs', value: AppSpacing.xs),
      _SpacingItem(name: 'sm', value: AppSpacing.sm),
      _SpacingItem(name: 'md', value: AppSpacing.md),
      _SpacingItem(name: 'lg', value: AppSpacing.lg),
      _SpacingItem(name: 'xl', value: AppSpacing.xl),
      _SpacingItem(name: 'xxl', value: AppSpacing.xxl),
      _SpacingItem(name: 'xxxl', value: AppSpacing.xxxl),
    ],
  );
}

@widgetbook.UseCase(name: 'Padding Helpers', type: AppSpacing)
Widget paddingHelpers(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.all(24.0),
    children: [
      _PaddingItem(
        name: 'edgeInsetsAllSm (8.0)',
        padding: AppSpacing.edgeInsetsAllSm,
      ),
      const SizedBox(height: 16),
      _PaddingItem(
        name: 'edgeInsetsHMd (Horizontal 16.0)',
        padding: AppSpacing.edgeInsetsHMd,
      ),
      const SizedBox(height: 16),
      _PaddingItem(
        name: 'edgeInsetsVLg (Vertical 24.0)',
        padding: AppSpacing.edgeInsetsVLg,
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'SizedBox Helpers', type: AppSpacing)
Widget sizedBoxHelpers(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Items separated by verticalMd (16.0)'),
        Container(height: 50, color: Colors.blue.withOpacity(0.2)),
        AppSpacing.verticalMd,
        Container(height: 50, color: Colors.blue.withOpacity(0.2)),
        AppSpacing.verticalMd,
        Container(height: 50, color: Colors.blue.withOpacity(0.2)),
        const SizedBox(height: 32),
        const Text('Items separated by horizontalMd (16.0)'),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              color: Colors.red.withOpacity(0.2),
            ),
            AppSpacing.horizontalMd,
            Container(
              width: 50,
              height: 50,
              color: Colors.red.withOpacity(0.2),
            ),
            AppSpacing.horizontalMd,
            Container(
              width: 50,
              height: 50,
              color: Colors.red.withOpacity(0.2),
            ),
          ],
        ),
      ],
    ),
  );
}

class _SpacingItem extends StatelessWidget {
  const _SpacingItem({required this.name, required this.value});

  final String name;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: value,
            height: value,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 16),
          Text(
            '$name (${value.toStringAsFixed(1)})',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _PaddingItem extends StatelessWidget {
  const _PaddingItem({required this.name, required this.padding});

  final String name;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Container(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Container(
            margin: padding,
            height: 50,
            color: Theme.of(context).colorScheme.primary,
            child: const Center(
              child: Text('Content', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}

@widgetbook.UseCase(name: 'Interactive Playground', type: AppSpacing)
Widget interactivePlayground(BuildContext context) {
  final spacing = context.knobs.list<double>(
    label: 'Spacing Size',
    options: [
      AppSpacing.xs,
      AppSpacing.sm,
      AppSpacing.md,
      AppSpacing.lg,
      AppSpacing.xl,
      AppSpacing.xxl,
      AppSpacing.xxxl,
    ],
    initialOption: AppSpacing.md,
    labelBuilder: (value) {
      if (value == AppSpacing.xs) return 'xs (4.0)';
      if (value == AppSpacing.sm) return 'sm (8.0)';
      if (value == AppSpacing.md) return 'md (16.0)';
      if (value == AppSpacing.lg) return 'lg (24.0)';
      if (value == AppSpacing.xl) return 'xl (32.0)';
      if (value == AppSpacing.xxl) return 'xxl (48.0)';
      if (value == AppSpacing.xxxl) return 'xxxl (64.0)';
      return value.toString();
    },
  );

  final isHorizontal = context.knobs.boolean(
    label: 'Horizontal Layout',
    initialValue: false,
  );

  return Center(
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: isHorizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Box(color: Colors.blue),
                SizedBox(width: spacing),
                _Box(color: Colors.red),
                SizedBox(width: spacing),
                _Box(color: Colors.green),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Box(color: Colors.blue),
                SizedBox(height: spacing),
                _Box(color: Colors.red),
                SizedBox(height: spacing),
                _Box(color: Colors.green),
              ],
            ),
    ),
  );
}

class _Box extends StatelessWidget {
  const _Box({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
