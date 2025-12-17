// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A model class representing a single option in an [AppRadioGroup].
///
/// Each option has a [value] of type [T], a [label] for display,
/// and optional [description], [icon], and [enabled] state.
///
/// ## Example
///
/// ```dart
/// final options = [
///   RadioOption(value: 'male', label: 'Male', icon: Icons.male),
///   RadioOption(value: 'female', label: 'Female', icon: Icons.female),
///   RadioOption(value: 'other', label: 'Other'),
/// ];
/// ```
class RadioOption<T> {
  /// Creates a radio option with the given properties.
  const RadioOption({
    required this.value,
    required this.label,
    this.description,
    this.icon,
    this.enabled = true,
  });

  /// The value associated with this option.
  ///
  /// This value is passed to [AppRadioGroup.onChanged] when selected.
  final T value;

  /// The text label displayed for this option.
  final String label;

  /// An optional description displayed below the label.
  ///
  /// Useful for providing additional context about the option.
  final String? description;

  /// An optional icon displayed before the radio button.
  final IconData? icon;

  /// Whether this individual option is enabled for selection.
  ///
  /// Defaults to true.
  final bool enabled;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioOption<T> &&
        other.value == value &&
        other.label == label;
  }

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}

/// A signature for building custom radio option widgets.
///
/// The [context] is the build context, [option] is the radio option data,
/// [isSelected] indicates if this option is currently selected, and
/// [isEnabled] indicates if the option can be interacted with.
typedef RadioOptionBuilder<T> =
    Widget Function(
      BuildContext context,
      RadioOption<T> option,
      bool isSelected,
      bool isEnabled,
    );

/// A Material Design 3 radio button group widget that allows users to select
/// exactly one option from a set of mutually exclusive choices.
///
/// The [AppRadioGroup] component supports:
/// - Single-selection logic with mutually exclusive options
/// - Vertical and horizontal layout variants
/// - Optional group label/title
/// - Disabled state for entire group or individual options
/// - Error state with validation messages
/// - Custom option builder for complex items
/// - Icons and descriptions per option
/// - Material Design 3 theming
/// - Accessibility features
///
/// ## Basic Usage
///
/// ```dart
/// String? selectedGender;
///
/// AppRadioGroup<String>(
///   label: 'Select Gender',
///   value: selectedGender,
///   options: [
///     RadioOption(value: 'male', label: 'Male'),
///     RadioOption(value: 'female', label: 'Female'),
///     RadioOption(value: 'other', label: 'Other'),
///   ],
///   onChanged: (value) {
///     setState(() {
///       selectedGender = value;
///     });
///   },
/// )
/// ```
///
/// ## Horizontal Layout
///
/// ```dart
/// AppRadioGroup<String>(
///   direction: Axis.horizontal,
///   value: selectedOption,
///   options: options,
///   onChanged: (value) {},
/// )
/// ```
///
/// ## With Icons and Descriptions
///
/// ```dart
/// AppRadioGroup<String>(
///   label: 'Payment Method',
///   value: selectedPayment,
///   options: [
///     RadioOption(
///       value: 'card',
///       label: 'Credit Card',
///       description: 'Pay with Visa/Mastercard',
///       icon: Icons.credit_card,
///     ),
///     RadioOption(
///       value: 'paypal',
///       label: 'PayPal',
///       description: 'Fast and secure',
///       icon: Icons.paypal,
///     ),
///   ],
///   onChanged: (value) {},
/// )
/// ```
///
/// ## Error State
///
/// ```dart
/// AppRadioGroup<String>(
///   label: 'Select an option',
///   value: null,
///   options: options,
///   error: true,
///   errorText: 'Please select an option',
///   onChanged: (value) {},
/// )
/// ```
///
/// ## Material Design 3 Specifications
///
/// - Radio size: 20dp diameter
/// - Touch target: 48dp minimum
/// - Vertical spacing: 12dp between options
/// - Horizontal spacing: 16dp between options
/// - Label spacing: 12dp from radio button to label text
/// - Colors: Uses theme's [ColorScheme] tokens
///
/// ## Accessibility
///
/// - Minimum touch target of 48dp
/// - Semantic labels for screen readers
/// - Group semantics for radio button sets
/// - Keyboard navigation support
///
/// See also:
/// - [Material Design 3 Radio](https://m3.material.io/components/radio-button)
/// - [Radio] - Flutter's base radio button widget
/// - [RadioGroup] - Flutter 3.32+ grouping widget for radio buttons
class AppRadioGroup<T> extends StatelessWidget {
  /// Creates a Material Design 3 radio button group.
  ///
  /// The [options] list must not be empty.
  const AppRadioGroup({
    super.key,
    required this.options,
    required this.onChanged,
    this.value,
    this.label,
    this.direction = Axis.vertical,
    this.enabled = true,
    this.error = false,
    this.errorText,
    this.optionBuilder,
    this.activeColor,
    this.spacing,
  });

