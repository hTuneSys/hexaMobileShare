// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppListTile] component.
///
/// Material Design 3 list tile widget providing a consistent layout with
/// leading/trailing widgets and up to three lines of text.

// ============================================================================
// Interactive Playground - MUST BE FIRST
// ============================================================================

@widgetbook.UseCase(name: 'Interactive Playground', type: AppListTile)
Widget appListTilePlayground(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'List Item');
  final subtitle = context.knobs.stringOrNull(
    label: 'Subtitle',
    initialValue: 'This is a subtitle',
  );
  final showLeading = context.knobs.boolean(
    label: 'Show Leading',
    initialValue: true,
  );
  final showTrailing = context.knobs.boolean(
    label: 'Show Trailing',
    initialValue: true,
  );
  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final dense = context.knobs.boolean(label: 'Dense', initialValue: false);
  final isThreeLine = context.knobs.boolean(
    label: 'Three Line',
    initialValue: false,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppListTile(
        title: title,
        subtitle: subtitle,
        leading: showLeading ? const Icon(Icons.inbox) : null,
        trailing: showTrailing ? const Icon(Icons.chevron_right) : null,
        selected: selected,
        enabled: enabled,
        dense: dense,
        isThreeLine: isThreeLine,
        onTap: () => debugPrint('Tile tapped'),
      ),
    ),
  );
}

// ============================================================================
// Variant 2: Basic
// ============================================================================

@widgetbook.UseCase(name: 'Basic', type: AppListTile)
Widget basicListTile(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppListTile(
        title: 'Basic List Tile',
        onTap: () => debugPrint('Tapped'),
      ),
    ),
  );
}

// ============================================================================
// Variant 3: With Subtitle
// ============================================================================

@widgetbook.UseCase(name: 'With Subtitle', type: AppListTile)
Widget listTileWithSubtitle(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppListTile(
        title: 'Two-line List Tile',
        subtitle: 'This is a subtitle providing additional information',
        onTap: () => debugPrint('Tapped'),
      ),
    ),
  );
}

// ============================================================================
// Variant 4: With Leading Icon
// ============================================================================

@widgetbook.UseCase(name: 'With Leading', type: AppListTile)
Widget listTileWithLeading(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppListTile(
        leading: const Icon(Icons.person),
        title: 'Profile',
        subtitle: 'View your profile settings',
        onTap: () => debugPrint('Tapped'),
      ),
    ),
  );
}

// ============================================================================
// Variant 5: With Trailing Icon
// ============================================================================

@widgetbook.UseCase(name: 'With Trailing', type: AppListTile)
Widget listTileWithTrailing(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppListTile(
        leading: const Icon(Icons.folder),
        title: 'Documents',
        subtitle: '24 files',
        trailing: const Icon(Icons.chevron_right),
        onTap: () => debugPrint('Tapped'),
      ),
    ),
  );
}

// ============================================================================
// Variant 6: Selected State
// ============================================================================

@widgetbook.UseCase(name: 'Selected', type: AppListTile)
Widget selectedListTile(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppListTile(
        leading: const Icon(Icons.home),
        title: 'Selected Item',
        subtitle: 'This item is currently selected',
        selected: true,
        onTap: () => debugPrint('Tapped'),
      ),
    ),
  );
}

// ============================================================================
// Variant 7: Disabled State
// ============================================================================

@widgetbook.UseCase(name: 'Disabled', type: AppListTile)
Widget disabledListTile(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: const AppListTile(
        leading: Icon(Icons.block),
        title: 'Disabled Item',
        subtitle: 'This item is not interactive',
        enabled: false,
      ),
    ),
  );
}

// ============================================================================
// Variant 8: Dense Layout
// ============================================================================

@widgetbook.UseCase(name: 'Dense', type: AppListTile)
Widget denseListTile(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppListTile(
            leading: const Icon(Icons.mail),
            title: 'Inbox',
            subtitle: '12 unread',
            dense: true,
            onTap: () => debugPrint('Tapped'),
          ),
          AppListTile(
            leading: const Icon(Icons.send),
            title: 'Sent',
            subtitle: '45 messages',
            dense: true,
            onTap: () => debugPrint('Tapped'),
          ),
          AppListTile(
            leading: const Icon(Icons.drafts),
            title: 'Drafts',
            subtitle: '3 drafts',
            dense: true,
            onTap: () => debugPrint('Tapped'),
          ),
        ],
      ),
    ),
  );
}

// ============================================================================
// Variant 9: Three Line
// ============================================================================

@widgetbook.UseCase(name: 'Three Line', type: AppListTile)
Widget threeLineListTile(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Icon(
            Icons.message,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        title: 'Message Title',
        subtitle:
            'This is a longer message that spans up to three lines of text to provide more detailed information to the user.',
        isThreeLine: true,
        trailing: const Text('12:30'),
        onTap: () => debugPrint('Tapped'),
      ),
    ),
  );
}

// ============================================================================
// Variant 10: With Switch
// ============================================================================

class _SwitchTileDemo extends StatefulWidget {
  const _SwitchTileDemo();

  @override
  State<_SwitchTileDemo> createState() => _SwitchTileDemoState();
}

class _SwitchTileDemoState extends State<_SwitchTileDemo> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppListTile(
          leading: const Icon(Icons.notifications),
          title: 'Notifications',
          subtitle: 'Enable push notifications',
          trailing: Switch(
            value: _enabled,
            onChanged: (value) {
              setState(() {
                _enabled = value;
              });
            },
          ),
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'With Switch', type: AppListTile)
Widget listTileWithSwitch(BuildContext context) {
  return const _SwitchTileDemo();
}
