// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppTextField] component.
///
/// A Material Design 3 text input component with consistent styling and theming.

/// Interactive Playground - explore all AppTextField properties with knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppTextField)
Widget appTextFieldPlayground(BuildContext context) {
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
  final hasPrefixIcon = context.knobs.boolean(
    label: 'Has Prefix Icon',
    initialValue: false,
  );
  final hasSuffixIcon = context.knobs.boolean(
    label: 'Has Suffix Icon',
    initialValue: false,
  );
  final obscureText = context.knobs.boolean(
    label: 'Obscure Text',
    initialValue: false,
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final readOnly = context.knobs.boolean(
    label: 'Read Only',
    initialValue: false,
  );
  final hasMaxLength = context.knobs.boolean(
    label: 'Has Max Length',
    initialValue: false,
  );

  final label = hasLabel
      ? context.knobs.string(label: 'Label', initialValue: 'Label text')
      : null;
  final hint = hasHint
      ? context.knobs.string(label: 'Hint', initialValue: 'Enter text here')
      : null;
  final helperText = hasHelperText
      ? context.knobs.string(
          label: 'Helper Text',
          initialValue: 'Helper text goes here',
        )
      : null;
  final errorText = hasError
      ? context.knobs.string(
          label: 'Error Text',
          initialValue: 'This field has an error',
        )
      : null;
  final maxLength = hasMaxLength
      ? context.knobs.int.slider(
          label: 'Max Length',
          initialValue: 50,
          min: 10,
          max: 200,
        )
      : null;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppTextField(
        label: label,
        hint: hint,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: hasPrefixIcon ? Icons.text_fields : null,
        suffixIcon: hasSuffixIcon ? Icons.clear : null,
        obscureText: obscureText,
        enabled: enabled,
        readOnly: readOnly,
        maxLength: maxLength,
        onChanged: (_) {},
      ),
    ),
  );
}

/// Default - Basic text field
@widgetbook.UseCase(name: 'Default', type: AppTextField)
Widget appTextFieldDefault(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppTextField(
        label: 'Full Name',
        hint: 'Enter your full name',
        helperText: 'Your first and last name',
      ),
    ),
  );
}

/// With Error - Text field with validation error
@widgetbook.UseCase(name: 'With Error', type: AppTextField)
Widget appTextFieldWithError(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppTextField(
        label: 'Email',
        hint: 'example@email.com',
        errorText: 'Please enter a valid email address',
      ),
    ),
  );
}

/// Multiline - Text area with multiple lines
@widgetbook.UseCase(name: 'Multiline', type: AppTextField)
Widget appTextFieldMultiline(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppTextField.multiline(
        label: 'Description',
        hint: 'Enter a detailed description...',
        helperText: 'Maximum 500 characters',
        maxLength: 500,
        maxLines: 5,
        minLines: 3,
      ),
    ),
  );
}

/// With Prefix Icon - Text field with leading icon
@widgetbook.UseCase(name: 'With Prefix Icon', type: AppTextField)
Widget appTextFieldWithPrefixIcon(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppTextField(
        label: 'Email',
        hint: 'your.email@example.com',
        prefixIcon: Icons.email_outlined,
      ),
    ),
  );
}

/// With Suffix Icon - Text field with trailing icon
@widgetbook.UseCase(name: 'With Suffix Icon', type: AppTextField)
Widget appTextFieldWithSuffixIcon(BuildContext context) {
  final controller = TextEditingController(text: 'Some text');
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppTextField(
        controller: controller,
        label: 'Search',
        hint: 'Search for items...',
        prefixIcon: Icons.search,
        suffixIcon: Icons.clear,
        onSuffixIconTap: () => controller.clear(),
      ),
    ),
  );
}

/// Disabled - Non-editable text field
@widgetbook.UseCase(name: 'Disabled', type: AppTextField)
Widget appTextFieldDisabled(BuildContext context) {
  final controller = TextEditingController(text: 'Disabled content');
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppTextField(
        controller: controller,
        label: 'Disabled Field',
        hint: 'Cannot type here',
        helperText: 'This field is disabled',
        enabled: false,
      ),
    ),
  );
}

/// Read Only - Selectable but not editable
@widgetbook.UseCase(name: 'Read Only', type: AppTextField)
Widget appTextFieldReadOnly(BuildContext context) {
  final controller = TextEditingController(
    text: 'Read-only content that can be selected',
  );
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppTextField(
        controller: controller,
        label: 'Read-only Field',
        hint: 'Can select but not edit',
        helperText: 'This field is read-only',
        readOnly: true,
      ),
    ),
  );
}

/// Email Input - Text field optimized for email
@widgetbook.UseCase(name: 'Email Input', type: AppTextField)
Widget appTextFieldEmail(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppTextField.email(
        label: 'Email Address',
        hint: 'your.email@example.com',
        prefixIcon: Icons.email_outlined,
        helperText: 'We will never share your email',
      ),
    ),
  );
}

/// Numeric Input - Text field for numbers
@widgetbook.UseCase(name: 'Numeric Input', type: AppTextField)
Widget appTextFieldNumeric(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppTextField.numeric(
        label: 'Age',
        hint: 'Enter your age',
        maxLength: 3,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    ),
  );
}
