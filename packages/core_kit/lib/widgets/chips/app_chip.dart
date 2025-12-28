// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Defines the type of chip to display, following Material Design 3 guidelines.
///
/// Each type has specific use cases and visual characteristics:
/// - [assist]: Quick actions with elevation
/// - [filter]: Selectable options with checkmark
/// - [input]: Complex info with avatar and delete button
/// - [suggestion]: Flat suggestions without elevation
enum AppChipType {
  /// Assist chips help users take quick actions (e.g., "Add to calendar", "Set reminder").
  /// They have elevation and typically include an icon.
  assist,

  /// Filter chips let users select options from a set (e.g., categories, tags).
  /// They show a checkmark when selected.
  filter,

  /// Input chips represent complex information entered by users (e.g., contacts, tags).
  /// They typically include an avatar and a delete button.
  input,

  /// Suggestion chips help users discover actions or complete tasks (e.g., search suggestions).
  /// They have no elevation and a flat appearance.
  suggestion,
}

/// A Material Design 3 chip component that provides compact, interactive elements
/// for actions, selections, and filters.
///
/// The [AppChip] component supports four types of chips following Material Design 3
/// guidelines: assist, filter, input, and suggestion chips. Each type has specific
/// use cases and visual characteristics optimized for different interaction patterns.
///
/// ## Usage
///
/// ```dart
/// // Assist chip for quick actions
/// AppChip.assist(
///   label: 'Set reminder',
///   icon: Icons.alarm,
///   onTap: () => print('Reminder set'),
/// )
///
/// // Filter chip for selections
/// AppChip.filter(
///   label: 'Photos',
///   selected: true,
///   onTap: () => print('Filter toggled'),
/// )
///
/// // Input chip with avatar
/// AppChip.input(
///   label: 'Alice Johnson',
///   avatar: CircleAvatar(child: Text('A')),
///   onDelete: () => print('Contact removed'),
/// )
///
/// // Suggestion chip
/// AppChip.suggestion(
///   label: 'Coffee shops nearby',
///   onTap: () => print('Suggestion selected'),
/// )
/// ```
///
/// ## When to Use Each Type
///
/// **Assist Chip** ([AppChip.assist]):
/// - Quick actions that help users complete tasks
/// - Contextual shortcuts (e.g., "Add to calendar", "Share")
/// - Actions related to content being viewed
/// - Has elevation to stand out as an actionable element
///
/// **Filter Chip** ([AppChip.filter]):
/// - Filtering content by category, tag, or attribute
/// - Multi-select or single-select options
/// - Toggling view modes or preferences
/// - Shows checkmark when selected
///
/// **Input Chip** ([AppChip.input]):
/// - Representing user input like contacts or tags
/// - Showing selected items that can be removed
/// - Email/contact chips in compose fields
/// - Typically includes avatar and delete button
///
/// **Suggestion Chip** ([AppChip.suggestion]):
/// - Search suggestions and autocomplete
/// - Quick replies and smart responses
/// - Recommended actions or content
/// - Flat appearance, no elevation
///
/// ## Material Design 3 Compliance
///
/// This component follows MD3 specifications:
/// - Height: 32dp standard for all chip types
/// - Padding: 16dp horizontal (8dp when icon is present)
/// - Icon size: 18dp
/// - Avatar size: 24dp (input chips only)
/// - Typography: Uses theme's `labelLarge` text style
/// - Colors: Automatically adapts to theme's color scheme
///
/// See also:
/// - [Material Design 3 Chips](https://m3.material.io/components/chips)
/// - [AppChipType] for available chip types
class AppChip extends StatelessWidget {
  /// Creates a chip widget.
  ///
  /// Use the named constructors [AppChip.assist], [AppChip.filter],
  /// [AppChip.input], or [AppChip.suggestion] for type-specific chips.
  const AppChip({
    super.key,
    required this.type,
    required this.label,
    this.icon,
    this.avatar,
    this.selected = false,
    this.enabled = true,
    this.onTap,
    this.onDelete,
    this.backgroundColor,
    this.labelColor,
    this.selectedBackgroundColor,
    this.selectedLabelColor,
    this.deleteIconColor,
  });

  /// Creates an assist chip for quick actions.
  ///
  /// Assist chips help users take contextual actions quickly.
  /// They have elevation and typically include an icon.
  ///
  /// Example:
  /// ```dart
  /// AppChip.assist(
  ///   label: 'Set reminder',
  ///   icon: Icons.alarm,
  ///   onTap: () => print('Reminder set'),
  /// )
  /// ```
  factory AppChip.assist({
    Key? key,
    required String label,
    IconData? icon,
    bool enabled = true,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? labelColor,
  }) {
    return AppChip(
      key: key,
      type: AppChipType.assist,
      label: label,
      icon: icon,
      enabled: enabled,
      onTap: onTap,
      backgroundColor: backgroundColor,
      labelColor: labelColor,
    );
  }

  /// Creates a filter chip for selections.
  ///
  /// Filter chips let users select options from a set.
  /// They show a checkmark when selected.
  ///
  /// Example:
  /// ```dart
  /// AppChip.filter(
  ///   label: 'Photos',
  ///   selected: isPhotosSelected,
  ///   onTap: () => setState(() => isPhotosSelected = !isPhotosSelected),
  /// )
  /// ```
  factory AppChip.filter({
    Key? key,
    required String label,
    IconData? icon,
    bool selected = false,
    bool enabled = true,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? labelColor,
    Color? selectedBackgroundColor,
    Color? selectedLabelColor,
  }) {
    return AppChip(
      key: key,
      type: AppChipType.filter,
      label: label,
      icon: icon,
      selected: selected,
      enabled: enabled,
      onTap: onTap,
      backgroundColor: backgroundColor,
      labelColor: labelColor,
      selectedBackgroundColor: selectedBackgroundColor,
      selectedLabelColor: selectedLabelColor,
    );
  }

