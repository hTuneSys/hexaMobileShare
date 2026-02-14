// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_color_scheme.dart';

/// A debug overlay that displays current theme values.
///
/// Shows color scheme tokens, typography scale, spacing values, and other
/// design tokens from the current [ThemeData]. Intended for development
/// and debugging only.
///
/// ## Usage
///
/// ```dart
/// // Wrap your app or a section
/// Stack(
///   children: [
///     MyApp(),
///     if (kDebugMode) ThemeDebugOverlay(isVisible: true),
///   ],
/// )
/// ```
class ThemeDebugOverlay extends StatelessWidget {
  /// Creates a theme debug overlay.
  const ThemeDebugOverlay({
    this.isVisible = true,
    this.alignment = Alignment.bottomRight,
    super.key,
  });

  /// Whether the overlay is visible. Defaults to `true`.
  final bool isVisible;

  /// Where to position the overlay on screen.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 360, maxHeight: 480),
        margin: AppSpacing.edgeInsetsAllMd,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.95),
          borderRadius: AppRadius.mdRadius,
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: SingleChildScrollView(
          padding: AppSpacing.edgeInsetsAllMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.bug_report,
                    size: 20,
                    color: colorScheme.onSurface,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Theme Debug',
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Divider(color: colorScheme.outlineVariant),
              const SizedBox(height: AppSpacing.sm),

              // Brightness
              _DebugRow(
                label: 'Brightness',
                value: colorScheme.brightness == Brightness.light
                    ? 'Light'
                    : 'Dark',
              ),
              const SizedBox(height: AppSpacing.xs),

              // Material 3
              _DebugRow(
                label: 'Material 3',
                value: theme.useMaterial3 ? 'Yes' : 'No',
              ),
              const SizedBox(height: AppSpacing.md),

              // Color tokens
              Text(
                'Color Tokens',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              _ColorDebugRow(label: 'primary', color: colorScheme.primary),
              _ColorDebugRow(label: 'secondary', color: colorScheme.secondary),
              _ColorDebugRow(label: 'tertiary', color: colorScheme.tertiary),
              _ColorDebugRow(label: 'error', color: colorScheme.error),
              _ColorDebugRow(label: 'surface', color: colorScheme.surface),
              _ColorDebugRow(label: 'onSurface', color: colorScheme.onSurface),
              _ColorDebugRow(label: 'outline', color: colorScheme.outline),
              const SizedBox(height: AppSpacing.md),

              // Contrast ratios
              Text(
                'Contrast Ratios',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              _ContrastRow(
                label: 'onPrimary/primary',
                ratio: AppColorScheme.contrastRatio(
                  colorScheme.onPrimary,
                  colorScheme.primary,
                ),
              ),
              _ContrastRow(
                label: 'onSurface/surface',
                ratio: AppColorScheme.contrastRatio(
                  colorScheme.onSurface,
                  colorScheme.surface,
                ),
              ),
              _ContrastRow(
                label: 'onError/error',
                ratio: AppColorScheme.contrastRatio(
                  colorScheme.onError,
                  colorScheme.error,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Typography scale
              Text(
                'Typography Scale',
                style: textTheme.labelMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              _DebugRow(
                label: 'displayLarge',
                value: '${textTheme.displayLarge?.fontSize ?? '-'}sp',
              ),
              _DebugRow(
                label: 'headlineMedium',
                value: '${textTheme.headlineMedium?.fontSize ?? '-'}sp',
              ),
              _DebugRow(
                label: 'titleMedium',
                value: '${textTheme.titleMedium?.fontSize ?? '-'}sp',
              ),
              _DebugRow(
                label: 'bodyMedium',
                value: '${textTheme.bodyMedium?.fontSize ?? '-'}sp',
              ),
              _DebugRow(
                label: 'labelMedium',
                value: '${textTheme.labelMedium?.fontSize ?? '-'}sp',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DebugRow extends StatelessWidget {
  const _DebugRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorDebugRow extends StatelessWidget {
  const _ColorDebugRow({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: AppRadius.xsRadius,
              border: Border.all(color: colorScheme.outlineVariant, width: 0.5),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
            style: textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: colorScheme.onSurface,
            ),
          ),
        ],
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final meetsAA = ratio >= 4.5;
    final meetsAAA = ratio >= 7.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Icon(
            meetsAA ? Icons.check_circle : Icons.warning,
            size: 14,
            color: meetsAA ? colorScheme.success : colorScheme.error,
          ),
          const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            '${ratio.toStringAsFixed(1)}:1 ${meetsAAA
                ? 'AAA'
                : meetsAA
                ? 'AA'
                : 'FAIL'}',
            style: textTheme.bodySmall?.copyWith(
              color: meetsAA ? colorScheme.onSurface : colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
