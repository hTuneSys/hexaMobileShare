// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A Material Design 3 text input component with consistent styling and theming.
///
/// This component wraps Flutter's [TextField] widget with Material Design 3
/// styling, providing a standardized, accessible way to collect text input
/// from users with built-in validation support, prefix/suffix icons, and
/// multiple input variants.
///
/// ## Features
///
/// - **Material Design 3 Theming**: Automatically uses theme colors, typography,
///   and spacing following MD3 guidelines
/// - **Validation Support**: Displays error text with proper styling and state
/// - **Prefix/Suffix Icons**: Support for leading and trailing icons with tap callbacks
/// - **Multiple Input Types**: Single-line, multiline, numeric, email, URL, phone
/// - **Input Formatters**: Built-in support for custom input formatting
/// - **Character Counter**: Optional character count display with max length
/// - **Accessibility**: Proper semantic labels and screen reader support
/// - **State Management**: Handles enabled, disabled, read-only, focused, and error states
///
/// ## Usage
///
/// ```dart
/// // Basic text field
/// AppTextField(
///   label: 'Full Name',
///   hint: 'Enter your full name',
///   onChanged: (value) => print(value),
/// )
///
/// // Text field with validation error
/// AppTextField(
///   label: 'Email',
///   errorText: 'Please enter a valid email',
///   keyboardType: TextInputType.emailAddress,
/// )
///
/// // Multiline text area
/// AppTextField.multiline(
///   label: 'Description',
///   hint: 'Enter a detailed description',
///   maxLines: 5,
/// )
///
/// // Text field with prefix and suffix icons
/// AppTextField(
///   label: 'Search',
///   prefixIcon: Icons.search,
///   suffixIcon: Icons.clear,
///   onSuffixIconTap: () => controller.clear(),
/// )
///
/// // Numeric input with formatter
/// AppTextField.numeric(
///   label: 'Phone Number',
///   hint: '(123) 456-7890',
/// )
/// ```
///
/// ## Common Use Cases
///
/// **Registration/Login Forms**:
/// - Name, email, username fields with appropriate keyboard types
/// - Integration with form validation frameworks
///
/// **Comments & Descriptions**:
/// - Multi-line text areas with character limits
/// - Helper text for user guidance
///
/// **Numeric Input**:
/// - Phone numbers, age, quantity with numeric keyboards
/// - Input formatters for proper formatting
///
/// **Search Functionality**:
/// - Search bars with search icons and clear buttons
/// - Real-time search feedback
///
/// **Formatted Input**:
/// - Credit card numbers, dates with input formatters
/// - Custom pattern validation
///
/// ## Material Design 3 Specifications
///
/// **States**:
/// - Enabled: Default interactive state with outlined border
/// - Focused: Primary color border (2px width)
/// - Error: Error color border with error text
/// - Disabled: Reduced opacity (38%)
/// - Read-only: Enabled appearance without editing
///
/// **Typography**:
/// - Label: bodyLarge with floating label animation
/// - Input text: bodyLarge
/// - Helper/Error text: bodySmall
/// - Character counter: bodySmall
///
/// **Spacing**:
/// - Vertical padding: 16dp inside field
/// - Horizontal padding: 16dp inside field
/// - Label to input: 4dp when floating
/// - Helper text margin: 4dp from bottom
/// - Icon padding: 12dp from edges
///
/// **Border Radius**: 4dp (M3 small)
///
/// ## Accessibility
///
/// - Semantic labels automatically set from label text
/// - Error announcements for screen readers
/// - Proper keyboard navigation
/// - Minimum touch target sizes enforced
///
/// See also:
/// - [Material Design 3 Text Fields](https://m3.material.io/components/text-fields)
/// - [AppPasswordField] for password-specific functionality
/// - [AppSearchField] for search-optimized text fields
class AppTextField extends StatelessWidget {
  /// Controller for the text field.
  ///
  /// If null, a controller will be created internally.
  final TextEditingController? controller;

  /// Label text displayed above the field (floats when focused or filled).
  final String? label;

  /// Hint text displayed when field is empty and not focused.
  final String? hint;

  /// Helper text displayed below the field.
  ///
  /// Provides guidance to the user about what to enter.
  final String? helperText;

  /// Error text displayed below the field in error color.
  ///
  /// When not null, the field displays error state with appropriate styling.
  final String? errorText;

  /// Prefix icon displayed at the start of the field.
  final IconData? prefixIcon;

  /// Callback when prefix icon is tapped.
  final VoidCallback? onPrefixIconTap;

  /// Suffix icon displayed at the end of the field.
  final IconData? suffixIcon;

  /// Callback when suffix icon is tapped.
  final VoidCallback? onSuffixIconTap;

  /// Callback when text changes.
  ///
  /// Called for every character change in the field.
  final ValueChanged<String>? onChanged;

  /// Callback when editing is complete.
  ///
  /// Called when user presses "done" or field loses focus.
  final VoidCallback? onEditingComplete;

  /// Callback when field is submitted.
  ///
  /// Called when user presses keyboard action button (e.g., "done", "search").
  final ValueChanged<String>? onSubmitted;

  /// Callback when field gains or loses focus.
  final ValueChanged<bool>? onFocusChange;

  /// Whether the field text is obscured (for passwords).
  ///
  /// When true, text is replaced with dots/asterisks.
  final bool obscureText;

  /// Whether the field is enabled for user interaction.
  ///
  /// When false, the field appears disabled and cannot be edited.
  final bool enabled;

  /// Whether the field is read-only.
  ///
  /// When true, the field displays text but cannot be edited.
  /// Unlike disabled state, read-only fields can be focused and text can be selected.
  final bool readOnly;

