// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

// ============================================================================
// Knob Helper Functions (DRY)
// ============================================================================

/// Available seed color options for theme generation.
const _seedColorOptions = [
  '0xFF6750A4', // Purple (M3 default)
  '0xFF0061A4', // Blue
  '0xFF006A60', // Teal
  '0xFF984061', // Pink
  '0xFF7D5700', // Orange
  '0xFF006E1C', // Green
  '0xFFBA1A1A', // Red
];

/// Short seed color options for compact stories.
const _seedColorOptionsShort = [
  '0xFF6750A4', // Purple
  '0xFF0061A4', // Blue
  '0xFF006A60', // Teal
];

/// Label builder for seed color options.
String _seedColorLabelBuilder(String value) {
  switch (value) {
    case '0xFF6750A4':
      return 'Purple (M3 Default)';
    case '0xFF0061A4':
      return 'Blue';
    case '0xFF006A60':
      return 'Teal';
    case '0xFF984061':
      return 'Pink';
    case '0xFF7D5700':
      return 'Orange';
    case '0xFF006E1C':
      return 'Green';
    case '0xFFBA1A1A':
      return 'Red';
    default:
      return value;
  }
}

/// Creates a seed color knob with full or short options.
Color _seedColorKnob(BuildContext context, {bool useShortOptions = false}) {
  final options = useShortOptions ? _seedColorOptionsShort : _seedColorOptions;
  final seedColorHex = context.knobs.object.dropdown(
    label: 'Seed Color',
    options: options,
    labelBuilder: _seedColorLabelBuilder,
  );
  return Color(int.parse(seedColorHex));
}

/// Gets brightness from Widgetbook's theme addon.
/// Falls back to light if not available.
Brightness _getBrightness(BuildContext context) {
  return Theme.of(context).brightness;
}

// ============================================================================
// Stories
// ============================================================================

