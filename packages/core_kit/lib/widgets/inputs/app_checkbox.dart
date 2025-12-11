// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 checkbox widget that provides consistent checkbox
/// experience across the application.
///
/// The [AppCheckbox] component supports:
/// - Standard checked/unchecked states
/// - Tristate mode (checked/unchecked/indeterminate)
/// - Optional text labels
/// - Error state styling
/// - Material Design 3 theming
/// - Accessibility features
///
/// ## Basic Usage
///
/// ```dart
/// bool isChecked = false;
///
/// AppCheckbox(
///   value: isChecked,
///   label: 'Accept terms and conditions',
///   onChanged: (value) {
///     setState(() {
///       isChecked = value ?? false;
///     });
///   },
/// )
/// ```
///
/// ## Tristate Mode
///
/// Enable tristate mode to support indeterminate state (useful for "select all"
/// functionality):
///
/// ```dart
/// bool? selectAll = null;
///
/// AppCheckbox(
///   value: selectAll,
///   label: 'Select all items',
///   tristate: true,
///   onChanged: (value) {
///     setState(() {
///       selectAll = value;
///     });
///   },
/// )
/// ```
///
/// ## Error State
///
/// Display error state with custom error message:
///
/// ```dart
/// AppCheckbox(
///   value: false,
///   label: 'I agree to the terms',
///   error: true,
///   errorText: 'You must accept the terms to continue',
///   onChanged: (value) {},
/// )
/// ```
///
/// ## Material Design 3 Specifications
///
/// - Visual size: 18x18dp
/// - Touch target: 48x48dp (minimum for accessibility)
/// - Border: 2dp outline when unchecked
/// - Border radius: 2dp
/// - Animation: 200ms smooth transition
/// - Colors: Uses theme's [ColorScheme] tokens
///
/// ## Accessibility
///
/// - Minimum touch target of 48x48dp
/// - Semantic labels from [label] property
/// - State changes announced to screen readers
/// - Keyboard navigation support (Space to toggle)
///
/// See also:
/// - [Material Design 3 Checkbox](https://m3.material.io/components/checkbox)
/// - [Checkbox] - Flutter's base checkbox widget
class AppCheckbox extends StatelessWidget {
  /// Creates a Material Design 3 checkbox.
  ///
  /// The [value] and [onChanged] parameters must not be null unless
  /// [enabled] is false.
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.tristate = false,
    this.activeColor,
    this.checkColor,
    this.error = false,
    this.errorText,
    this.enabled = true,
  });

  /// The current value of the checkbox.
  ///
  /// When [tristate] is false, this value must be either true or false.
  /// When [tristate] is true, this value can be true, false, or null
  /// (representing the indeterminate state).
  final bool? value;

  /// Called when the user toggles the checkbox.
  ///
  /// The checkbox passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the checkbox with the new
  /// value.
  ///
  /// If this callback is null, the checkbox will be displayed as disabled.
  final ValueChanged<bool?>? onChanged;

  /// Optional text label displayed next to the checkbox.
  ///
  /// When null, only the checkbox is displayed.
  final String? label;

  /// If true, the checkbox's [value] can be true, false, or null.
  ///
  /// When [tristate] is true and [value] is null, the checkbox displays
  /// a dash (indeterminate state).
  ///
  /// Defaults to false.
  final bool tristate;

  /// The color to use when this checkbox is checked.
  ///
  /// If null, uses the theme's primary color.
  final Color? activeColor;

  /// The color to use for the checkmark when this checkbox is checked.
  ///
  /// If null, uses the theme's onPrimary color.
  final Color? checkColor;

  /// Whether to display the checkbox in an error state.
  ///
  /// When true, the checkbox uses error color styling.
  ///
  /// Defaults to false.
  final bool error;

  /// Error message to display below the checkbox when [error] is true.
  ///
  /// If null, no error message is displayed even if [error] is true.
  final String? errorText;

  /// Whether the checkbox is enabled for interaction.
  ///
  /// When false, the checkbox is displayed with reduced opacity and does not
  /// respond to touch.
  ///
  /// Defaults to true.
  final bool enabled;

  /// Whether this checkbox is currently enabled.
  ///
  /// A checkbox is considered enabled if [enabled] is true and [onChanged]
  /// is not null.
  bool get _isEnabled => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine checkbox colors based on state
    final Color effectiveActiveColor = error
        ? colorScheme.error
        : (activeColor ?? colorScheme.primary);

    final Color effectiveCheckColor = checkColor ?? colorScheme.onPrimary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main checkbox row
        InkWell(
          onTap: _isEnabled
              ? () {
                  if (tristate) {
                    // Cycle through: unchecked → checked → indeterminate → unchecked
                    if (value == false) {
                      onChanged?.call(true);
                    } else if (value == true) {
                      onChanged?.call(null);
                    } else {
                      onChanged?.call(false);
                    }
                  } else {
                    // Toggle between checked and unchecked
                    onChanged?.call(!(value ?? false));
                  }
                }
              : null,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Checkbox widget
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Checkbox(
                    value: value,
                    tristate: tristate,
                    onChanged: _isEnabled ? onChanged : null,
                    activeColor: effectiveActiveColor,
                    checkColor: effectiveCheckColor,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                  ),
                ),
                // Label (if provided)
                if (label != null) ...[
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      label!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: _isEnabled
                            ? (error
                                  ? colorScheme.error
                                  : colorScheme.onSurface)
                            : colorScheme.onSurface.withValues(alpha: 0.38),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        // Error text (if provided)
        if (error && errorText != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 56.0, top: 4.0),
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
}
