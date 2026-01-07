// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppRadioGroup] component.
///
/// A Material Design 3 radio button group widget that allows users to select
/// exactly one option from a set of mutually exclusive choices.

/// Interactive Playground - explore all AppRadioGroup properties with knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppRadioGroup)
Widget appRadioGroupPlayground(BuildContext context) {
  final direction = context.knobs.object.dropdown(
    label: 'Direction',
    options: const ['vertical', 'horizontal'],
    labelBuilder: (value) => value,
  );

  final optionCount = context.knobs.int.slider(
    label: 'Option Count',
    initialValue: 3,
    min: 2,
    max: 5,
  );

  final hasLabel = context.knobs.boolean(
    label: 'Has Group Label',
    initialValue: true,
  );
  final hasIcons = context.knobs.boolean(
    label: 'Has Icons',
    initialValue: false,
  );
  final hasDescriptions = context.knobs.boolean(
    label: 'Has Descriptions',
    initialValue: false,
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final error = context.knobs.boolean(label: 'Error', initialValue: false);
  final hasErrorText = context.knobs.boolean(
    label: 'Has Error Text',
    initialValue: false,
  );

  final label = hasLabel
      ? context.knobs.string(
          label: 'Group Label',
          initialValue: 'Select an option',
        )
      : null;

  final errorText = hasErrorText
      ? context.knobs.string(
          label: 'Error Text',
          initialValue: 'Please select an option',
        )
      : null;

  final options = List.generate(optionCount, (index) {
    return RadioOption<String>(
      value: 'option${index + 1}',
      label: 'Option ${index + 1}',
      description: hasDescriptions
          ? 'Description for option ${index + 1}'
          : null,
      icon: hasIcons ? Icons.radio_button_checked : null,
    );
  });

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppRadioGroup<String>(
        label: label,
        value: 'option1',
        direction: direction == 'horizontal' ? Axis.horizontal : Axis.vertical,
        options: options,
        enabled: enabled,
        error: error,
        errorText: errorText,
        onChanged: enabled ? (_) {} : null,
      ),
    ),
  );
}

/// Default - Basic vertical radio group
@widgetbook.UseCase(name: 'Default', type: AppRadioGroup)
Widget appRadioGroupDefault(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppRadioGroup<String>(
        label: 'Select an option',
        value: null,
        options: const [
          RadioOption(value: 'option1', label: 'Option 1'),
          RadioOption(value: 'option2', label: 'Option 2'),
          RadioOption(value: 'option3', label: 'Option 3'),
        ],
        onChanged: (_) {},
      ),
    ),
  );
}

/// Horizontal Layout - Options displayed horizontally
@widgetbook.UseCase(name: 'Horizontal Layout', type: AppRadioGroup)
Widget appRadioGroupHorizontal(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppRadioGroup<String>(
        label: 'Layout Direction',
        value: 'center',
        direction: Axis.horizontal,
        options: const [
          RadioOption(value: 'left', label: 'Left'),
          RadioOption(value: 'center', label: 'Center'),
          RadioOption(value: 'right', label: 'Right'),
        ],
        onChanged: (_) {},
      ),
    ),
  );
}

/// With Icons - Radio options with leading icons
@widgetbook.UseCase(name: 'With Icons', type: AppRadioGroup)
Widget appRadioGroupWithIcons(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppRadioGroup<String>(
        label: 'Payment Method',
        value: 'card',
        options: const [
          RadioOption(
            value: 'card',
            label: 'Credit Card',
            icon: Icons.credit_card,
          ),
          RadioOption(value: 'cash', label: 'Cash', icon: Icons.money),
          RadioOption(
            value: 'transfer',
            label: 'Bank Transfer',
            icon: Icons.account_balance,
          ),
        ],
        onChanged: (_) {},
      ),
    ),
  );
}

/// With Descriptions - Options with additional description text
@widgetbook.UseCase(name: 'With Descriptions', type: AppRadioGroup)
Widget appRadioGroupWithDescriptions(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppRadioGroup<String>(
        label: 'Shipping Method',
        value: 'standard',
        options: const [
          RadioOption(
            value: 'standard',
            label: 'Standard Shipping',
            description: 'Delivery in 5-7 business days',
            icon: Icons.local_shipping,
          ),
          RadioOption(
            value: 'express',
            label: 'Express Shipping',
            description: 'Delivery in 2-3 business days',
            icon: Icons.delivery_dining,
          ),
          RadioOption(
            value: 'overnight',
            label: 'Overnight Shipping',
            description: 'Next business day delivery',
            icon: Icons.flight,
          ),
        ],
        onChanged: (_) {},
      ),
    ),
  );
}

/// Pre-selected - Radio group with pre-selected value
@widgetbook.UseCase(name: 'Pre-selected', type: AppRadioGroup)
Widget appRadioGroupPreselected(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppRadioGroup<String>(
        label: 'Notification Preference',
        value: 'email',
        options: const [
          RadioOption(value: 'email', label: 'Email'),
          RadioOption(value: 'sms', label: 'SMS'),
          RadioOption(value: 'push', label: 'Push Notification'),
        ],
        onChanged: (_) {},
      ),
    ),
  );
}

/// Disabled - Entire group disabled
@widgetbook.UseCase(name: 'Disabled', type: AppRadioGroup)
Widget appRadioGroupDisabled(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppRadioGroup<String>(
        label: 'Disabled Group',
        enabled: false,
        value: 'option1',
        options: const [
          RadioOption(value: 'option1', label: 'Selected but disabled'),
          RadioOption(value: 'option2', label: 'Not selected'),
          RadioOption(value: 'option3', label: 'Also disabled'),
        ],
        onChanged: (_) {},
      ),
    ),
  );
}

/// Individual Option Disabled - Some options disabled
@widgetbook.UseCase(name: 'Individual Option Disabled', type: AppRadioGroup)
Widget appRadioGroupIndividualDisabled(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppRadioGroup<String>(
        label: 'Individual Option Disabled',
        value: 'available',
        options: const [
          RadioOption(value: 'available', label: 'Available Option'),
          RadioOption(
            value: 'unavailable',
            label: 'Unavailable Option',
            enabled: false,
          ),
          RadioOption(value: 'available2', label: 'Another Available Option'),
        ],
        onChanged: (_) {},
      ),
    ),
  );
}

/// Error State - Radio group with error message
@widgetbook.UseCase(name: 'Error State', type: AppRadioGroup)
Widget appRadioGroupError(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppRadioGroup<String>(
        label: 'Select Required Field',
        value: null,
        error: true,
        errorText: 'Please select an option to continue',
        options: const [
          RadioOption(value: 'accept', label: 'Accept terms and conditions'),
          RadioOption(value: 'decline', label: 'Decline'),
        ],
        onChanged: (_) {},
      ),
    ),
  );
}

/// Gender Selection - Real-world gender selection example
@widgetbook.UseCase(name: 'Gender Selection', type: AppRadioGroup)
Widget appRadioGroupGenderSelection(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppRadioGroup<String>(
        label: 'Gender',
        value: null,
        options: const [
          RadioOption(value: 'male', label: 'Male', icon: Icons.male),
          RadioOption(value: 'female', label: 'Female', icon: Icons.female),
          RadioOption(value: 'other', label: 'Other'),
          RadioOption(value: 'prefer_not', label: 'Prefer not to say'),
        ],
        onChanged: (_) {},
      ),
    ),
  );
}
