// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive playground for exploring all AppTextStyles utilities.
///
/// This playground allows you to:
/// - Test semantic presets (error, success, warning, info, link, muted)
/// - Try modification helpers (bold, italic, underline, strikethrough)
/// - Adjust color and opacity
/// - Experiment with size scaling
/// - Customize font weight, decorations, and colors
@widgetbook.UseCase(name: 'Interactive Playground', type: AppTextStyles)
Widget interactivePlayground(BuildContext context) {
  // Semantic preset dropdown
  final semanticPreset = context.knobs.object.dropdown(
    label: 'Semantic Preset',
    options: const [
      'none',
      'error',
      'success',
      'warning',
      'info',
      'link',
      'muted',
    ],
    labelBuilder: (option) => option,
  );

  // Font weight dropdown
  final fontWeight = context.knobs.object.dropdown(
    label: 'Font Weight',
    options: const ['normal', 'bold'],
    labelBuilder: (option) => option,
  );

  // Italic boolean
  final isItalic = context.knobs.boolean(label: 'Italic', initialValue: false);

  // Underline boolean
  final hasUnderline = context.knobs.boolean(
    label: 'Underline',
    initialValue: false,
  );

  // Strikethrough boolean
  final hasStrikethrough = context.knobs.boolean(
    label: 'Strikethrough',
    initialValue: false,
  );

  // Font size slider
  final fontSize = context.knobs.double.slider(
    label: 'Font Size',
    initialValue: 16.0,
    min: 10.0,
    max: 32.0,
  );

  // Opacity slider
  final opacity = context.knobs.double.slider(
    label: 'Opacity',
    initialValue: 1.0,
    min: 0.0,
    max: 1.0,
  );

  // Color dropdown
  final color = context.knobs.object.dropdown(
    label: 'Color',
    options: const [
      Colors.black,
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.grey,
    ],
    labelBuilder: (color) {
      if (color == Colors.black) return 'Black';
      if (color == Colors.red) return 'Red';
      if (color == Colors.green) return 'Green';
      if (color == Colors.blue) return 'Blue';
      if (color == Colors.orange) return 'Orange';
      if (color == Colors.purple) return 'Purple';
      if (color == Colors.grey) return 'Grey';
      return 'Unknown';
    },
  );

  final text = context.knobs.string(
    label: 'Text Content',
    initialValue: 'Sample text with AppTextStyles',
  );

  // Build style based on semantic preset
  TextStyle style;
  if (semanticPreset != 'none') {
    switch (semanticPreset) {
      case 'error':
        style = AppTextStyles.error(context);
        break;
      case 'success':
        style = AppTextStyles.success(context);
        break;
      case 'warning':
        style = AppTextStyles.warning(context);
        break;
      case 'info':
        style = AppTextStyles.info(context);
        break;
      case 'link':
        style = AppTextStyles.link(context);
        break;
      case 'muted':
        style = AppTextStyles.muted(context);
        break;
      default:
        style = Theme.of(context).textTheme.bodyMedium!;
    }
  } else {
    style = Theme.of(context).textTheme.bodyMedium!;
  }

  // Apply font weight
  if (fontWeight == 'bold') {
    style = AppTextStyles.bold(context, style: style);
  }

  // Apply italic
  if (isItalic) {
    style = AppTextStyles.italic(context, style: style);
  }

  // Apply underline
  if (hasUnderline) {
    style = AppTextStyles.underline(context, style: style);
  }

  // Apply strikethrough
  if (hasStrikethrough) {
    style = AppTextStyles.strikethrough(context, style: style);
  }

  // Apply font size
  style = style.copyWith(fontSize: fontSize);

  // Apply color
  style = AppTextStyles.withColor(style, color);

  // Apply opacity
  style = AppTextStyles.withOpacity(style, opacity);

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(text, style: style),
    ),
  );
}

/// Showcase of all semantic preset styles.
///
/// Demonstrates error, success, warning, info, link, and muted styles.
@widgetbook.UseCase(name: 'Semantic Presets', type: AppTextStyles)
Widget semanticPresets(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Error: Operation failed', style: AppTextStyles.error(context)),
          const SizedBox(height: 12),
          Text('Success: Changes saved', style: AppTextStyles.success(context)),
          const SizedBox(height: 12),
          Text('Warning: Please review', style: AppTextStyles.warning(context)),
          const SizedBox(height: 12),
          Text(
            'Info: New update available',
            style: AppTextStyles.info(context),
          ),
          const SizedBox(height: 12),
          Text('Link: Learn more', style: AppTextStyles.link(context)),
          const SizedBox(height: 12),
          Text(
            'Muted: Secondary information',
            style: AppTextStyles.muted(context),
          ),
        ],
      ),
    ),
  );
}

