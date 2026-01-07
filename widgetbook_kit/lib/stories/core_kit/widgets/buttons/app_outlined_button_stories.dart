// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/buttons/app_outlined_button.dart';

/// Interactive Playground - Expose ALL AppOutlinedButton properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppOutlinedButton)
Widget appOutlinedButtonPlayground(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Outlined Button',
  );

  final hasIcon = context.knobs.boolean(label: 'Has Icon', initialValue: false);

  final icon = hasIcon
      ? context.knobs.object.dropdown(
          label: 'Icon',
          options: const [
            Icons.download,
            Icons.upload,
            Icons.share,
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
      child: AppOutlinedButton(
        label: label,
        icon: icon,
        onPressed: isEnabled ? () {} : null,
        isLoading: isLoading,
        fullWidth: fullWidth,
      ),
    ),
  );
}

/// Default Outlined Button - Basic outlined button
@widgetbook.UseCase(name: 'Default', type: AppOutlinedButton)
Widget appOutlinedButtonDefault(BuildContext context) {
  return Center(
    child: AppOutlinedButton(label: 'Outlined Button', onPressed: () {}),
  );
}

/// With Icon - Outlined button with leading icon
@widgetbook.UseCase(name: 'With Icon', type: AppOutlinedButton)
Widget appOutlinedButtonWithIcon(BuildContext context) {
  return Center(
    child: AppOutlinedButton(
      label: 'Download',
      icon: Icons.download,
      onPressed: () {},
    ),
  );
}

/// Disabled State - Outlined button with null onPressed
@widgetbook.UseCase(name: 'Disabled State', type: AppOutlinedButton)
Widget appOutlinedButtonDisabled(BuildContext context) {
  return const Center(
    child: AppOutlinedButton(label: 'Disabled', onPressed: null),
  );
}

/// Loading State - Outlined button showing loading indicator
@widgetbook.UseCase(name: 'Loading State', type: AppOutlinedButton)
Widget appOutlinedButtonLoading(BuildContext context) {
  return Center(
    child: AppOutlinedButton(
      label: 'Processing',
      isLoading: true,
      onPressed: () {},
    ),
  );
}

/// Full Width - Outlined button that expands to fill parent width
@widgetbook.UseCase(name: 'Full Width', type: AppOutlinedButton)
Widget appOutlinedButtonFullWidth(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppOutlinedButton(
      label: 'Full Width Outlined Button',
      fullWidth: true,
      onPressed: () {},
    ),
  );
}

/// Long Label - Outlined button with long text to test wrapping
@widgetbook.UseCase(name: 'Long Label', type: AppOutlinedButton)
Widget appOutlinedButtonLongLabel(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 200,
      child: AppOutlinedButton(
        label:
            'This is a very long button label that might wrap to multiple lines',
        onPressed: () {},
      ),
    ),
  );
}

/// With Icon and Loading - Demonstrates loading state with icon
@widgetbook.UseCase(name: 'Icon + Loading State', type: AppOutlinedButton)
Widget appOutlinedButtonIconLoading(BuildContext context) {
  return Center(
    child: AppOutlinedButton(
      label: 'Uploading',
      icon: Icons.upload,
      isLoading: true,
      onPressed: () {},
    ),
  );
}
