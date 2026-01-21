// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppRadius] theme component.
///
/// Demonstrates Material Design 3 radius values, partial radius helpers,
/// shape helpers, and common component patterns.

// ========================================================================
// Interactive Playground
// ========================================================================

@widgetbook.UseCase(name: 'Interactive Playground', type: AppRadius)
Widget appRadiusPlayground(BuildContext context) {
  final radiusSize = context.knobs.list(
    label: 'Radius Size',
    options: ['none', 'xs', 'sm', 'md', 'lg', 'xl', 'full'],
    initialOption: 'md',
  );

  final radiusType = context.knobs.list(
    label: 'Radius Type',
    options: [
      'all',
      'top',
      'bottom',
      'left',
      'right',
      'topLeft',
      'topRight',
      'bottomLeft',
      'bottomRight',
    ],
    initialOption: 'all',
  );

  final shapeType = context.knobs.list(
    label: 'Shape Type',
    options: ['rounded', 'continuous', 'stadium', 'circle'],
    initialOption: 'rounded',
  );

  final showAsShape = context.knobs.boolean(
    label: 'Show as Material Shape',
    initialValue: false,
  );

  // Map radius size to value
  final radiusValue = switch (radiusSize) {
    'none' => AppRadius.none,
    'xs' => AppRadius.xs,
    'sm' => AppRadius.sm,
    'md' => AppRadius.md,
    'lg' => AppRadius.lg,
    'xl' => AppRadius.xl,
    'full' => AppRadius.full,
    _ => AppRadius.md,
  };

  // Map radius type to BorderRadius
  BorderRadius getBorderRadius() {
    return switch (radiusType) {
      'all' => switch (radiusSize) {
        'none' => AppRadius.noneRadius,
        'xs' => AppRadius.xsRadius,
        'sm' => AppRadius.smRadius,
        'md' => AppRadius.mdRadius,
        'lg' => AppRadius.lgRadius,
        'xl' => AppRadius.xlRadius,
        'full' => AppRadius.fullRadius,
        _ => AppRadius.mdRadius,
      },
      'top' => switch (radiusSize) {
        'xs' => AppRadius.topXs,
        'sm' => AppRadius.topSm,
        'md' => AppRadius.topMd,
        'lg' => AppRadius.topLg,
        'xl' => AppRadius.topXl,
        _ => AppRadius.topMd,
      },
      'bottom' => switch (radiusSize) {
        'xs' => AppRadius.bottomXs,
        'sm' => AppRadius.bottomSm,
        'md' => AppRadius.bottomMd,
        'lg' => AppRadius.bottomLg,
        'xl' => AppRadius.bottomXl,
        _ => AppRadius.bottomMd,
      },
      'left' => switch (radiusSize) {
        'xs' => AppRadius.leftXs,
        'sm' => AppRadius.leftSm,
        'md' => AppRadius.leftMd,
        'lg' => AppRadius.leftLg,
        'xl' => AppRadius.leftXl,
        _ => AppRadius.leftMd,
      },
      'right' => switch (radiusSize) {
        'xs' => AppRadius.rightXs,
        'sm' => AppRadius.rightSm,
        'md' => AppRadius.rightMd,
        'lg' => AppRadius.rightLg,
        'xl' => AppRadius.rightXl,
        _ => AppRadius.rightMd,
      },
      'topLeft' => AppRadius.onlyTopLeft(radiusValue),
      'topRight' => AppRadius.onlyTopRight(radiusValue),
      'bottomLeft' => AppRadius.onlyBottomLeft(radiusValue),
      'bottomRight' => AppRadius.onlyBottomRight(radiusValue),
      _ => AppRadius.mdRadius,
    };
  }

  // Get OutlinedBorder based on type
  OutlinedBorder getShape() {
    if (shapeType == 'stadium') return AppRadius.stadium;
    if (shapeType == 'circle') return AppRadius.circular;

    final borderRadius = getBorderRadius();

    if (shapeType == 'continuous') {
      return ContinuousRectangleBorder(borderRadius: borderRadius);
    }

    return RoundedRectangleBorder(borderRadius: borderRadius);
  }

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Radius: ${radiusValue}dp',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Type: $radiusType',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        if (!showAsShape)
          Container(
            width: 200,
            height: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: getBorderRadius(),
            ),
            alignment: Alignment.center,
            child: Text(
              radiusType.toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          )
        else
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: getShape(),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: () {},
            child: const Text('Material Shape'),
          ),
      ],
    ),
  );
}

// ========================================================================
// Radius Scale - All Values
// ========================================================================

