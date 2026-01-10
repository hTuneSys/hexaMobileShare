// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/typography/app_body_text.dart';
import 'package:core_kit/layout/gap.dart';
import 'package:core_kit/theme/app_spacing.dart';

/// Default body text variant (medium).
@widgetbook.UseCase(name: 'Default (Medium)', type: AppBodyText)
Widget defaultBodyText(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: AppBodyText(
        'This is default body text. It uses the medium variant with 14sp font size.',
      ),
    ),
  );
}

/// All three body text variants displayed together.
@widgetbook.UseCase(name: 'Variants', type: AppBodyText)
Widget allVariants(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBodyText.large(
            'Large: 16sp font size. Perfect for primary content.',
          ),
          VGap.md(),
          AppBodyText.medium(
            'Medium: 14sp font size (default). Great for standard content.',
          ),
          VGap.md(),
          AppBodyText.small(
            'Small: 12sp font size. Ideal for tertiary content or footnotes.',
          ),
        ],
      ),
    ),
  );
}

/// Body text with semantic colors from Material Design 3.
@widgetbook.UseCase(name: 'Color Overrides', type: AppBodyText)
Widget semanticColors(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBodyText(
            'Default: onSurface color (uses theme default).',
            color: colorScheme.onSurface,
          ),
          const VGap.md(),
          AppBodyText(
            'Primary: for emphasized content.',
            color: colorScheme.primary,
          ),
          const VGap.md(),
          AppBodyText(
            'Secondary: for secondary content.',
            color: colorScheme.secondary,
          ),
          const VGap.md(),
          AppBodyText(
            'Error: for error messages or warnings.',
            color: colorScheme.error,
          ),
          const VGap.md(),
          AppBodyText(
            'OnSurfaceVariant: for subtle or de-emphasized text.',
            color: colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    ),
  );
}

/// Body text with different font weight variations.
@widgetbook.UseCase(name: 'Weight Variations', type: AppBodyText)
Widget boldWeight(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBodyText('Regular weight body text (400).'),
          VGap.md(),
          AppBodyText(
            'Bold weight body text (700).',
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    ),
  );
}

/// Body text with overflow handling strategies.
@widgetbook.UseCase(name: 'Text Overflow', type: AppBodyText)
Widget overflowHandling(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBodyText(
              'This is a very long body text that will overflow and show ellipsis at the end.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            VGap.md(),
            AppBodyText(
              'This is a very long body text that will overflow and clip at the end.',
              maxLines: 2,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
    ),
  );
}

/// Body text with different text alignments.
@widgetbook.UseCase(name: 'Text Alignment', type: AppBodyText)
Widget textAlignment(BuildContext context) {
  const longText =
      'This is a longer text that demonstrates text alignment. '
      'It contains multiple sentences to show how the alignment works with '
      'wrapped text across several lines.';

  return const Center(
    child: Padding(
      padding: EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBodyText(longText, textAlign: TextAlign.left),
          VGap.md(),
          AppBodyText(longText, textAlign: TextAlign.center),
          VGap.md(),
          AppBodyText(longText, textAlign: TextAlign.right),
        ],
      ),
    ),
  );
}

/// Interactive playground for [AppBodyText] widget.
///
/// Allows real-time testing of all component properties.
@widgetbook.UseCase(name: 'Interactive Playground', type: AppBodyText)
Widget interactivePlayground(BuildContext context) {
  final variant = context.knobs.object.dropdown(
    label: 'Variant',
    options: const ['large', 'medium', 'small'],
    labelBuilder: (value) => value,
  );

  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'This is body text for your content.',
  );

  final colorOption = context.knobs.object.dropdown(
    label: 'Color',
    options: const [
      'default',
      'primary',
      'secondary',
      'error',
      'onSurfaceVariant',
    ],
    labelBuilder: (value) => value,
  );

  final colorScheme = Theme.of(context).colorScheme;
  final color = switch (colorOption) {
    'primary' => colorScheme.primary,
    'secondary' => colorScheme.secondary,
    'error' => colorScheme.error,
    'onSurfaceVariant' => colorScheme.onSurfaceVariant,
    _ => null, // default uses theme's onSurface
  };

  final fontWeight = context.knobs.object.dropdown(
    label: 'Font Weight',
    options: const ['regular', 'bold'],
    labelBuilder: (value) => value,
  );

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
          initialValue: 2,
          min: 1,
          max: 5,
        )
      : null;

  final overflow = maxLinesEnabled
      ? context.knobs.object.dropdown(
          label: 'Overflow',
          options: const ['clip', 'ellipsis'],
          labelBuilder: (value) => value,
        )
      : 'clip';

  final weight = fontWeight == 'bold' ? FontWeight.bold : FontWeight.normal;

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
    'medium' => AppBodyText.medium(
      text,
      color: color,
      fontWeight: weight,
      textAlign: alignment,
      maxLines: maxLines,
      overflow: overflowValue,
    ),
    'small' => AppBodyText.small(
      text,
      color: color,
      fontWeight: weight,
      textAlign: alignment,
      maxLines: maxLines,
      overflow: overflowValue,
    ),
    _ => AppBodyText.large(
      text,
      color: color,
      fontWeight: weight,
      textAlign: alignment,
      maxLines: maxLines,
      overflow: overflowValue,
    ),
  };

  return Center(
    child: Padding(padding: const EdgeInsets.all(AppSpacing.md), child: widget),
  );
}
