// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/surfaces/app_section_header.dart';
import 'package:core_kit/theme/app_spacing.dart';

@widgetbook.UseCase(name: 'Default', type: AppSectionHeader)
Widget appSectionHeaderDefault(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: AppSectionHeader(
      title: context.knobs.string(
        label: 'Title',
        initialValue: 'Section Title',
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Subtitle', type: AppSectionHeader)
Widget appSectionHeaderWithSubtitle(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSectionHeader(
          title: 'Account Settings',
          subtitle: 'Manage your account preferences and security',
        ),
        SizedBox(height: AppSpacing.lg),
        AppSectionHeader(
          title: 'Privacy',
          subtitle: 'Control who can see your information',
        ),
        SizedBox(height: AppSpacing.lg),
        AppSectionHeader(
          title: 'Notifications',
          subtitle: 'Choose how you want to be notified',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'With Leading', type: AppSectionHeader)
Widget appSectionHeaderWithLeading(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSectionHeader(
          leading: Icon(Icons.person, size: 20),
          title: 'Profile',
        ),
        SizedBox(height: AppSpacing.md),
        AppSectionHeader(
          leading: Icon(Icons.lock, size: 20),
          title: 'Security',
        ),
        SizedBox(height: AppSpacing.md),
        AppSectionHeader(
          leading: Icon(Icons.notifications, size: 20),
          title: 'Notifications',
        ),
        SizedBox(height: AppSpacing.md),
        AppSectionHeader(
          leading: Icon(Icons.palette, size: 20),
          title: 'Appearance',
          subtitle: 'Customize your app experience',
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'With Trailing', type: AppSectionHeader)
Widget appSectionHeaderWithTrailing(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSectionHeader(
          title: 'Recent Files',
          trailing: TextButton(
            onPressed: () {},
            child: const Text('Clear all'),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppSectionHeader(
          title: 'Favorites',
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, size: 20),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppSectionHeader(
          title: 'Downloads',
          subtitle: '12 items pending',
          trailing: TextButton(onPressed: () {}, child: const Text('View all')),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'With Divider', type: AppSectionHeader)
Widget appSectionHeaderWithDivider(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Divider Below (Default)',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        const AppSectionHeader(
          title: 'Section with divider below',
          showDivider: true,
          dividerPosition: DividerPosition.below,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Divider Above', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        const AppSectionHeader(
          title: 'Section with divider above',
          showDivider: true,
          dividerPosition: DividerPosition.above,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Divider Both', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        const AppSectionHeader(
          title: 'Section with dividers on both sides',
          showDivider: true,
          dividerPosition: DividerPosition.both,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Settings List Example', type: AppSectionHeader)
Widget appSectionHeaderSettingsList(BuildContext context) {
  return const _SettingsListContent();
}

/// Stateful widget for Settings List Example to demonstrate realistic usage
class _SettingsListContent extends StatefulWidget {
  const _SettingsListContent();

  @override
  State<_SettingsListContent> createState() => _SettingsListContentState();
}

class _SettingsListContentState extends State<_SettingsListContent> {
  bool _biometricLogin = true;
  bool _pushNotifications = true;
  bool _emailNotifications = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppSectionHeader(title: 'Account', isUpperCase: true),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            subtitle: const Text('john.doe@example.com'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Phone number'),
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          const AppSectionHeader(
            title: 'Privacy & Security',
            isUpperCase: true,
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Password'),
            subtitle: const Text('Last changed 30 days ago'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.fingerprint),
            title: const Text('Biometric login'),
            trailing: Switch(
              value: _biometricLogin,
              onChanged: (value) => setState(() => _biometricLogin = value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Two-factor authentication'),
            onTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          const AppSectionHeader(title: 'Notifications', isUpperCase: true),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Push notifications'),
            trailing: Switch(
              value: _pushNotifications,
              onChanged: (value) => setState(() => _pushNotifications = value),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.mail_outline),
            title: const Text('Email notifications'),
            trailing: Switch(
              value: _emailNotifications,
              onChanged: (value) => setState(() => _emailNotifications = value),
            ),
          ),
        ],
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Theme Variations', type: AppSectionHeader)
Widget appSectionHeaderThemeVariations(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Default Theme', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        const AppSectionHeader(
          title: 'Default Section Header',
          subtitle: 'Uses theme colors automatically',
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'With Background Color',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppSectionHeader(
          title: 'Highlighted Section',
          subtitle: 'With primary container background',
          backgroundColor: colorScheme.primaryContainer,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Custom Colors', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        AppSectionHeader(
          title: 'Custom Styled Section',
          subtitle: 'With custom text colors',
          textStyle: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          subtitleStyle: TextStyle(
            color: colorScheme.secondary,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Sticky Header Style',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppSectionHeader(
          title: 'Sticky Section',
          backgroundColor: colorScheme.surface,
          showDivider: true,
          dividerPosition: DividerPosition.below,
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Interactive Playground', type: AppSectionHeader)
Widget appSectionHeaderPlayground(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Section Header',
  );

  final subtitle = context.knobs.stringOrNull(
    label: 'Subtitle',
    initialValue: null,
  );

  final showLeading = context.knobs.boolean(
    label: 'Show Leading Icon',
    initialValue: false,
  );

  final showTrailing = context.knobs.boolean(
    label: 'Show Trailing Action',
    initialValue: false,
  );

  final isUpperCase = context.knobs.boolean(
    label: 'Uppercase Title',
    initialValue: false,
  );

  final showDivider = context.knobs.boolean(
    label: 'Show Divider',
    initialValue: false,
  );

  final dividerPositionOptions = context.knobs.object.dropdown<DividerPosition>(
    label: 'Divider Position',
    options: DividerPosition.values,
    labelBuilder: (value) => value.name,
  );

  final showBackground = context.knobs.boolean(
    label: 'Show Background',
    initialValue: false,
  );

  final colorScheme = Theme.of(context).colorScheme;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: AppSectionHeader(
        title: title,
        subtitle: subtitle,
        leading: showLeading ? const Icon(Icons.settings, size: 20) : null,
        trailing: showTrailing
            ? TextButton(onPressed: () {}, child: const Text('Action'))
            : null,
        isUpperCase: isUpperCase,
        showDivider: showDivider,
        dividerPosition: dividerPositionOptions,
        backgroundColor: showBackground
            ? colorScheme.surfaceContainerLow
            : null,
      ),
    ),
  );
}
