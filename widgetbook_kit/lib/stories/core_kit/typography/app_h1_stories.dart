// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Expose ALL AppH1 properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppH1)
Widget appH1Playground(BuildContext context) {
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Main Heading',
  );

  final colorOption = context.knobs.object.dropdown(
    label: 'Color',
    options: ['Default', 'Primary', 'Secondary', 'Error', 'Custom Blue'],
    labelBuilder: (value) => value,
  );

  final fontWeightOption = context.knobs.object.dropdown(
    label: 'Font Weight',
    options: ['Default', 'Normal (400)', 'Medium (500)', 'Bold (700)'],
    labelBuilder: (value) => value,
  );

  final textAlignOption = context.knobs.object.dropdown(
    label: 'Text Align',
    options: ['Default', 'Left', 'Center', 'Right', 'Justify'],
    labelBuilder: (value) => value,
  );

  final maxLines = context.knobs.intOrNull.slider(
    label: 'Max Lines',
    initialValue: null,
    min: 1,
    max: 5,
  );

  final overflowOption = context.knobs.object.dropdown(
    label: 'Overflow',
    options: ['Default', 'Clip', 'Fade', 'Ellipsis'],
    labelBuilder: (value) => value,
  );

  // Map string selections to actual values
  final Color? color = switch (colorOption) {
    'Primary' => Theme.of(context).colorScheme.primary,
    'Secondary' => Theme.of(context).colorScheme.secondary,
    'Error' => Theme.of(context).colorScheme.error,
    'Custom Blue' => Colors.blue,
    _ => null,
  };

  final FontWeight? fontWeight = switch (fontWeightOption) {
    'Normal (400)' => FontWeight.w400,
    'Medium (500)' => FontWeight.w500,
    'Bold (700)' => FontWeight.w700,
    _ => null,
  };

  final TextAlign? textAlign = switch (textAlignOption) {
    'Left' => TextAlign.left,
    'Center' => TextAlign.center,
    'Right' => TextAlign.right,
    'Justify' => TextAlign.justify,
    _ => null,
  };

  final TextOverflow? overflow = switch (overflowOption) {
    'Clip' => TextOverflow.clip,
    'Fade' => TextOverflow.fade,
    'Ellipsis' => TextOverflow.ellipsis,
    _ => null,
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppH1(
        text,
        color: color,
        fontWeight: fontWeight,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    ),
  );
}

/// Default H1 - Simple usage with default styling
@widgetbook.UseCase(name: 'Default H1', type: AppH1)
Widget appH1Default(BuildContext context) {
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Welcome to the App',
  );

  return Center(
    child: Padding(padding: const EdgeInsets.all(16.0), child: AppH1(text)),
  );
}

/// Heading Levels Comparison - Show H1, H2, H3 visual hierarchy
@widgetbook.UseCase(name: 'Heading Levels Comparison', type: AppH1)
Widget appH1Comparison(BuildContext context) {
  final headingLevel = context.knobs.object.dropdown(
    label: 'Heading Level',
    options: ['H1', 'H2', 'H3'],
    labelBuilder: (value) => value,
  );

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headingLevel == 'H1') const AppH1('Heading Level 1 (H1)'),
        if (headingLevel == 'H2') const AppH2('Heading Level 2 (H2)'),
        if (headingLevel == 'H3') const AppH3('Heading Level 3 (H3)'),
        const SizedBox(height: 24),
        const Text(
          'Use the knob above to switch between heading levels and see the visual hierarchy. '
          'H1 is the largest and most prominent, followed by H2 and H3.',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
        ),
      ],
    ),
  );
}

/// Color Variants - Different color options
@widgetbook.UseCase(name: 'Color Variants', type: AppH1)
Widget appH1Colors(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  final colorOption = context.knobs.object.dropdown(
    label: 'Color',
    options: ['Default', 'Primary', 'Secondary', 'Error', 'Custom Teal'],
    labelBuilder: (value) => value,
  );

  final Color? color = switch (colorOption) {
    'Primary' => colorScheme.primary,
    'Secondary' => colorScheme.secondary,
    'Error' => colorScheme.error,
    'Custom Teal' => Colors.teal,
    _ => null,
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppH1('Colored Heading', color: color),
    ),
  );
}

/// Alignment Options - Left, center, right alignment
@widgetbook.UseCase(name: 'Alignment Options', type: AppH1)
Widget appH1Alignment(BuildContext context) {
  final alignmentOption = context.knobs.object.dropdown(
    label: 'Text Align',
    options: ['Left', 'Center', 'Right'],
    labelBuilder: (value) => value,
  );

  final TextAlign textAlign = switch (alignmentOption) {
    'Center' => TextAlign.center,
    'Right' => TextAlign.right,
    _ => TextAlign.left,
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppH1('Aligned Heading', textAlign: textAlign),
    ),
  );
}

/// Font Weight Variants - Light, normal, semibold, bold
@widgetbook.UseCase(name: 'Font Weight Variants', type: AppH1)
Widget appH1FontWeights(BuildContext context) {
  final weightOption = context.knobs.object.dropdown(
    label: 'Font Weight',
    options: ['Light (300)', 'Normal (400)', 'SemiBold (600)', 'Bold (700)'],
    labelBuilder: (value) => value,
  );

  final FontWeight fontWeight = switch (weightOption) {
    'Light (300)' => FontWeight.w300,
    'SemiBold (600)' => FontWeight.w600,
    'Bold (700)' => FontWeight.w700,
    _ => FontWeight.w400,
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppH1('Weighted Heading', fontWeight: fontWeight),
    ),
  );
}

/// Real-world Page Title Example
@widgetbook.UseCase(name: 'Page Title Example', type: AppH1)
Widget appH1PageTitle(BuildContext context) {
  final pageTitle = context.knobs.string(
    label: 'Page Title',
    initialValue: 'Dashboard',
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Example Screen')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppH1(pageTitle),
          const SizedBox(height: 8),
          Text(
            'Welcome back! Here\'s your overview.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          const AppH2('Recent Activity'),
          const SizedBox(height: 8),
          const Text('No recent activity to display.'),
        ],
      ),
    ),
  );
}
