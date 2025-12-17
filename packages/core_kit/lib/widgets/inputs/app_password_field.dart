// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Password strength level enumeration
enum PasswordStrength {
  /// Weak password (length < 8 or simple patterns)
  weak,

  /// Medium password (meets basic requirements)
  medium,

  /// Strong password (meets all requirements with complexity)
  strong,
}

/// A Material Design 3 password input field with security features.
///
/// This specialized text field extends the standard text input with
/// password-specific functionality including:
/// - Obscured text display with visibility toggle
/// - Password strength indicator
/// - Copy/paste prevention option
/// - Integration with password validators
/// - Accessibility support for screen readers
///
/// Security Best Practices:
/// - Use [preventCopyPaste] carefully: while it enhances security by
///   preventing clipboard access, it may impact user experience,
///   especially for users relying on password managers. Consider
///   disabling it for login forms and enabling it only for critical
///   operations like password creation or admin actions.
/// - Enable [showStrengthIndicator] for password creation flows to
///   guide users toward creating stronger passwords.
///
/// Example:
/// ```dart
/// AppPasswordField(
///   label: 'Password',
///   onChanged: (value) => print('Password: $value'),
///   showStrengthIndicator: true,
/// )
/// ```
class AppPasswordField extends StatefulWidget {
  /// Controller for the password field
  final TextEditingController? controller;

  /// Label text displayed above the field
  final String? label;

  /// Hint text displayed when field is empty
  final String? hint;

  /// Helper text displayed below the field
  final String? helperText;

  /// Error text displayed below the field
  final String? errorText;

  /// Callback when password changes
  final ValueChanged<String>? onChanged;

  /// Callback when field is submitted
  final ValueChanged<String>? onSubmitted;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether to show password strength indicator
  final bool showStrengthIndicator;

  /// Whether to prevent copy/paste operations
  final bool preventCopyPaste;

  /// Whether to show visibility toggle icon
  final bool showVisibilityToggle;

  /// Whether to show lock prefix icon
  final bool showLockIcon;

  /// Autofocus the field
  final bool autofocus;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Auto-fill hints for browser/OS integration
  final Iterable<String>? autofillHints;

  /// Creates an AppPasswordField
  const AppPasswordField({
    this.controller,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.showStrengthIndicator = false,
    this.preventCopyPaste = false,
    this.showVisibilityToggle = true,
    this.showLockIcon = false,
    this.autofocus = false,
    this.textInputAction,
    this.autofillHints,
    super.key,
  });

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  late TextEditingController _controller;
  bool _obscureText = true;
  PasswordStrength _strength = PasswordStrength.weak;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_updatePasswordStrength);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _updatePasswordStrength() {
    if (widget.showStrengthIndicator) {
      setState(() {
        _strength = _calculatePasswordStrength(_controller.text);
      });
    }
  }

  /// Calculates password strength based on various criteria
  PasswordStrength _calculatePasswordStrength(String password) {
    if (password.isEmpty) {
      return PasswordStrength.weak;
    }

    int score = 0;

    // Length check
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;

    // Character variety checks
    if (RegExp(r'[a-z]').hasMatch(password)) score++; // lowercase
    if (RegExp(r'[A-Z]').hasMatch(password)) score++; // uppercase
    if (RegExp(r'[0-9]').hasMatch(password)) score++; // numbers
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      score++; // special chars
    }

    // Calculate strength
    if (score >= 5) {
      return PasswordStrength.strong;
    } else if (score >= 3) {
      return PasswordStrength.medium;
    } else {
      return PasswordStrength.weak;
    }
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Color _getStrengthColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (_strength) {
      case PasswordStrength.weak:
        return colorScheme.error;
      case PasswordStrength.medium:
        return colorScheme.tertiary;
      case PasswordStrength.strong:
        return colorScheme.primary;
    }
  }

  String _getStrengthText() {
    switch (_strength) {
      case PasswordStrength.weak:
        return 'Weak';
      case PasswordStrength.medium:
        return 'Medium';
      case PasswordStrength.strong:
        return 'Strong';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          label: widget.label ?? 'Password field',
          hint: _obscureText
              ? 'Password is hidden. Tap eye icon to show password.'
              : 'Password is visible. Tap eye icon to hide password.',
          child: TextField(
            controller: _controller,
            obscureText: _obscureText,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: widget.textInputAction ?? TextInputAction.done,
            autofillHints: widget.autofillHints ?? [AutofillHints.password],
            enableInteractiveSelection: !widget.preventCopyPaste,
            contextMenuBuilder: widget.preventCopyPaste
                ? (context, editableTextState) => const SizedBox.shrink()
                : null,
            inputFormatters: widget.preventCopyPaste
                ? [
                    FilteringTextInputFormatter.deny(
                      RegExp(r'[\u0000-\u001F\u007F-\u009F]'),
                    ),
                  ]
                : null,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              helperText: widget.helperText,
              errorText: widget.errorText,
              prefixIcon: widget.showLockIcon
                  ? Icon(
                      Icons.lock_outline,
                      semanticLabel: 'Password lock icon',
                    )
                  : null,
              suffixIcon: widget.showVisibilityToggle
                  ? Semantics(
                      label: _obscureText ? 'Show password' : 'Hide password',
                      child: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                        onPressed: widget.enabled ? _toggleVisibility : null,
                        tooltip: _obscureText
                            ? 'Show password'
                            : 'Hide password',
                      ),
                    )
                  : null,
            ),
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
          ),
        ),
        if (widget.showStrengthIndicator &&
            _controller.text.isNotEmpty &&
            widget.errorText == null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 12.0),
            child: Row(
              children: [
                // Strength bars
                for (int i = 0; i < 3; i++)
                  Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(right: i < 2 ? 4.0 : 0),
                      decoration: BoxDecoration(
                        color: i <= _strength.index
                            ? _getStrengthColor(context)
                            : colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                // Strength text
                Text(
                  _getStrengthText(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: _getStrengthColor(context),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
