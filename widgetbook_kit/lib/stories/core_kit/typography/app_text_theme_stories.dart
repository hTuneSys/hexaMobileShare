// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Explore AppTextTheme utilities
@widgetbook.UseCase(name: 'Interactive Playground', type: AppTextTheme)
Widget interactivePlayground(BuildContext context) {
  // TextTheme variant selection
  final themeVariant = context.knobs.object.dropdown(
    label: 'TextTheme Variant',
    options: ['default', 'merged'],
    initialOption: 'default',
    labelBuilder: (value) =>
        value == 'default' ? 'Default Theme' : 'Merged Theme',
  );

  final scale = context.knobs.double.slider(
    label: 'Scale Factor',
    initialValue: 1.0,
    min: 0.5,
    max: 2.0,
  );

  final fontWeightOverride = context.knobs.boolean(
    label: 'Font Weight Override (Bold)',
    initialValue: false,
  );

  final color = context.knobs.colorOrNull(
    label: 'Text Color',
    initialValue: Theme.of(context).colorScheme.onSurface,
  );

  final compareMode = context.knobs.boolean(
    label: 'Compare Mode',
    initialValue: false,
    description: 'Show original vs modified side by side',
  );

  final textStyle = context.knobs.object.dropdown(
    label: 'Text Style',
    options: [
      'displayLarge',
      'displayMedium',
      'displaySmall',
      'headlineLarge',
      'headlineMedium',
      'headlineSmall',
      'titleLarge',
      'titleMedium',
      'titleSmall',
      'bodyLarge',
      'bodyMedium',
      'bodySmall',
      'labelLarge',
      'labelMedium',
      'labelSmall',
    ],
    initialOption: 'bodyLarge',
    labelBuilder: (value) => value,
  );

  // Get base theme
  TextTheme baseTheme = Theme.of(context).textTheme;

  // Apply merged variant if selected
  if (themeVariant == 'merged') {
    // Use existing AppTypography component for Material Design 3 compliance
    final customTheme = AppTypography.textTheme().apply(
      displayColor: Theme.of(context).colorScheme.primary,
      bodyColor: Theme.of(context).colorScheme.secondary,
      fontSizeFactor: 1.1, // Make merged theme 10% larger
      fontSizeDelta: 2.0, // Add 2px to all font sizes
    );
    baseTheme = AppTextTheme.merge(baseTheme, customTheme);
  }

  // Apply customizations
  TextTheme modifiedTheme = baseTheme;

  if (scale != 1.0) {
    modifiedTheme = modifiedTheme.withScale(scale);
  }

  if (color != null) {
    modifiedTheme = modifiedTheme.withColor(color);
  }

  if (fontWeightOverride) {
    modifiedTheme = TextTheme(
      displayLarge: modifiedTheme.displayLarge != null
          ? AppTextTheme.bold(modifiedTheme.displayLarge!)
          : null,
      displayMedium: modifiedTheme.displayMedium != null
          ? AppTextTheme.bold(modifiedTheme.displayMedium!)
          : null,
      displaySmall: modifiedTheme.displaySmall != null
          ? AppTextTheme.bold(modifiedTheme.displaySmall!)
          : null,
      headlineLarge: modifiedTheme.headlineLarge != null
          ? AppTextTheme.bold(modifiedTheme.headlineLarge!)
          : null,
      headlineMedium: modifiedTheme.headlineMedium != null
          ? AppTextTheme.bold(modifiedTheme.headlineMedium!)
          : null,
      headlineSmall: modifiedTheme.headlineSmall != null
          ? AppTextTheme.bold(modifiedTheme.headlineSmall!)
          : null,
      titleLarge: modifiedTheme.titleLarge != null
          ? AppTextTheme.bold(modifiedTheme.titleLarge!)
          : null,
      titleMedium: modifiedTheme.titleMedium != null
          ? AppTextTheme.bold(modifiedTheme.titleMedium!)
          : null,
      titleSmall: modifiedTheme.titleSmall != null
          ? AppTextTheme.bold(modifiedTheme.titleSmall!)
          : null,
      bodyLarge: modifiedTheme.bodyLarge != null
          ? AppTextTheme.bold(modifiedTheme.bodyLarge!)
          : null,
      bodyMedium: modifiedTheme.bodyMedium != null
          ? AppTextTheme.bold(modifiedTheme.bodyMedium!)
          : null,
      bodySmall: modifiedTheme.bodySmall != null
          ? AppTextTheme.bold(modifiedTheme.bodySmall!)
          : null,
      labelLarge: modifiedTheme.labelLarge != null
          ? AppTextTheme.bold(modifiedTheme.labelLarge!)
          : null,
      labelMedium: modifiedTheme.labelMedium != null
          ? AppTextTheme.bold(modifiedTheme.labelMedium!)
          : null,
      labelSmall: modifiedTheme.labelSmall != null
          ? AppTextTheme.bold(modifiedTheme.labelSmall!)
          : null,
    );
  }

  // Get the selected style
  TextStyle? selectedStyle;
  switch (textStyle) {
    case 'displayLarge':
      selectedStyle = modifiedTheme.displayLarge;
      break;
    case 'displayMedium':
      selectedStyle = modifiedTheme.displayMedium;
      break;
    case 'displaySmall':
      selectedStyle = modifiedTheme.displaySmall;
      break;
    case 'headlineLarge':
      selectedStyle = modifiedTheme.headlineLarge;
      break;
    case 'headlineMedium':
      selectedStyle = modifiedTheme.headlineMedium;
      break;
    case 'headlineSmall':
      selectedStyle = modifiedTheme.headlineSmall;
      break;
    case 'titleLarge':
      selectedStyle = modifiedTheme.titleLarge;
      break;
    case 'titleMedium':
      selectedStyle = modifiedTheme.titleMedium;
      break;
    case 'titleSmall':
      selectedStyle = modifiedTheme.titleSmall;
      break;
    case 'bodyLarge':
      selectedStyle = modifiedTheme.bodyLarge;
      break;
    case 'bodyMedium':
      selectedStyle = modifiedTheme.bodyMedium;
      break;
    case 'bodySmall':
      selectedStyle = modifiedTheme.bodySmall;
      break;
    case 'labelLarge':
      selectedStyle = modifiedTheme.labelLarge;
      break;
    case 'labelMedium':
      selectedStyle = modifiedTheme.labelMedium;
      break;
    case 'labelSmall':
      selectedStyle = modifiedTheme.labelSmall;
      break;
  }

  // Compare mode logic
  if (compareMode) {
    TextStyle? originalStyle;
    switch (textStyle) {
      case 'displayLarge':
        originalStyle = baseTheme.displayLarge;
        break;
      case 'displayMedium':
        originalStyle = baseTheme.displayMedium;
        break;
      case 'displaySmall':
        originalStyle = baseTheme.displaySmall;
        break;
      case 'headlineLarge':
        originalStyle = baseTheme.headlineLarge;
        break;
      case 'headlineMedium':
        originalStyle = baseTheme.headlineMedium;
        break;
      case 'headlineSmall':
        originalStyle = baseTheme.headlineSmall;
        break;
      case 'titleLarge':
        originalStyle = baseTheme.titleLarge;
        break;
      case 'titleMedium':
        originalStyle = baseTheme.titleMedium;
        break;
      case 'titleSmall':
        originalStyle = baseTheme.titleSmall;
        break;
      case 'bodyLarge':
        originalStyle = baseTheme.bodyLarge;
        break;
      case 'bodyMedium':
        originalStyle = baseTheme.bodyMedium;
        break;
      case 'bodySmall':
        originalStyle = baseTheme.bodySmall;
        break;
      case 'labelLarge':
        originalStyle = baseTheme.labelLarge;
        break;
      case 'labelMedium':
        originalStyle = baseTheme.labelMedium;
        break;
      case 'labelSmall':
        originalStyle = baseTheme.labelSmall;
        break;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Original',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VGap.sm(),
                  Text(
                    'The quick brown fox jumps over the lazy dog',
                    style: originalStyle,
                  ),
                  const VGap.xs(),
                  Text(
                    'Style: $textStyle',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            const HGap.lg(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Modified',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VGap.sm(),
                  Text(
                    'The quick brown fox jumps over the lazy dog',
                    style: selectedStyle,
                  ),
                  const VGap.xs(),
                  Text(
                    'Style: $textStyle (modified)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sample Text', style: selectedStyle),
          const VGap.md(),
          Text(
            'Font Size: ${selectedStyle?.fontSize?.toStringAsFixed(1)}px',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            'Font Weight: ${selectedStyle?.fontWeight?.toString()}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            'Letter Spacing: ${selectedStyle?.letterSpacing?.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ),
  );
}

/// Theme Access Patterns - Quick access to text styles
@widgetbook.UseCase(name: 'Theme Access Patterns', type: AppTextTheme)
Widget themeAccessPatterns(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Theme Access Patterns')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Using context.textTheme Extension',
            style: context.textTheme.titleLarge,
          ),
          const VGap.sm(),
          Text(
            'This is body large text using context.textTheme.bodyLarge',
            style: context.textTheme.bodyLarge,
          ),
          const VGap.sm(),
          Text('This is body medium text', style: context.textTheme.bodyMedium),
          const VGap.lg(),
          const Divider(),
          const VGap.lg(),
          Text(
            'Using Theme.of(context)',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const VGap.sm(),
          Text(
            'Traditional access pattern',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    ),
  );
}

/// Responsive Scaling - Text adapts to screen size
@widgetbook.UseCase(name: 'Responsive Scaling', type: AppTextTheme)
Widget responsiveScaling(BuildContext context) {
  final responsiveTheme = AppTextTheme.responsive(
    context,
    baseSize: 16.0,
    scaleFactor: 1.0,
  );

  final width = MediaQuery.of(context).size.width;
  final scale = width < 600 ? 0.9 : (width < 1200 ? 1.0 : 1.1);

  return Scaffold(
    appBar: AppBar(title: const Text('Responsive Text Theme')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Screen Width: ${width.toInt()}px',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text(
                  'Scale Factor: ${scale}x',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          const VGap.lg(),
          Text('Display Large', style: responsiveTheme.displayLarge),
          const VGap.sm(),
          Text('Headline Medium', style: responsiveTheme.headlineMedium),
          const VGap.sm(),
          Text('Title Large', style: responsiveTheme.titleLarge),
          const VGap.sm(),
          Text(
            'Body Large - This text automatically scales based on screen size',
            style: responsiveTheme.bodyLarge,
          ),
          const VGap.sm(),
          Text(
            'Body Medium - Smaller screens get 0.9x scale, medium 1.0x, large 1.1x',
            style: responsiveTheme.bodyMedium,
          ),
        ],
      ),
    ),
  );
}

/// Theme Merging - Combine base and custom themes
@widgetbook.UseCase(name: 'Theme Merging', type: AppTextTheme)
Widget themeMerging(BuildContext context) {
  final baseTheme = Theme.of(context).textTheme;

  final customTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
    titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
  );

  final mergedTheme = AppTextTheme.merge(baseTheme, customTheme);

  return Scaffold(
    appBar: AppBar(title: const Text('Theme Merging')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Base Theme', style: Theme.of(context).textTheme.titleMedium),
          const VGap.sm(),
          Text(
            'Body Large (base): ${baseTheme.bodyLarge?.fontSize}px',
            style: baseTheme.bodyLarge,
          ),
          Text(
            'Title Large (base): ${baseTheme.titleLarge?.fontSize}px',
            style: baseTheme.titleLarge,
          ),
          const VGap.lg(),
          const Divider(),
          const VGap.lg(),
          Text('Merged Theme', style: Theme.of(context).textTheme.titleMedium),
          const VGap.sm(),
          Text(
            'Body Large (merged): ${mergedTheme.bodyLarge?.fontSize}px - Custom',
            style: mergedTheme.bodyLarge,
          ),
          Text(
            'Title Large (merged): ${mergedTheme.titleLarge?.fontSize}px - Custom',
            style: mergedTheme.titleLarge,
          ),
          const VGap.sm(),
          Text(
            'Display Medium (merged): ${mergedTheme.displayMedium?.fontSize}px - Base',
            style: mergedTheme.displayMedium,
          ),
        ],
      ),
    ),
  );
}

