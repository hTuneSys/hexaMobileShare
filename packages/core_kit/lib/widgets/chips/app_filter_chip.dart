// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 filter chip widget.
///
/// Filter chips allow users to refine content by selecting from predefined
/// filter criteria. They support multi-selection with visual feedback through
/// checkmarks and background highlighting.
///
/// The chip automatically handles:
/// - Selected/unselected toggle states
/// - Checkmark icon display when selected
/// - Background color changes based on selection state
/// - Outlined border when unselected
/// - Disabled state with reduced opacity
/// - Keyboard navigation with focus indicators
/// - Touch ripple effects
///
/// Material Design 3 specifications:
/// - Height: 32dp
/// - Horizontal padding: 16dp (8dp with icons)
/// - Checkmark size: 18dp
/// - Icon spacing: 8dp from label
/// - Unselected: Outlined with 1dp border
/// - Selected: Filled with secondary container color
///
/// Example usage:
///
/// ```dart
/// // Basic filter chip
/// AppFilterChip(
///   label: 'Shoes',
///   selected: false,
///   onSelected: (selected) {
///     setState(() => _isSelected = selected);
///   },
/// )
///
/// // Filter chip with custom icon
/// AppFilterChip(
///   label: 'New Arrivals',
///   icon: Icons.fiber_new,
///   selected: true,
///   onSelected: (selected) => _handleFilter(selected),
/// )
///
/// // Filter group with multiple chips
/// Wrap(
///   spacing: 8,
///   children: [
///     AppFilterChip(
///       label: 'Electronics',
///       selected: _filters.contains('electronics'),
///       onSelected: (selected) => _toggleFilter('electronics'),
///     ),
///     AppFilterChip(
///       label: 'Clothing',
///       selected: _filters.contains('clothing'),
///       onSelected: (selected) => _toggleFilter('clothing'),
///     ),
///   ],
/// )
///
/// // Filter chip with avatar
/// AppFilterChip(
///   label: 'John Doe',
///   avatar: CircleAvatar(child: Text('JD')),
///   selected: _selectedUser == 'john',
///   onSelected: (selected) => _selectUser('john'),
/// )
/// ```
///
/// See also:
/// - [FilterChip], the underlying Material widget
/// - [Chip], for other chip variants
/// - Material Design 3 Chips: https://m3.material.io/components/chips
class AppFilterChip extends StatelessWidget {
  /// Creates a Material Design 3 filter chip.
  ///
  /// The [label] and [onSelected] parameters are required.
  /// The [selected] parameter defaults to false.
  const AppFilterChip({
    required this.label,
    required this.onSelected,
    this.selected = false,
    this.icon,
    this.avatar,
    this.enabled = true,
    this.selectedColor,
    this.unselectedColor,
    this.checkmarkColor,
    this.labelStyle,
    this.padding,
    this.elevation,
    this.pressElevation,
    this.shape,
    this.tooltip,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    super.key,
  });

  /// The primary content of the filter chip.
  ///
  /// Displayed using Material Design 3 labelLarge style.
  final String label;

  /// Called when the filter chip selection state changes.
  ///
  /// The callback receives a boolean indicating the new selected state.
  /// This is called when the user taps the chip.
  final ValueChanged<bool>? onSelected;

  /// Whether this filter chip is currently selected.
  ///
  /// When true:
  /// - Shows checkmark icon
  /// - Uses secondary container background color
  /// - Uses on-secondary-container text color
  ///
  /// When false:
  /// - No checkmark icon
  /// - Outlined border style
  /// - Transparent background
  ///
  /// Default is false.
  final bool selected;

  /// An optional icon displayed before the label when unselected.
  ///
  /// This icon is replaced by a checkmark when the chip is selected.
  /// The icon should be 18dp in size to match Material Design 3 specs.
  final IconData? icon;

  /// An optional avatar displayed before the label.
  ///
  /// Typically used for user or entity filters. The avatar is shown
  /// in both selected and unselected states.
  ///
  /// When both [avatar] and [icon] are provided, [avatar] takes precedence.
  final Widget? avatar;

  /// Whether the filter chip is interactive.
  ///
  /// If false:
  /// - Chip appears with 38% opacity
  /// - [onSelected] is not called
  /// - No touch ripple effect
  ///
  /// Default is true.
  final bool enabled;

