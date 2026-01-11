// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppColorScheme].
///
/// Demonstrates Material Design 3 color system with interactive knobs
/// for exploring color tokens, surface variants, and semantic colors.

/// Interactive Playground - Explore color roles with a single demonstration component
@widgetbook.UseCase(name: 'Interactive Playground', type: AppColorScheme)
Widget appColorSchemePlayground(BuildContext context) {
  // Color role selection
  final colorRole = context.knobs.object.dropdown(
    label: 'Color Role',
    options: const [
      'Primary',
      'Secondary',
      'Tertiary',
      'Error',
      'Success',
      'Warning',
      'Info',
      'Surface',
    ],
    labelBuilder: (value) => value,
  );

  final useContainer = context.knobs.boolean(
    label: 'Use Container Variant',
    initialValue: false,
  );

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );

  final showButton = context.knobs.boolean(
    label: 'Show Action Button',
    initialValue: true,
  );

  // Use Widgetbook's theme switcher from Addons panel
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final colorScheme = isDark ? AppColorScheme.dark() : AppColorScheme.light();

  // Get colors based on selection
  Color backgroundColor;
  Color textColor;
  IconData icon;
  String title;
  String description;

  switch (colorRole) {
    case 'Primary':
      backgroundColor = useContainer
          ? colorScheme.primaryContainer
          : colorScheme.primary;
      textColor = useContainer
          ? colorScheme.onPrimaryContainer
          : colorScheme.onPrimary;
      icon = Icons.star;
      title = 'Primary Color Role';
      description = 'Key components and high-emphasis actions';
      break;
    case 'Secondary':
      backgroundColor = useContainer
          ? colorScheme.secondaryContainer
          : colorScheme.secondary;
      textColor = useContainer
          ? colorScheme.onSecondaryContainer
          : colorScheme.onSecondary;
      icon = Icons.palette;
      title = 'Secondary Color Role';
      description = 'Less prominent components';
      break;
    case 'Tertiary':
      backgroundColor = useContainer
          ? colorScheme.tertiaryContainer
          : colorScheme.tertiary;
      textColor = useContainer
          ? colorScheme.onTertiaryContainer
          : colorScheme.onTertiary;
      icon = Icons.brush;
      title = 'Tertiary Color Role';
      description = 'Complementary accents';
      break;
    case 'Error':
      backgroundColor = useContainer
          ? colorScheme.errorContainer
          : colorScheme.error;
      textColor = useContainer
          ? colorScheme.onErrorContainer
          : colorScheme.onError;
      icon = Icons.error;
      title = 'Error Color Role';
      description = 'Destructive actions and warnings';
      break;
    case 'Success':
      backgroundColor = useContainer
          ? colorScheme.successContainer
          : colorScheme.success;
      textColor = useContainer
          ? colorScheme.onSuccessContainer
          : colorScheme.onSuccess;
      icon = Icons.check_circle;
      title = 'Success Color Role';
      description = 'Positive feedback and completed states';
      break;
    case 'Warning':
      backgroundColor = useContainer
          ? colorScheme.warningContainer
          : colorScheme.warning;
      textColor = useContainer
          ? colorScheme.onWarningContainer
          : colorScheme.onWarning;
      icon = Icons.warning;
      title = 'Warning Color Role';
      description = 'Cautionary feedback';
      break;
    case 'Info':
      backgroundColor = useContainer
          ? colorScheme.infoContainer
          : colorScheme.info;
      textColor = useContainer
          ? colorScheme.onInfoContainer
          : colorScheme.onInfo;
      icon = Icons.info;
      title = 'Info Color Role';
      description = 'Informational feedback';
      break;
    case 'Surface':
    default:
      backgroundColor = colorScheme.surfaceContainer;
      textColor = colorScheme.onSurface;
      icon = Icons.layers;
      title = 'Surface Color Role';
      description = 'Backgrounds and cards';
  }

  final hexValue =
      '#${backgroundColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  final textHexValue =
      '#${textColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

  return Scaffold(
    backgroundColor: colorScheme.surface,
    appBar: AppBar(
      title: Text('Color Playground - ${isDark ? "Dark" : "Light"} Mode'),
      backgroundColor: colorScheme.surfaceContainer,
      foregroundColor: colorScheme.onSurface,
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main demonstration card
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: AppCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                color: backgroundColor,
                borderRadius: AppRadius.lgRadius,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with icon
                    Row(
                      children: [
                        if (showIcon)
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Icon(icon, color: textColor, size: 32),
                          ),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Description
                    Text(
                      description,
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    // Color information
                    AppCard(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      color: textColor.withValues(alpha: 0.1),
                      borderRadius: AppRadius.smRadius,
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Background: $hexValue',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Foreground: $textHexValue',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showButton) ...[
                      const SizedBox(height: 16),
                      // Action button
                      AppButton.elevated(
                        label: 'Action Button',
                        onPressed: () {},
                        fullWidth: true,
                        backgroundColor: textColor,
                        foregroundColor: backgroundColor,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Light vs Dark Comparison - Side-by-side theme comparison
@widgetbook.UseCase(name: 'Light vs Dark Comparison', type: AppColorScheme)
Widget appColorSchemeLightDarkComparison(BuildContext context) {
  final roleFilter = context.knobs.object.dropdown(
    label: 'Color Role Filter',
    options: const [
      'All',
      'Primary',
      'Secondary',
      'Tertiary',
      'Error',
      'Surface',
      'Semantic',
    ],
    labelBuilder: (value) => value,
  );

  final lightScheme = AppColorScheme.light();
  final darkScheme = AppColorScheme.dark();

  Map<String, Color> getFilteredColors(ColorScheme scheme) {
    final Map<String, Color> colors = {};

    if (roleFilter == 'All' || roleFilter == 'Primary') {
      colors.addAll({
        'primary': scheme.primary,
        'onPrimary': scheme.onPrimary,
        'primaryContainer': scheme.primaryContainer,
      });
    }

    if (roleFilter == 'All' || roleFilter == 'Secondary') {
      colors.addAll({
        'secondary': scheme.secondary,
        'onSecondary': scheme.onSecondary,
        'secondaryContainer': scheme.secondaryContainer,
      });
    }

    if (roleFilter == 'All' || roleFilter == 'Tertiary') {
      colors.addAll({
        'tertiary': scheme.tertiary,
        'tertiaryContainer': scheme.tertiaryContainer,
      });
    }

    if (roleFilter == 'All' || roleFilter == 'Error') {
      colors.addAll({
        'error': scheme.error,
        'errorContainer': scheme.errorContainer,
      });
    }

    if (roleFilter == 'All' || roleFilter == 'Surface') {
      colors.addAll({
        'surface': scheme.surface,
        'surfaceContainer': scheme.surfaceContainer,
        'surfaceContainerHigh': scheme.surfaceContainerHigh,
      });
    }

    if (roleFilter == 'All' || roleFilter == 'Semantic') {
      colors.addAll({
        'success': scheme.success,
        'warning': scheme.warning,
        'info': scheme.info,
      });
    }

    return colors;
  }

  final lightColors = getFilteredColors(lightScheme);
  final darkColors = getFilteredColors(darkScheme);

  return Scaffold(
    backgroundColor: Colors.grey[200],
    body: Row(
      children: [
        // Light theme side
        Expanded(
          child: Container(
            color: lightScheme.surface,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  color: lightScheme.primary,
                  child: Center(
                    child: Text(
                      'Light Theme',
                      style: TextStyle(
                        color: lightScheme.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: lightColors.length,
                    itemBuilder: (context, index) {
                      final entry = lightColors.entries.elementAt(index);
                      return _buildColorTile(entry.key, entry.value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // Divider
        Container(width: 2, color: Colors.grey[400]),
        // Dark theme side
        Expanded(
          child: Container(
            color: darkScheme.surface,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  color: darkScheme.primary,
                  child: Center(
                    child: Text(
                      'Dark Theme',
                      style: TextStyle(
                        color: darkScheme.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: darkColors.length,
                    itemBuilder: (context, index) {
                      final entry = darkColors.entries.elementAt(index);
                      return _buildColorTile(entry.key, entry.value);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// Semantic Color Usage - Demonstrates semantic feedback colors
@widgetbook.UseCase(name: 'Semantic Color Usage', type: AppColorScheme)
Widget appColorSchemeSemanticUsage(BuildContext context) {
  final semanticType = context.knobs.object.dropdown(
    label: 'Semantic Type',
    options: const ['Success', 'Warning', 'Info', 'Error'],
    labelBuilder: (value) => value,
  );

  final useContainer = context.knobs.boolean(
    label: 'Use Container Variant',
    initialValue: false,
  );

  // Use Widgetbook's theme switcher from Addons panel
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final colorScheme = isDark ? AppColorScheme.dark() : AppColorScheme.light();

  Color backgroundColor;
  Color textColor;
  IconData icon;
  String message;

  switch (semanticType) {
    case 'Success':
      backgroundColor = useContainer
          ? colorScheme.successContainer
          : colorScheme.success;
      textColor = useContainer
          ? colorScheme.onSuccessContainer
          : colorScheme.onSuccess;
      icon = Icons.check_circle;
      message = 'Operation completed successfully!';
      break;
    case 'Warning':
      backgroundColor = useContainer
          ? colorScheme.warningContainer
          : colorScheme.warning;
      textColor = useContainer
          ? colorScheme.onWarningContainer
          : colorScheme.onWarning;
      icon = Icons.warning;
      message = 'Please review this information carefully.';
      break;
    case 'Info':
      backgroundColor = useContainer
          ? colorScheme.infoContainer
          : colorScheme.info;
      textColor = useContainer
          ? colorScheme.onInfoContainer
          : colorScheme.onInfo;
      icon = Icons.info;
      message = 'Here is some helpful information for you.';
      break;
    case 'Error':
    default:
      backgroundColor = useContainer
          ? colorScheme.errorContainer
          : colorScheme.error;
      textColor = useContainer
          ? colorScheme.onErrorContainer
          : colorScheme.onError;
      icon = Icons.error;
      message = 'An error occurred. Please try again.';
  }

  return Scaffold(
    backgroundColor: colorScheme.surface,
    appBar: AppBar(
      title: Text('Semantic Colors - $semanticType'),
      backgroundColor: colorScheme.surfaceContainer,
    ),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Card example
            AppCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              color: backgroundColor,
              borderRadius: AppRadius.mdRadius,
              elevation: 1,
              child: Row(
                children: [
                  Icon(icon, color: textColor, size: 32),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Button example
            AppButton.elevated(
              label: '$semanticType Action',
              icon: icon,
              onPressed: () {},
              backgroundColor: backgroundColor,
              foregroundColor: textColor,
            ),
            const SizedBox(height: 16),
            // Chip example
            AppChip.assist(
              label: semanticType,
              icon: icon,
              backgroundColor: backgroundColor,
              labelColor: textColor,
            ),
          ],
        ),
      ),
    ),
  );
}

/// Surface Variant Hierarchy - Shows all 7 surface levels
@widgetbook.UseCase(name: 'Surface Variant Hierarchy', type: AppColorScheme)
Widget appColorSchemeSurfaceVariants(BuildContext context) {
  final surfaceLevel = context.knobs.object.dropdown(
    label: 'Surface Level',
    options: const [
      'Lowest (0dp)',
      'Low (1dp)',
      'Container (3dp)',
      'High (6dp)',
      'Highest (12dp)',
      'Dim (Recessed)',
      'Bright (Elevated)',
    ],
    labelBuilder: (value) => value,
  );

  final showContent = context.knobs.boolean(
    label: 'Show Example Content',
    initialValue: true,
  );

  // Use Widgetbook's theme switcher from Addons panel
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final colorScheme = isDark ? AppColorScheme.dark() : AppColorScheme.light();

  // Determine surface color and metadata based on selection
  Color surfaceColor;
  String colorName;
  String elevationInfo;
  String usageDescription;

  switch (surfaceLevel) {
    case 'Lowest (0dp)':
      surfaceColor = colorScheme.surfaceContainerLowest;
      colorName = 'surfaceContainerLowest';
      elevationInfo = '0dp elevation';
      usageDescription =
          'Lowest emphasis surface. Used for subtle backgrounds and least prominent containers.';
      break;
    case 'Low (1dp)':
      surfaceColor = colorScheme.surfaceContainerLow;
      colorName = 'surfaceContainerLow';
      elevationInfo = '1dp elevation';
      usageDescription =
          'Low emphasis surface. Slightly elevated from the base surface.';
      break;
    case 'Container (3dp)':
      surfaceColor = colorScheme.surfaceContainer;
      colorName = 'surfaceContainer';
      elevationInfo = '3dp elevation (default)';
      usageDescription =
          'Default container surface. Standard cards and container backgrounds.';
      break;
    case 'High (6dp)':
      surfaceColor = colorScheme.surfaceContainerHigh;
      colorName = 'surfaceContainerHigh';
      elevationInfo = '6dp elevation';
      usageDescription =
          'High emphasis surface. More prominent containers and elevated cards.';
      break;
    case 'Highest (12dp)':
      surfaceColor = colorScheme.surfaceContainerHighest;
      colorName = 'surfaceContainerHighest';
      elevationInfo = '12dp elevation';
      usageDescription =
          'Highest emphasis surface. Most prominent containers, dialogs, and modals.';
      break;
    case 'Dim (Recessed)':
      surfaceColor = colorScheme.surfaceDim;
      colorName = 'surfaceDim';
      elevationInfo = 'Recessed appearance';
      usageDescription =
          'Recessed surface variant. Creates depth by appearing below the base surface.';
      break;
    case 'Bright (Elevated)':
    default:
      surfaceColor = colorScheme.surfaceBright;
      colorName = 'surfaceBright';
      elevationInfo = 'Elevated appearance';
      usageDescription =
          'Bright surface variant. Creates elevation by appearing above the base surface.';
  }

  final hexValue =
      '#${surfaceColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

  return Scaffold(
    backgroundColor: colorScheme.surface,
    appBar: AppBar(
      title: Text('Surface Variant - $surfaceLevel'),
      backgroundColor: colorScheme.surfaceContainer,
      foregroundColor: colorScheme.onSurface,
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main surface demonstration
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: AppCard(
                padding: const EdgeInsets.all(AppSpacing.xl),
                color: surfaceColor,
                borderRadius: AppRadius.lgRadius,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: colorScheme.outline, width: 2),
                  borderRadius: AppRadius.lgRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      colorName,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      elevationInfo,
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 14,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppCard(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      color: colorScheme.onSurface.withValues(alpha: 0.05),
                      borderRadius: AppRadius.smRadius,
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hex Value: $hexValue',
                            style: TextStyle(
                              color: colorScheme.onSurface,
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            usageDescription,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showContent) ...[
                      const SizedBox(height: 24),
                      Divider(color: colorScheme.outline),
                      const SizedBox(height: 16),
                      Text(
                        'Example Content',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This is how text and content would appear on this surface variant. The surface color provides the appropriate contrast and visual hierarchy for the content.',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton.outlined(
                              label: 'Secondary',
                              onPressed: () {},
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: AppButton.filled(
                              label: 'Primary',
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Contrast Ratio Tester - Test WCAG compliance
@widgetbook.UseCase(name: 'Contrast Ratio Tester', type: AppColorScheme)
Widget appColorSchemeContrastTester(BuildContext context) {
  final foregroundColor =
      context.knobs.colorOrNull(
        label: 'Foreground Color',
        initialValue: Colors.black,
      ) ??
      Colors.black;

  final backgroundColor =
      context.knobs.colorOrNull(
        label: 'Background Color',
        initialValue: Colors.white,
      ) ??
      Colors.white;

  final fontSize = context.knobs.object.dropdown(
    label: 'Font Size',
    options: const ['Large (18pt+)', 'Normal (14-17pt)', 'Small (<14pt)'],
    labelBuilder: (value) => value,
  );

  final isBold = context.knobs.boolean(label: 'Bold Text', initialValue: false);

  final ratio = AppColorScheme.contrastRatio(foregroundColor, backgroundColor);

  // WCAG standards
  bool passesAANormal = ratio >= 4.5;
  bool passesAALarge = ratio >= 3.0;
  bool passesAAANormal = ratio >= 7.0;
  bool passesAAALarge = ratio >= 4.5;

  String getCompliance() {
    if (fontSize == 'Large (18pt+)' ||
        (fontSize == 'Normal (14-17pt)' && isBold)) {
      if (passesAAALarge) return 'AAA ✓';
      if (passesAALarge) return 'AA ✓';
      return 'Fails';
    } else {
      if (passesAAANormal) return 'AAA ✓';
      if (passesAANormal) return 'AA ✓';
      return 'Fails';
    }
  }

  return Scaffold(
    backgroundColor: Colors.grey[200],
    appBar: AppBar(title: const Text('Contrast Ratio Tester')),
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Preview
            AppCard(
              padding: const EdgeInsets.all(AppSpacing.xl),
              color: backgroundColor,
              borderRadius: AppRadius.mdRadius,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: AppRadius.mdRadius,
              ),
              child: Text(
                'Sample Text',
                style: TextStyle(
                  color: foregroundColor,
                  fontSize: fontSize == 'Large (18pt+)'
                      ? 24
                      : fontSize == 'Normal (14-17pt)'
                      ? 16
                      : 12,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            // Results
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Contrast Ratio: ${ratio.toStringAsFixed(2)}:1',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'WCAG Compliance: ${getCompliance()}',
                      style: TextStyle(
                        fontSize: 16,
                        color: getCompliance().contains('✓')
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    _buildComplianceRow(
                      'AA Normal Text (4.5:1)',
                      passesAANormal,
                    ),
                    _buildComplianceRow('AA Large Text (3.0:1)', passesAALarge),
                    _buildComplianceRow(
                      'AAA Normal Text (7.0:1)',
                      passesAAANormal,
                    ),
                    _buildComplianceRow(
                      'AAA Large Text (4.5:1)',
                      passesAAALarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper widgets

Widget _buildColorTile(String name, Color color) {
  final hexValue =
      '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  return AppCard(
    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
    padding: const EdgeInsets.all(AppSpacing.sm),
    color: color,
    borderRadius: AppRadius.smRadius,
    elevation: 0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            color: _getTextColorForBackground(color),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          hexValue,
          style: TextStyle(
            color: _getTextColorForBackground(color),
            fontSize: 11,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

Widget _buildComplianceRow(String label, bool passes) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Icon(
          passes ? Icons.check_circle : Icons.cancel,
          color: passes ? Colors.green : Colors.red,
          size: 20,
        ),
      ],
    ),
  );
}

/// Color Palette Grid - Explore individual color tokens
@widgetbook.UseCase(name: 'Color Palette Grid', type: AppColorScheme)
Widget appColorSchemeColorPaletteGrid(BuildContext context) {
  final colorToken = context.knobs.object.dropdown(
    label: 'Color Token',
    options: const [
      'primary',
      'onPrimary',
      'primaryContainer',
      'onPrimaryContainer',
      'secondary',
      'onSecondary',
      'secondaryContainer',
      'onSecondaryContainer',
      'tertiary',
      'onTertiary',
      'tertiaryContainer',
      'onTertiaryContainer',
      'error',
      'onError',
      'errorContainer',
      'onErrorContainer',
      'success',
      'onSuccess',
      'successContainer',
      'onSuccessContainer',
      'warning',
      'onWarning',
      'warningContainer',
      'onWarningContainer',
      'info',
      'onInfo',
      'infoContainer',
      'onInfoContainer',
      'surface',
      'onSurface',
      'surfaceContainer',
    ],
    labelBuilder: (value) => value,
  );

  final showUsageInfo = context.knobs.boolean(
    label: 'Show Usage Info',
    initialValue: true,
  );

  // Use Widgetbook's theme switcher from Addons panel
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final colorScheme = isDark ? AppColorScheme.dark() : AppColorScheme.light();

  // Get color and metadata based on selection
  Color color;
  String colorFamily;
  String usageDescription;

  switch (colorToken) {
    case 'primary':
      color = colorScheme.primary;
      colorFamily = 'Primary Family';
      usageDescription =
          'Key components and high-emphasis actions (FAB, filled buttons, app bars)';
      break;
    case 'onPrimary':
      color = colorScheme.onPrimary;
      colorFamily = 'Primary Family';
      usageDescription = 'Text and icons on primary color';
      break;
    case 'primaryContainer':
      color = colorScheme.primaryContainer;
      colorFamily = 'Primary Family';
      usageDescription = 'Lower-emphasis primary backgrounds';
      break;
    case 'onPrimaryContainer':
      color = colorScheme.onPrimaryContainer;
      colorFamily = 'Primary Family';
      usageDescription = 'Text and icons on primary container';
      break;
    case 'secondary':
      color = colorScheme.secondary;
      colorFamily = 'Secondary Family';
      usageDescription = 'Less prominent components and actions';
      break;
    case 'onSecondary':
      color = colorScheme.onSecondary;
      colorFamily = 'Secondary Family';
      usageDescription = 'Text and icons on secondary color';
      break;
    case 'secondaryContainer':
      color = colorScheme.secondaryContainer;
      colorFamily = 'Secondary Family';
      usageDescription = 'Lower-emphasis secondary backgrounds';
      break;
    case 'onSecondaryContainer':
      color = colorScheme.onSecondaryContainer;
      colorFamily = 'Secondary Family';
      usageDescription = 'Text and icons on secondary container';
      break;
    case 'tertiary':
      color = colorScheme.tertiary;
      colorFamily = 'Tertiary Family';
      usageDescription = 'Complementary accents';
      break;
    case 'onTertiary':
      color = colorScheme.onTertiary;
      colorFamily = 'Tertiary Family';
      usageDescription = 'Text and icons on tertiary color';
      break;
    case 'tertiaryContainer':
      color = colorScheme.tertiaryContainer;
      colorFamily = 'Tertiary Family';
      usageDescription = 'Lower-emphasis tertiary backgrounds';
      break;
    case 'onTertiaryContainer':
      color = colorScheme.onTertiaryContainer;
      colorFamily = 'Tertiary Family';
      usageDescription = 'Text and icons on tertiary container';
      break;
    case 'error':
      color = colorScheme.error;
      colorFamily = 'Error Family';
      usageDescription = 'Destructive actions and error states';
      break;
    case 'onError':
      color = colorScheme.onError;
      colorFamily = 'Error Family';
      usageDescription = 'Text and icons on error color';
      break;
    case 'errorContainer':
      color = colorScheme.errorContainer;
      colorFamily = 'Error Family';
      usageDescription = 'Lower-emphasis error backgrounds';
      break;
    case 'onErrorContainer':
      color = colorScheme.onErrorContainer;
      colorFamily = 'Error Family';
      usageDescription = 'Text and icons on error container';
      break;
    case 'success':
      color = colorScheme.success;
      colorFamily = 'Semantic - Success';
      usageDescription = 'Positive feedback and completed states';
      break;
    case 'onSuccess':
      color = colorScheme.onSuccess;
      colorFamily = 'Semantic - Success';
      usageDescription = 'Text and icons on success color';
      break;
    case 'successContainer':
      color = colorScheme.successContainer;
      colorFamily = 'Semantic - Success';
      usageDescription = 'Lower-emphasis success backgrounds';
      break;
    case 'onSuccessContainer':
      color = colorScheme.onSuccessContainer;
      colorFamily = 'Semantic - Success';
      usageDescription = 'Text and icons on success container';
      break;
    case 'warning':
      color = colorScheme.warning;
      colorFamily = 'Semantic - Warning';
      usageDescription = 'Cautionary feedback';
      break;
    case 'onWarning':
      color = colorScheme.onWarning;
      colorFamily = 'Semantic - Warning';
      usageDescription = 'Text and icons on warning color';
      break;
    case 'warningContainer':
      color = colorScheme.warningContainer;
      colorFamily = 'Semantic - Warning';
      usageDescription = 'Lower-emphasis warning backgrounds';
      break;
    case 'onWarningContainer':
      color = colorScheme.onWarningContainer;
      colorFamily = 'Semantic - Warning';
      usageDescription = 'Text and icons on warning container';
      break;
    case 'info':
      color = colorScheme.info;
      colorFamily = 'Semantic - Info';
      usageDescription = 'Informational feedback';
      break;
    case 'onInfo':
      color = colorScheme.onInfo;
      colorFamily = 'Semantic - Info';
      usageDescription = 'Text and icons on info color';
      break;
    case 'infoContainer':
      color = colorScheme.infoContainer;
      colorFamily = 'Semantic - Info';
      usageDescription = 'Lower-emphasis info backgrounds';
      break;
    case 'onInfoContainer':
      color = colorScheme.onInfoContainer;
      colorFamily = 'Semantic - Info';
      usageDescription = 'Text and icons on info container';
      break;
    case 'surface':
      color = colorScheme.surface;
      colorFamily = 'Surface Family';
      usageDescription = 'Default background surfaces';
      break;
    case 'onSurface':
      color = colorScheme.onSurface;
      colorFamily = 'Surface Family';
      usageDescription = 'High-emphasis text on surfaces';
      break;
    case 'surfaceContainer':
    default:
      color = colorScheme.surfaceContainer;
      colorFamily = 'Surface Family';
      usageDescription = 'Standard cards and containers';
  }

  final hexValue =
      '#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
  final textColor = _getTextColorForBackground(color);

  return Scaffold(
    backgroundColor: colorScheme.surface,
    appBar: AppBar(
      title: Text('Color Token - $colorToken'),
      backgroundColor: colorScheme.surfaceContainer,
      foregroundColor: colorScheme.onSurface,
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Main color demonstration
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: AppCard(
                padding: const EdgeInsets.all(AppSpacing.xl),
                color: color,
                borderRadius: AppRadius.lgRadius,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: colorScheme.outline, width: 2),
                  borderRadius: AppRadius.lgRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.palette, color: textColor, size: 48),
                    const SizedBox(height: 16),
                    Text(
                      colorToken,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      hexValue,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontFamily: 'monospace',
                      ),
                    ),
                    if (showUsageInfo) ...[
                      const SizedBox(height: 24),
                      AppCard(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        color: textColor.withValues(alpha: 0.1),
                        borderRadius: AppRadius.smRadius,
                        elevation: 0,
                        child: Column(
                          children: [
                            Text(
                              colorFamily,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              usageDescription,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 12,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Primary Color Family - Demonstrates primary color role relationships
@widgetbook.UseCase(name: 'Primary Color Family', type: AppColorScheme)
Widget appColorSchemePrimaryFamily(BuildContext context) {
  final showContrastRatio = context.knobs.boolean(
    label: 'Show Contrast Ratios',
    initialValue: true,
  );

  // Use Widgetbook's theme switcher from Addons panel
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final colorScheme = isDark ? AppColorScheme.dark() : AppColorScheme.light();

  // Calculate contrast ratios
  final primaryContrast = AppColorScheme.contrastRatio(
    colorScheme.onPrimary,
    colorScheme.primary,
  );
  final containerContrast = AppColorScheme.contrastRatio(
    colorScheme.onPrimaryContainer,
    colorScheme.primaryContainer,
  );

  return Scaffold(
    backgroundColor: colorScheme.surface,
    appBar: AppBar(
      title: const Text('Primary Color Family'),
      backgroundColor: colorScheme.surfaceContainer,
      foregroundColor: colorScheme.onSurface,
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Primary + onPrimary
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: AppCard(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.lg),
                color: colorScheme.primary,
                borderRadius: AppRadius.lgRadius,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: colorScheme.onPrimary,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Primary Color',
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'High-emphasis actions and key components',
                      style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontSize: 14,
                      ),
                    ),
                    if (showContrastRatio) ...[
                      const SizedBox(height: 12),
                      AppCard(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        color: colorScheme.onPrimary.withValues(alpha: 0.1),
                        borderRadius: AppRadius.smRadius,
                        elevation: 0,
                        child: Text(
                          'Contrast: ${primaryContrast.toStringAsFixed(2)}:1',
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // PrimaryContainer + onPrimaryContainer
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: AppCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                color: colorScheme.primaryContainer,
                borderRadius: AppRadius.lgRadius,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star_border,
                          color: colorScheme.onPrimaryContainer,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Primary Container',
                            style: TextStyle(
                              color: colorScheme.onPrimaryContainer,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Lower-emphasis primary backgrounds',
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontSize: 14,
                      ),
                    ),
                    if (showContrastRatio) ...[
                      const SizedBox(height: 12),
                      AppCard(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        color: colorScheme.onPrimaryContainer.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: AppRadius.smRadius,
                        elevation: 0,
                        child: Text(
                          'Contrast: ${containerContrast.toStringAsFixed(2)}:1',
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Text Color Hierarchy - Shows text emphasis levels
@widgetbook.UseCase(name: 'Text Color Hierarchy', type: AppColorScheme)
Widget appColorSchemeTextHierarchy(BuildContext context) {
  final emphasisLevel = context.knobs.object.dropdown(
    label: 'Emphasis Level',
    options: const ['High Emphasis', 'Medium Emphasis', 'Disabled'],
    labelBuilder: (value) => value,
  );

  final textStyle = context.knobs.object.dropdown(
    label: 'Text Style',
    options: const ['Heading', 'Body', 'Caption'],
    labelBuilder: (value) => value,
  );

  final showTechnicalInfo = context.knobs.boolean(
    label: 'Show Technical Info',
    initialValue: true,
  );

  // Use Widgetbook's theme switcher from Addons panel
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final colorScheme = isDark ? AppColorScheme.dark() : AppColorScheme.light();

  // Determine text color based on emphasis level
  Color textColor;
  String colorName;
  String opacityInfo;
  String usageDescription;

  switch (emphasisLevel) {
    case 'High Emphasis':
      textColor = colorScheme.onSurface;
      colorName = 'onSurface';
      opacityInfo = '100% opacity';
      usageDescription =
          'Used for primary content, headings, and important information. Maximum visibility and contrast.';
      break;
    case 'Medium Emphasis':
      textColor = colorScheme.onSurfaceVariant;
      colorName = 'onSurfaceVariant';
      opacityInfo = '~74% opacity equivalent';
      usageDescription =
          'Used for secondary content, body text, and supporting information. Reduces visual weight.';
      break;
    case 'Disabled':
    default:
      textColor = colorScheme.onSurface.withValues(alpha: 0.38);
      colorName = 'onSurface';
      opacityInfo = '38% opacity';
      usageDescription =
          'Used for disabled states and inactive elements. Minimum recommended opacity.';
  }

  // Determine font sizes based on text style
  double fontSize;
  FontWeight fontWeight;

  switch (textStyle) {
    case 'Heading':
      fontSize = 32;
      fontWeight = FontWeight.bold;
      break;
    case 'Body':
      fontSize = 16;
      fontWeight = FontWeight.normal;
      break;
    case 'Caption':
    default:
      fontSize = 12;
      fontWeight = FontWeight.normal;
  }

  return Scaffold(
    backgroundColor: colorScheme.surface,
    appBar: AppBar(
      title: Text('Text Hierarchy - $emphasisLevel'),
      backgroundColor: colorScheme.surfaceContainer,
      foregroundColor: colorScheme.onSurface,
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: AppCard(
                padding: const EdgeInsets.all(AppSpacing.xl),
                color: colorScheme.surfaceContainerLow,
                borderRadius: AppRadius.lgRadius,
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main text demonstration
                    Text(
                      '$emphasisLevel Example',
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sample content
                    Text(
                      'The quick brown fox jumps over the lazy dog. This sentence demonstrates how the selected emphasis level affects text visibility and readability.',
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize * 0.75,
                        height: 1.5,
                      ),
                    ),

                    if (showTechnicalInfo) ...[
                      const SizedBox(height: 24),
                      Divider(color: colorScheme.outline),
                      const SizedBox(height: 16),

                      // Technical information
                      AppCard(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        color: colorScheme.surfaceContainer,
                        borderRadius: AppRadius.smRadius,
                        elevation: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Color Information',
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              'Color Token',
                              colorName,
                              colorScheme.onSurface,
                            ),
                            _buildInfoRow(
                              'Opacity',
                              opacityInfo,
                              colorScheme.onSurface,
                            ),
                            _buildInfoRow(
                              'Font Size',
                              '${fontSize}pt',
                              colorScheme.onSurface,
                            ),
                            _buildInfoRow(
                              'Font Weight',
                              fontWeight == FontWeight.bold ? 'Bold' : 'Normal',
                              colorScheme.onSurface,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              usageDescription,
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildInfoRow(String label, String value, Color textColor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor.withValues(alpha: 0.74),
            fontSize: 12,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Color _getTextColorForBackground(Color background) {
  final luminance = background.computeLuminance();
  return luminance > 0.5 ? Colors.black : Colors.white;
}