/// Custom Font Family - Apply custom fonts
@widgetbook.UseCase(name: 'Custom Font Family', type: AppTextTheme)
Widget customFontFamily(BuildContext context) {
  final defaultTheme = Theme.of(context).textTheme;
  final monoTheme = AppTextTheme.withFontFamily(defaultTheme, 'Courier');

  return Scaffold(
    appBar: AppBar(title: const Text('Custom Font Family')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Default Font (Roboto)', style: defaultTheme.titleLarge),
          const VGap.sm(),
          Text(
            'The quick brown fox jumps over the lazy dog',
            style: defaultTheme.bodyLarge,
          ),
          const VGap.lg(),
          const Divider(),
          const VGap.lg(),
          Text('Monospace Font', style: monoTheme.titleLarge),
          const VGap.sm(),
          Text(
            'The quick brown fox jumps over the lazy dog',
            style: monoTheme.bodyLarge,
          ),
          const VGap.sm(),
          Text('CODE_EXAMPLE = "Hello World";', style: monoTheme.bodyMedium),
        ],
      ),
    ),
  );
}

/// Custom Color Theme - Apply colors to text
@widgetbook.UseCase(name: 'Custom Color Theme', type: AppTextTheme)
Widget customColorTheme(BuildContext context) {
  final defaultTheme = Theme.of(context).textTheme;
  final primaryTheme = AppTextTheme.withColor(
    defaultTheme,
    Theme.of(context).colorScheme.primary,
  );
  final errorTheme = AppTextTheme.withColor(
    defaultTheme,
    Theme.of(context).colorScheme.error,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Custom Color Theme')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Default Color', style: defaultTheme.titleLarge),
          const VGap.sm(),
          Text(
            'This uses the default text color from theme',
            style: defaultTheme.bodyLarge,
          ),
          const VGap.lg(),
          const Divider(),
          const VGap.lg(),
          Text('Primary Color Theme', style: primaryTheme.titleLarge),
          const VGap.sm(),
          Text(
            'All text styles use primary color',
            style: primaryTheme.bodyLarge,
          ),
          const VGap.lg(),
          const Divider(),
          const VGap.lg(),
          Text('Error Color Theme', style: errorTheme.titleLarge),
          const VGap.sm(),
          Text(
            'All text styles use error color for warnings',
            style: errorTheme.bodyLarge,
          ),
        ],
      ),
    ),
  );
}

