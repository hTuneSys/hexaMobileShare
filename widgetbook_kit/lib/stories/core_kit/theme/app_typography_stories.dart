// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Interactive playground for exploring Material Design 3 text styles.
///
/// Allows real-time customization of all text style properties including:
/// - Text content
/// - Text style (from MD3 type scale)
/// - Font weight
/// - Font style (italic)
/// - Color
/// - Font size
/// - Line height
/// - Letter spacing
@widgetbook.UseCase(name: 'Interactive Playground', type: AppTypography)
Widget interactivePlayground(BuildContext context) {
  final textContent = context.knobs.string(
    label: 'Text Content',
    initialValue: 'The quick brown fox jumps over the lazy dog',
  );

  final textStyleName = context.knobs.string(
    label: 'Text Style',
    initialValue: 'bodyLarge',
  );

  final fontWeight = context.knobs.string(
    label: 'Font Weight',
    initialValue: 'w400',
  );

  final isItalic = context.knobs.boolean(label: 'Italic', initialValue: false);

  final color = context.knobs.colorOrNull(
    label: 'Text Color',
    initialValue: Theme.of(context).colorScheme.onSurface,
  );

  final fontSize = context.knobs.double.slider(
    label: 'Font Size Override',
    initialValue: 0,
    min: 0,
    max: 100,
  );

  final lineHeight = context.knobs.double.slider(
    label: 'Line Height',
    initialValue: 0,
    min: 0,
    max: 3,
  );

  final letterSpacing = context.knobs.double.slider(
    label: 'Letter Spacing',
    initialValue: 0,
    min: -2,
    max: 5,
  );

  // Get base text style
  TextStyle baseStyle;
  switch (textStyleName) {
    case 'displayLarge':
      baseStyle = Theme.of(context).textTheme.displayLarge!;
      break;
    case 'displayMedium':
      baseStyle = Theme.of(context).textTheme.displayMedium!;
      break;
    case 'displaySmall':
      baseStyle = Theme.of(context).textTheme.displaySmall!;
      break;
    case 'headlineLarge':
      baseStyle = Theme.of(context).textTheme.headlineLarge!;
      break;
    case 'headlineMedium':
      baseStyle = Theme.of(context).textTheme.headlineMedium!;
      break;
    case 'headlineSmall':
      baseStyle = Theme.of(context).textTheme.headlineSmall!;
      break;
    case 'titleLarge':
      baseStyle = Theme.of(context).textTheme.titleLarge!;
      break;
    case 'titleMedium':
      baseStyle = Theme.of(context).textTheme.titleMedium!;
      break;
    case 'titleSmall':
      baseStyle = Theme.of(context).textTheme.titleSmall!;
      break;
    case 'bodyLarge':
      baseStyle = Theme.of(context).textTheme.bodyLarge!;
      break;
    case 'bodyMedium':
      baseStyle = Theme.of(context).textTheme.bodyMedium!;
      break;
    case 'bodySmall':
      baseStyle = Theme.of(context).textTheme.bodySmall!;
      break;
    case 'labelLarge':
      baseStyle = Theme.of(context).textTheme.labelLarge!;
      break;
    case 'labelMedium':
      baseStyle = Theme.of(context).textTheme.labelMedium!;
      break;
    case 'labelSmall':
      baseStyle = Theme.of(context).textTheme.labelSmall!;
      break;
    default:
      baseStyle = Theme.of(context).textTheme.bodyLarge!;
  }

  // Apply customizations
  final fontWeightValue = _fontWeightFromString(fontWeight);
  TextStyle finalStyle = baseStyle.copyWith(
    fontWeight: fontWeightValue,
    fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
    color: color,
  );

  if (fontSize > 0) {
    finalStyle = AppTypography.withSize(finalStyle, fontSize);
  }

  if (lineHeight > 0) {
    finalStyle = AppTypography.withLineHeight(finalStyle, lineHeight);
  }

  if (letterSpacing != 0) {
    finalStyle = AppTypography.withLetterSpacing(finalStyle, letterSpacing);
  }

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(textContent, style: finalStyle, textAlign: TextAlign.center),
    ),
  );
}