@widgetbook.UseCase(name: 'Radius Scale', type: AppRadius)
Widget appRadiusScale(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Material Design 3 Radius Scale',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Standardized radius values from none (0dp) to full (pill shape)',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        _RadiusExample(
          label: 'None (0dp)',
          radius: AppRadius.noneRadius,
          description: 'Sharp corners, no rounding',
        ),
        _RadiusExample(
          label: 'XS (4dp)',
          radius: AppRadius.xsRadius,
          description: 'Subtle rounding for text fields',
        ),
        _RadiusExample(
          label: 'SM (8dp)',
          radius: AppRadius.smRadius,
          description: 'Light rounding for small buttons',
        ),
        _RadiusExample(
          label: 'MD (12dp)',
          radius: AppRadius.mdRadius,
          description: 'Standard rounding for cards (M3 default)',
        ),
        _RadiusExample(
          label: 'LG (16dp)',
          radius: AppRadius.lgRadius,
          description: 'Prominent rounding for large surfaces',
        ),
        _RadiusExample(
          label: 'XL (28dp)',
          radius: AppRadius.xlRadius,
          description: 'Extra large for dialogs and sheets',
        ),
        _RadiusExample(
          label: 'Full (9999dp)',
          radius: AppRadius.fullRadius,
          description: 'Pill/capsule shape for buttons',
        ),
      ],
    ),
  );
}

// ========================================================================
// Partial Radius Examples
// ========================================================================

@widgetbook.UseCase(name: 'Top Radius Only', type: AppRadius)
Widget appRadiusTopOnly(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Corners Only',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Common for bottom sheets and modals',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _PartialRadiusExample(label: 'Top XS', radius: AppRadius.topXs),
          _PartialRadiusExample(label: 'Top SM', radius: AppRadius.topSm),
          _PartialRadiusExample(label: 'Top MD', radius: AppRadius.topMd),
          _PartialRadiusExample(label: 'Top LG', radius: AppRadius.topLg),
          _PartialRadiusExample(
            label: 'Top XL (Bottom Sheets)',
            radius: AppRadius.topXl,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Bottom Radius Only', type: AppRadius)
Widget appRadiusBottomOnly(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bottom Corners Only',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Common for top app bars and headers',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _PartialRadiusExample(label: 'Bottom XS', radius: AppRadius.bottomXs),
          _PartialRadiusExample(label: 'Bottom SM', radius: AppRadius.bottomSm),
          _PartialRadiusExample(label: 'Bottom MD', radius: AppRadius.bottomMd),
          _PartialRadiusExample(label: 'Bottom LG', radius: AppRadius.bottomLg),
          _PartialRadiusExample(label: 'Bottom XL', radius: AppRadius.bottomXl),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Left/Right Radius', type: AppRadius)
Widget appRadiusLeftRight(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Left/Right Corners Only',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Common for drawers, side panels, and horizontal scrollers',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _PartialRadiusExample(label: 'Left XS', radius: AppRadius.leftXs),
          _PartialRadiusExample(label: 'Left SM', radius: AppRadius.leftSm),
          _PartialRadiusExample(label: 'Left MD', radius: AppRadius.leftMd),
          _PartialRadiusExample(label: 'Left LG', radius: AppRadius.leftLg),
          _PartialRadiusExample(label: 'Left XL', radius: AppRadius.leftXl),
          const SizedBox(height: 16),
          _PartialRadiusExample(label: 'Right XS', radius: AppRadius.rightXs),
          _PartialRadiusExample(label: 'Right SM', radius: AppRadius.rightSm),
          _PartialRadiusExample(label: 'Right MD', radius: AppRadius.rightMd),
          _PartialRadiusExample(label: 'Right LG', radius: AppRadius.rightLg),
          _PartialRadiusExample(label: 'Right XL', radius: AppRadius.rightXl),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Corners', type: AppRadius)
Widget appRadiusCustomCorners(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Single Corner Radius',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Apply radius to individual corners',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _PartialRadiusExample(
            label: 'Top Left Only',
            radius: AppRadius.onlyTopLeft(AppRadius.xl),
          ),
          _PartialRadiusExample(
            label: 'Top Right Only',
            radius: AppRadius.onlyTopRight(AppRadius.xl),
          ),
          _PartialRadiusExample(
            label: 'Bottom Left Only',
            radius: AppRadius.onlyBottomLeft(AppRadius.xl),
          ),
          _PartialRadiusExample(
            label: 'Bottom Right Only',
            radius: AppRadius.onlyBottomRight(AppRadius.xl),
          ),
        ],
      ),
    ),
  );
}

// ========================================================================
// Common Component Shapes
// ========================================================================

