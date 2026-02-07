// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Widgetbook stories for [AppThemeExtension].
///
/// Demonstrates the usage of custom theme extensions that extend Material
/// Design 3 with app-specific properties including custom colors, spacing,
/// shadows, and typography.

// ═════════════════════════════════════════════════════════════════════════════
// Constants
// ═════════════════════════════════════════════════════════════════════════════

const double _kColorPreviewSize = 48.0;
const double _kSpacingPreviewWidth = 80.0;
const double _kSpacingPreviewHeight = 40.0;
const double _kShadowCardHeight = 60.0;
const double _kSemanticIconSize = 32.0;
const double _kSemanticColorOpacity = 0.1;
const double _kBrandCardHeight = 120.0;
const double _kDemoContainerWidth = 280.0;
const double _kShadowDemoHeight = 100.0;
const double _kRadiusDemoHeight = 80.0;

// ═════════════════════════════════════════════════════════════════════════════
// Interactive Playground - MANDATORY FIRST VARIANT
// ═════════════════════════════════════════════════════════════════════════════

/// Interactive playground for [AppThemeExtension] with all customizable
/// properties exposed as knobs.
///
/// Allows experimenting with all theme extension properties in real-time.
@widgetbook.UseCase(name: 'Interactive Playground', type: AppThemeExtension)
Widget interactivePlayground(BuildContext context) {
  // Section selector
  final section = context.knobs.object.dropdown(
    label: 'Section',
    options: ['Colors', 'Spacing', 'Radius', 'Shadows', 'Typography'],
    labelBuilder: (value) => value,
  );

  Widget sectionContent;

  switch (section) {
    case 'Colors':
      final successColor = context.knobs.color(
        label: 'Success Color',
        initialValue: const Color(0xFF2E7D32),
      );
      final warningColor = context.knobs.color(
        label: 'Warning Color',
        initialValue: const Color(0xFFF57C00),
      );
      final infoColor = context.knobs.color(
        label: 'Info Color',
        initialValue: const Color(0xFF1976D2),
      );
      final accent2Color = context.knobs.color(
        label: 'Accent 2 Color',
        initialValue: const Color(0xFF6A1B9A),
      );
      final accent3Color = context.knobs.color(
        label: 'Accent 3 Color',
        initialValue: const Color(0xFF00838F),
      );

      final theme = AppThemeExtension(
        successColor: successColor,
        warningColor: warningColor,
        infoColor: infoColor,
        accent2Color: accent2Color,
        accent3Color: accent3Color,
      );

      sectionContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppH3('Custom Colors'),
          Gap.sm(),
          _ColorRow(label: 'Success', color: theme.successColor),
          _ColorRow(label: 'Warning', color: theme.warningColor),
          _ColorRow(label: 'Info', color: theme.infoColor),
          _ColorRow(label: 'Accent 2', color: theme.accent2Color),
          _ColorRow(label: 'Accent 3', color: theme.accent3Color),
        ],
      );
      break;

    case 'Spacing':
      final spacingMicro = context.knobs.double.slider(
        label: 'Spacing Micro',
        initialValue: 2.0,
        min: 0,
        max: 8,
      );
      final spacingXxs = context.knobs.double.slider(
        label: 'Spacing XXS',
        initialValue: 4.0,
        min: 0,
        max: 16,
      );
      final spacingXs = context.knobs.double.slider(
        label: 'Spacing XS',
        initialValue: 8.0,
        min: 0,
        max: 24,
      );

      final theme = AppThemeExtension(
        spacingMicro: spacingMicro,
        spacingXxs: spacingXxs,
        spacingXs: spacingXs,
      );

      sectionContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppH3('Custom Spacing'),
          Gap.sm(),
          _SpacingRow(label: 'Micro', spacing: theme.spacingMicro ?? 2.0),
          _SpacingRow(label: 'XXS', spacing: theme.spacingXxs ?? 4.0),
          _SpacingRow(label: 'XS', spacing: theme.spacingXs ?? 8.0),
        ],
      );
      break;

    case 'Radius':
      final radiusXxs = context.knobs.double.slider(
        label: 'Radius XXS',
        initialValue: 2.0,
        min: 0,
        max: 8,
      );
      final radiusXxl = context.knobs.double.slider(
        label: 'Radius XXL',
        initialValue: 32.0,
        min: 0,
        max: 64,
      );

      final theme = AppThemeExtension(
        radiusXxs: radiusXxs,
        radiusXxl: radiusXxl,
      );

      sectionContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppH3('Custom Radius'),
          Gap.sm(),
          _RadiusRow(label: 'XXS', radius: theme.radiusXxs ?? 2.0),
          _RadiusRow(label: 'XXL', radius: theme.radiusXxl ?? 32.0),
        ],
      );
      break;

    case 'Shadows':
      final shadowSoftOpacity = context.knobs.double.slider(
        label: 'Shadow Soft Opacity',
        initialValue: 0.08,
        min: 0,
        max: 1,
      );
      final shadowHardOpacity = context.knobs.double.slider(
        label: 'Shadow Hard Opacity',
        initialValue: 0.16,
        min: 0,
        max: 1,
      );

      final theme = AppThemeExtension(
        shadowSoft: BoxShadow(
          color: Colors.black.withValues(alpha: shadowSoftOpacity),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
        shadowHard: BoxShadow(
          color: Colors.black.withValues(alpha: shadowHardOpacity),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      );

      sectionContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppH3('Custom Shadows'),
          Gap.sm(),
          _ShadowCard(label: 'Soft Shadow', shadow: theme.shadowSoft),
          Gap.sm(),
          _ShadowCard(label: 'Hard Shadow', shadow: theme.shadowHard),
        ],
      );
      break;

    case 'Typography':
      final monoFontSize = context.knobs.double.slider(
        label: 'Mono Font Size',
        initialValue: 14.0,
        min: 10,
        max: 24,
      );
      final displayFontSize = context.knobs.double.slider(
        label: 'Display Font Size',
        initialValue: 57.0,
        min: 32,
        max: 96,
      );

      final theme = AppThemeExtension(
        monoTextStyle: TextStyle(
          fontFamily: 'monospace',
          fontSize: monoFontSize,
          fontWeight: FontWeight.w400,
        ),
        displayTextStyle: TextStyle(
          fontSize: displayFontSize,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
        ),
      );

      sectionContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppH3('Custom Typography'),
          Gap.sm(),
          if (theme.monoTextStyle != null)
            Text(
              'fn main() { println!("Hello"); }',
              style: theme.monoTextStyle,
            ),
          Gap.sm(),
          if (theme.displayTextStyle != null)
            Text('Display', style: theme.displayTextStyle),
        ],
      );
      break;

    default:
      sectionContent = const SizedBox.shrink();
  }

  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: SingleChildScrollView(
      padding: AppSpacing.edgeInsetsAllMd,
      child: sectionContent,
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// Use Case Variants
// ═════════════════════════════════════════════════════════════════════════════

/// Demonstrates semantic color usage with success, warning, and info states.
@widgetbook.UseCase(name: 'Semantic Colors', type: AppThemeExtension)
Widget semanticColors(BuildContext context) {
  final cardType = context.knobs.object.dropdown(
    label: 'Card Type',
    options: ['Success', 'Warning', 'Info'],
    labelBuilder: (value) => value,
  );

  final message = context.knobs.string(
    label: 'Message',
    initialValue: cardType == 'Success'
        ? 'Your changes have been saved successfully.'
        : cardType == 'Warning'
        ? 'Please review your input before proceeding.'
        : 'This feature is currently in beta testing.',
  );

  IconData icon;
  Color? color;
  String title;

  switch (cardType) {
    case 'Success':
      icon = Icons.check_circle;
      color = context.appThemeExtension.successColor;
      title = 'Success';
      break;
    case 'Warning':
      icon = Icons.warning;
      color = context.appThemeExtension.warningColor;
      title = 'Warning';
      break;
    case 'Info':
    default:
      icon = Icons.info;
      color = context.appThemeExtension.infoColor;
      title = 'Information';
      break;
  }

  return Theme(
    data: Theme.of(context).copyWith(extensions: [AppThemeExtension.light()]),
    child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: AppSpacing.edgeInsetsAllMd,
        child: Center(
          child: _SemanticCard(
            icon: icon,
            title: title,
            message: message,
            color: color,
          ),
        ),
      ),
    ),
  );
}