/// Showcase of modification helpers.
///
/// Demonstrates bold, italic, underline, and strikethrough styles.
@widgetbook.UseCase(name: 'Modification Helpers', type: AppTextStyles)
Widget modificationHelpers(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bold text style', style: AppTextStyles.bold(context)),
          const SizedBox(height: 12),
          Text('Italic text style', style: AppTextStyles.italic(context)),
          const SizedBox(height: 12),
          Text(
            'Underlined text style',
            style: AppTextStyles.underline(context),
          ),
          const SizedBox(height: 12),
          Text(
            'Strikethrough text style',
            style: AppTextStyles.strikethrough(context),
          ),
        ],
      ),
    ),
  );
}

/// Showcase of error style for validation messages.
@widgetbook.UseCase(name: 'Error Messages', type: AppTextStyles)
Widget errorMessages(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Invalid email address', style: AppTextStyles.error(context)),
          const SizedBox(height: 12),
          Text(
            'Password must be at least 8 characters',
            style: AppTextStyles.error(context),
          ),
          const SizedBox(height: 12),
          Text(
            'Network connection failed',
            style: AppTextStyles.error(context),
          ),
        ],
      ),
    ),
  );
}

/// Showcase of success style for confirmation messages.
@widgetbook.UseCase(name: 'Success Messages', type: AppTextStyles)
Widget successMessages(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile updated successfully',
            style: AppTextStyles.success(context),
          ),
          const SizedBox(height: 12),
          Text('Payment processed', style: AppTextStyles.success(context)),
          const SizedBox(height: 12),
          Text('File uploaded', style: AppTextStyles.success(context)),
        ],
      ),
    ),
  );
}

/// Showcase of link style for clickable text.
@widgetbook.UseCase(name: 'Link Text', type: AppTextStyles)
Widget linkText(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learn more about our features',
            style: AppTextStyles.link(context),
          ),
          const SizedBox(height: 12),
          Text('View terms and conditions', style: AppTextStyles.link(context)),
          const SizedBox(height: 12),
          Text('Contact support', style: AppTextStyles.link(context)),
        ],
      ),
    ),
  );
}

/// Showcase of monospace style for code snippets.
@widgetbook.UseCase(name: 'Monospace Code', type: AppTextStyles)
Widget monospaceCode(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('const value = 42;', style: AppTextStyles.monospace(context)),
          const SizedBox(height: 12),
          Text('npm install package', style: AppTextStyles.monospace(context)),
          const SizedBox(height: 12),
          Text(
            'git commit -m "feat: add feature"',
            style: AppTextStyles.monospace(context),
          ),
        ],
      ),
    ),
  );
}

/// Showcase of size helpers for responsive text.
@widgetbook.UseCase(name: 'Size Variations', type: AppTextStyles)
Widget sizeVariations(BuildContext context) {
  final baseStyle = Theme.of(context).textTheme.bodyMedium!;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Smaller text (0.85x)',
            style: AppTextStyles.smaller(context, style: baseStyle),
          ),
          const SizedBox(height: 12),
          Text('Normal text (1.0x)', style: baseStyle),
          const SizedBox(height: 12),
          Text(
            'Larger text (1.2x)',
            style: AppTextStyles.larger(context, style: baseStyle),
          ),
          const SizedBox(height: 12),
          Text(
            'Much larger text (1.5x)',
            style: AppTextStyles.larger(context, style: baseStyle, factor: 1.5),
          ),
        ],
      ),
    ),
  );
}

/// Showcase of combined styles for complex use cases.
@widgetbook.UseCase(name: 'Combined Styles', type: AppTextStyles)
Widget combinedStyles(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bold error message',
            style: AppTextStyles.bold(
              context,
              style: AppTextStyles.error(context),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Italic muted text',
            style: AppTextStyles.italic(
              context,
              style: AppTextStyles.muted(context),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Large success message',
            style: AppTextStyles.larger(
              context,
              style: AppTextStyles.success(context),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Faded strikethrough',
            style: AppTextStyles.withOpacity(
              AppTextStyles.strikethrough(context),
              0.5,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Showcase of opacity variations for visual hierarchy.
@widgetbook.UseCase(name: 'Opacity Variations', type: AppTextStyles)
Widget opacityVariations(BuildContext context) {
  final baseStyle = Theme.of(context).textTheme.bodyMedium!;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full opacity (100%)',
            style: AppTextStyles.withOpacity(baseStyle, 1.0),
          ),
          const SizedBox(height: 12),
          Text(
            'High opacity (80%)',
            style: AppTextStyles.withOpacity(baseStyle, 0.8),
          ),
          const SizedBox(height: 12),
          Text(
            'Medium opacity (60%)',
            style: AppTextStyles.withOpacity(baseStyle, 0.6),
          ),
          const SizedBox(height: 12),
          Text(
            'Low opacity (40%)',
            style: AppTextStyles.withOpacity(baseStyle, 0.4),
          ),
          const SizedBox(height: 12),
          Text(
            'Very low opacity (20%)',
            style: AppTextStyles.withOpacity(baseStyle, 0.2),
          ),
        ],
      ),
    ),
  );
}