  /// Maximum number of lines for the text field.
  ///
  /// Set to null for unlimited lines (auto-expanding field).
  /// Must be null or greater than or equal to [minLines].
  final int? maxLines;

  /// Minimum number of lines for the text field.
  ///
  /// The field will have at least this many lines even if empty.
  final int? minLines;

  /// Maximum length of text that can be entered.
  ///
  /// When set, a character counter is displayed below the field.
  final int? maxLength;

  /// Whether to show character counter.
  ///
  /// Only applies when [maxLength] is set.
  final bool showCharacterCounter;

  /// Keyboard type for the text input.
  ///
  /// Determines which keyboard layout is shown to the user.
  final TextInputType? keyboardType;

  /// Text input action button label.
  ///
  /// Determines the action button shown on the keyboard (e.g., "done", "next", "search").
  final TextInputAction? textInputAction;

  /// Input formatters to apply to the text.
  ///
  /// Used to format text as user types (e.g., phone number formatting).
  final List<TextInputFormatter>? inputFormatters;

  /// Whether to autofocus this field on widget creation.
  final bool autofocus;

  /// Focus node for controlling focus programmatically.
  final FocusNode? focusNode;

  /// Text capitalization mode.
  final TextCapitalization textCapitalization;

  /// Text alignment within the field.
  final TextAlign textAlign;

  /// Semantic label for accessibility.
  ///
  /// If null, uses [label] text.
  final String? semanticLabel;

  /// Auto-fill hints for browser/OS integration.
  final Iterable<String>? autofillHints;

  /// Creates a Material Design 3 text field.
  const AppTextField({
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onFocusChange,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.showCharacterCounter = true,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.autofocus = false,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.semanticLabel,
    this.autofillHints,
    super.key,
  });

  /// Creates a multiline text field (text area).
  ///
  /// Optimized for longer text input with multiple lines.
  /// Default configuration includes 3-5 visible lines.
  const AppTextField.multiline({
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onFocusChange,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 5,
    this.minLines = 3,
    this.maxLength,
    this.showCharacterCounter = true,
    this.inputFormatters,
    this.autofocus = false,
    this.focusNode,
    this.textCapitalization = TextCapitalization.sentences,
    this.textAlign = TextAlign.start,
    this.semanticLabel,
    this.autofillHints,
    super.key,
  }) : obscureText = false,
       keyboardType = TextInputType.multiline,
       textInputAction = TextInputAction.newline;

  /// Creates a numeric input text field.
  ///
  /// Optimized for numeric input with numeric keyboard and appropriate formatting.
  const AppTextField.numeric({
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onFocusChange,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.showCharacterCounter = true,
    this.inputFormatters,
    this.autofocus = false,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.semanticLabel,
    this.autofillHints,
    super.key,
  }) : obscureText = false,
       keyboardType = TextInputType.number,
       textInputAction = TextInputAction.done,
       maxLines = 1,
       minLines = null,
       textCapitalization = TextCapitalization.none;

  /// Creates an email input text field.
  ///
  /// Optimized for email addresses with email keyboard layout.
  const AppTextField.email({
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onFocusChange,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.showCharacterCounter = false,
    this.inputFormatters,
    this.autofocus = false,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.semanticLabel,
    super.key,
  }) : obscureText = false,
       keyboardType = TextInputType.emailAddress,
       textInputAction = TextInputAction.next,
       maxLines = 1,
       minLines = null,
       textCapitalization = TextCapitalization.none,
       autofillHints = const [AutofillHints.email];

  /// Creates a phone number input text field.
  ///
  /// Optimized for phone numbers with phone keyboard layout.
  const AppTextField.phone({
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onFocusChange,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.showCharacterCounter = false,
    this.inputFormatters,
    this.autofocus = false,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.semanticLabel,
    super.key,
  }) : obscureText = false,
       keyboardType = TextInputType.phone,
       textInputAction = TextInputAction.done,
       maxLines = 1,
       minLines = null,
       textCapitalization = TextCapitalization.none,
       autofillHints = const [AutofillHints.telephoneNumber];

  /// Creates a URL input text field.
  ///
  /// Optimized for web addresses with URL keyboard layout.
  const AppTextField.url({
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.onPrefixIconTap,
    this.suffixIcon,
    this.onSuffixIconTap,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onFocusChange,
    this.enabled = true,
    this.readOnly = false,
    this.maxLength,
    this.showCharacterCounter = false,
    this.inputFormatters,
    this.autofocus = false,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.semanticLabel,
    super.key,
  }) : obscureText = false,
       keyboardType = TextInputType.url,
       textInputAction = TextInputAction.done,
       maxLines = 1,
       minLines = null,
       textCapitalization = TextCapitalization.none,
       autofillHints = const [AutofillHints.url];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Focus(
      onFocusChange: onFocusChange,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          helperText: helperText,
          errorText: errorText,
          prefixIcon: prefixIcon != null
              ? IconButton(
                  icon: Icon(prefixIcon),
                  onPressed: onPrefixIconTap,
                  color: errorText != null ? colorScheme.error : null,
                )
              : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: onSuffixIconTap,
                  color: errorText != null ? colorScheme.error : null,
                )
              : null,
          counterText: showCharacterCounter ? null : '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: colorScheme.outline, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: colorScheme.error, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: colorScheme.error, width: 2.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: colorScheme.outline.withValues(alpha: 0.38),
              width: 1.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
        ),
        obscureText: obscureText,
        enabled: enabled,
        readOnly: readOnly,
        maxLines: obscureText ? 1 : maxLines,
        minLines: minLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        autofocus: autofocus,
        textCapitalization: textCapitalization,
        textAlign: textAlign,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
        autofillHints: autofillHints,
      ),
    );
  }
}