/// Demonstrates custom spacing values for fine-grained layout control.
@widgetbook.UseCase(name: 'Custom Spacing', type: AppThemeExtension)
Widget customSpacing(BuildContext context) {
  final spacingType = context.knobs.object.dropdown(
    label: 'Spacing Type',
    options: ['Micro', 'XXS', 'XS'],
    labelBuilder: (value) => value,
  );

  final theme = AppThemeExtension.light();

  double spacingValue;
  String label;
  Color containerColor;

  switch (spacingType) {
    case 'Micro':
      spacingValue = theme.spacingMicro!;
      label = 'Micro Spacing (${spacingValue}dp)';
      containerColor = Theme.of(context).colorScheme.primary;
      break;
    case 'XXS':
      spacingValue = theme.spacingXxs!;
      label = 'XXS Spacing (${spacingValue}dp)';
      containerColor = Theme.of(context).colorScheme.secondary;
      break;
    case 'XS':
    default:
      spacingValue = theme.spacingXs!;
      label = 'XS Spacing (${spacingValue}dp)';
      containerColor = Theme.of(context).colorScheme.tertiary;
      break;
  }

  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: Padding(
      padding: AppSpacing.edgeInsetsAllMd,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            Gap.sm(),
            Container(
              height: _kShadowCardHeight,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                  (index) => Padding(
                    padding: EdgeInsets.all(spacingValue),
                    child: Container(
                      width: _kSpacingPreviewHeight,
                      color: containerColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Demonstrates custom shadow variations for different elevation effects.
@widgetbook.UseCase(name: 'Custom Shadows', type: AppThemeExtension)
Widget customShadows(BuildContext context) {
  final shadowType = context.knobs.object.dropdown(
    label: 'Shadow Type',
    options: ['Soft', 'Hard', 'Colored'],
    labelBuilder: (value) => value,
  );

  final theme = AppThemeExtension.light();

  String label;
  String description;
  BoxShadow shadow;

  switch (shadowType) {
    case 'Soft':
      label = 'Soft Shadow';
      description = 'Subtle depth with soft shadow';
      shadow = theme.shadowSoft!;
      break;
    case 'Hard':
      label = 'Hard Shadow';
      description = 'Strong depth with hard shadow';
      shadow = theme.shadowHard!;
      break;
    case 'Colored':
    default:
      label = 'Colored Shadow';
      description = 'Branded shadow with color tint';
      shadow = theme.shadowColored!;
      break;
  }

  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: Padding(
      padding: AppSpacing.edgeInsetsAllMd,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            Gap.sm(),
            Container(
              width: _kDemoContainerWidth,
              height: _kShadowDemoHeight,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppRadius.md),
                boxShadow: [shadow],
              ),
              child: Center(child: Text(description)),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Compares light and dark theme variants side by side.
@widgetbook.UseCase(name: 'Light vs Dark Theme', type: AppThemeExtension)
Widget lightVsDark(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: Theme(
          data: ThemeData.light().copyWith(
            extensions: [AppThemeExtension.light()],
          ),
          child: _ThemePreview(label: 'Light Theme'),
        ),
      ),
      Expanded(
        child: Theme(
          data: ThemeData.dark().copyWith(
            extensions: [AppThemeExtension.dark()],
          ),
          child: _ThemePreview(label: 'Dark Theme'),
        ),
      ),
    ],
  );
}

/// Demonstrates brand accent colors beyond the primary palette.
@widgetbook.UseCase(name: 'Brand Accent Colors', type: AppThemeExtension)
Widget brandAccents(BuildContext context) {
  final accentType = context.knobs.object.dropdown(
    label: 'Accent Color',
    options: ['Accent 2', 'Accent 3'],
    labelBuilder: (value) => value,
  );

  final theme = AppThemeExtension.light();

  final color = accentType == 'Accent 2'
      ? theme.accent2Color!
      : theme.accent3Color!;
  final label = accentType;
  final hex = _colorToHex(color);

  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: Padding(
      padding: AppSpacing.edgeInsetsAllMd,
      child: Center(
        child: _BrandCard(color: color, label: label, hex: hex),
      ),
    ),
  );
}

/// Demonstrates custom typography styles for specialized content.
@widgetbook.UseCase(name: 'Custom Typography', type: AppThemeExtension)
Widget customTypography(BuildContext context) {
  final typographyType = context.knobs.object.dropdown(
    label: 'Typography Type',
    options: ['Display', 'Monospace'],
    labelBuilder: (value) => value,
  );

  final theme = AppThemeExtension.light();

  Widget content;

  if (typographyType == 'Display') {
    content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Display Text Style',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Gap.sm(),
        Text('Hero', style: theme.displayTextStyle),
      ],
    );
  } else {
    content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Monospace Text Style',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Gap.sm(),
        Container(
          padding: AppSpacing.edgeInsetsAllSm,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text('''
void main() {
  print('Hello, World!');
  final greeting = 'Welcome';
  debugPrint(greeting);
}''', style: theme.monoTextStyle),
        ),
      ],
    );
  }

  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: Padding(
      padding: AppSpacing.edgeInsetsAllMd,
      child: Center(child: content),
    ),
  );
}