/// Showcases all 15 Material Design 3 text styles in the type scale.
@widgetbook.UseCase(name: 'Full Type Scale', type: AppTypography)
Widget fullTypeScale(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TypeScaleSection(
          title: 'Display',
          description: 'Largest text - hero sections, splash screens',
          styles: [
            _TypeScaleItem(
              label: 'Display Large',
              style: Theme.of(context).textTheme.displayLarge!,
              specs: '57sp / Regular / -0.25',
            ),
            _TypeScaleItem(
              label: 'Display Medium',
              style: Theme.of(context).textTheme.displayMedium!,
              specs: '45sp / Regular / 0',
            ),
            _TypeScaleItem(
              label: 'Display Small',
              style: Theme.of(context).textTheme.displaySmall!,
              specs: '36sp / Regular / 0',
            ),
          ],
        ),
        const SizedBox(height: 32),
        _TypeScaleSection(
          title: 'Headline',
          description: 'High emphasis - page titles, section headers',
          styles: [
            _TypeScaleItem(
              label: 'Headline Large',
              style: Theme.of(context).textTheme.headlineLarge!,
              specs: '32sp / Regular / 0',
            ),
            _TypeScaleItem(
              label: 'Headline Medium',
              style: Theme.of(context).textTheme.headlineMedium!,
              specs: '28sp / Regular / 0',
            ),
            _TypeScaleItem(
              label: 'Headline Small',
              style: Theme.of(context).textTheme.headlineSmall!,
              specs: '24sp / Regular / 0',
            ),
          ],
        ),
        const SizedBox(height: 32),
        _TypeScaleSection(
          title: 'Title',
          description: 'Medium emphasis - card titles, toolbar titles',
          styles: [
            _TypeScaleItem(
              label: 'Title Large',
              style: Theme.of(context).textTheme.titleLarge!,
              specs: '22sp / Regular / 0',
            ),
            _TypeScaleItem(
              label: 'Title Medium',
              style: Theme.of(context).textTheme.titleMedium!,
              specs: '16sp / Medium / 0.15',
            ),
            _TypeScaleItem(
              label: 'Title Small',
              style: Theme.of(context).textTheme.titleSmall!,
              specs: '14sp / Medium / 0.1',
            ),
          ],
        ),
        const SizedBox(height: 32),
        _TypeScaleSection(
          title: 'Body',
          description: 'Main content - paragraphs, descriptions',
          styles: [
            _TypeScaleItem(
              label: 'Body Large',
              style: Theme.of(context).textTheme.bodyLarge!,
              specs: '16sp / Regular / 0.5',
            ),
            _TypeScaleItem(
              label: 'Body Medium',
              style: Theme.of(context).textTheme.bodyMedium!,
              specs: '14sp / Regular / 0.25',
            ),
            _TypeScaleItem(
              label: 'Body Small',
              style: Theme.of(context).textTheme.bodySmall!,
              specs: '12sp / Regular / 0.4',
            ),
          ],
        ),
        const SizedBox(height: 32),
        _TypeScaleSection(
          title: 'Label',
          description: 'UI elements - buttons, tabs, captions',
          styles: [
            _TypeScaleItem(
              label: 'Label Large',
              style: Theme.of(context).textTheme.labelLarge!,
              specs: '14sp / Medium / 0.1',
            ),
            _TypeScaleItem(
              label: 'Label Medium',
              style: Theme.of(context).textTheme.labelMedium!,
              specs: '12sp / Medium / 0.5',
            ),
            _TypeScaleItem(
              label: 'Label Small',
              style: Theme.of(context).textTheme.labelSmall!,
              specs: '11sp / Medium / 0.5',
            ),
          ],
        ),
      ],
    ),
  );
}

