// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Interactive Playground - Expose ALL component properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppCaption)
Widget appCaptionPlayground(BuildContext context) {
  // Knob for text content
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'This is a caption text',
  );

  // Knob for custom color
  final customColor = context.knobs.colorOrNull(
    label: 'Custom Color',
    initialValue: null,
  );

  // Knob for max lines
  final maxLinesValue = context.knobs.int.slider(
    label: 'Max Lines (0 = unlimited)',
    initialValue: 0,
    min: 0,
    max: 5,
  );
  final maxLines = maxLinesValue == 0 ? null : maxLinesValue;

  // Knob for overflow behavior
  final overflowOptions = [
    TextOverflow.clip,
    TextOverflow.ellipsis,
    TextOverflow.fade,
    TextOverflow.visible,
  ];
  final overflow = context.knobs.object.dropdown(
    label: 'Overflow',
    options: overflowOptions,
    labelBuilder: (value) => value.name,
    initialOption: TextOverflow.clip,
  );

  // Knob for text alignment
  final alignOptions = [
    TextAlign.start,
    TextAlign.center,
    TextAlign.end,
    TextAlign.justify,
  ];
  final textAlign = context.knobs.object.dropdown(
    label: 'Text Align',
    options: alignOptions,
    labelBuilder: (value) => value.name,
    initialOption: TextAlign.start,
  );

  // Knob for label style
  final useLabel = context.knobs.boolean(
    label: 'Use Label Style',
    initialValue: false,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCaption(
        text: text,
        color: customColor,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        useLabel: useLabel,
      ),
    ),
  );
}

/// Default Caption - Basic caption with default styling
@widgetbook.UseCase(name: 'Default Caption', type: AppCaption)
Widget defaultCaption(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppCaption(
        text: 'This is a caption text using default Material Design 3 styling',
      ),
    ),
  );
}

/// Timestamp Example - Common timestamp use case
@widgetbook.UseCase(name: 'Timestamp', type: AppCaption)
Widget timestampExample(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AppCaption(text: '2 hours ago'),
          SizedBox(height: 8),
          AppCaption(text: 'Updated yesterday'),
          SizedBox(height: 8),
          AppCaption(text: 'Posted on January 10, 2026'),
          SizedBox(height: 8),
          AppCaption(text: 'Last modified: 5 minutes ago'),
        ],
      ),
    ),
  );
}

/// Helper Text - Form field helper text examples
@widgetbook.UseCase(name: 'Helper Text', type: AppCaption)
Widget helperTextExample(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AppCaption(text: 'Enter your email address'),
          SizedBox(height: 16),
          AppCaption(text: 'Password must be at least 8 characters'),
          SizedBox(height: 16),
          AppCaption(text: 'Optional field - you can leave this blank'),
        ],
      ),
    ),
  );
}

/// With Custom Color - Caption with custom colors
@widgetbook.UseCase(name: 'Custom Colors', type: AppCaption)
Widget customColorExample(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppCaption(text: 'Default color (onSurfaceVariant)'),
          const SizedBox(height: 12),
          AppCaption(text: 'Error message in red', color: colorScheme.error),
          const SizedBox(height: 12),
          AppCaption(
            text: 'Success message in primary color',
            color: colorScheme.primary,
          ),
          const SizedBox(height: 12),
          AppCaption(
            text: 'Tertiary color caption',
            color: colorScheme.tertiary,
          ),
        ],
      ),
    ),
  );
}

/// Ellipsis Overflow - Long text with ellipsis
@widgetbook.UseCase(name: 'Ellipsis Overflow', type: AppCaption)
Widget ellipsisOverflowExample(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(
            width: 200,
            child: AppCaption(
              text:
                  'This is a very long caption text that will overflow and show ellipsis at the end',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: 200,
            child: AppCaption(
              text:
                  'Another long caption that demonstrates ellipsis overflow behavior with Material Design 3 typography',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Max Lines - Caption limited to specific number of lines
@widgetbook.UseCase(name: 'Max Lines (2 lines)', type: AppCaption)
Widget maxLinesExample(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppCaption(
        text:
            'This caption is limited to exactly 2 lines. Any additional text beyond these two lines will be clipped according to the overflow behavior setting.',
        maxLines: 2,
        overflow: TextOverflow.clip,
      ),
    ),
  );
}

/// Center Aligned - Center-aligned caption text
@widgetbook.UseCase(name: 'Text Alignment', type: AppCaption)
Widget textAlignmentExample(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          AppCaption(
            text: 'Left aligned caption (start)',
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 12),
          AppCaption(
            text: 'Center aligned caption',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          AppCaption(
            text: 'Right aligned caption (end)',
            textAlign: TextAlign.end,
          ),
        ],
      ),
    ),
  );
}

/// Label Style - Using labelSmall instead of bodySmall
@widgetbook.UseCase(name: 'Label Style', type: AppCaption)
Widget labelStyleExample(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AppCaption(
            text: 'Body style (default) - 12sp, 400 weight',
            useLabel: false,
          ),
          SizedBox(height: 12),
          AppCaption(text: 'Label style - 11sp, 500 weight', useLabel: true),
          SizedBox(height: 24),
          AppCaption(text: 'FILE SIZE: 2.4 MB', useLabel: true),
          SizedBox(height: 8),
          AppCaption(text: 'CREATED: JAN 10, 2026', useLabel: true),
        ],
      ),
    ),
  );
}

/// Real-world Example - Image card with caption
@widgetbook.UseCase(name: 'Image Card Example', type: AppCaption)
Widget realWorldExample(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Center(child: Icon(Icons.image, size: 64)),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Beautiful Sunset',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  AppCaption(text: 'Photo by John Doe • Unsplash'),
                  SizedBox(height: 4),
                  AppCaption(text: 'Taken on January 10, 2026 at 6:30 PM'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