/// Demonstrates custom border radius variations.
@widgetbook.UseCase(name: 'Custom Border Radius', type: AppThemeExtension)
Widget customRadius(BuildContext context) {
  final radiusType = context.knobs.object.dropdown(
    label: 'Radius Type',
    options: ['XXS', 'XXL'],
    labelBuilder: (value) => value,
  );

  final theme = AppThemeExtension.light();

  final radius = radiusType == 'XXS' ? theme.radiusXxs! : theme.radiusXxl!;
  final label = radiusType == 'XXS'
      ? 'XXS Radius (${radius}dp)'
      : 'XXL Radius (${radius}dp)';
  final description = radiusType == 'XXS'
      ? 'Very subtle rounding'
      : 'Pill-shaped rounding';
  final color = radiusType == 'XXS'
      ? Theme.of(context).colorScheme.primaryContainer
      : Theme.of(context).colorScheme.secondaryContainer;

  return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: Padding(
      padding: AppSpacing.edgeInsetsAllMd,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: Theme.of(context).textTheme.titleMedium),
            Gap.sm(),
            Container(
              width: _kDemoContainerWidth,
              height: _kRadiusDemoHeight,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Center(child: Text(description)),
            ),
          ],
        ),
      ),
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// Helper Widgets
// ═════════════════════════════════════════════════════════════════════════════