/// Demonstrates text style modification helpers (bold, italic, color, size).
@widgetbook.UseCase(name: 'Style Helpers', type: AppTypography)
Widget styleHelpers(BuildContext context) {
  final baseStyle = Theme.of(context).textTheme.bodyLarge!;

  return SingleChildScrollView(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Style Modification Helpers',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        Text('Base style (bodyLarge)', style: baseStyle),
        const SizedBox(height: 8),
        Text('Bold text', style: AppTypography.bold(baseStyle)),
        const SizedBox(height: 8),
        Text('Italic text', style: AppTypography.italic(baseStyle)),
        const SizedBox(height: 8),
        Text(
          'Colored text',
          style: AppTypography.withColor(
            baseStyle,
            Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Larger size (20sp)',
          style: AppTypography.withSize(baseStyle, 20),
        ),
        const SizedBox(height: 8),
        Text(
          'Increased line height (2.0)',
          style: AppTypography.withLineHeight(baseStyle, 2.0),
        ),
        const SizedBox(height: 8),
        Text(
          'Letter spacing (2.0)',
          style: AppTypography.withLetterSpacing(baseStyle, 2.0),
        ),
        const SizedBox(height: 24),
        Text(
          'Combined: Bold + Italic + Color',
          style: AppTypography.withColor(
            AppTypography.italic(AppTypography.bold(baseStyle)),
            Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ],
    ),
  );
}

/// Shows responsive text scaling for different screen sizes.
@widgetbook.UseCase(name: 'Responsive Scaling', type: AppTypography)
Widget responsiveScaling(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  String deviceCategory;
  if (width < 600) {
    deviceCategory = 'Small (< 600dp) - 0.9x scale';
  } else if (width < 840) {
    deviceCategory = 'Medium (600-840dp) - 1.0x scale';
  } else {
    deviceCategory = 'Large (> 840dp) - 1.1x scale';
  }

  return SingleChildScrollView(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Responsive Text Scaling',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Screen width: ${width.toInt()}dp',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(deviceCategory, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 32),
        Text('Standard Text', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          'This text uses standard titleLarge style without responsive scaling.',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 24),
        Text(
          'Responsive Text',
          style: AppTypography.responsive(
            Theme.of(context).textTheme.titleLarge,
            context,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This text uses responsive titleLarge style that adapts to screen size.',
          style: AppTypography.responsive(
            Theme.of(context).textTheme.titleLarge,
            context,
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Custom Scale (1.5x)',
          style: AppTypography.scale(
            Theme.of(context).textTheme.bodyMedium,
            1.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This demonstrates custom scaling with a 1.5x multiplier.',
          style: AppTypography.scale(
            Theme.of(context).textTheme.bodyMedium,
            1.5,
          ),
        ),
      ],
    ),
  );
}

/// Demonstrates common text style patterns (link, error, success, warning).
@widgetbook.UseCase(name: 'Common Patterns', type: AppTypography)
Widget commonPatterns(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Common Text Patterns',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        Text('Link Style', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Text(
          'Click here to learn more',
          style: AppTypography.linkStyle(context),
        ),
        const SizedBox(height: 24),
        Text('Error Style', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Text(
          'Invalid email address. Please try again.',
          style: AppTypography.errorStyle(context),
        ),
        const SizedBox(height: 24),
        Text('Success Style', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Text(
          'Profile updated successfully!',
          style: AppTypography.successStyle(context),
        ),
        const SizedBox(height: 24),
        Text('Warning Style', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Text(
          'Connection may be unstable. Please check your network.',
          style: AppTypography.warningStyle(context),
        ),
        const SizedBox(height: 24),
        Text('Hint Style', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Text(
          'Enter your email address to continue',
          style: AppTypography.hintStyle(context),
        ),
        const SizedBox(height: 24),
        Text('Disabled Style', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Text(
          'This option is currently unavailable',
          style: AppTypography.disabledStyle(context),
        ),
        const SizedBox(height: 24),
        Text('Code Style', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Text('const value = 42;', style: AppTypography.codeStyle(context)),
      ],
    ),
  );
}

/// Compares different text properties (size, weight, line height).
@widgetbook.UseCase(name: 'Text Comparisons', type: AppTypography)
Widget textComparisons(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Font Size Comparison',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text('12sp', style: AppTypography.withSize(null, 12)),
        Text('14sp', style: AppTypography.withSize(null, 14)),
        Text('16sp', style: AppTypography.withSize(null, 16)),
        Text('20sp', style: AppTypography.withSize(null, 20)),
        Text('24sp', style: AppTypography.withSize(null, 24)),
        const SizedBox(height: 32),
        Text(
          'Font Weight Comparison',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Light (300)',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w300),
        ),
        Text(
          'Regular (400)',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w400),
        ),
        Text(
          'Medium (500)',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          'Bold (700)',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 32),
        Text(
          'Line Height Comparison',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        Text(
          'Line height 1.0: Lorem ipsum dolor sit amet, '
          'consectetur adipiscing elit. Sed do eiusmod tempor.',
          style: AppTypography.withLineHeight(
            Theme.of(context).textTheme.bodyMedium,
            1.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Line height 1.5: Lorem ipsum dolor sit amet, '
          'consectetur adipiscing elit. Sed do eiusmod tempor.',
          style: AppTypography.withLineHeight(
            Theme.of(context).textTheme.bodyMedium,
            1.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Line height 2.0: Lorem ipsum dolor sit amet, '
          'consectetur adipiscing elit. Sed do eiusmod tempor.',
          style: AppTypography.withLineHeight(
            Theme.of(context).textTheme.bodyMedium,
            2.0,
          ),
        ),
      ],
    ),
  );
}

/// Shows typography hierarchy in a practical page layout.
@widgetbook.UseCase(name: 'Hierarchy Example', type: AppTypography)
Widget hierarchyExample(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to Our App',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Getting Started Guide',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        Text('Introduction', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          'This guide will help you understand the typography system '
          'and how to use it effectively in your application. '
          'Follow these best practices for consistent text styling.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        Text('Key Features', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          '• Complete Material Design 3 type scale',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '• Responsive text scaling',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          '• Accessibility support',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Note: Always use semantic text styles from the theme.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            'Get Started',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    ),
  );
}

/// Showcases typography for different use cases (headlines, body, labels).
@widgetbook.UseCase(name: 'Use Case Examples', type: AppTypography)
Widget useCaseExamples(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Use Case Examples',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        _UseCaseCard(
          title: 'Page Title',
          useCase: 'displayLarge or headlineLarge',
          example: Text(
            'Dashboard',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        const SizedBox(height: 16),
        _UseCaseCard(
          title: 'Section Header',
          useCase: 'headlineMedium or headlineSmall',
          example: Text(
            'Recent Activity',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: 16),
        _UseCaseCard(
          title: 'Card Title',
          useCase: 'titleLarge or titleMedium',
          example: Text(
            'Product Features',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 16),
        _UseCaseCard(
          title: 'Body Text',
          useCase: 'bodyLarge or bodyMedium',
          example: Text(
            'This is the main content of your application. '
            'Use body styles for paragraphs and descriptions.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 16),
        _UseCaseCard(
          title: 'Button Label',
          useCase: 'labelLarge',
          example: ElevatedButton(
            onPressed: () {},
            child: const Text('Action Button'),
          ),
        ),
        const SizedBox(height: 16),
        _UseCaseCard(
          title: 'Caption / Helper Text',
          useCase: 'bodySmall or labelSmall',
          example: Text(
            'Last updated 2 hours ago',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    ),
  );
}

// Helper Widgets

class _TypeScaleSection extends StatelessWidget {
  const _TypeScaleSection({
    required this.title,
    required this.description,
    required this.styles,
  });

  final String title;
  final String description;
  final List<_TypeScaleItem> styles;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 16),
        ...styles,
      ],
    );
  }
}

class _TypeScaleItem extends StatelessWidget {
  const _TypeScaleItem({
    required this.label,
    required this.style,
    required this.specs,
  });

  final String label;
  final TextStyle style;
  final String specs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Text(
                specs,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text('The quick brown fox', style: style),
        ],
      ),
    );
  }
}

class _UseCaseCard extends StatelessWidget {
  const _UseCaseCard({
    required this.title,
    required this.useCase,
    required this.example,
  });

  final String title;
  final String useCase;
  final Widget example;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Style: $useCase',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.6),
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 12),
          example,
        ],
      ),
    );
  }
}

// Helper Functions

FontWeight _fontWeightFromString(String weight) {
  switch (weight) {
    case 'w100':
      return FontWeight.w100;
    case 'w200':
      return FontWeight.w200;
    case 'w300':
      return FontWeight.w300;
    case 'w400':
      return FontWeight.w400;
    case 'w500':
      return FontWeight.w500;
    case 'w600':
      return FontWeight.w600;
    case 'w700':
      return FontWeight.w700;
    case 'w800':
      return FontWeight.w800;
    case 'w900':
      return FontWeight.w900;
    default:
      return FontWeight.w400;
  }
}
