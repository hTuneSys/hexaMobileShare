// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 input chip component for representing complex
/// selections like contacts, files, or tags with avatars and delete capability.
///
/// Input chips represent discrete pieces of information that users can
/// add or remove, typically in input contexts like email recipients,
/// file attachments, or tag management.
///
/// Features:
/// - Optional avatar/thumbnail display
/// - Delete button for removal
/// - Selected state support
/// - Disabled state handling
/// - Custom colors and styling
/// - Keyboard delete support
/// - Full accessibility
///
/// Example:
/// ```dart
/// AppInputChip(
///   label: 'John Doe',
///   avatar: CircleAvatar(
///     backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
///   ),
///   onDeleted: () {
///     // Handle deletion
///   },
///   onTap: () {
///     // Handle tap
///   },
/// )
/// ```
class AppInputChip extends StatelessWidget {
  /// Creates an input chip.
  ///
  /// The [label] parameter is required and represents the main content.
  const AppInputChip({
    super.key,
    required this.label,
    this.avatar,
    this.onDeleted,
    this.onTap,
    this.selected = false,
    this.enabled = true,
    this.backgroundColor,
    this.selectedColor,
    this.labelStyle,
    this.deleteIconColor,
    this.elevation,
    this.padding,
    this.tooltip,
    this.deleteButtonTooltipMessage,
  });

  /// The primary content of the chip, typically text or a short label.
  final String label;

  /// Optional widget to display before the label, typically a [CircleAvatar].
  /// The avatar extends slightly beyond the chip border per M3 specs.
  final Widget? avatar;

  /// Called when the delete button is tapped.
  /// If null, the delete button is not displayed.
  final VoidCallback? onDeleted;

  /// Called when the chip is tapped (excluding the delete button area).
  final VoidCallback? onTap;

  /// Whether the chip is in a selected state.
  /// Selected chips use secondary container background color.
  final bool selected;

  /// Whether the chip is enabled for interaction.
  /// Disabled chips have reduced opacity and no interaction.
  final bool enabled;

  /// Custom background color. If null, uses surface variant or
  /// secondary container (when selected) from the theme.
  final Color? backgroundColor;

  /// Custom color when selected. If null, uses secondary container from theme.
  final Color? selectedColor;

  /// Custom text style for the label.
  final TextStyle? labelStyle;

  /// Custom color for the delete icon.
  final Color? deleteIconColor;

  /// The elevation of the chip. Defaults to 0 per M3 specs.
  final double? elevation;

  /// Custom padding. If null, uses standard M3 padding.
  final EdgeInsetsGeometry? padding;

  /// Tooltip message for the chip.
  final String? tooltip;

  /// Tooltip message for the delete button. Defaults to 'Delete'.
  final String? deleteButtonTooltipMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine background color based on state
    final effectiveBackgroundColor = !enabled
        ? (backgroundColor ?? colorScheme.surfaceContainerHighest).withValues(
            alpha: 0.38,
          )
        : selected
        ? (selectedColor ?? colorScheme.secondaryContainer)
        : (backgroundColor ?? colorScheme.surfaceContainerHighest);

    // Determine label color
    final effectiveLabelColor = !enabled
        ? colorScheme.onSurface.withValues(alpha: 0.38)
        : selected
        ? colorScheme.onSecondaryContainer
        : colorScheme.onSurfaceVariant;

    // Determine delete icon color
    final effectiveDeleteIconColor = !enabled
        ? colorScheme.onSurface.withValues(alpha: 0.38)
        : selected
        ? colorScheme.onSecondaryContainer
        : (deleteIconColor ?? colorScheme.onSurfaceVariant);

    // Default padding: 8dp with avatar, 12dp without
    final effectivePadding =
        padding ??
        EdgeInsets.only(
          left: avatar != null ? 4.0 : 12.0,
          right: onDeleted != null ? 4.0 : 12.0,
          top: 4.0,
          bottom: 4.0,
        );

    final chipContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (avatar != null) ...[
          SizedBox(width: 24.0, height: 24.0, child: avatar),
          const SizedBox(width: 8.0),
        ],
        Flexible(
          child: Text(
            label,
            style: (labelStyle ?? theme.textTheme.labelLarge)?.copyWith(
              color: effectiveLabelColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onDeleted != null) ...[
          const SizedBox(width: 4.0),
          _DeleteButton(
            onPressed: enabled ? onDeleted : null,
            color: effectiveDeleteIconColor,
            tooltip: deleteButtonTooltipMessage ?? 'Delete',
          ),
        ],
      ],
    );

    final chip = Material(
      elevation: elevation ?? 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: !enabled
              ? colorScheme.outline.withValues(alpha: 0.38)
              : selected
              ? Colors.transparent
              : colorScheme.outline,
          width: 1.0,
        ),
      ),
      color: effectiveBackgroundColor,
      child: InkWell(
        onTap: enabled && onTap != null ? onTap : null,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          constraints: const BoxConstraints(minHeight: 32.0),
          padding: effectivePadding,
          child: chipContent,
        ),
      ),
    );

    // Wrap with tooltip if provided
    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(message: tooltip!, child: chip);
    }

    return chip;
  }
}

/// Internal delete button widget for the input chip.
class _DeleteButton extends StatelessWidget {
  const _DeleteButton({
    required this.onPressed,
    required this.color,
    required this.tooltip,
  });

  final VoidCallback? onPressed;
  final Color color;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          width: 24.0,
          height: 24.0,
          child: Icon(Icons.close, size: 18.0, color: color),
        ),
      ),
    );
  }
}
