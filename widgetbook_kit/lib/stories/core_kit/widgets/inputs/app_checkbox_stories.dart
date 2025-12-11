// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// 1. Default Checkbox - Basic unchecked state
@widgetbook.UseCase(name: 'Default', type: AppCheckbox)
Widget appCheckboxDefault(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppCheckbox(
      value: false,
      label: 'Checkbox label',
      onChanged: (value) {},
    ),
  );
}

// 2. Checked State
@widgetbook.UseCase(name: 'Checked', type: AppCheckbox)
Widget appCheckboxChecked(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppCheckbox(
      value: true,
      label: 'Checked checkbox',
      onChanged: (value) {},
    ),
  );
}

// 3. Indeterminate State
@widgetbook.UseCase(name: 'Indeterminate', type: AppCheckbox)
Widget appCheckboxIndeterminate(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppCheckbox(
      value: null,
      tristate: true,
      label: 'Indeterminate checkbox (tristate)',
      onChanged: (value) {},
    ),
  );
}

// 4. Disabled Unchecked
@widgetbook.UseCase(name: 'Disabled Unchecked', type: AppCheckbox)
Widget appCheckboxDisabledUnchecked(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: AppCheckbox(
      value: false,
      label: 'Disabled unchecked',
      onChanged: null,
    ),
  );
}

// 5. Disabled Checked
@widgetbook.UseCase(name: 'Disabled Checked', type: AppCheckbox)
Widget appCheckboxDisabledChecked(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: AppCheckbox(value: true, label: 'Disabled checked', onChanged: null),
  );
}

// 6. Error State
@widgetbook.UseCase(name: 'Error State', type: AppCheckbox)
Widget appCheckboxError(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppCheckbox(
      value: false,
      label: 'Required checkbox',
      error: true,
      errorText: 'This field is required',
      onChanged: (value) {},
    ),
  );
}

// 7. No Label
@widgetbook.UseCase(name: 'No Label', type: AppCheckbox)
Widget appCheckboxNoLabel(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppCheckbox(value: false, onChanged: (value) {}),
  );
}

// 8. Short Label
@widgetbook.UseCase(name: 'Short Label', type: AppCheckbox)
Widget appCheckboxShortLabel(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppCheckbox(value: true, label: 'I agree', onChanged: (value) {}),
  );
}

// 9. Long Label
@widgetbook.UseCase(name: 'Long Label', type: AppCheckbox)
Widget appCheckboxLongLabel(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SizedBox(
      width: 300,
      child: AppCheckbox(
        value: false,
        label:
            'I have read and agree to the Terms of Service and Privacy Policy, and I understand that my data will be processed according to these terms.',
        onChanged: (value) {},
      ),
    ),
  );
}

// 10. List Integration
@widgetbook.UseCase(name: 'List Integration', type: AppCheckbox)
Widget appCheckboxListIntegration(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select All (Indeterminate)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppCheckbox(
            value: null,
            tristate: true,
            label: 'Select all items',
            onChanged: (value) {},
          ),
          const Divider(height: 24),
          AppCheckbox(
            value: true,
            label: 'Item 1 - Selected',
            onChanged: (value) {},
          ),
          AppCheckbox(
            value: true,
            label: 'Item 2 - Selected',
            onChanged: (value) {},
          ),
          AppCheckbox(
            value: false,
            label: 'Item 3 - Not selected',
            onChanged: (value) {},
          ),
          AppCheckbox(
            value: false,
            label: 'Item 4 - Not selected',
            onChanged: (value) {},
          ),
        ],
      ),
    ),
  );
}

// 11. Form Example
@widgetbook.UseCase(name: 'Form Example', type: AppCheckbox)
Widget appCheckboxFormExample(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Registration Form',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          AppCheckbox(
            value: false,
            label: 'I accept the Terms and Conditions',
            error: true,
            errorText: 'You must accept the terms to continue',
            onChanged: (value) {},
          ),
          const SizedBox(height: 8),
          AppCheckbox(
            value: true,
            label: 'Subscribe to newsletter (optional)',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: null, child: const Text('Register')),
        ],
      ),
    ),
  );
}

// 12. Theme Variations - Light & dark mode
@widgetbook.UseCase(name: 'Theme Variations', type: AppCheckbox)
Widget appCheckboxThemeVariations(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Toggle theme in Widgetbook to see variations',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
          ),
          const SizedBox(height: 16),
          const Text(
            'Default Colors',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppCheckbox(
            value: true,
            label: 'Checked (uses primary color)',
            onChanged: (value) {},
          ),
          const SizedBox(height: 8),
          AppCheckbox(
            value: false,
            label: 'Unchecked (uses outline color)',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          const Text(
            'Error State',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppCheckbox(
            value: true,
            label: 'Error checkbox',
            error: true,
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          const Text(
            'Custom Colors',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppCheckbox(
            value: true,
            label: 'Custom green checkbox',
            activeColor: Colors.green,
            onChanged: (value) {},
          ),
          const SizedBox(height: 8),
          AppCheckbox(
            value: true,
            label: 'Custom orange checkbox',
            activeColor: Colors.deepOrange,
            checkColor: Colors.white,
            onChanged: (value) {},
          ),
        ],
      ),
    ),
  );
}

// 13. All States
@widgetbook.UseCase(name: 'All States', type: AppCheckbox)
Widget appCheckboxAllStates(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Unchecked',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          AppCheckbox(value: false, label: 'Unchecked', onChanged: (value) {}),
          const SizedBox(height: 8),
          const Text('Checked', style: TextStyle(fontWeight: FontWeight.bold)),
          AppCheckbox(value: true, label: 'Checked', onChanged: (value) {}),
          const SizedBox(height: 8),
          const Text(
            'Indeterminate',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          AppCheckbox(
            value: null,
            tristate: true,
            label: 'Indeterminate',
            onChanged: (value) {},
          ),
          const SizedBox(height: 8),
          const Text('Disabled', style: TextStyle(fontWeight: FontWeight.bold)),
          const AppCheckbox(value: false, label: 'Disabled', onChanged: null),
          const SizedBox(height: 8),
          const Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
          AppCheckbox(
            value: false,
            label: 'Error',
            error: true,
            errorText: 'Required field',
            onChanged: (value) {},
          ),
        ],
      ),
    ),
  );
}
