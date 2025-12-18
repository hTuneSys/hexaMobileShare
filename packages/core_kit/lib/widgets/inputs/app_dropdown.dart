// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 dropdown menu component for selecting a single value
/// from a list of options.
///
/// Wraps Flutter's [DropdownMenu] with consistent theming and enhanced
/// functionality like search, custom item rendering, and validation.
///
/// Example usage:
/// ```dart
/// AppDropdown<String>(
///   items: ['Option 1', 'Option 2', 'Option 3'],
///   value: selectedValue,
///   onChanged: (value) => setState(() => selectedValue = value),
///   label: 'Select an option',
///   hint: 'Choose...',
/// )
/// ```
class AppDropdown<T> extends StatelessWidget {
  /// List of items to display in the dropdown
  final List<T> items;

  /// Currently selected value
  final T? value;

  /// Callback when a new value is selected
  final ValueChanged<T?>? onChanged;

  /// Function to convert item to display string
  final String Function(T) itemLabelBuilder;

  /// Label text displayed above the field
  final String? label;

  /// Hint text displayed when no value is selected
  final String? hint;

  /// Helper text displayed below the field
  final String? helperText;

  /// Error text displayed below the field with error styling
  final String? errorText;

  /// Leading icon for the dropdown field
  final IconData? leadingIcon;

  /// Whether the dropdown is enabled
  final bool enabled;

  /// Enable search/filter functionality for items
  final bool enableSearch;

  /// Width of the dropdown menu
  final double? width;

  /// Custom function to extract searchable text from item
  /// If null, uses itemLabelBuilder
  final String Function(T)? searchMatcher;

  /// Custom widget builder for dropdown menu entries
  /// Allows rich content like icons and subtitles
  final Widget Function(T)? customItemBuilder;

  /// Creates a Material Design 3 dropdown component
  const AppDropdown({
    required this.items,
    required this.itemLabelBuilder,
    this.value,
    this.onChanged,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.leadingIcon,
    this.enabled = true,
    this.enableSearch = false,
    this.width,
    this.searchMatcher,
    this.customItemBuilder,
    super.key,
  });

  /// Creates a dropdown with search enabled
  const AppDropdown.withSearch({
    required this.items,
    required this.itemLabelBuilder,
    this.value,
    this.onChanged,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.leadingIcon,
    this.enabled = true,
    this.width,
    this.searchMatcher,
    this.customItemBuilder,
    super.key,
  }) : enableSearch = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownMenu<T>(
          initialSelection: value,
          enabled: enabled,
          width: width,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          leadingIcon: leadingIcon != null ? Icon(leadingIcon) : null,
          enableSearch: enableSearch,
          enableFilter: enableSearch,
          errorText: errorText,
          dropdownMenuEntries: items.map((item) {
            return DropdownMenuEntry<T>(
              value: item,
              label: itemLabelBuilder(item),
              enabled: enabled,
              // Use custom builder if provided
              labelWidget: customItemBuilder != null
                  ? customItemBuilder!(item)
                  : null,
            );
          }).toList(),
          onSelected: enabled ? onChanged : null,
          inputDecorationTheme: InputDecorationTheme(
            border: hasError
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.error),
                  )
                : null,
            enabledBorder: hasError
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: theme.colorScheme.error),
                  )
                : null,
          ),
        ),
        if (helperText != null && !hasError) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              helperText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// A helper class for creating dropdown items with rich content
///
/// Use this when you need dropdown items with icons, subtitles,
/// or other complex layouts.
///
/// Example:
/// ```dart
/// final items = [
///   AppDropdownItem(
///     value: 'us',
///     label: 'United States',
///     icon: Icons.flag,
///     subtitle: 'USA',
///   ),
/// ];
/// ```
class AppDropdownItem<T> {
  /// The actual value of this item
  final T value;

  /// Display label for the item
  final String label;

  /// Optional icon to display
  final IconData? icon;

  /// Optional subtitle text
  final String? subtitle;

  /// Creates a dropdown item with rich content
  const AppDropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.subtitle,
  });

  /// Builds the widget representation of this item
  Widget buildWidget(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 12)],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppDropdownItem<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'AppDropdownItem(value: $value, label: $label)';
}