  /// The background color when the chip is selected.
  ///
  /// If null, uses theme's secondaryContainer color.
  final Color? selectedColor;

  /// The border color when the chip is unselected.
  ///
  /// If null, uses theme's outline color.
  final Color? unselectedColor;

  /// The color of the checkmark icon when selected.
  ///
  /// If null, uses theme's onSecondaryContainer color.
  final Color? checkmarkColor;

  /// The style for the label text.
  ///
  /// If null, uses theme's labelLarge style.
  final TextStyle? labelStyle;

  /// The padding around the chip content.
  ///
  /// Default is EdgeInsets.symmetric(horizontal: 16.0) for text-only chips,
  /// or EdgeInsets.symmetric(horizontal: 8.0) when icon/avatar is present.
  final EdgeInsetsGeometry? padding;

  /// The elevation when the chip is unselected and not pressed.
  ///
  /// Default is 0.0 (flat).
  final double? elevation;

  /// The elevation when the chip is pressed.
  ///
  /// Default is 0.0 (flat).
  final double? pressElevation;

  /// The shape of the chip's border.
  ///
  /// If null, uses a stadium border (fully rounded).
  final OutlinedBorder? shape;

  /// Tooltip message shown on long press.
  final String? tooltip;

  /// Defines how compact the chip's layout will be.
  final VisualDensity? visualDensity;

  /// An optional focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Whether this chip should request focus when first built.
  ///
  /// Default is false.
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Determine colors based on selection state
    final effectiveSelectedColor =
        selectedColor ?? colorScheme.secondaryContainer;
    final effectiveLabelColor = selected
        ? colorScheme.onSecondaryContainer
        : colorScheme.onSurfaceVariant;
    final effectiveCheckmarkColor =
        checkmarkColor ?? colorScheme.onSecondaryContainer;

    // Build label with proper typography
    final labelWidget = Text(
      label,
      style: (labelStyle ?? textTheme.labelLarge)?.copyWith(
        color: effectiveLabelColor,
      ),
    );

    // Determine leading widget based on state and properties
    Widget? leadingWidget;
    bool showCheckmark = false;

    if (avatar != null) {
      // Avatar takes precedence and shows in both states
      leadingWidget = avatar;
      showCheckmark = false;
    } else if (selected) {
      // Show checkmark when selected (replaces custom icon if present)
      leadingWidget = Icon(
        Icons.check,
        size: 18,
        color: effectiveCheckmarkColor,
      );
      showCheckmark = false; // We're manually adding checkmark as avatar
    } else if (icon != null) {
      // Show custom icon only when unselected
      leadingWidget = Icon(icon, size: 18, color: effectiveLabelColor);
      showCheckmark = false;
    }

    // Build the filter chip
    Widget chip = FilterChip(
      label: labelWidget,
      selected: selected,
      onSelected: enabled ? onSelected : null,
      avatar: leadingWidget,

      // Disable built-in checkmark since we handle it manually
      showCheckmark: showCheckmark,
      checkmarkColor: effectiveCheckmarkColor,

      // Selection color (background when selected)
      selectedColor: effectiveSelectedColor,

      // Background color when unselected (transparent for outlined style)
      backgroundColor: Colors.transparent,

      // Border color when unselected
      side: selected
          ? BorderSide.none
          : BorderSide(color: unselectedColor ?? colorScheme.outline, width: 1),

      // Shape with stadium border (fully rounded ends)
      shape: shape ?? const StadiumBorder(),

      // Padding
      padding: padding,
      labelPadding:
          padding ??
          EdgeInsets.symmetric(horizontal: leadingWidget != null ? 8.0 : 16.0),

      // Elevation
      elevation: elevation ?? 0.0,
      pressElevation: pressElevation ?? 0.0,

      // Visual density
      visualDensity: visualDensity,

      // Focus handling
      focusNode: focusNode,
      autofocus: autofocus,

      // Material state properties for custom styling
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    // Wrap with tooltip if provided
    if (tooltip != null) {
      chip = Tooltip(message: tooltip, child: chip);
    }

    // Apply disabled opacity if not enabled
    if (!enabled) {
      chip = Opacity(
        opacity: 0.38, // Material Design 3 disabled opacity
        child: chip,
      );
    }

    return chip;
  }
}
