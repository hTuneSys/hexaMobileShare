// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive Playground', type: AppSpacing)
Widget interactivePlayground(BuildContext context) {
  // ignore: deprecated_member_use
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

  final colorScheme = Theme.of(context).colorScheme;

  return Center(
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outline),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: isHorizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
                SizedBox(width: spacing),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
                SizedBox(width: spacing),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
                SizedBox(height: spacing),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
                SizedBox(height: spacing),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
              ],
            ),
    ),
  );
}

@widgetbook.UseCase(name: 'Spacing Scale', type: AppSpacing)
Widget spacingScale(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return ListView(
    padding: AppSpacing.edgeInsetsAllLg,
    children: [
      _buildSpacingItem(context, 'xs', AppSpacing.xs, colorScheme, textTheme),
      VGap.md(),
      _buildSpacingItem(context, 'sm', AppSpacing.sm, colorScheme, textTheme),
      VGap.md(),
      _buildSpacingItem(context, 'md', AppSpacing.md, colorScheme, textTheme),
      VGap.md(),
      _buildSpacingItem(context, 'lg', AppSpacing.lg, colorScheme, textTheme),
      VGap.md(),
      _buildSpacingItem(context, 'xl', AppSpacing.xl, colorScheme, textTheme),
      VGap.md(),
      _buildSpacingItem(context, 'xxl', AppSpacing.xxl, colorScheme, textTheme),
      VGap.md(),
      _buildSpacingItem(
        context,
        'xxxl',
        AppSpacing.xxxl,
        colorScheme,
        textTheme,
      ),
    ],
  );
}

Widget _buildSpacingItem(
  BuildContext context,
  String name,
  double value,
  ColorScheme colorScheme,
  TextTheme textTheme,
) {
  return Row(
    children: [
      Container(width: value, height: value, color: colorScheme.primary),
      HGap.md(),
      Text('$name (${value.toStringAsFixed(1)})', style: textTheme.bodyLarge),
    ],
  );
}

@widgetbook.UseCase(name: 'Padding Helpers', type: AppSpacing)
Widget paddingHelpers(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return ListView(
    padding: AppSpacing.edgeInsetsAllLg,
    children: [
      _buildPaddingItem(
        context,
        'edgeInsetsAllSm (8.0)',
        AppSpacing.edgeInsetsAllSm,
        colorScheme,
        textTheme,
      ),
      VGap.md(),
      _buildPaddingItem(
        context,
        'edgeInsetsHMd (Horizontal 16.0)',
        AppSpacing.edgeInsetsHMd,
        colorScheme,
        textTheme,
      ),
      VGap.md(),
      _buildPaddingItem(
        context,
        'edgeInsetsVLg (Vertical 24.0)',
        AppSpacing.edgeInsetsVLg,
        colorScheme,
        textTheme,
      ),
    ],
  );
}

