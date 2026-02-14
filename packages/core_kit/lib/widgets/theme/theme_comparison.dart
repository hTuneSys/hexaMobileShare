// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_radius.dart';

/// A widget that displays two themes side-by-side for comparison.
///
/// Renders the same sample content under two different [ThemeData] instances
/// so differences in colors, typography, and component styling are visible.
///
/// ## Usage
///
/// ```dart
/// ThemeComparison(
///   leftTheme: AppTheme.light(),
///   rightTheme: AppTheme.highContrastLight(),
///   leftLabel: 'Standard',
///   rightLabel: 'High Contrast',
/// )
/// ```
class ThemeComparison extends StatelessWidget {
  /// Creates a side-by-side theme comparison widget.
  const ThemeComparison({
    required this.leftTheme,
    required this.rightTheme,
    this.leftLabel = 'Theme A',
    this.rightLabel = 'Theme B',
    this.sampleBuilder,
    super.key,
  });

  /// The theme shown on the left side.
  final ThemeData leftTheme;

  /// The theme shown on the right side.
  final ThemeData rightTheme;

  /// Label for the left theme.
  final String leftLabel;

  /// Label for the right theme.
  final String rightLabel;

  /// Optional builder for custom sample content.
  ///
  /// If not provided, a default set of Material Design 3 components
  /// is shown (text, buttons, cards, inputs).
  final Widget Function(BuildContext context)? sampleBuilder;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _ThemeSide(
            theme: leftTheme,
            label: leftLabel,
            sampleBuilder: sampleBuilder,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: _ThemeSide(
            theme: rightTheme,
            label: rightLabel,
            sampleBuilder: sampleBuilder,
          ),
        ),
      ],
    );
  }
}

class _ThemeSide extends StatelessWidget {
  const _ThemeSide({
    required this.theme,
    required this.label,
    this.sampleBuilder,
  });

  final ThemeData theme;
  final String label;
  final Widget Function(BuildContext context)? sampleBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: AppRadius.mdRadius,
          child: Theme(
            data: theme,
            child: Builder(
              builder: (themedContext) {
                if (sampleBuilder != null) {
                  return ColoredBox(
                    color: theme.colorScheme.surface,
                    child: sampleBuilder!(themedContext),
                  );
                }
                return _DefaultSample(theme: theme);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _DefaultSample extends StatelessWidget {
  const _DefaultSample({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return ColoredBox(
      color: colorScheme.surface,
      child: Padding(
        padding: AppSpacing.edgeInsetsAllMd,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Typography samples
            Text('Headline', style: textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.xs),
            Text('Body text sample', style: textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.md),

            // Color chips
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                _ColorChip(
                  color: colorScheme.primary,
                  label: 'P',
                  onColor: colorScheme.onPrimary,
                ),
                _ColorChip(
                  color: colorScheme.secondary,
                  label: 'S',
                  onColor: colorScheme.onSecondary,
                ),
                _ColorChip(
                  color: colorScheme.tertiary,
                  label: 'T',
                  onColor: colorScheme.onTertiary,
                ),
                _ColorChip(
                  color: colorScheme.error,
                  label: 'E',
                  onColor: colorScheme.onError,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Button samples
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Filled'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Outlined'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Input sample
            TextField(
              decoration: InputDecoration(
                labelText: 'Input field',
                hintText: 'Placeholder',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorChip extends StatelessWidget {
  const _ColorChip({
    required this.color,
    required this.label,
    required this.onColor,
  });

  final Color color;
  final String label;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppRadius.smRadius,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: onColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
