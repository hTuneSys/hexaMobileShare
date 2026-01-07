// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppPasswordField] component.
///
/// A Material Design 3 password input field with security features and
/// password strength indicator.

/// Interactive Playground - explore all AppPasswordField properties with knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppPasswordField)
Widget appPasswordFieldPlayground(BuildContext context) {
  final hasLabel = context.knobs.boolean(
    label: 'Has Label',
    initialValue: true,
  );
  final hasHint = context.knobs.boolean(label: 'Has Hint', initialValue: true);
  final hasHelperText = context.knobs.boolean(
    label: 'Has Helper Text',
    initialValue: false,
  );
  final hasError = context.knobs.boolean(
    label: 'Has Error',
    initialValue: false,
  );
  final showStrengthIndicator = context.knobs.boolean(
    label: 'Show Strength Indicator',
    initialValue: true,
  );
  final showVisibilityToggle = context.knobs.boolean(
    label: 'Show Visibility Toggle',
    initialValue: true,
  );
  final showLockIcon = context.knobs.boolean(
    label: 'Show Lock Icon',
    initialValue: true,
  );
  final preventCopyPaste = context.knobs.boolean(
    label: 'Prevent Copy/Paste',
    initialValue: false,
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  final label = hasLabel
      ? context.knobs.string(label: 'Label', initialValue: 'Password')
      : null;
  final hint = hasHint
      ? context.knobs.string(label: 'Hint', initialValue: 'Enter your password')
      : null;
  final helperText = hasHelperText
      ? context.knobs.string(
          label: 'Helper Text',
          initialValue: 'Must be at least 8 characters',
        )
      : null;
  final errorText = hasError
      ? context.knobs.string(
          label: 'Error Text',
          initialValue: 'Password is too weak',
        )
      : null;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppPasswordField(
        label: label,
        hint: hint,
        helperText: helperText,
        errorText: errorText,
        showStrengthIndicator: showStrengthIndicator,
        showVisibilityToggle: showVisibilityToggle,
        showLockIcon: showLockIcon,
        preventCopyPaste: preventCopyPaste,
        enabled: enabled,
        onChanged: (_) {},
      ),
    ),
  );
}

/// Default - Basic password field
@widgetbook.UseCase(name: 'Default', type: AppPasswordField)
Widget appPasswordFieldDefault(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppPasswordField(label: 'Password', hint: 'Enter your password'),
    ),
  );
}

/// With Strength Indicator - Shows password strength
@widgetbook.UseCase(name: 'With Strength Indicator', type: AppPasswordField)
Widget appPasswordFieldWithStrength(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppPasswordField(
        label: 'Create Password',
        hint: 'Choose a strong password',
        helperText: 'Must be at least 8 characters',
        showStrengthIndicator: true,
      ),
    ),
  );
}

/// With Error - Password field with validation error
@widgetbook.UseCase(name: 'With Error', type: AppPasswordField)
Widget appPasswordFieldWithError(BuildContext context) {
  final controller = TextEditingController(text: '123');
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppPasswordField(
        controller: controller,
        label: 'Password',
        hint: 'Enter your password',
        errorText: 'Password must be at least 8 characters',
        showStrengthIndicator: true,
      ),
    ),
  );
}

/// Without Lock Icon - Password field without prefix icon
@widgetbook.UseCase(name: 'Without Lock Icon', type: AppPasswordField)
Widget appPasswordFieldWithoutLockIcon(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppPasswordField(
        label: 'Password',
        hint: 'Enter your password',
        showLockIcon: false,
      ),
    ),
  );
}

/// Without Visibility Toggle - Cannot toggle visibility
@widgetbook.UseCase(name: 'Without Visibility Toggle', type: AppPasswordField)
Widget appPasswordFieldWithoutVisibilityToggle(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppPasswordField(
        label: 'PIN Code',
        hint: 'Enter your PIN',
        showVisibilityToggle: false,
      ),
    ),
  );
}

/// Prevent Copy/Paste - Enhanced security mode
@widgetbook.UseCase(name: 'Prevent Copy/Paste', type: AppPasswordField)
Widget appPasswordFieldPreventCopyPaste(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppPasswordField(
        label: 'Master Password',
        hint: 'Enter master password',
        helperText: 'Copy/paste disabled for security',
        preventCopyPaste: true,
      ),
    ),
  );
}

/// Disabled - Non-editable password field
@widgetbook.UseCase(name: 'Disabled', type: AppPasswordField)
Widget appPasswordFieldDisabled(BuildContext context) {
  final controller = TextEditingController(text: 'password123');
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppPasswordField(
        controller: controller,
        label: 'Password',
        hint: 'Enter your password',
        enabled: false,
      ),
    ),
  );
}

/// Confirm Password - Password confirmation field
@widgetbook.UseCase(name: 'Confirm Password', type: AppPasswordField)
Widget appPasswordFieldConfirm(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppPasswordField(
        label: 'Confirm Password',
        hint: 'Re-enter your password',
        helperText: 'Passwords must match',
        showStrengthIndicator: false,
      ),
    ),
  );
}

/// Current Password - Field for current password
@widgetbook.UseCase(name: 'Current Password', type: AppPasswordField)
Widget appPasswordFieldCurrent(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppPasswordField(
        label: 'Current Password',
        hint: 'Enter current password',
        helperText: 'Required to change password',
        showStrengthIndicator: false,
      ),
    ),
  );
}