  /// Creates an input chip with avatar and delete button.
  ///
  /// Input chips represent complex information entered by users,
  /// typically with an avatar and a delete button.
  ///
  /// Example:
  /// ```dart
  /// AppChip.input(
  ///   label: 'Alice Johnson',
  ///   avatar: CircleAvatar(child: Text('A')),
  ///   onDelete: () => print('Contact removed'),
  /// )
  /// ```
  factory AppChip.input({
    Key? key,
    required String label,
    Widget? avatar,
    bool enabled = true,
    VoidCallback? onTap,
    VoidCallback? onDelete,
    Color? backgroundColor,
    Color? labelColor,
    Color? deleteIconColor,
  }) {
    return AppChip(
      key: key,
      type: AppChipType.input,
      label: label,
      avatar: avatar,
      enabled: enabled,
      onTap: onTap,
      onDelete: onDelete,
      backgroundColor: backgroundColor,
      labelColor: labelColor,
      deleteIconColor: deleteIconColor,
    );
  }

  /// Creates a suggestion chip for recommendations.
  ///
  /// Suggestion chips help users discover actions or complete tasks.
  /// They have a flat appearance without elevation.
  ///
  /// Example:
  /// ```dart
  /// AppChip.suggestion(
  ///   label: 'Coffee shops nearby',
  ///   onTap: () => print('Suggestion selected'),
  /// )
  /// ```
  factory AppChip.suggestion({
    Key? key,
    required String label,
    IconData? icon,
    bool enabled = true,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? labelColor,
  }) {
    return AppChip(
      key: key,
      type: AppChipType.suggestion,
      label: label,
      icon: icon,
      enabled: enabled,
      onTap: onTap,
      backgroundColor: backgroundColor,
      labelColor: labelColor,
    );
  }

  /// The type of chip to display.
  final AppChipType type;

  /// The text label displayed on the chip.
  final String label;

  /// Optional icon displayed before the label (not used for input chips).
  final IconData? icon;

  /// Optional avatar widget displayed before the label (input chips only).
  final Widget? avatar;

  /// Whether the chip is selected (filter chips only).
  final bool selected;

  /// Whether the chip is enabled for interaction.
  final bool enabled;

  /// Callback when the chip is tapped.
  final VoidCallback? onTap;

  /// Callback when the delete button is tapped (input chips only).
  final VoidCallback? onDelete;

  /// Custom background color (overrides theme).
  final Color? backgroundColor;

  /// Custom label color (overrides theme).
  final Color? labelColor;

  /// Custom selected background color (filter chips only).
  final Color? selectedBackgroundColor;

  /// Custom selected label color (filter chips only).
  final Color? selectedLabelColor;

  /// Custom delete icon color (input chips only).
  final Color? deleteIconColor;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppChipType.assist:
        return _buildAssistChip(context);
      case AppChipType.filter:
        return _buildFilterChip(context);
      case AppChipType.input:
        return _buildInputChip(context);
      case AppChipType.suggestion:
        return _buildSuggestionChip(context);
    }
  }

  Widget _buildAssistChip(BuildContext context) {
    return ActionChip(
      label: Text(label),
      avatar: icon != null ? Icon(icon, size: 18) : null,
      onPressed: enabled ? onTap : null,
      backgroundColor: backgroundColor,
      labelStyle: TextStyle(color: labelColor),
      elevation: 1,
      pressElevation: 2,
    );
  }

  Widget _buildFilterChip(BuildContext context) {
    final theme = Theme.of(context);
    return FilterChip(
      label: Text(label),
      avatar: icon != null && !selected ? Icon(icon, size: 18) : null,
      selected: selected,
      onSelected: enabled ? (value) => onTap?.call() : null,
      backgroundColor: backgroundColor,
      selectedColor:
          selectedBackgroundColor ?? theme.colorScheme.secondaryContainer,
      labelStyle: TextStyle(
        color: selected
            ? (selectedLabelColor ?? theme.colorScheme.onSecondaryContainer)
            : labelColor,
      ),
      showCheckmark: true,
      checkmarkColor:
          selectedLabelColor ?? theme.colorScheme.onSecondaryContainer,
    );
  }

  Widget _buildInputChip(BuildContext context) {
    return InputChip(
      label: Text(label),
      avatar: avatar,
      onPressed: enabled ? onTap : null,
      onDeleted: enabled ? onDelete : null,
      backgroundColor: backgroundColor,
      labelStyle: TextStyle(color: labelColor),
      deleteIconColor: deleteIconColor,
      deleteIcon: onDelete != null ? const Icon(Icons.cancel, size: 18) : null,
    );
  }

  Widget _buildSuggestionChip(BuildContext context) {
    final theme = Theme.of(context);
    return ActionChip(
      label: Text(label),
      avatar: icon != null ? Icon(icon, size: 18) : null,
      onPressed: enabled ? onTap : null,
      backgroundColor: backgroundColor ?? theme.colorScheme.surfaceContainerLow,
      labelStyle: TextStyle(color: labelColor),
      elevation: 0,
      pressElevation: 0,
    );
  }
}
