// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A widget that displays an empty state with a title, optional description,
/// and optional action buttons.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.title,
    this.description,
    this.illustration,
    this.icon,
    this.primaryButtonText,
    this.onPrimaryPressed,
    this.secondaryButtonText,
    this.onSecondaryPressed,
    this.compact = false,
    super.key,
  });

  /// The main title text to display.
  final String title;

  /// The optional description text to display below the title.
  final String? description;

  /// An optional illustration widget to display above the title.
  /// Typically an [Image], [SvgPicture], or Lottie animation.
  ///
  /// The widget will be constrained to a box (default 200x200, compact 120x120).
  final Widget? illustration;

  /// An optional icon to display if [illustration] is null.
  final IconData? icon;

  /// The text to display on the primary action button.
  final String? primaryButtonText;

  /// The callback to execute when the primary action button is pressed.
  final VoidCallback? onPrimaryPressed;

  /// The text to display on the secondary action button.
  final String? secondaryButtonText;

  /// The callback to execute when the secondary action button is pressed.
  final VoidCallback? onSecondaryPressed;

  /// Whether to display the empty state in a compact mode.
  ///
  /// If true:
  /// - Illustration size becomes 120x120
  /// - Title style becomes [TextTheme.titleLarge]
  /// - Description style becomes [TextTheme.bodyMedium]
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Define styles based on compact mode
    final illustrationSize = compact ? 120.0 : 200.0;
    final titleStyle = compact
        ? theme.textTheme.titleLarge
        : theme.textTheme.headlineSmall;
    final descriptionStyle = compact
        ? theme.textTheme.bodyMedium
        : theme.textTheme.bodyLarge;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration or Icon
            if (illustration != null) ...[
              SizedBox(
                width: illustrationSize,
                height: illustrationSize,
                child: illustration,
              ),
              const SizedBox(height: 24),
            ] else if (icon != null) ...[
              Icon(
                icon,
                size:
                    64, // Icon stays same distinct size or could be scaled too if needed
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 24),
            ],

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: titleStyle?.copyWith(color: colorScheme.onSurface),
            ),

            if (description != null) ...[
              const SizedBox(height: 8),
              // Description
              Text(
                description!,
                textAlign: TextAlign.center,
                style: descriptionStyle?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],

            // Actions
            if (primaryButtonText != null && onPrimaryPressed != null) ...[
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onPrimaryPressed,
                child: Text(primaryButtonText!),
              ),
            ],

            if (secondaryButtonText != null && onSecondaryPressed != null) ...[
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: onSecondaryPressed,
                child: Text(secondaryButtonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