/// Text Style Utilities - Bold, Italic, Scale
@widgetbook.UseCase(name: 'Text Style Utilities', type: AppTextTheme)
Widget textStyleUtilities(BuildContext context) {
  final baseStyle = context.textTheme.bodyLarge!;
  final boldStyle = AppTextTheme.bold(baseStyle);
  final italicStyle = AppTextTheme.italic(baseStyle);
  final scaledStyle = AppTextTheme.scaleStyle(baseStyle, 1.5);

  return Scaffold(
    appBar: AppBar(title: const Text('Text Style Utilities')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Base Style', style: Theme.of(context).textTheme.titleMedium),
          const VGap.sm(),
          Text('This is the base bodyLarge style', style: baseStyle),
          const VGap.lg(),
          const Divider(),
          const VGap.lg(),
          Text('Bold Utility', style: Theme.of(context).textTheme.titleMedium),
          const VGap.sm(),
          Text('This text is bold using AppTextTheme.bold()', style: boldStyle),
          const VGap.lg(),
          const Divider(),
          const VGap.lg(),
          Text(
            'Italic Utility',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const VGap.sm(),
          Text(
            'This text is italic using AppTextTheme.italic()',
            style: italicStyle,
          ),
          const VGap.lg(),
          const Divider(),
          const VGap.lg(),
          Text(
            'Scaled Utility',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const VGap.sm(),
          Text('This text is 1.5x larger', style: scaledStyle),
        ],
      ),
    ),
  );
}

