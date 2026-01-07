// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Expose ALL component properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppButton)
Widget appButtonPlayground(BuildContext context) {
  // Knobs for all AppButton properties
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Button Label',
  );

  final selectedVariant = context.knobs.object.dropdown(
    label: 'Variant',
    options: const ['filled', 'outlined', 'text', 'elevated'],
    labelBuilder: (value) => value,
  );

  final hasIcon = context.knobs.boolean(label: 'Has Icon', initialValue: false);

  final selectedIcon = context.knobs.object.dropdown(
    label: 'Icon (if enabled)',
    options: const [
      'add',
      'download',
      'upload',
      'arrow_forward',
      'shopping_cart',
      'login',
      'check_circle',
      'favorite',
    ],
    labelBuilder: (value) => value,
  );

  final isEnabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  final isLoading = context.knobs.boolean(
    label: 'Loading',
    initialValue: false,
  );

  final fullWidth = context.knobs.boolean(
    label: 'Full Width',
    initialValue: false,
  );

  // Map string icon name to IconData
  final IconData? icon = hasIcon
      ? switch (selectedIcon) {
          'add' => Icons.add,
          'download' => Icons.download,
          'upload' => Icons.upload,
          'arrow_forward' => Icons.arrow_forward,
          'shopping_cart' => Icons.shopping_cart,
          'login' => Icons.login,
          'check_circle' => Icons.check_circle,
          'favorite' => Icons.favorite,
          _ => Icons.add,
        }
      : null;

  // Build button based on selected variant
  final button = switch (selectedVariant) {
    'filled' => AppButton.filled(
      label: label,
      icon: icon,
      onPressed: isEnabled ? () {} : null,
      isLoading: isLoading,
      fullWidth: fullWidth,
    ),
    'outlined' => AppButton.outlined(
      label: label,
      icon: icon,
      onPressed: isEnabled ? () {} : null,
      isLoading: isLoading,
      fullWidth: fullWidth,
    ),
    'text' => AppButton.text(
      label: label,
      icon: icon,
      onPressed: isEnabled ? () {} : null,
      isLoading: isLoading,
      fullWidth: fullWidth,
    ),
    'elevated' => AppButton.elevated(
      label: label,
      icon: icon,
      onPressed: isEnabled ? () {} : null,
      isLoading: isLoading,
      fullWidth: fullWidth,
    ),
    _ => AppButton.filled(
      label: label,
      icon: icon,
      onPressed: isEnabled ? () {} : null,
      isLoading: isLoading,
      fullWidth: fullWidth,
    ),
  };

  return Center(
    child: Padding(padding: const EdgeInsets.all(16.0), child: button),
  );
}

/// Filled Button - High emphasis primary action
@widgetbook.UseCase(name: 'Filled Button', type: AppButton)
Widget appButtonFilled(BuildContext context) {
  return Center(
    child: AppButton.filled(label: 'Filled Button', onPressed: () {}),
  );
}

/// Outlined Button - Medium emphasis secondary action
@widgetbook.UseCase(name: 'Outlined Button', type: AppButton)
Widget appButtonOutlined(BuildContext context) {
  return Center(
    child: AppButton.outlined(label: 'Outlined Button', onPressed: () {}),
  );
}

/// Text Button - Low emphasis tertiary action
@widgetbook.UseCase(name: 'Text Button', type: AppButton)
Widget appButtonText(BuildContext context) {
  return Center(
    child: AppButton.text(label: 'Text Button', onPressed: () {}),
  );
}

/// Elevated Button - Elevated emphasis for busy backgrounds
@widgetbook.UseCase(name: 'Elevated Button', type: AppButton)
Widget appButtonElevated(BuildContext context) {
  return Center(
    child: AppButton.elevated(label: 'Elevated Button', onPressed: () {}),
  );
}

/// Button with Icon - Shows button with leading icon
@widgetbook.UseCase(name: 'With Icon', type: AppButton)
Widget appButtonWithIcon(BuildContext context) {
  return Center(
    child: AppButton.filled(
      label: 'Add Item',
      icon: Icons.add,
      onPressed: () {},
    ),
  );
}

/// Disabled State - Shows disabled button appearance
@widgetbook.UseCase(name: 'Disabled State', type: AppButton)
Widget appButtonDisabled(BuildContext context) {
  return const Center(
    child: AppButton.filled(label: 'Disabled Button', onPressed: null),
  );
}

/// Loading State - Shows button in loading state with spinner
@widgetbook.UseCase(name: 'Loading State', type: AppButton)
Widget appButtonLoading(BuildContext context) {
  return Center(
    child: AppButton.filled(
      label: 'Processing',
      isLoading: true,
      onPressed: () {},
    ),
  );
}

/// Full Width Button - Button that expands to fill parent width
@widgetbook.UseCase(name: 'Full Width', type: AppButton)
Widget appButtonFullWidth(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppButton.filled(
      label: 'Full Width Button',
      fullWidth: true,
      onPressed: () {},
    ),
  );
}

/// Real-world Example - Login form with primary and text buttons
@widgetbook.UseCase(name: 'Login Form Example', type: AppButton)
Widget appButtonLoginExample(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Real-world example: Login form layout',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        AppButton.filled(
          label: 'Sign In',
          icon: Icons.login,
          fullWidth: true,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        AppButton.text(
          label: 'Forgot Password?',
          fullWidth: true,
          onPressed: () {},
        ),
      ],
    ),
  );
}
