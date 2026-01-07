// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppCheckbox] component.
///
/// A Material Design 3 checkbox widget that provides consistent checkbox
/// experience with support for tristate mode, error states, and theming.

/// Interactive Playground - explore all AppCheckbox properties with knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppCheckbox)
Widget appCheckboxPlayground(BuildContext context) {
  final state = context.knobs.object.dropdown(
    label: 'State',
    options: const ['unchecked', 'checked', 'indeterminate'],
    labelBuilder: (value) => value,
  );

  final bool? value = state == 'checked'
      ? true
      : state == 'unchecked'
      ? false
      : null;

  final tristate = state == 'indeterminate';
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final error = context.knobs.boolean(label: 'Error', initialValue: false);
  final hasLabel = context.knobs.boolean(
    label: 'Has Label',
    initialValue: true,
  );
  final hasErrorText = context.knobs.boolean(
    label: 'Has Error Text',
    initialValue: false,
  );
  final hasCustomColors = context.knobs.boolean(
    label: 'Has Custom Colors',
    initialValue: false,
  );

  final label = hasLabel
      ? context.knobs.string(
          label: 'Label Text',
          initialValue: 'Checkbox label',
        )
      : null;

  final errorText = hasErrorText
      ? context.knobs.string(
          label: 'Error Text',
          initialValue: 'This field is required',
        )
      : null;

  final activeColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Active Color',
          initialValue: Colors.green,
        )
      : null;

  final checkColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Check Color',
          initialValue: Colors.white,
        )
      : null;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCheckbox(
        value: value,
        label: label,
        tristate: tristate,
        error: error,
        errorText: errorText,
        activeColor: activeColor,
        checkColor: checkColor,
        enabled: enabled,
        onChanged: enabled ? (_) {} : null,
      ),
    ),
  );
}

/// Default - Basic unchecked checkbox
@widgetbook.UseCase(name: 'Default', type: AppCheckbox)
Widget appCheckboxDefault(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCheckbox(
        value: false,
        label: 'Checkbox label',
        onChanged: (_) {},
      ),
    ),
  );
}

/// Checked - Checked state
@widgetbook.UseCase(name: 'Checked', type: AppCheckbox)
Widget appCheckboxChecked(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCheckbox(
        value: true,
        label: 'Checked checkbox',
        onChanged: (_) {},
      ),
    ),
  );
}

/// Indeterminate - Tristate mode (indeterminate state)
@widgetbook.UseCase(name: 'Indeterminate', type: AppCheckbox)
Widget appCheckboxIndeterminate(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCheckbox(
        value: null,
        tristate: true,
        label: 'Indeterminate (tristate)',
        onChanged: (_) {},
      ),
    ),
  );
}

/// Disabled Unchecked - Disabled in unchecked state
@widgetbook.UseCase(name: 'Disabled Unchecked', type: AppCheckbox)
Widget appCheckboxDisabledUnchecked(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppCheckbox(
        value: false,
        label: 'Disabled unchecked',
        onChanged: null,
      ),
    ),
  );
}

/// Disabled Checked - Disabled in checked state
@widgetbook.UseCase(name: 'Disabled Checked', type: AppCheckbox)
Widget appCheckboxDisabledChecked(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppCheckbox(
        value: true,
        label: 'Disabled checked',
        onChanged: null,
      ),
    ),
  );
}

/// Error State - Checkbox with error styling and error text
@widgetbook.UseCase(name: 'Error State', type: AppCheckbox)
Widget appCheckboxError(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCheckbox(
        value: false,
        label: 'I accept the Terms and Conditions',
        error: true,
        errorText: 'You must accept the terms to continue',
        onChanged: (_) {},
      ),
    ),
  );
}

/// Without Label - Checkbox without label text
@widgetbook.UseCase(name: 'Without Label', type: AppCheckbox)
Widget appCheckboxNoLabel(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCheckbox(value: false, onChanged: (_) {}),
    ),
  );
}

/// Long Label - Checkbox with long wrapping label
@widgetbook.UseCase(name: 'Long Label', type: AppCheckbox)
Widget appCheckboxLongLabel(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 300,
        child: AppCheckbox(
          value: false,
          label:
              'I have read and agree to the Terms of Service and Privacy Policy, and I understand that my data will be processed according to these terms.',
          onChanged: (_) {},
        ),
      ),
    ),
  );
}

/// Custom Colors - Checkbox with custom colors
@widgetbook.UseCase(name: 'Custom Colors', type: AppCheckbox)
Widget appCheckboxCustomColors(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCheckbox(
        value: true,
        label: 'Custom green checkbox',
        activeColor: Colors.green,
        checkColor: Colors.white,
        onChanged: (_) {},
      ),
    ),
  );
}