class _ColorRow extends StatelessWidget {
  const _ColorRow({required this.label, required this.color});

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.edgeInsetsVXs,
      child: Row(
        children: [
          Container(
            width: _kColorPreviewSize,
            height: _kColorPreviewSize,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
          ),
          HGap.md(),
          AppBodyText.large(label),
        ],
      ),
    );
  }
}

class _SpacingRow extends StatelessWidget {
  const _SpacingRow({required this.label, required this.spacing});

  final String label;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.edgeInsetsVXs,
      child: Row(
        children: [
          Container(
            width: _kSpacingPreviewWidth,
            height: _kSpacingPreviewHeight,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
            ),
            child: Row(
              children: [
                Container(
                  width: spacing,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
          HGap.md(),
          AppBodyText.large('$label (${spacing}dp)'),
        ],
      ),
    );
  }
}

class _RadiusRow extends StatelessWidget {
  const _RadiusRow({required this.label, required this.radius});

  final String label;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.edgeInsetsVXs,
      child: Row(
        children: [
          Container(
            width: _kSpacingPreviewWidth,
            height: _kSpacingPreviewHeight,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          HGap.md(),
          AppBodyText.large('$label (${radius}dp)'),
        ],
      ),
    );
  }
}

class _ShadowCard extends StatelessWidget {
  const _ShadowCard({required this.label, required this.shadow});

  final String label;
  final BoxShadow? shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kShadowCardHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: shadow != null ? [shadow!] : null,
      ),
      child: Center(child: AppBodyText(label)),
    );
  }
}

class _SemanticCard extends StatelessWidget {
  const _SemanticCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.edgeInsetsAllMd,
      decoration: BoxDecoration(
        color: color?.withValues(alpha: _kSemanticColorOpacity),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color ?? Colors.transparent),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: _kSemanticIconSize),
          HGap.md(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLabel.large(title, color: color),
                Gap.xs(),
                AppBodyText(message),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemePreview extends StatelessWidget {
  const _ThemePreview({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = context.appThemeExtension;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: AppSpacing.edgeInsetsAllMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppH3(label),
            Gap.md(),
            _ColorRow(label: 'Success', color: theme.successColor),
            _ColorRow(label: 'Warning', color: theme.warningColor),
            _ColorRow(label: 'Info', color: theme.infoColor),
          ],
        ),
      ),
    );
  }
}

class _BrandCard extends StatelessWidget {
  const _BrandCard({
    required this.color,
    required this.label,
    required this.hex,
  });

  final Color color;
  final String label;
  final String hex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kBrandCardHeight,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLabel.large(label, color: Colors.white),
            Gap.xs(),
            AppCaption(text: hex, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}

String _colorToHex(Color color) {
  return '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
}