Widget _buildPaddingItem(
  BuildContext context,
  String name,
  EdgeInsets padding,
  ColorScheme colorScheme,
  TextTheme textTheme,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(name, style: textTheme.bodyMedium),
      VGap.sm(),
      Container(
        color: colorScheme.surfaceContainerHighest,
        child: Container(
          margin: padding,
          height: 50,
          color: colorScheme.primary,
          child: Center(
            child: Text(
              'Content',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Gap Widgets Demo', type: AppSpacing)
Widget gapWidgetsDemo(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return Padding(
    padding: AppSpacing.edgeInsetsAllLg,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Items separated by VGap.md() (16.0)',
          style: textTheme.titleMedium,
        ),
        VGap.sm(),
        Container(height: 50, color: colorScheme.primaryContainer),
        VGap.md(),
        Container(height: 50, color: colorScheme.primaryContainer),
        VGap.md(),
        Container(height: 50, color: colorScheme.primaryContainer),
        VGap.xl(),
        Text(
          'Items separated by HGap.md() (16.0)',
          style: textTheme.titleMedium,
        ),
        VGap.sm(),
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              color: colorScheme.secondaryContainer,
            ),
            HGap.md(),
            Container(
              width: 50,
              height: 50,
              color: colorScheme.secondaryContainer,
            ),
            HGap.md(),
            Container(
              width: 50,
              height: 50,
              color: colorScheme.secondaryContainer,
            ),
          ],
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Common Patterns', type: AppSpacing)
Widget commonPatterns(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return ListView(
    padding: AppSpacing.edgeInsetsAllLg,
    children: [
      // Card Padding Pattern
      Text('Card Padding Pattern', style: textTheme.titleLarge),
      VGap.sm(),
      Container(
        padding: AppSpacing.edgeInsetsAllMd,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Card Title', style: textTheme.titleMedium),
            VGap.sm(),
            Text(
              'Card content with 16dp padding on all sides',
              style: textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      VGap.xl(),

      // List Item Spacing Pattern
      Text('List Item Spacing Pattern', style: textTheme.titleLarge),
      VGap.sm(),
      Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          children: [
            Container(
              padding: AppSpacing.edgeInsetsAllMd,
              child: Text('List Item 1', style: textTheme.bodyMedium),
            ),
            Divider(height: 1, color: colorScheme.outlineVariant),
            Container(
              padding: AppSpacing.edgeInsetsAllMd,
              child: Text('List Item 2', style: textTheme.bodyMedium),
            ),
            Divider(height: 1, color: colorScheme.outlineVariant),
            Container(
              padding: AppSpacing.edgeInsetsAllMd,
              child: Text('List Item 3', style: textTheme.bodyMedium),
            ),
          ],
        ),
      ),
      VGap.xl(),

      // Form Field Gaps Pattern
      Text('Form Field Gaps Pattern', style: textTheme.titleLarge),
      VGap.sm(),
      Container(
        padding: AppSpacing.edgeInsetsAllMd,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Field 1', style: textTheme.bodyMedium),
            Container(height: 40, color: colorScheme.surfaceContainerHighest),
            VGap.md(),
            Text('Field 2', style: textTheme.bodyMedium),
            Container(height: 40, color: colorScheme.surfaceContainerHighest),
            VGap.md(),
            Text('Field 3', style: textTheme.bodyMedium),
            Container(height: 40, color: colorScheme.surfaceContainerHighest),
          ],
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Responsive Spacing', type: AppSpacing)
Widget responsiveSpacing(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  // Demonstrate responsive spacing
  final responsiveSpacing = AppSpacing.responsive(context, AppSpacing.md);
  final screenWidth = MediaQuery.of(context).size.width;

  String deviceType;
  if (screenWidth < 600) {
    deviceType = 'Mobile';
  } else if (screenWidth < 840) {
    deviceType = 'Tablet';
  } else {
    deviceType = 'Desktop';
  }

  return Center(
    child: Container(
      padding: AppSpacing.edgeInsetsAllLg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Responsive Spacing Demo', style: textTheme.titleLarge),
          VGap.md(),
          Text('Device: $deviceType', style: textTheme.bodyLarge),
          VGap.sm(),
          Text(
            'Screen Width: ${screenWidth.toStringAsFixed(0)}dp',
            style: textTheme.bodyMedium,
          ),
          VGap.sm(),
          Text(
            'Base Spacing (md): ${AppSpacing.md}dp',
            style: textTheme.bodyMedium,
          ),
          VGap.sm(),
          Text(
            'Responsive Spacing: ${responsiveSpacing.toStringAsFixed(0)}dp',
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          VGap.xl(),
          Container(
            padding: EdgeInsets.all(responsiveSpacing),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Text(
              'This box uses responsive padding',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Edge Cases', type: AppSpacing)
Widget edgeCases(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  return ListView(
    padding: AppSpacing.edgeInsetsAllLg,
    children: [
      Text('Minimum Spacing (xs - 4dp)', style: textTheme.titleMedium),
      VGap.xs(),
      Container(
        height: 40,
        color: colorScheme.primaryContainer,
        child: Center(
          child: Text('Tightly spaced content', style: textTheme.bodyMedium),
        ),
      ),
      VGap.xs(),
      Container(
        height: 40,
        color: colorScheme.primaryContainer,
        child: Center(
          child: Text('Tightly spaced content', style: textTheme.bodyMedium),
        ),
      ),
      VGap.xl(),
      Text('Maximum Spacing (xxxl - 64dp)', style: textTheme.titleMedium),
      const SizedBox(height: AppSpacing.xxxl),
      Container(
        height: 40,
        color: colorScheme.secondaryContainer,
        child: Center(
          child: Text('Widely spaced content', style: textTheme.bodyMedium),
        ),
      ),
      const SizedBox(height: AppSpacing.xxxl),
      Container(
        height: 40,
        color: colorScheme.secondaryContainer,
        child: Center(
          child: Text('Widely spaced content', style: textTheme.bodyMedium),
        ),
      ),
      VGap.xl(),
      Text('Mixed Spacing Pattern', style: textTheme.titleMedium),
      VGap.xs(),
      Container(height: 30, color: colorScheme.tertiaryContainer),
      VGap.sm(),
      Container(height: 30, color: colorScheme.tertiaryContainer),
      VGap.md(),
      Container(height: 30, color: colorScheme.tertiaryContainer),
      VGap.lg(),
      Container(height: 30, color: colorScheme.tertiaryContainer),
    ],
  );
}
