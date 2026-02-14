// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppTheme] enhancements.
///
/// Demonstrates high-contrast modes, font scale adaptation,
/// color blindness simulation, theme validation, comparison,
/// debug overlay, and accessibility reporting.

// ═════════════════════════════════════════════════════════════════════════════
// Shared Helpers (DRY)
// ═════════════════════════════════════════════════════════════════════════════

/// All theme variant labels used across multiple stories.
const _kThemeVariants = ['Light', 'Dark', 'HC Light', 'HC Dark'];

/// Resolves a human-readable variant label to [ThemeData].
ThemeData _resolveTheme(String name) => switch (name) {
  'Dark' => AppTheme.dark(),
  'High Contrast Light' || 'HC Light' => AppTheme.highContrastLight(),
  'High Contrast Dark' || 'HC Dark' => AppTheme.highContrastDark(),
  _ => AppTheme.light(),
};

/// Resolves a human-readable variant label to a [ColorScheme].
ColorScheme _resolveColorScheme(String name) => switch (name) {
  'Dark' => AppColorScheme.dark(),
  'High Contrast Light' || 'HC Light' => AppColorScheme.highContrastLight(),
  'High Contrast Dark' || 'HC Dark' => AppColorScheme.highContrastDark(),
  _ => AppColorScheme.light(),
};

/// Human-readable display name for a variant key.
String _variantDisplayName(String key) => switch (key) {
  'HC Light' => 'High Contrast Light',
  'HC Dark' => 'High Contrast Dark',
  _ => '$key Theme',
};

/// Wraps [child] in a [Theme] with surface-colored background and scroll.
Widget _themedSurface({required ThemeData theme, required Widget child}) {
  return Theme(
    data: theme,
    child: Builder(
      builder: (ctx) => ColoredBox(
        color: Theme.of(ctx).colorScheme.surface,
        child: SingleChildScrollView(
          padding: AppSpacing.edgeInsetsAllMd,
          child: child,
        ),
      ),
    ),
  );
}