@widgetbook.UseCase(name: 'Component Patterns', type: AppRadius)
Widget appRadiusComponentPatterns(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Common Material Design 3 Patterns',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),

        // Cards
        Text(
          'Card (MD - 12dp)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Card(
          shape: AppRadius.mdShape,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Cards use medium radius per Material Design 3'),
          ),
        ),
        const SizedBox(height: 24),

        // Buttons
        Text(
          'Button (Full - Pill Shape)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(shape: AppRadius.fullShape),
          onPressed: () {},
          child: const Text('Material 3 Filled Button'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          style: OutlinedButton.styleFrom(shape: AppRadius.fullShape),
          onPressed: () {},
          child: const Text('Material 3 Outlined Button'),
        ),
        const SizedBox(height: 24),

        // Stadium Shape
        Text(
          'Stadium Border (Pill)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(shape: AppRadius.stadium),
          onPressed: () {},
          child: const Text('Pill-Style Button'),
        ),
        const SizedBox(height: 24),

        // Bottom Sheet
        Text(
          'Bottom Sheet (Top XL - 28dp)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: AppRadius.topXl,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text('Bottom sheets use top XL radius'),
        ),
        const SizedBox(height: 24),

        // Dialog
        Text(
          'Dialog (XL - 28dp)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: AppRadius.xlRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dialog Title',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text(
                'Dialogs use extra large radius per Material Design 3',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ========================================================================
// Shape Helpers
// ========================================================================

@widgetbook.UseCase(name: 'Material Shape Helpers', type: AppRadius)
Widget appRadiusShapeHelpers(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'RoundedRectangleBorder Helpers',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Ready-to-use shapes for Material widgets',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        _ShapeExample(label: 'noneShape', shape: AppRadius.noneShape),
        _ShapeExample(label: 'xsShape', shape: AppRadius.xsShape),
        _ShapeExample(label: 'smShape', shape: AppRadius.smShape),
        _ShapeExample(label: 'mdShape', shape: AppRadius.mdShape),
        _ShapeExample(label: 'lgShape', shape: AppRadius.lgShape),
        _ShapeExample(label: 'xlShape', shape: AppRadius.xlShape),
        _ShapeExample(label: 'fullShape (Pill)', shape: AppRadius.fullShape),
        const SizedBox(height: 24),

        Text('Circular Shape', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {},
          shape: AppRadius.circular,
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 24),

        Text('Stadium Shape', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.send),
          label: const Text('Send Message'),
          style: ElevatedButton.styleFrom(shape: AppRadius.stadium),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Continuous Curves', type: AppRadius)
Widget appRadiusContinuousCurves(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Continuous Curve Shapes (Material Design 3)',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Smoother, more premium curves compared to standard circular curves',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),

        // Comparison: Rounded vs Continuous
        Text(
          'Comparison: Standard vs Continuous',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Card(
                shape: AppRadius.mdShape,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Standard',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Text('Circular curve'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Card(
                shape: AppRadius.continuousMd,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Continuous',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const Text('Smoother curve'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // All continuous shapes
        _ContinuousShapeExample(
          label: 'continuousNone',
          shape: AppRadius.continuousNone,
        ),
        _ContinuousShapeExample(
          label: 'continuousXs',
          shape: AppRadius.continuousXs,
        ),
        _ContinuousShapeExample(
          label: 'continuousSm',
          shape: AppRadius.continuousSm,
        ),
        _ContinuousShapeExample(
          label: 'continuousMd',
          shape: AppRadius.continuousMd,
        ),
        _ContinuousShapeExample(
          label: 'continuousLg',
          shape: AppRadius.continuousLg,
        ),
        _ContinuousShapeExample(
          label: 'continuousXl',
          shape: AppRadius.continuousXl,
        ),
        _ContinuousShapeExample(
          label: 'continuousFull',
          shape: AppRadius.continuousFull,
        ),
      ],
    ),
  );
}

// ========================================================================
// Helper Widgets
// ========================================================================

class _RadiusExample extends StatelessWidget {
  const _RadiusExample({
    required this.label,
    required this.radius,
    required this.description,
  });

  final String label;
  final BorderRadius radius;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: radius,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.titleSmall),
                Text(description, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PartialRadiusExample extends StatelessWidget {
  const _PartialRadiusExample({required this.label, required this.radius});

  final String label;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: radius,
            ),
            alignment: Alignment.center,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
        ],
      ),
    );
  }
}

class _ShapeExample extends StatelessWidget {
  const _ShapeExample({required this.label, required this.shape});

  final String label;
  final OutlinedBorder shape;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: shape,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        onPressed: () {},
        child: Text(label),
      ),
    );
  }
}

class _ContinuousShapeExample extends StatelessWidget {
  const _ContinuousShapeExample({required this.label, required this.shape});

  final String label;
  final OutlinedBorder shape;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Card(
        shape: shape,
        child: Padding(padding: const EdgeInsets.all(16), child: Text(label)),
      ),
    );
  }
}
