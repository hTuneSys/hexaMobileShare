// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Expose ALL AppH3 properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppH3)
Widget appH3Playground(BuildContext context) {
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Subsection Title',
  );

  final colorOption = context.knobs.object.dropdown(
    label: 'Color',
    options: ['Default', 'Primary', 'Secondary', 'Tertiary', 'Custom Orange'],
    labelBuilder: (value) => value,
  );

  final fontWeightOption = context.knobs.object.dropdown(
    label: 'Font Weight',
    options: ['Default', 'Normal (400)', 'Medium (500)', 'Bold (700)'],
    labelBuilder: (value) => value,
  );

  final textAlignOption = context.knobs.object.dropdown(
    label: 'Text Align',
    options: ['Default', 'Left', 'Center', 'Right'],
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

  final Color? color = switch (colorOption) {
    'Primary' => Theme.of(context).colorScheme.primary,
    'Secondary' => Theme.of(context).colorScheme.secondary,
    'Tertiary' => Theme.of(context).colorScheme.tertiary,
    'Custom Orange' => Colors.orange,
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
      child: AppH3(
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

/// Default H3 - Simple usage with default styling
@widgetbook.UseCase(name: 'Default H3', type: AppH3)
Widget appH3Default(BuildContext context) {
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Personal Details',
  );

  return Center(
    child: Padding(padding: const EdgeInsets.all(16.0), child: AppH3(text)),
  );
}

/// Nested Heading Structure - Showing full H1>H2>H3 hierarchy
@widgetbook.UseCase(name: 'Nested Heading Structure', type: AppH3)
Widget appH3Nested(BuildContext context) {
  final subsectionTitle = context.knobs.string(
    label: 'Subsection Title (H3)',
    initialValue: 'Installation',
  );

  final showContent = context.knobs.boolean(
    label: 'Show Content',
    initialValue: true,
  );

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppH1('Documentation'),
        const SizedBox(height: 16),
        const AppH2('Getting Started'),
        const SizedBox(height: 12),
        AppH3(subsectionTitle),
        if (showContent) ...[
          const SizedBox(height: 8),
          const Text('Run npm install to install dependencies...'),
        ],
      ],
    ),
  );
}

/// Color Variants - Different color options
@widgetbook.UseCase(name: 'Color Variants', type: AppH3)
Widget appH3Colors(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  final colorOption = context.knobs.object.dropdown(
    label: 'Color',
    options: ['Default', 'Primary', 'Tertiary', 'Custom Indigo'],
    labelBuilder: (value) => value,
  );

  final Color? color = switch (colorOption) {
    'Primary' => colorScheme.primary,
    'Tertiary' => colorScheme.tertiary,
    'Custom Indigo' => Colors.indigo,
    _ => null,
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppH3('Colored Subsection', color: color),
    ),
  );
}

/// Alignment Options - Left, center, right alignment
@widgetbook.UseCase(name: 'Alignment Options', type: AppH3)
Widget appH3Alignment(BuildContext context) {
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
      child: AppH3('Aligned Subsection', textAlign: textAlign),
    ),
  );
}

/// Font Weight Variants - Light, normal, semibold, bold
@widgetbook.UseCase(name: 'Font Weight Variants', type: AppH3)
Widget appH3FontWeights(BuildContext context) {
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
      child: AppH3('Weighted Subsection', fontWeight: fontWeight),
    ),
  );
}

/// FAQ Example - Real-world usage with expansion panels
@widgetbook.UseCase(name: 'FAQ Example', type: AppH3)
Widget appH3FaqExample(BuildContext context) {
  final faqQuestion = context.knobs.object.dropdown(
    label: 'FAQ Question',
    options: [
      'How do I reset my password?',
      'Can I change my subscription plan?',
      'App crashes on startup',
    ],
    labelBuilder: (value) => value,
  );

  final faqAnswers = {
    'How do I reset my password?':
        'To reset your password, click on "Forgot Password" on the login screen '
        'and follow the instructions sent to your email.',
    'Can I change my subscription plan?':
        'Yes, you can upgrade or downgrade your plan at any time from the '
        'Settings > Billing section.',
    'App crashes on startup':
        'Try clearing the app cache or reinstalling the application. If the '
        'problem persists, contact our support team.',
  };

  return Scaffold(
    appBar: AppBar(title: const Text('FAQ')),
    body: ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const AppH1('Frequently Asked Questions'),
        const SizedBox(height: 24),
        const AppH2('Account & Billing'),
        const SizedBox(height: 12),
        ExpansionTile(
          title: AppH3(faqQuestion),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(faqAnswers[faqQuestion] ?? ''),
            ),
          ],
        ),
      ],
    ),
  );
}