/// Interactive Playground for AppThemeBuilder.
///
/// Allows testing all theme building features with interactive knobs.
/// Use Widgetbook's Addons (top bar) to switch between Light/Dark mode.
@UseCase(name: 'Interactive Playground', type: AppThemeBuilder)
Widget interactivePlayground(BuildContext context) {
  final seedColor = _seedColorKnob(context);

  final colorRole = context.knobs.object.dropdown(
    label: 'Color Role',
    options: const [
      'Primary',
      'Secondary',
      'Tertiary',
      'Error',
      'Surface',
      'Primary Container',
      'Secondary Container',
      'Tertiary Container',
    ],
    labelBuilder: (value) => value,
  );

  final componentType = context.knobs.object.dropdown(
    label: 'Component Type',
    options: const ['Tag', 'Button', 'Card'],
    labelBuilder: (value) => value,
  );

  final highContrast = context.knobs.boolean(
    label: 'High Contrast',
    initialValue: false,
  );

  final contrastLevel = context.knobs.double.slider(
    label: 'Contrast Level',
    initialValue: 0.5,
    min: 0.0,
    max: 1.0,
  );

  return Builder(
    builder: (context) {
      final brightness = _getBrightness(context);
      final colorScheme = AppThemeBuilder.generateColorScheme(
        seedColor: seedColor,
        brightness: brightness,
      );

      ThemeData theme = AppThemeBuilder.buildTheme(colorScheme: colorScheme);

      if (highContrast) {
        theme = AppThemeBuilder.buildHighContrastTheme(
          baseTheme: theme,
          contrastLevel: contrastLevel,
        );
      }

      // Get colors based on selected role
      Color backgroundColor;
      Color textColor;
      switch (colorRole) {
        case 'Secondary':
          backgroundColor = theme.colorScheme.secondary;
          textColor = theme.colorScheme.onSecondary;
        case 'Tertiary':
          backgroundColor = theme.colorScheme.tertiary;
          textColor = theme.colorScheme.onTertiary;
        case 'Error':
          backgroundColor = theme.colorScheme.error;
          textColor = theme.colorScheme.onError;
        case 'Surface':
          backgroundColor = theme.colorScheme.surface;
          textColor = theme.colorScheme.onSurface;
        case 'Primary Container':
          backgroundColor = theme.colorScheme.primaryContainer;
          textColor = theme.colorScheme.onPrimaryContainer;
        case 'Secondary Container':
          backgroundColor = theme.colorScheme.secondaryContainer;
          textColor = theme.colorScheme.onSecondaryContainer;
        case 'Tertiary Container':
          backgroundColor = theme.colorScheme.tertiaryContainer;
          textColor = theme.colorScheme.onTertiaryContainer;
        default: // Primary
          backgroundColor = theme.colorScheme.primary;
          textColor = theme.colorScheme.onPrimary;
      }

      // Build component based on type
      Widget buildComponent() {
        switch (componentType) {
          case 'Button':
            return Theme(
              data: theme,
              child: AppButton(label: colorRole, onPressed: () {}),
            );
          case 'Card':
            return Theme(
              data: theme,
              child: AppCard(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(colorRole, style: theme.textTheme.titleMedium),
                      const Gap.sm(),
                      Text(
                        'Generated from seed color',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            );
          default: // Tag
            return AppTag(
              label: colorRole,
              backgroundColor: backgroundColor,
              textColor: textColor,
            );
        }
      }

      return Theme(
        data: theme,
        child: Container(
          color: theme.colorScheme.surface,
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Center(child: buildComponent()),
        ),
      );
    },
  );
}

/// Seed Color Theme story.
///
/// Demonstrates generating a complete theme from a single seed color.
/// Use Widgetbook's Addons (top bar) to switch between Light/Dark mode.
@UseCase(name: 'Seed Color Theme', type: AppThemeBuilder)
Widget seedColorTheme(BuildContext context) {
  final seedColor = _seedColorKnob(context);

  final colorRole = context.knobs.object.dropdown(
    label: 'Color Role',
    options: const [
      'Primary',
      'Secondary',
      'Tertiary',
      'Error',
      'Surface',
      'Primary Container',
    ],
    labelBuilder: (value) => value,
  );

  return Builder(
    builder: (context) {
      final brightness = _getBrightness(context);
      final colorScheme = AppThemeBuilder.generateColorScheme(
        seedColor: seedColor,
        brightness: brightness,
      );
      final theme = AppThemeBuilder.buildTheme(colorScheme: colorScheme);

      // Get colors based on selected role
      Color backgroundColor;
      Color textColor;
      switch (colorRole) {
        case 'Secondary':
          backgroundColor = theme.colorScheme.secondary;
          textColor = theme.colorScheme.onSecondary;
        case 'Tertiary':
          backgroundColor = theme.colorScheme.tertiary;
          textColor = theme.colorScheme.onTertiary;
        case 'Error':
          backgroundColor = theme.colorScheme.error;
          textColor = theme.colorScheme.onError;
        case 'Surface':
          backgroundColor = theme.colorScheme.surface;
          textColor = theme.colorScheme.onSurface;
        case 'Primary Container':
          backgroundColor = theme.colorScheme.primaryContainer;
          textColor = theme.colorScheme.onPrimaryContainer;
        default: // Primary
          backgroundColor = theme.colorScheme.primary;
          textColor = theme.colorScheme.onPrimary;
      }

      return Theme(
        data: theme,
        child: Container(
          color: theme.colorScheme.surface,
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Center(
            child: AppTag(
              label: colorRole,
              backgroundColor: backgroundColor,
              textColor: textColor,
            ),
          ),
        ),
      );
    },
  );
}

/// Light/Dark Theme Pair story.
///
/// Shows both light and dark themes generated from the same seed color.
@UseCase(name: 'Light/Dark Theme Pair', type: AppThemeBuilder)
Widget lightDarkThemePair(BuildContext context) {
  final seedColor = _seedColorKnob(context, useShortOptions: true);

  final showLightTheme = context.knobs.boolean(
    label: 'Show Light Theme',
    initialValue: true,
  );

  final themes = AppThemeBuilder.buildThemePair(seedColor: seedColor);
  final theme = showLightTheme ? themes.light : themes.dark;

  return Theme(
    data: theme,
    child: Builder(
      builder: (context) {
        final colors = Theme.of(context).colorScheme;
        return Container(
          color: colors.surface,
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    showLightTheme ? Icons.light_mode : Icons.dark_mode,
                    color: colors.primary,
                  ),
                  const Gap.sm(),
                  Text(
                    showLightTheme ? 'Light Theme' : 'Dark Theme',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const Gap.md(),
              AppCard(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sample Card',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Gap.sm(),
                      Text(
                        'This card uses the generated theme colors.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const Gap.md(),
                      AppButton(label: 'Primary Button', onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

/// Dynamic Color Theme story.
///
/// Simulates Material You dynamic color extraction from wallpaper.
/// Use Widgetbook's Addons (top bar) to switch between Light/Dark mode.
@UseCase(name: 'Dynamic Color Theme', type: AppThemeBuilder)
Widget dynamicColorTheme(BuildContext context) {
  final wallpaperColorHex = context.knobs.object.dropdown(
    label: 'Simulated Wallpaper Color',
    options: const [
      '0xFF3C8CE7',
      '0xFF00695C',
      '0xFFF57C00',
      '0xFF7B1FA2',
      '0xFFD32F2F',
    ],
    labelBuilder: (value) {
      switch (value) {
        case '0xFF3C8CE7':
          return 'Sky Blue';
        case '0xFF00695C':
          return 'Teal';
        case '0xFFF57C00':
          return 'Orange';
        case '0xFF7B1FA2':
          return 'Purple';
        case '0xFFD32F2F':
          return 'Red';
        default:
          return value.toString();
      }
    },
  );

  final colorRole = context.knobs.object.dropdown(
    label: 'Color Role',
    options: const [
      'Primary',
      'Secondary',
      'Tertiary',
      'Error',
      'Surface',
      'Primary Container',
      'Secondary Container',
      'Tertiary Container',
    ],
    labelBuilder: (value) => value,
  );

  final wallpaperColor = Color(int.parse(wallpaperColorHex));

  return Builder(
    builder: (context) {
      final brightness = _getBrightness(context);
      final themes = AppThemeBuilder.buildFromDynamicColor(
        wallpaperColor: wallpaperColor,
      );
      final theme = brightness == Brightness.light ? themes.light : themes.dark;

      // Get colors based on selected role
      Color backgroundColor;
      Color textColor;
      switch (colorRole) {
        case 'Secondary':
          backgroundColor = theme.colorScheme.secondary;
          textColor = theme.colorScheme.onSecondary;
        case 'Tertiary':
          backgroundColor = theme.colorScheme.tertiary;
          textColor = theme.colorScheme.onTertiary;
        case 'Surface':
          backgroundColor = theme.colorScheme.surface;
          textColor = theme.colorScheme.onSurface;
        default: // Primary
          backgroundColor = theme.colorScheme.primary;
          textColor = theme.colorScheme.onPrimary;
      }

      return Theme(
        data: theme,
        child: Container(
          color: theme.colorScheme.surface,
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Center(
            child: AppTag(
              label: '$colorRole (Dynamic)',
              backgroundColor: backgroundColor,
              textColor: textColor,
            ),
          ),
        ),
      );
    },
  );
}

/// Custom ColorScheme story.
///
/// Demonstrates overriding specific color roles in the generated scheme.
/// Use Widgetbook's Addons (top bar) to switch between Light/Dark mode.
@UseCase(name: 'Custom ColorScheme', type: AppThemeBuilder)
Widget customColorScheme(BuildContext context) {
  final seedColor = _seedColorKnob(context, useShortOptions: true);

  final colorRole = context.knobs.object.dropdown(
    label: 'Color Role to Override',
    options: const ['Primary', 'Secondary', 'None'],
    labelBuilder: (value) => value,
  );

  return Builder(
    builder: (context) {
      final brightness = _getBrightness(context);
      final colorScheme = AppThemeBuilder.generateCustomColorScheme(
        seedColor: seedColor,
        brightness: brightness,
        primary: colorRole == 'Primary' ? const Color(0xFFFF5722) : null,
        secondary: colorRole == 'Secondary' ? const Color(0xFF4CAF50) : null,
      );
      final theme = AppThemeBuilder.buildTheme(colorScheme: colorScheme);

      // Get the appropriate colors
      Color backgroundColor;
      Color textColor;
      String label;
      switch (colorRole) {
        case 'Primary':
          backgroundColor = theme.colorScheme.primary;
          textColor = theme.colorScheme.onPrimary;
          label = 'Primary (Custom: Orange)';
        case 'Secondary':
          backgroundColor = theme.colorScheme.secondary;
          textColor = theme.colorScheme.onSecondary;
          label = 'Secondary (Custom: Green)';
        default: // None
          backgroundColor = theme.colorScheme.primary;
          textColor = theme.colorScheme.onPrimary;
          label = 'Primary (From Seed)';
      }

      return Theme(
        data: theme,
        child: Container(
          color: theme.colorScheme.surface,
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Center(
            child: AppTag(
              label: label,
              backgroundColor: backgroundColor,
              textColor: textColor,
            ),
          ),
        ),
      );
    },
  );
}

/// Theme Switching Animation story.
///
/// Demonstrates smooth animated transitions between themes.
@UseCase(name: 'Theme Switching Animation', type: AppThemeBuilder)
Widget themeSwitchingAnimation(BuildContext context) {
  final seedColor = _seedColorKnob(context, useShortOptions: true);

  final animationDurationMs = context.knobs.double.slider(
    label: 'Animation Duration (ms)',
    initialValue: 300,
    min: 100,
    max: 1000,
  );

  final animationCurve = context.knobs.object.dropdown(
    label: 'Animation Curve',
    options: const ['easeInOut', 'easeIn', 'easeOut', 'linear'],
    labelBuilder: (value) => value,
  );

  Curve getCurve(String name) {
    switch (name) {
      case 'easeIn':
        return Curves.easeIn;
      case 'easeOut':
        return Curves.easeOut;
      case 'linear':
        return Curves.linear;
      default:
        return Curves.easeInOut;
    }
  }

  final themes = AppThemeBuilder.buildThemePair(seedColor: seedColor);

  return _ThemeSwitchAnimationDemo(
    lightTheme: themes.light,
    darkTheme: themes.dark,
    duration: Duration(milliseconds: animationDurationMs.toInt()),
    curve: getCurve(animationCurve),
  );
}

/// Theme Preview Comparison story.
///
/// Preview components with different theme configurations.
/// Use Widgetbook's Addons (top bar) to switch between Light/Dark mode.
@UseCase(name: 'Theme Preview Comparison', type: AppThemeBuilder)
Widget themePreviewComparison(BuildContext context) {
  final seedColor = _seedColorKnob(context, useShortOptions: true);

  final componentType = context.knobs.object.dropdown(
    label: 'Component Type',
    options: const ['Tag', 'Button', 'Card'],
    labelBuilder: (value) => value,
  );

  return Builder(
    builder: (context) {
      final brightness = _getBrightness(context);
      final colorScheme = AppThemeBuilder.generateColorScheme(
        seedColor: seedColor,
        brightness: brightness,
      );
      final theme = AppThemeBuilder.buildTheme(colorScheme: colorScheme);

      Widget buildPreviewComponent(String type) {
        switch (type) {
          case 'Button':
            return AppButton(label: 'Preview Button', onPressed: () {});
          case 'TextField':
            return const AppTextField(
              label: 'Preview TextField',
              hint: 'Enter text...',
            );
          case 'Chip':
            return AppChip.suggestion(label: 'Preview Chip', onTap: () {});
          case 'Card':
          default:
            return AppCard(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Preview Card', style: theme.textTheme.titleMedium),
                    const Gap.sm(),
                    Text(
                      'Card content with theme colors applied.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
        }
      }

      return Theme(
        data: theme,
        child: Builder(
          builder: (context) {
            final colors = Theme.of(context).colorScheme;
            return Container(
              color: colors.surface,
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Component Preview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Gap.sm(),
                  Text(
                    'Preview different components with the current theme.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const Gap.lg(),
                  Center(child: buildPreviewComponent(componentType)),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

/// High Contrast Accessibility story.
///
/// Demonstrates accessibility-optimized high contrast themes.
/// Use Widgetbook's Addons (top bar) to switch between Light/Dark mode.
@UseCase(name: 'High Contrast Accessibility', type: AppThemeBuilder)
Widget highContrastAccessibility(BuildContext context) {
  final seedColor = _seedColorKnob(context, useShortOptions: true);

  final highContrast = context.knobs.boolean(
    label: 'High Contrast Mode',
    initialValue: true,
  );

  final contrastLevel = context.knobs.double.slider(
    label: 'Contrast Level',
    initialValue: 0.5,
    min: 0.0,
    max: 1.0,
  );

  return Builder(
    builder: (context) {
      final brightness = _getBrightness(context);
      final colorScheme = AppThemeBuilder.generateColorScheme(
        seedColor: seedColor,
        brightness: brightness,
      );

      ThemeData theme = AppThemeBuilder.buildTheme(colorScheme: colorScheme);

      if (highContrast) {
        theme = AppThemeBuilder.buildHighContrastTheme(
          baseTheme: theme,
          contrastLevel: contrastLevel,
        );
      }

      return Theme(
        data: theme,
        child: Builder(
          builder: (context) {
            final colors = Theme.of(context).colorScheme;
            return Container(
              color: colors.surface,
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.accessibility, color: colors.primary),
                      const Gap.sm(),
                      Text(
                        'Accessibility Theme',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const Gap.sm(),
                  Text(
                    highContrast
                        ? 'High contrast mode enabled for better visibility.'
                        : 'Standard contrast mode.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                  const Gap.md(),
                  _ContrastInfo(colorScheme: colors),
                  const Gap.md(),
                  AppCard(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sample Content',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Gap.sm(),
                          Text(
                            'This text should be readable with good contrast.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Gap.md(),
                          AppButton(label: 'Action Button', onPressed: () {}),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

// ============================================================================
// Helper Widgets
// ============================================================================

class _ContrastInfo extends StatelessWidget {
  const _ContrastInfo({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final primaryContrast = AppThemeBuilder.getContrastRatio(
      colorScheme.onPrimary,
      colorScheme.primary,
    );
    final surfaceContrast = AppThemeBuilder.getContrastRatio(
      colorScheme.onSurface,
      colorScheme.surface,
    );

    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contrast Ratios',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const Gap.sm(),
            _ContrastRow(label: 'onPrimary / Primary', ratio: primaryContrast),
            const Gap.xs(),
            _ContrastRow(label: 'onSurface / Surface', ratio: surfaceContrast),
          ],
        ),
      ),
    );
  }
}

class _ContrastRow extends StatelessWidget {
  const _ContrastRow({required this.label, required this.ratio});

  final String label;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final meetsAA = ratio >= AppThemeBuilder.wcagAANormalText;
    final meetsAAA = ratio >= AppThemeBuilder.wcagAAANormalText;

    return Row(
      children: [
        Expanded(
          child: Text(label, style: Theme.of(context).textTheme.bodySmall),
        ),
        Text(
          '${ratio.toStringAsFixed(1)}:1',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap.sm(),
        AppTag(
          label: meetsAAA
              ? 'AAA'
              : meetsAA
              ? 'AA'
              : 'Fail',
          size: AppTagSize.small,
          backgroundColor: meetsAAA
              ? colors.primary
              : meetsAA
              ? colors.tertiary
              : colors.error,
          textColor: meetsAAA
              ? colors.onPrimary
              : meetsAA
              ? colors.onTertiary
              : colors.onError,
        ),
      ],
    );
  }
}

class _ThemeSwitchAnimationDemo extends StatefulWidget {
  const _ThemeSwitchAnimationDemo({
    required this.lightTheme,
    required this.darkTheme,
    required this.duration,
    required this.curve,
  });

  final ThemeData lightTheme;
  final ThemeData darkTheme;
  final Duration duration;
  final Curve curve;

  @override
  State<_ThemeSwitchAnimationDemo> createState() =>
      _ThemeSwitchAnimationDemoState();
}

class _ThemeSwitchAnimationDemoState extends State<_ThemeSwitchAnimationDemo> {
  bool _isLight = true;

  @override
  Widget build(BuildContext context) {
    final theme = _isLight ? widget.lightTheme : widget.darkTheme;

    return AnimatedTheme(
      data: theme,
      duration: widget.duration,
      curve: widget.curve,
      child: Builder(
        builder: (context) {
          final colors = Theme.of(context).colorScheme;
          return Container(
            color: colors.surface,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Animated Theme Switch',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap.sm(),
                Text(
                  'Tap the switch to see smooth theme transition.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const Gap.md(),
                AppSwitch(
                  value: !_isLight,
                  onChanged: (value) {
                    setState(() {
                      _isLight = !value;
                    });
                  },
                  label: _isLight ? 'Light Mode' : 'Dark Mode',
                ),
                const Gap.lg(),
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Animated Card',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Gap.sm(),
                        Text(
                          'Watch the colors transition smoothly.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Gap.md(),
                        Row(
                          children: [
                            AppButton(label: 'Primary', onPressed: () {}),
                            const Gap.sm(),
                            AppOutlinedButton(
                              label: 'Outlined',
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