/// Standard set of sample components used across multiple stories.
///
/// Shows buttons ([AppButton]), an input ([AppTextField]), and a card
/// ([AppCard]) so theme changes are immediately visible.
class _ComponentSamples extends StatelessWidget {
  const _ComponentSamples();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            AppButton.filled(label: 'Filled', onPressed: () {}),
            AppButton.outlined(label: 'Outlined', onPressed: () {}),
            AppButton.text(label: 'Text', onPressed: () {}),
          ],
        ),
        const Gap.md(),
        const AppTextField(label: 'Sample Input', hint: 'Type here...'),
        const Gap.md(),
        AppCard(
          padding: AppSpacing.edgeInsetsAllMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Card Title', style: textTheme.titleMedium),
              const Gap.xs(),
              Text(
                'Card body content with theme styling.',
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// 1. Interactive Playground
// ═════════════════════════════════════════════════════════════════════════════

/// Interactive Playground — explore **all** theme enhancement features via
/// knobs on a **single [AppCard]** component instance.
///
/// Every knob directly mutates the theme that wraps the card, making each
/// feature's impact immediately visible on one unified surface:
///
/// | Knob                 | Effect on the card                         |
/// |----------------------|--------------------------------------------|
/// | Theme Variant        | Color scheme & surface tone                |
/// | Font Scale           | All typography sizes inside the card       |
/// | Color Blindness Mode | Color simulation on the entire palette     |
/// | Platform Adaptation  | iOS / Android typography & appBar tweaks   |
/// | Show Debug Overlay   | Overlays theme token inspector             |
@widgetbook.UseCase(name: 'Interactive Playground', type: AppTheme)
Widget appThemePlayground(BuildContext context) {
  // ── Knobs ────────────────────────────────────────────────────────────────
  final themeVariant = context.knobs.object.dropdown(
    label: 'Theme Variant',
    options: ['Light', 'Dark', 'High Contrast Light', 'High Contrast Dark'],
    initialOption: 'Light',
  );

  final fontScale = context.knobs.object.dropdown(
    label: 'Font Scale',
    options: FontScale.values,
    initialOption: FontScale.normal,
    labelBuilder: (scale) => '${scale.label} (${scale.factor}x)',
  );

  final colorBlindness = context.knobs.object.dropdown(
    label: 'Color Blindness Mode',
    options: ColorBlindnessMode.values,
    initialOption: ColorBlindnessMode.none,
    labelBuilder: (mode) => mode.label,
  );

  final platform = context.knobs.object.dropdown(
    label: 'Platform Adaptation',
    options: [TargetPlatform.android, TargetPlatform.iOS],
    initialOption: TargetPlatform.android,
    labelBuilder: (p) =>
        p == TargetPlatform.iOS ? 'iOS (Apple)' : 'Android (Material)',
  );

  final showDebugOverlay = context.knobs.boolean(
    label: 'Show Debug Overlay',
    initialValue: false,
  );

  // ── Theme composition ────────────────────────────────────────────────────
  var theme = _resolveTheme(themeVariant);

  if (fontScale != FontScale.normal) {
    theme = theme.copyWith(
      textTheme: FontScaleAdapter.scaleTextTheme(theme.textTheme, fontScale),
    );
  }

  if (colorBlindness != ColorBlindnessMode.none) {
    theme = theme.copyWith(
      colorScheme: ColorBlindnessSimulator.simulateScheme(
        theme.colorScheme,
        colorBlindness,
      ),
    );
  }

  theme = PlatformThemeAdapter.adapt(theme, platform);

  // ── Single-component render ──────────────────────────────────────────────
  return Theme(
    data: theme,
    child: Builder(
      builder: (ctx) {
        final tt = Theme.of(ctx).textTheme;
        final cs = Theme.of(ctx).colorScheme;
        final isApple = platform == TargetPlatform.iOS;

        return ColoredBox(
          color: cs.surface,
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: AppSpacing.edgeInsetsAllSm,
                child: AppCard(
                  padding: AppSpacing.edgeInsetsAllSm,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Header ──
                      Row(
                        children: [
                          Icon(Icons.palette, color: cs.primary),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              'Interactive Card',
                              style: tt.titleLarge,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Gap.xs(),
                      // Theme variant badge (scales with font)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: cs.primaryContainer,
                          borderRadius: AppRadius.xsRadius,
                        ),
                        child: Text(
                          themeVariant,
                          style: tt.labelSmall?.copyWith(
                            color: cs.onPrimaryContainer,
                          ),
                        ),
                      ),
                      const Gap.sm(),

                      // ── Platform hint (plain text, no fixed-height tag) ──
                      Row(
                        children: [
                          Icon(
                            isApple ? Icons.phone_iphone : Icons.phone_android,
                            size: 16,
                            color: cs.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              isApple
                                  ? 'iOS — SF Pro · Center · No splash'
                                  : 'Android — Roboto · Left · Ripple',
                              style: tt.labelSmall?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Gap.md(),

                      // ── Body text ──
                      Text(
                        'Adjust the knobs to see how theme '
                        'features affect this card.',
                        style: tt.bodyMedium,
                      ),
                      const Gap.md(),

                      // ── Color role indicators ──
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          _ColorChip(
                            label: 'Primary',
                            background: cs.primary,
                            foreground: cs.onPrimary,
                          ),
                          _ColorChip(
                            label: 'Secondary',
                            background: cs.secondary,
                            foreground: cs.onSecondary,
                          ),
                          _ColorChip(
                            label: 'Error',
                            background: cs.error,
                            foreground: cs.onError,
                          ),
                        ],
                      ),
                      const Gap.md(),

                      // ── Input field (HC borders / focus ring) ──
                      const AppTextField(
                        label: 'Input',
                        hint: 'Focus to see border styling…',
                        prefixIcon: Icons.search,
                      ),
                      const Gap.md(),

                      // ── Buttons ──
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          AppButton.filled(
                            label: 'Action',
                            icon: Icons.check_circle_outline,
                            onPressed: () {},
                            fullWidth: true,
                          ),
                          const Gap.sm(),
                          AppButton.outlined(
                            label: 'Cancel',
                            onPressed: () {},
                            fullWidth: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (showDebugOverlay) const ThemeDebugOverlay(),
            ],
          ),
        );
      },
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// 2. High Contrast Mode
// ═════════════════════════════════════════════════════════════════════════════

/// Demonstrates high-contrast themes with WCAG AAA compliance.
@widgetbook.UseCase(name: 'High Contrast Mode', type: AppTheme)
Widget highContrastMode(BuildContext context) {
  final isDark = context.knobs.boolean(label: 'Dark Mode', initialValue: false);

  final theme = isDark
      ? AppTheme.highContrastDark()
      : AppTheme.highContrastLight();

  return _themedSurface(
    theme: theme,
    child: Builder(
      builder: (ctx) {
        final colorScheme = Theme.of(ctx).colorScheme;
        final textTheme = Theme.of(ctx).textTheme;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            AppCard(
              color: colorScheme.primaryContainer,
              padding: AppSpacing.edgeInsetsAllMd,
              child: Row(
                children: [
                  Icon(
                    Icons.accessibility_new,
                    color: colorScheme.onPrimaryContainer,
                  ),
                  const Gap.sm(),
                  Expanded(
                    child: Text(
                      'High Contrast Mode — WCAG AAA (7:1)',
                      style: textTheme.titleMedium?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap.md(),

            // Contrast info
            AppSectionHeader(title: 'Key Contrast Ratios'),
            const Gap.xs(),
            _ContrastInfoRow(
              label: 'onSurface / surface',
              ratio: AppColorScheme.contrastRatio(
                colorScheme.onSurface,
                colorScheme.surface,
              ),
            ),
            _ContrastInfoRow(
              label: 'onPrimary / primary',
              ratio: AppColorScheme.contrastRatio(
                colorScheme.onPrimary,
                colorScheme.primary,
              ),
            ),
            _ContrastInfoRow(
              label: 'onError / error',
              ratio: AppColorScheme.contrastRatio(
                colorScheme.onError,
                colorScheme.error,
              ),
            ),
            const Gap.md(),

            // Component samples with 2dp borders
            AppSectionHeader(title: 'Components with 2dp borders'),
            const Gap.sm(),
            const _ComponentSamples(),
          ],
        );
      },
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// 3. Font Scale Adaptation
// ═════════════════════════════════════════════════════════════════════════════

/// Demonstrates font scale adaptation across all levels.
@widgetbook.UseCase(name: 'Font Scale Adaptation', type: AppTheme)
Widget fontScaleAdaptation(BuildContext context) {
  final fontScale = context.knobs.object.dropdown(
    label: 'Font Scale',
    options: FontScale.values,
    initialOption: FontScale.normal,
    labelBuilder: (scale) => '${scale.label} (${scale.factor}x)',
  );

  final isDark = Theme.of(context).brightness == Brightness.dark;
  final baseTheme = isDark ? AppTheme.dark() : AppTheme.light();
  final theme = baseTheme.copyWith(
    textTheme: FontScaleAdapter.scaleTextTheme(baseTheme.textTheme, fontScale),
  );

  return _themedSurface(
    theme: theme,
    child: Builder(
      builder: (ctx) {
        final textTheme = Theme.of(ctx).textTheme;
        final colorScheme = Theme.of(ctx).colorScheme;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTag(
              label: 'Scale: ${fontScale.label} (${fontScale.factor}x)',
              backgroundColor: colorScheme.tertiaryContainer,
              textColor: colorScheme.onTertiaryContainer,
            ),
            const Gap.md(),

            Text('Display Small', style: textTheme.displaySmall),
            const Gap.xs(),
            Text('Headline Medium', style: textTheme.headlineMedium),
            const Gap.xs(),
            Text('Title Large', style: textTheme.titleLarge),
            const Gap.xs(),
            Text('Title Medium', style: textTheme.titleMedium),
            const Gap.xs(),
            Text(
              'Body Large — The quick brown fox jumps.',
              style: textTheme.bodyLarge,
            ),
            const Gap.xs(),
            Text(
              'Body Medium — The quick brown fox jumps over the lazy dog.',
              style: textTheme.bodyMedium,
            ),
            const Gap.xs(),
            Text(
              'Body Small — Smaller text for captions.',
              style: textTheme.bodySmall,
            ),
            const Gap.xs(),
            Text('Label Large', style: textTheme.labelLarge),
            const Gap.xs(),
            Text('Label Small', style: textTheme.labelSmall),
            const Gap.lg(),

            AppButton.filled(label: 'Scaled Button', onPressed: () {}),
          ],
        );
      },
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// 4. Color Blindness Preview
// ═════════════════════════════════════════════════════════════════════════════

/// Demonstrates color blindness simulation modes.
@widgetbook.UseCase(name: 'Color Blindness Preview', type: AppTheme)
Widget colorBlindnessPreview(BuildContext context) {
  final mode = context.knobs.object.dropdown(
    label: 'Color Blindness Mode',
    options: ColorBlindnessMode.values,
    initialOption: ColorBlindnessMode.none,
    labelBuilder: (m) => m.label,
  );

  final isDark = Theme.of(context).brightness == Brightness.dark;
  final baseScheme = isDark ? AppColorScheme.dark() : AppColorScheme.light();
  final simulatedScheme = ColorBlindnessSimulator.simulateScheme(
    baseScheme,
    mode,
  );
  final theme = (isDark ? AppTheme.dark() : AppTheme.light()).copyWith(
    colorScheme: simulatedScheme,
  );

  return _themedSurface(
    theme: theme,
    child: Builder(
      builder: (ctx) {
        final textTheme = Theme.of(ctx).textTheme;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color Blindness: ${mode.label}',
              style: textTheme.titleMedium,
            ),
            const Gap.md(),

            AppSectionHeader(title: 'Primary Colors'),
            const Gap.xs(),
            _ColorSwatchRow(
              colors: {
                'primary': simulatedScheme.primary,
                'primaryContainer': simulatedScheme.primaryContainer,
                'secondary': simulatedScheme.secondary,
                'secondaryContainer': simulatedScheme.secondaryContainer,
              },
            ),
            const Gap.md(),

            AppSectionHeader(title: 'Semantic Colors'),
            const Gap.xs(),
            _ColorSwatchRow(
              colors: {
                'tertiary': simulatedScheme.tertiary,
                'error': simulatedScheme.error,
                'surface': simulatedScheme.surface,
                'outline': simulatedScheme.outline,
              },
            ),
            const Gap.md(),

            AppSectionHeader(title: 'Interactive Elements'),
            const Gap.sm(),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                AppButton.filled(label: 'Primary', onPressed: () {}),
                AppButton.outlined(label: 'Outlined', onPressed: () {}),
                AppButton.elevated(label: 'Elevated', onPressed: () {}),
              ],
            ),
            const Gap.md(),

            // Error banner
            AppCard(
              color: simulatedScheme.errorContainer,
              padding: AppSpacing.edgeInsetsAllMd,
              child: Row(
                children: [
                  Icon(Icons.warning, color: simulatedScheme.onErrorContainer),
                  const Gap.sm(),
                  Expanded(
                    child: Text(
                      'Error state visibility check',
                      style: textTheme.bodyMedium?.copyWith(
                        color: simulatedScheme.onErrorContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// 5. Theme Validation Tool
// ═════════════════════════════════════════════════════════════════════════════

/// Displays WCAG contrast validation results for theme color pairs.
@widgetbook.UseCase(name: 'Theme Validation Tool', type: AppTheme)
Widget themeValidationTool(BuildContext context) {
  final themeVariant = context.knobs.object.dropdown(
    label: 'Theme to Validate',
    options: _kThemeVariants,
    initialOption: 'Light',
  );

  final scheme = _resolveColorScheme(themeVariant);
  final results = ThemeValidator.validateColorScheme(scheme);
  final aaSummary = ThemeValidator.summary(scheme, WcagLevel.aa);
  final aaaSummary = ThemeValidator.summary(scheme, WcagLevel.aaa);

  final parentTheme = Theme.of(context);

  return ColoredBox(
    color: parentTheme.colorScheme.surface,
    child: SingleChildScrollView(
      padding: AppSpacing.edgeInsetsAllMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme Validation: $themeVariant',
            style: parentTheme.textTheme.titleMedium,
          ),
          const Gap.md(),

          // Summary cards
          Row(
            children: [
              Expanded(
                child: _SummaryCard(
                  title: 'WCAG AA (4.5:1)',
                  passing: aaSummary.passing,
                  total: aaSummary.total,
                  color: aaSummary.failing == 0
                      ? parentTheme.colorScheme.success
                      : parentTheme.colorScheme.warning,
                ),
              ),
              const Gap.sm(),
              Expanded(
                child: _SummaryCard(
                  title: 'WCAG AAA (7:1)',
                  passing: aaaSummary.passing,
                  total: aaaSummary.total,
                  color: aaaSummary.failing == 0
                      ? parentTheme.colorScheme.success
                      : parentTheme.colorScheme.warning,
                ),
              ),
            ],
          ),
          const Gap.md(),

          AppSectionHeader(title: 'Color Pair Details'),
          const Gap.sm(),
          ...results.map((r) => _ValidationResultRow(result: r)),
        ],
      ),
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// 6. Theme Comparison
// ═════════════════════════════════════════════════════════════════════════════

/// Side-by-side comparison of two themes.
@widgetbook.UseCase(name: 'Theme Comparison', type: AppTheme)
Widget themeComparisonStory(BuildContext context) {
  final leftTheme = context.knobs.object.dropdown(
    label: 'Left Theme',
    options: _kThemeVariants,
    initialOption: 'Light',
  );

  final rightTheme = context.knobs.object.dropdown(
    label: 'Right Theme',
    options: _kThemeVariants,
    initialOption: 'HC Light',
  );

  return ColoredBox(
    color: Theme.of(context).colorScheme.surface,
    child: SingleChildScrollView(
      padding: AppSpacing.edgeInsetsAllMd,
      child: ThemeComparison(
        leftTheme: _resolveTheme(leftTheme),
        rightTheme: _resolveTheme(rightTheme),
        leftLabel: leftTheme,
        rightLabel: rightTheme,
      ),
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// 7. Theme Debug Overlay
// ═════════════════════════════════════════════════════════════════════════════

/// Demonstrates the theme debug overlay.
@widgetbook.UseCase(name: 'Theme Debug Overlay', type: AppTheme)
Widget themeDebugOverlayStory(BuildContext context) {
  final isVisible = context.knobs.boolean(
    label: 'Overlay Visible',
    initialValue: true,
  );

  final alignment = context.knobs.object.dropdown(
    label: 'Alignment',
    options: ['Bottom Right', 'Bottom Left', 'Top Right', 'Top Left'],
    initialOption: 'Bottom Right',
  );

  final resolvedAlignment = switch (alignment) {
    'Bottom Left' => Alignment.bottomLeft,
    'Top Right' => Alignment.topRight,
    'Top Left' => Alignment.topLeft,
    _ => Alignment.bottomRight,
  };

  return ColoredBox(
    color: Theme.of(context).colorScheme.surface,
    child: SizedBox(
      width: double.infinity,
      height: 600,
      child: Stack(
        children: [
          Padding(
            padding: AppSpacing.edgeInsetsAllMd,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'App Content',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Gap.sm(),
                Text(
                  'The debug overlay floats above your content to show '
                  'current theme values in real-time.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Gap.md(),
                AppButton.filled(label: 'Sample Button', onPressed: () {}),
              ],
            ),
          ),
          ThemeDebugOverlay(isVisible: isVisible, alignment: resolvedAlignment),
        ],
      ),
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// 8. Accessibility Report
// ═════════════════════════════════════════════════════════════════════════════

/// Generates and displays an accessibility compliance report.
@widgetbook.UseCase(name: 'Accessibility Report', type: AppTheme)
Widget accessibilityReportStory(BuildContext context) {
  final themeVariant = context.knobs.object.dropdown(
    label: 'Theme',
    options: _kThemeVariants,
    initialOption: 'Light',
  );

  final scheme = _resolveColorScheme(themeVariant);
  final themeName = _variantDisplayName(themeVariant);
  final report = AccessibilityReportGenerator.generate(
    colorScheme: scheme,
    themeName: themeName,
  );

  final parentTheme = Theme.of(context);

  return ColoredBox(
    color: parentTheme.colorScheme.surface,
    child: SingleChildScrollView(
      padding: AppSpacing.edgeInsetsAllMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.accessibility, color: parentTheme.colorScheme.primary),
              const Gap.sm(),
              Text(
                'Accessibility Report',
                style: parentTheme.textTheme.titleMedium,
              ),
            ],
          ),
          const Gap.md(),
          AppCard(
            color: parentTheme.colorScheme.surfaceContainerHighest,
            padding: AppSpacing.edgeInsetsAllMd,
            child: SelectableText(
              report,
              style: parentTheme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

// ═════════════════════════════════════════════════════════════════════════════
// Private Helper Widgets
// ═════════════════════════════════════════════════════════════════════════════

/// A color swatch chip whose height scales with font size (2x-safe).
///
/// Unlike [AppTag] (fixed dp height), this widget uses padding-based
/// sizing so the label remains visible at all font scales.
class _ColorChip extends StatelessWidget {
  const _ColorChip({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.xsRadius,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Row of WCAG contrast ratio results with pass/fail icons.
class _ContrastInfoRow extends StatelessWidget {
  const _ContrastInfoRow({required this.label, required this.ratio});

  final String label;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final meetsAAA = ratio >= 7.0;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: AppSpacing.edgeInsetsVXs,
      child: Row(
        children: [
          Icon(
            meetsAAA ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: meetsAAA ? colorScheme.success : colorScheme.error,
          ),
          const Gap.sm(),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Text(
            '${ratio.toStringAsFixed(1)}:1',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// Renders a row of color swatches from a `{label: Color}` map.
class _ColorSwatchRow extends StatelessWidget {
  const _ColorSwatchRow({required this.colors});

  final Map<String, Color> colors;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: colors.entries.map((e) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: e.value,
                borderRadius: AppRadius.smRadius,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
            const Gap.xs(),
            SizedBox(
              width: 64,
              child: Text(
                e.key,
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

/// Summary card showing pass/total count for a WCAG level.
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.title,
    required this.passing,
    required this.total,
    required this.color,
  });

  final String title;
  final int passing;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: AppSpacing.edgeInsetsAllMd,
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.labelMedium),
          const Gap.xs(),
          Text(
            '$passing / $total',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Single row in the validation results list showing a contrast check.
class _ValidationResultRow extends StatelessWidget {
  const _ValidationResultRow({required this.result});

  final ContrastResult result;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: AppSpacing.edgeInsetsVXs,
      child: Row(
        children: [
          // Nested color swatch
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: result.background,
              borderRadius: AppRadius.xsRadius,
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: Center(
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: result.foreground,
                  borderRadius: AppRadius.xsRadius,
                ),
              ),
            ),
          ),
          const Gap.sm(),

          // Labels
          Expanded(
            child: Text(
              '${result.foregroundLabel} / ${result.backgroundLabel}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),

          // Ratio
          Text(
            '${result.contrastRatio.toStringAsFixed(1)}:1',
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
          ),
          const Gap.sm(),

          // Status
          Icon(
            result.meetsAA ? Icons.check : Icons.close,
            size: 14,
            color: result.meetsAA ? colorScheme.success : colorScheme.error,
          ),
          const Gap.xs(),
          Text(
            result.meetsAAA
                ? 'AAA'
                : result.meetsAA
                ? 'AA'
                : 'FAIL',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: result.meetsAAA
                  ? colorScheme.success
                  : result.meetsAA
                  ? colorScheme.warning
                  : colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
