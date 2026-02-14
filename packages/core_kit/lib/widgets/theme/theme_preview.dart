// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';
import '../../theme/app_radius.dart';

/// A widget that previews theme changes without applying them globally.
///
/// Wraps a child in a localized [Theme] to show how it would look with
/// a different [ThemeData], without affecting the rest of the application.
///
/// ## Usage
///
/// ```dart
/// ThemePreview(
///   theme: AppTheme.highContrastLight(),
///   child: Column(
///     children: [
///       Text('Preview'),
///       ElevatedButton(onPressed: () {}, child: Text('Button')),
///     ],
///   ),
/// )
/// ```
class ThemePreview extends StatelessWidget {
  /// Creates a theme preview wrapper.
  ///
  /// The [theme] is applied locally to the [child] widget tree.
  const ThemePreview({
    required this.theme,
    required this.child,
    this.label,
    this.showLabel = true,
    super.key,
  });

  /// The theme to preview.
  final ThemeData theme;

  /// The widget tree to render with the preview theme.
  final Widget child;

  /// Optional label displayed above the preview.
  final String? label;

  /// Whether to show the label. Defaults to `true`.
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel && label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              label!,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ClipRRect(
          borderRadius: AppRadius.mdRadius,
          child: Theme(
            data: theme,
            child: ColoredBox(color: theme.colorScheme.surface, child: child),
          ),
        ),
      ],
    );
  }
}
