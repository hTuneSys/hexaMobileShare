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

  // Color override (optional) - Using Material Design 3 ColorScheme
  final colorScheme = Theme.of(context).colorScheme;

  final colorOverride = context.knobs.objectOrNull.dropdown<Color>(
    label: 'Color Override',
    options: [
      colorScheme.primary,
      colorScheme.onPrimary,
      colorScheme.secondary,
      colorScheme.onSecondary,
      colorScheme.tertiary,
      colorScheme.onTertiary,
      colorScheme.error,
      colorScheme.onError,
      colorScheme.surface,
      colorScheme.onSurface,
    ],
    labelBuilder: (color) {
      if (color == colorScheme.primary) return 'Primary';
      if (color == colorScheme.onPrimary) return 'On Primary';
      if (color == colorScheme.secondary) return 'Secondary';
      if (color == colorScheme.onSecondary) return 'On Secondary';
      if (color == colorScheme.tertiary) return 'Tertiary';
      if (color == colorScheme.onTertiary) return 'On Tertiary';
      if (color == colorScheme.error) return 'Error';
      if (color == colorScheme.onError) return 'On Error';
      if (color == colorScheme.surface) return 'Surface';
      if (color == colorScheme.onSurface) return 'On Surface';
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

  // Apply color override only if not default
  if (colorOverride != null) {
    style = AppTextStyles.withColor(style, colorOverride);
  }

  // Apply opacity
  style = AppTextStyles.withOpacity(style, opacity);

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Error: Operation failed', style: AppTextStyles.error(context)),
          const VGap.md(),
          Text('Success: Changes saved', style: AppTextStyles.success(context)),
          const VGap.md(),
          Text('Warning: Please review', style: AppTextStyles.warning(context)),
          const VGap.md(),
          Text(
            'Info: New update available',
            style: AppTextStyles.info(context),
          ),
          const VGap.md(),
          Text('Link: Learn more', style: AppTextStyles.link(context)),
          const VGap.md(),
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Bold text style', style: AppTextStyles.bold(context)),
          const VGap.md(),
          Text('Italic text style', style: AppTextStyles.italic(context)),
          const VGap.md(),
          Text(
            'Underlined text style',
            style: AppTextStyles.underline(context),
          ),
          const VGap.md(),
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Invalid email address', style: AppTextStyles.error(context)),
          const VGap.md(),
          Text(
            'Password must be at least 8 characters',
            style: AppTextStyles.error(context),
          ),
          const VGap.md(),
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile updated successfully',
            style: AppTextStyles.success(context),
          ),
          const VGap.md(),
          Text('Payment processed', style: AppTextStyles.success(context)),
          const VGap.md(),
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Learn more about our features',
            style: AppTextStyles.link(context),
          ),
          const VGap.md(),
          Text('View terms and conditions', style: AppTextStyles.link(context)),
          const VGap.md(),
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('const value = 42;', style: AppTextStyles.monospace(context)),
          const VGap.md(),
          Text('npm install package', style: AppTextStyles.monospace(context)),
          const VGap.md(),
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Smaller text (0.85x)',
            style: AppTextStyles.smaller(context, style: baseStyle),
          ),
          const VGap.md(),
          Text('Normal text (1.0x)', style: baseStyle),
          const VGap.md(),
          Text(
            'Larger text (1.2x)',
            style: AppTextStyles.larger(context, style: baseStyle),
          ),
          const VGap.md(),
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
      padding: const EdgeInsets.all(AppSpacing.md),
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
          const VGap.md(),
          Text(
            'Italic muted text',
            style: AppTextStyles.italic(
              context,
              style: AppTextStyles.muted(context),
            ),
          ),
          const VGap.md(),
          Text(
            'Large success message',
            style: AppTextStyles.larger(
              context,
              style: AppTextStyles.success(context),
            ),
          ),
          const VGap.md(),
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
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full opacity (100%)',
            style: AppTextStyles.withOpacity(baseStyle, 1.0),
          ),
          const VGap.md(),
          Text(
            'High opacity (80%)',
            style: AppTextStyles.withOpacity(baseStyle, 0.8),
          ),
          const VGap.md(),
          Text(
            'Medium opacity (60%)',
            style: AppTextStyles.withOpacity(baseStyle, 0.6),
          ),
          const VGap.md(),
          Text(
            'Low opacity (40%)',
            style: AppTextStyles.withOpacity(baseStyle, 0.4),
          ),
          const VGap.md(),
          Text(
            'Very low opacity (20%)',
            style: AppTextStyles.withOpacity(baseStyle, 0.2),
          ),
        ],
      ),
    ),
  );
}
