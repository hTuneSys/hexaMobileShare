// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// AppIconButton: MD3-compliant icon-only button with variants and accessibility.
class AppIconButton extends StatelessWidget {
  /// Standard icon button (no background).
  const AppIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.iconSize = 24.0,
    this.color,
    this.padding,
    this.style,
    this.isSelected = false,
  }) : _variant = _AppIconButtonVariant.standard;

  /// Filled icon button (primary emphasis).
  const AppIconButton.filled({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.iconSize = 24.0,
    this.color,
    this.padding,
    this.style,
    this.isSelected = false,
  }) : _variant = _AppIconButtonVariant.filled;

  /// Filled tonal icon button (secondary/tonal emphasis).
  const AppIconButton.filledTonal({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.iconSize = 24.0,
    this.color,
    this.padding,
    this.style,
    this.isSelected = false,
  }) : _variant = _AppIconButtonVariant.filledTonal;

  /// Outlined icon button (medium emphasis, with border).
  const AppIconButton.outlined({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.iconSize = 24.0,
    this.color,
    this.padding,
    this.style,
    this.isSelected = false,
  }) : _variant = _AppIconButtonVariant.outlined;

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final double iconSize;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;
  final bool isSelected;

  final _AppIconButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    // MD3: minimum 48x48dp touch target even if visually smaller.
    final Widget child = _buildVariantButton(context);

    return Semantics(
      button: true,
      selected: isSelected,
      enabled: onPressed != null,
      label: tooltip,
      child: SizedBox(width: 48, height: 48, child: child),
    );
  }

  Widget _buildVariantButton(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    // Icon color defaults per variant using MD3 tokens.
    final Color defaultIconColor = switch (_variant) {
      _AppIconButtonVariant.standard => cs.onSurfaceVariant,
      _AppIconButtonVariant.filled => cs.onPrimary,
      _AppIconButtonVariant.filledTonal => cs.onSecondaryContainer,
      _AppIconButtonVariant.outlined => cs.onSurfaceVariant,
    };

    final ButtonStyle baseStyle = switch (_variant) {
      _AppIconButtonVariant.standard => const ButtonStyle(),
      _AppIconButtonVariant.filled => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return cs.onSurface.withValues(alpha: 0.12);
          }
          return cs.primary;
        }),
      ),
      _AppIconButtonVariant.filledTonal => ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return cs.onSurface.withValues(alpha: 0.12);
          }
          return cs.secondaryContainer;
        }),
      ),
      _AppIconButtonVariant.outlined => ButtonStyle(
        side: WidgetStateProperty.resolveWith((states) {
          final Color outline = cs.outline;
          final Color disabledOutline = outline.withValues(alpha: 0.12);
          return BorderSide(
            color: states.contains(WidgetState.disabled)
                ? disabledOutline
                : outline,
          );
        }),
      ),
    };

    final ButtonStyle mergedStyle = baseStyle.merge(style);

    final EdgeInsetsGeometry effectivePadding =
        padding ?? const EdgeInsets.all(12); // 48 container with 24 icon

    final Icon iconWidget = Icon(
      icon,
      size: iconSize,
      color: color ?? defaultIconColor,
    );

    // Toggle visual hint.
    final Icon effectiveIcon = isSelected
        ? Icon(
            iconWidget.icon,
            size: iconWidget.size,
            color: (color ?? defaultIconColor).withValues(alpha: 1.0),
          )
        : iconWidget;

    // Choose base IconButton class by variant for MD3 behavior.
    return switch (_variant) {
      _AppIconButtonVariant.standard => IconButton(
        icon: effectiveIcon,
        tooltip: tooltip,
        isSelected: isSelected,
        onPressed: onPressed,
        style: mergedStyle,
        padding: effectivePadding,
      ),
      _AppIconButtonVariant.filled => IconButton.filled(
        icon: effectiveIcon,
        tooltip: tooltip,
        isSelected: isSelected,
        onPressed: onPressed,
        style: mergedStyle,
        padding: effectivePadding,
      ),
      _AppIconButtonVariant.filledTonal => IconButton.filledTonal(
        icon: effectiveIcon,
        tooltip: tooltip,
        isSelected: isSelected,
        onPressed: onPressed,
        style: mergedStyle,
        padding: effectivePadding,
      ),
      _AppIconButtonVariant.outlined => IconButton.outlined(
        icon: effectiveIcon,
        tooltip: tooltip,
        isSelected: isSelected,
        onPressed: onPressed,
        style: mergedStyle,
        padding: effectivePadding,
      ),
    };
  }
}

enum _AppIconButtonVariant { standard, filled, filledTonal, outlined }
