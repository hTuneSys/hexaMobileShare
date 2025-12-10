// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/buttons/app_outlined_button.dart';
import 'package:core_kit/widgets/buttons/app_button.dart';

// ...existing code...
@widgetbook.UseCase(name: 'Default', type: AppOutlinedButton)
Widget appOutlinedButtonDefault(BuildContext context) {
  return Center(
    child: AppOutlinedButton(
      label: context.knobs.string(label: 'Label', initialValue: 'Button'),
      onPressed: () {},
    ),
  );
}

// ...existing code...
@widgetbook.UseCase(name: 'With Icon', type: AppOutlinedButton)
Widget appOutlinedButtonWithIcon(BuildContext context) {
  return Center(
    child: AppOutlinedButton(
      icon: Icons.download,
      label: context.knobs.string(label: 'Label', initialValue: 'Download'),
      onPressed: () {},
    ),
  );
}

// ...existing code...
@widgetbook.UseCase(name: 'States', type: AppOutlinedButton)
Widget appOutlinedButtonStates(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Submit');
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AppOutlinedButton(label: '$label (enabled)', onPressed: () {}),
      const SizedBox(height: 12),
      const AppOutlinedButton(label: 'Disabled'),
      const SizedBox(height: 12),
      const AppOutlinedButton(label: 'Loading', isLoading: true),
      const SizedBox(height: 12),
      AppOutlinedButton(label: 'Hover/Pressed demo', onPressed: () {}),
    ],
  );
}

// ...existing code...
@widgetbook.UseCase(name: 'Sizes', type: AppOutlinedButton)
Widget appOutlinedButtonSizes(BuildContext context) {
  final longText = context.knobs.boolean(
    label: 'Use long text',
    initialValue: true,
  );
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        AppOutlinedButton(
          label: longText
              ? 'This is a very long button label to test wrapping and overflow'
              : 'Normal',
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        const AppOutlinedButton(label: 'Full width', fullWidth: true),
      ],
    ),
  );
}

// ...existing code...
@widgetbook.UseCase(name: 'Theme Variations', type: AppOutlinedButton)
Widget appOutlinedButtonTheme(BuildContext context) {
  final dark = context.knobs.boolean(label: 'Dark mode', initialValue: false);
  final toggledTheme = dark
      ? ThemeData.from(colorScheme: const ColorScheme.dark())
      : ThemeData.from(colorScheme: const ColorScheme.light());

  return Theme(
    data: toggledTheme,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AppOutlinedButton(label: 'Outlined'),
          SizedBox(width: 12),
          AppButton.filled(label: 'Filled'),
        ],
      ),
    ),
  );
}

// ...existing code...
@widgetbook.UseCase(name: 'Comparison', type: AppOutlinedButton)
Widget appOutlinedButtonComparison(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        AppButton.text(label: 'Text'),
        SizedBox(width: 12),
        AppOutlinedButton(label: 'Outlined'),
        SizedBox(width: 12),
        AppButton.filled(label: 'Filled'),
      ],
    ),
  );
}

// ...existing code...
