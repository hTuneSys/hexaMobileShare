// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Expose ALL AppH2 properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppH2)
Widget appH2Playground(BuildContext context) {
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Section Heading',
  );

  final colorOption = context.knobs.object.dropdown(
    label: 'Color',
    options: ['Default', 'Primary', 'Secondary', 'Error', 'Custom Green'],
    labelBuilder: (value) => value,
  );

  final fontWeightOption = context.knobs.object.dropdown(
    label: 'Font Weight',
    options: ['Default', 'Normal (400)', 'Medium (500)', 'Bold (700)'],
    labelBuilder: (value) => value,
  );

  final textAlignOption = context.knobs.object.dropdown(
    label: 'Text Align',
    options: ['Default', 'Left', 'Center', 'Right'],
    labelBuilder: (value) => value,
  );

  final maxLines = context.knobs.intOrNull.slider(
    label: 'Max Lines',
    initialValue: null,
    min: 1,
    max: 5,
  );

  final overflowOption = context.knobs.object.dropdown(
    label: 'Overflow',
    options: ['Default', 'Clip', 'Fade', 'Ellipsis'],
    labelBuilder: (value) => value,
  );

  final Color? color = switch (colorOption) {
    'Primary' => Theme.of(context).colorScheme.primary,
    'Secondary' => Theme.of(context).colorScheme.secondary,
    'Error' => Theme.of(context).colorScheme.error,
    'Custom Green' => Colors.green,
    _ => null,
  };

  final FontWeight? fontWeight = switch (fontWeightOption) {
    'Normal (400)' => FontWeight.w400,
    'Medium (500)' => FontWeight.w500,
    'Bold (700)' => FontWeight.w700,
    _ => null,
  };

  final TextAlign? textAlign = switch (textAlignOption) {
    'Left' => TextAlign.left,
    'Center' => TextAlign.center,
    'Right' => TextAlign.right,
    _ => null,
  };

  final TextOverflow? overflow = switch (overflowOption) {
    'Clip' => TextOverflow.clip,
    'Fade' => TextOverflow.fade,
    'Ellipsis' => TextOverflow.ellipsis,
    _ => null,
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppH2(
        text,
        color: color,
        fontWeight: fontWeight,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    ),
  );
}

/// Default H2 - Simple usage with default styling
@widgetbook.UseCase(name: 'Default H2', type: AppH2)
Widget appH2Default(BuildContext context) {
  final text = context.knobs.string(
    label: 'Text',
    initialValue: 'Account Settings',
  );

  return Center(
    child: Padding(padding: const EdgeInsets.all(16.0), child: AppH2(text)),
  );
}

/// Section Headings - H2 for dividing content into sections
@widgetbook.UseCase(name: 'Section Headings', type: AppH2)
Widget appH2Sections(BuildContext context) {
  final sectionTitle = context.knobs.string(
    label: 'Section Title',
    initialValue: 'Personal Information',
  );

  final showContent = context.knobs.boolean(
    label: 'Show Section Content',
    initialValue: true,
  );

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppH1('User Profile'),
        const SizedBox(height: 24),
        AppH2(sectionTitle),
        if (showContent) ...[
          const SizedBox(height: 8),
          const Text('Name: John Doe'),
          const Text('Email: john@example.com'),
        ],
      ],
    ),
  );
}

/// Color Variants - Different color options
@widgetbook.UseCase(name: 'Color Variants', type: AppH2)
Widget appH2Colors(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  final colorOption = context.knobs.object.dropdown(
    label: 'Color',
    options: ['Default', 'Primary', 'Secondary', 'Custom Purple'],
    labelBuilder: (value) => value,
  );

  final Color? color = switch (colorOption) {
    'Primary' => colorScheme.primary,
    'Secondary' => colorScheme.secondary,
    'Custom Purple' => Colors.purple,
    _ => null,
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppH2('Colored Section', color: color),
    ),
  );
}

/// Alignment Options - Left, center, right alignment
@widgetbook.UseCase(name: 'Alignment Options', type: AppH2)
Widget appH2Alignment(BuildContext context) {
  final alignmentOption = context.knobs.object.dropdown(
    label: 'Text Align',
    options: ['Left', 'Center', 'Right'],
    labelBuilder: (value) => value,
  );

  final TextAlign textAlign = switch (alignmentOption) {
    'Center' => TextAlign.center,
    'Right' => TextAlign.right,
    _ => TextAlign.left,
  };

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppH2('Aligned Section', textAlign: textAlign),
    ),
  );
}

/// Font Weight Variants - Light, normal, semibold, bold
@widgetbook.UseCase(name: 'Font Weight Variants', type: AppH2)
Widget appH2FontWeights(BuildContext context) {
  final weightOption = context.knobs.object.dropdown(
    label: 'Font Weight',
    options: ['Light (300)', 'Normal (400)', 'SemiBold (600)', 'Bold (700)'],
    labelBuilder: (value) => value,
  );

  final FontWeight fontWeight = switch (weightOption) {
    'Light (300)' => FontWeight.w300,
    'SemiBold (600)' => FontWeight.w600,
    'Bold (700)' => FontWeight.w700,
    _ => FontWeight.w400,
  };

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppH2('Weighted Section', fontWeight: fontWeight),
    ),
  );
}

/// Settings Screen Example - Real-world usage
@widgetbook.UseCase(name: 'Settings Screen Example', type: AppH2)
Widget appH2SettingsExample(BuildContext context) {
  return const _AppH2SettingsExample();
}

class _AppH2SettingsExample extends StatefulWidget {
  const _AppH2SettingsExample();

  @override
  State<_AppH2SettingsExample> createState() => _AppH2SettingsExampleState();
}

class _AppH2SettingsExampleState extends State<_AppH2SettingsExample> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = false;

  @override
  Widget build(BuildContext context) {
    final sectionName = context.knobs.object.dropdown(
      label: 'Section',
      options: ['General', 'Privacy & Security', 'Notifications'],
      labelBuilder: (value) => value,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          AppH2(sectionName),
          const SizedBox(height: 8),
          if (sectionName == 'General') ...[
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              subtitle: const Text('English'),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
            ),
          ],
          if (sectionName == 'Privacy & Security') ...[
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.chevron_right),
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Two-Factor Authentication'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ],
          if (sectionName == 'Notifications') ...[
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email Notifications'),
              trailing: Switch(
                value: _emailNotifications,
                onChanged: (value) {
                  setState(() {
                    _emailNotifications = value;
                  });
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone_android),
              title: const Text('Push Notifications'),
              trailing: Switch(
                value: _pushNotifications,
                onChanged: (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
