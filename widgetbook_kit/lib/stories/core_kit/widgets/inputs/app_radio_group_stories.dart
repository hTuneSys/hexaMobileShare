// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// 1. Default - Basic vertical radio group
@widgetbook.UseCase(name: 'Default', type: AppRadioGroup)
Widget appRadioGroupDefault(BuildContext context) {
  return _RadioGroupWrapper(
    child: AppRadioGroup<String>(
      label: 'Select an option',
      options: const [
        RadioOption(value: 'option1', label: 'Option 1'),
        RadioOption(value: 'option2', label: 'Option 2'),
        RadioOption(value: 'option3', label: 'Option 3'),
      ],
      onChanged: (value) {},
    ),
  );
}

// 2. Horizontal Layout
@widgetbook.UseCase(name: 'Horizontal Layout', type: AppRadioGroup)
Widget appRadioGroupHorizontal(BuildContext context) {
  return _RadioGroupWrapper(
    child: AppRadioGroup<String>(
      label: 'Layout Direction',
      direction: Axis.horizontal,
      options: const [
        RadioOption(value: 'left', label: 'Left'),
        RadioOption(value: 'center', label: 'Center'),
        RadioOption(value: 'right', label: 'Right'),
      ],
      onChanged: (value) {},
    ),
  );
}

// 3. With Icons
@widgetbook.UseCase(name: 'With Icons', type: AppRadioGroup)
Widget appRadioGroupWithIcons(BuildContext context) {
  return _RadioGroupWrapper(
    child: AppRadioGroup<String>(
      label: 'Payment Method',
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
      onChanged: (value) {},
    ),
  );
}

// 4. With Descriptions
@widgetbook.UseCase(name: 'With Descriptions', type: AppRadioGroup)
Widget appRadioGroupWithDescriptions(BuildContext context) {
  return _RadioGroupWrapper(
    child: AppRadioGroup<String>(
      label: 'Shipping Method',
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
      onChanged: (value) {},
    ),
  );
}

// 5. Pre-selected
@widgetbook.UseCase(name: 'Pre-selected', type: AppRadioGroup)
Widget appRadioGroupPreselected(BuildContext context) {
  return _RadioGroupWrapper(
    child: AppRadioGroup<String>(
      label: 'Notification Preference',
      value: 'email',
      options: const [
        RadioOption(value: 'email', label: 'Email'),
        RadioOption(value: 'sms', label: 'SMS'),
        RadioOption(value: 'push', label: 'Push Notification'),
      ],
      onChanged: (value) {},
    ),
  );
}

// 6. Disabled Group
@widgetbook.UseCase(name: 'Disabled', type: AppRadioGroup)
Widget appRadioGroupDisabled(BuildContext context) {
  return _RadioGroupWrapper(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Disabled entire group
        AppRadioGroup<String>(
          label: 'Disabled Group',
          enabled: false,
          value: 'option1',
          options: const [
            RadioOption(value: 'option1', label: 'Selected but disabled'),
            RadioOption(value: 'option2', label: 'Not selected'),
          ],
          onChanged: (value) {},
        ),
        const SizedBox(height: 24),
        // Individual option disabled
        AppRadioGroup<String>(
          label: 'Individual Option Disabled',
          options: const [
            RadioOption(value: 'available', label: 'Available Option'),
            RadioOption(
              value: 'unavailable',
              label: 'Unavailable Option',
              enabled: false,
            ),
          ],
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

// 7. Error State
@widgetbook.UseCase(name: 'Error State', type: AppRadioGroup)
Widget appRadioGroupError(BuildContext context) {
  return _RadioGroupWrapper(
    child: AppRadioGroup<String>(
      label: 'Select Required Field',
      error: true,
      errorText: 'Please select an option to continue',
      options: const [
        RadioOption(value: 'accept', label: 'Accept terms and conditions'),
        RadioOption(value: 'decline', label: 'Decline'),
      ],
      onChanged: (value) {},
    ),
  );
}

// 8. All States - Comprehensive comparison
@widgetbook.UseCase(name: 'All States', type: AppRadioGroup)
Widget appRadioGroupAllStates(BuildContext context) {
  return _RadioGroupWrapper(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Unselected
          _buildSection(
            'Unselected',
            AppRadioGroup<String>(
              options: const [
                RadioOption(value: 'a', label: 'Choice A'),
                RadioOption(value: 'b', label: 'Choice B'),
              ],
              onChanged: (value) {},
            ),
          ),

          const SizedBox(height: 16),

          // Selected
          _buildSection(
            'Selected',
            AppRadioGroup<String>(
              value: 'a',
              options: const [
                RadioOption(value: 'a', label: 'Choice A'),
                RadioOption(value: 'b', label: 'Choice B'),
              ],
              onChanged: (value) {},
            ),
          ),

          const SizedBox(height: 16),

          // With Label
          _buildSection(
            'With Group Label',
            AppRadioGroup<String>(
              label: 'Group Label',
              options: const [
                RadioOption(value: 'a', label: 'Choice A'),
                RadioOption(value: 'b', label: 'Choice B'),
              ],
              onChanged: (value) {},
            ),
          ),

          const SizedBox(height: 16),

          // Disabled
          _buildSection(
            'Disabled',
            AppRadioGroup<String>(
              enabled: false,
              value: 'a',
              options: const [
                RadioOption(value: 'a', label: 'Choice A'),
                RadioOption(value: 'b', label: 'Choice B'),
              ],
              onChanged: (value) {},
            ),
          ),

          const SizedBox(height: 16),

          // Error
          _buildSection(
            'Error State',
            AppRadioGroup<String>(
              error: true,
              errorText: 'Selection required',
              options: const [
                RadioOption(value: 'a', label: 'Choice A'),
                RadioOption(value: 'b', label: 'Choice B'),
              ],
              onChanged: (value) {},
            ),
          ),

          const SizedBox(height: 16),

          // With Icons
          _buildSection(
            'With Icons',
            AppRadioGroup<String>(
              value: 'star',
              options: const [
                RadioOption(value: 'star', label: 'Star', icon: Icons.star),
                RadioOption(
                  value: 'heart',
                  label: 'Heart',
                  icon: Icons.favorite,
                ),
              ],
              onChanged: (value) {},
            ),
          ),

          const SizedBox(height: 16),

          // Horizontal
          _buildSection(
            'Horizontal Layout',
            AppRadioGroup<String>(
              direction: Axis.horizontal,
              value: 'yes',
              options: const [
                RadioOption(value: 'yes', label: 'Yes'),
                RadioOption(value: 'no', label: 'No'),
              ],
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper widget for consistent padding
class _RadioGroupWrapper extends StatelessWidget {
  const _RadioGroupWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16.0), child: child);
  }
}

// Helper function for All States story
Widget _buildSection(String title, Widget content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      const SizedBox(height: 8),
      content,
    ],
  );
}