  /// The list of available options to choose from.
  ///
  /// Must contain at least one option.
  final List<RadioOption<T>> options;

  /// The currently selected value.
  ///
  /// If null, no option is selected.
  final T? value;

  /// Called when the user selects an option.
  ///
  /// The radio group passes the selected value to the callback.
  /// If null, the entire group is disabled.
  final ValueChanged<T?>? onChanged;

  /// Optional label displayed above the radio group.
  ///
  /// Uses titleMedium typography.
  final String? label;

  /// The layout direction for the options.
  ///
  /// Use [Axis.vertical] for stacked options (default) or
  /// [Axis.horizontal] for side-by-side options.
  final Axis direction;

  /// Whether the entire radio group is enabled.
  ///
  /// When false, all options are disabled regardless of their
  /// individual [RadioOption.enabled] state.
  ///
  /// Defaults to true.
  final bool enabled;

  /// Whether to display the radio group in an error state.
  ///
  /// When true, the group uses error color styling.
  ///
  /// Defaults to false.
  final bool error;

  /// Error message to display below the group when [error] is true.
  ///
  /// If null, no error message is displayed even if [error] is true.
  final String? errorText;

  /// Optional custom builder for rendering each option.
  ///
  /// When provided, this builder is used instead of the default option layout.
  /// The builder receives the option data, selection state, and enabled state.
  final RadioOptionBuilder<T>? optionBuilder;

  /// The color to use when an option is selected.
  ///
  /// If null, uses the theme's primary color.
  final Color? activeColor;

  /// The spacing between options.
  ///
  /// If null, uses 12dp for vertical and 16dp for horizontal layouts.
  final double? spacing;

  /// Whether this radio group is currently enabled.
  bool get _isGroupEnabled => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine active color based on state
    final effectiveActiveColor = error
        ? colorScheme.error
        : (activeColor ?? colorScheme.primary);

    // Determine spacing based on direction
    final effectiveSpacing =
        spacing ?? (direction == Axis.vertical ? 12.0 : 16.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group label
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.titleMedium?.copyWith(
              color: error
                  ? colorScheme.error
                  : (_isGroupEnabled
                        ? colorScheme.onSurface
                        : colorScheme.onSurface.withValues(alpha: 0.38)),
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Radio options with RadioGroup wrapper for Flutter 3.32+
        IgnorePointer(
          ignoring: !_isGroupEnabled,
          child: RadioGroup<T>(
            groupValue: value,
            onChanged: onChanged ?? (_) {},
            child: _buildOptionsLayout(
              context,
              effectiveActiveColor,
              effectiveSpacing,
            ),
          ),
        ),

        // Error text
        if (error && errorText != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              errorText!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Builds the options layout based on [direction].
  Widget _buildOptionsLayout(
    BuildContext context,
    Color activeColor,
    double spacing,
  ) {
    final optionWidgets = options.map((option) {
      return _buildOptionTile(context, option, activeColor);
    }).toList();

    if (direction == Axis.horizontal) {
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: optionWidgets,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < optionWidgets.length; i++) ...[
          optionWidgets[i],
          if (i < optionWidgets.length - 1) SizedBox(height: spacing),
        ],
      ],
    );
  }

  /// Builds a single radio option tile.
  Widget _buildOptionTile(
    BuildContext context,
    RadioOption<T> option,
    Color activeColor,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final isSelected = value == option.value;
    final isOptionEnabled = _isGroupEnabled && option.enabled;

    // Use custom builder if provided
    if (optionBuilder != null) {
      return GestureDetector(
        onTap: isOptionEnabled ? () => onChanged?.call(option.value) : null,
        child: optionBuilder!(context, option, isSelected, isOptionEnabled),
      );
    }

    // Default option layout
    return InkWell(
      onTap: isOptionEnabled ? () => onChanged?.call(option.value) : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: option.description != null
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            // Icon (if provided)
            if (option.icon != null) ...[
              Icon(
                option.icon,
                size: 24,
                color: isOptionEnabled
                    ? (isSelected ? activeColor : colorScheme.onSurfaceVariant)
                    : colorScheme.onSurface.withValues(alpha: 0.38),
              ),
              const SizedBox(width: 8),
            ],

            // Radio button - wrapped in IgnorePointer to prevent double-trigger
            // since InkWell handles the tap and RadioGroup manages the state
            IgnorePointer(
              child: SizedBox(
                width: 48,
                height: 48,
                child: Radio<T>.adaptive(
                  value: option.value,
                  toggleable: false,
                  activeColor: activeColor,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                ),
              ),
            ),

            // Label and description
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.label,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isOptionEnabled
                          ? colorScheme.onSurface
                          : colorScheme.onSurface.withValues(alpha: 0.38),
                    ),
                  ),
                  if (option.description != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      option.description!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isOptionEnabled
                            ? colorScheme.onSurfaceVariant
                            : colorScheme.onSurface.withValues(alpha: 0.38),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