/// Theme Comparison Tool - Side-by-side comparison
@widgetbook.UseCase(name: 'Theme Comparison Tool', type: AppTextTheme)
Widget themeComparisonTool(BuildContext context) {
  final defaultTheme = Theme.of(context).textTheme;
  final scaledTheme = defaultTheme.withScale(1.2);

  return Scaffold(
    appBar: AppBar(title: const Text('Theme Comparison')),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildComparisonRow(
            context,
            'Display Large',
            defaultTheme.displayLarge,
            scaledTheme.displayLarge,
          ),
          _buildComparisonRow(
            context,
            'Headline Medium',
            defaultTheme.headlineMedium,
            scaledTheme.headlineMedium,
          ),
          _buildComparisonRow(
            context,
            'Title Large',
            defaultTheme.titleLarge,
            scaledTheme.titleLarge,
          ),
          _buildComparisonRow(
            context,
            'Body Large',
            defaultTheme.bodyLarge,
            scaledTheme.bodyLarge,
          ),
          _buildComparisonRow(
            context,
            'Body Medium',
            defaultTheme.bodyMedium,
            scaledTheme.bodyMedium,
          ),
          _buildComparisonRow(
            context,
            'Label Large',
            defaultTheme.labelLarge,
            scaledTheme.labelLarge,
          ),
        ],
      ),
    ),
  );
}

Widget _buildComparisonRow(
  BuildContext context,
  String label,
  TextStyle? defaultStyle,
  TextStyle? scaledStyle,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: Theme.of(context).textTheme.titleSmall),
      const VGap.xs(),
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Default', style: Theme.of(context).textTheme.labelSmall),
                Text('Sample', style: defaultStyle),
                Text(
                  '${defaultStyle?.fontSize?.toStringAsFixed(1)}px',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const HGap.md(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scaled (1.2x)',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Text('Sample', style: scaledStyle),
                Text(
                  '${scaledStyle?.fontSize?.toStringAsFixed(1)}px',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
      const VGap.md(),
      const Divider(),
      const VGap.md(),
    ],
  );
}

/// Debug Styles Viewer - View all theme styles
@widgetbook.UseCase(name: 'Debug Styles Viewer', type: AppTextTheme)
Widget debugStylesViewer(BuildContext context) {
  final styles = AppTextTheme.debugStyles(context);

  return Scaffold(
    appBar: AppBar(title: const Text('Debug Styles Viewer')),
    body: ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: styles.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final entry = styles.entries.elementAt(index);
        final style = entry.value;

        return ListTile(
          title: Text(entry.key, style: Theme.of(context).textTheme.titleSmall),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VGap.xs(),
              Text('Sample Text', style: style),
              const VGap.xs(),
              Text(
                'Size: ${style?.fontSize?.toStringAsFixed(1)}px | '
                'Weight: ${style?.fontWeight?.toString().split('.').last} | '
                'Spacing: ${style?.letterSpacing?.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}
