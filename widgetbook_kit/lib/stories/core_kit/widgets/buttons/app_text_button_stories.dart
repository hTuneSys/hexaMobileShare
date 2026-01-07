// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/buttons/app_text_button.dart';

/// Interactive Playground - Expose ALL AppTextButton properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppTextButton)
Widget appTextButtonPlayground(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Text Button',
  );

  final hasIcon = context.knobs.boolean(label: 'Has Icon', initialValue: false);

  final icon = hasIcon
      ? context.knobs.object.dropdown(
          label: 'Icon',
          options: const [
            Icons.arrow_forward,
            Icons.info,
            Icons.help,
            Icons.add,
            Icons.edit,
          ],
          labelBuilder: (icon) => icon.toString(),
        )
      : null;

  final isEnabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  final isLoading = context.knobs.boolean(
    label: 'Loading',
    initialValue: false,
  );

  final fullWidth = context.knobs.boolean(
    label: 'Full Width',
    initialValue: false,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppTextButton(
        label: label,
        icon: icon,
        onPressed: isEnabled ? () {} : null,
        isLoading: isLoading,
        fullWidth: fullWidth,
      ),
    ),
  );
}

/// Default Text Button - Basic low-emphasis button
@widgetbook.UseCase(name: 'Default', type: AppTextButton)
Widget appTextButtonDefault(BuildContext context) {
  return Center(
    child: AppTextButton(label: 'Text Button', onPressed: () {}),
  );
}

/// With Icon - Text button with leading icon
@widgetbook.UseCase(name: 'With Icon', type: AppTextButton)
Widget appTextButtonWithIcon(BuildContext context) {
  return Center(
    child: AppTextButton(
      label: 'Learn More',
      icon: Icons.arrow_forward,
      onPressed: () {},
    ),
  );
}

/// Disabled State - Text button with null onPressed
@widgetbook.UseCase(name: 'Disabled State', type: AppTextButton)
Widget appTextButtonDisabled(BuildContext context) {
  return const Center(child: AppTextButton(label: 'Disabled', onPressed: null));
}

/// Loading State - Text button showing loading indicator
@widgetbook.UseCase(name: 'Loading State', type: AppTextButton)
Widget appTextButtonLoading(BuildContext context) {
  return Center(
    child: AppTextButton(
      label: 'Processing',
      isLoading: true,
      onPressed: () {},
    ),
  );
}

/// Full Width - Text button that expands to fill parent width
@widgetbook.UseCase(name: 'Full Width', type: AppTextButton)
Widget appTextButtonFullWidth(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppTextButton(
      label: 'Full Width Text Button',
      fullWidth: true,
      onPressed: () {},
    ),
  );
}

/// Dialog Action - Example of text button in dialog context
@widgetbook.UseCase(name: 'Dialog Action Example', type: AppTextButton)
Widget appTextButtonDialogAction(BuildContext context) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Example Dialog',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('This shows how text buttons work in dialogs.'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [AppTextButton(label: 'Cancel', onPressed: () {})],
          ),
        ],
      ),
    ),
  );
}

/// Inline Link - Text button used as an inline link
@widgetbook.UseCase(name: 'Inline Link Example', type: AppTextButton)
Widget appTextButtonInlineLink(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'By continuing, you agree to our terms.',
            textAlign: TextAlign.center,
          ),
          AppTextButton(label: 'Learn more', onPressed: () {}),
        ],
      ),
    ),
  );
}
