// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// ============================================================================
// Story 1: Default List Tile - Basic one-line
// ============================================================================

/// Default list tile with leading icon and trailing chevron.
@widgetbook.UseCase(name: 'Default', type: AppListTile)
Widget appListTileDefault(BuildContext context) {
  return Scaffold(
    body: ListView(
      children: [
        AppListTile(
          leading: const Icon(Icons.star),
          title: context.knobs.string(
            label: 'Title',
            initialValue: 'List item',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ],
    ),
  );
}

// ============================================================================
// Story 2: Line Variations - One, two, three lines
// ============================================================================

/// One-line list tile with title only.
@widgetbook.UseCase(name: 'One Line', type: AppListTile)
Widget appListTileOneLine(BuildContext context) {
  return Scaffold(
    body: ListView(
      children: [
        AppListTile(
          leading: const Icon(Icons.inbox),
          title: 'Inbox',
          trailing: const Text('24'),
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const Icon(Icons.send),
          title: 'Sent',
          trailing: const Text('8'),
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const Icon(Icons.drafts),
          title: 'Drafts',
          trailing: const Text('3'),
          onTap: () {},
        ),
      ],
    ),
  );
}

/// Two-line list tile with title and subtitle.
@widgetbook.UseCase(name: 'Two Line', type: AppListTile)
Widget appListTileTwoLine(BuildContext context) {
  return Scaffold(
    body: ListView(
      children: [
        AppListTile(
          leading: const CircleAvatar(child: Icon(Icons.folder)),
          title: 'Documents',
          subtitle: '24 files',
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const CircleAvatar(child: Icon(Icons.photo)),
          title: 'Photos',
          subtitle: '156 items',
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const CircleAvatar(child: Icon(Icons.music_note)),
          title: 'Music',
          subtitle: '42 songs',
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ],
    ),
  );
}

/// Three-line list tile with extended subtitle.
@widgetbook.UseCase(name: 'Three Line', type: AppListTile)
Widget appListTileThreeLine(BuildContext context) {
  return Scaffold(
    body: ListView(
      children: [
        AppListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=1'),
          ),
          title: 'John Doe',
          subtitle: 'Hey! How are you doing today?\nSent 2 hours ago',
          isThreeLine: true,
          trailing: const Text('12:30'),
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=2'),
          ),
          title: 'Jane Smith',
          subtitle: 'Can we schedule a meeting for tomorrow?\nSent 5 hours ago',
          isThreeLine: true,
          trailing: const Text('09:15'),
          onTap: () {},
        ),
      ],
    ),
  );
}

// ============================================================================
// Story 3: With Leading Widgets
// ============================================================================

/// List tiles with various leading widgets.
@widgetbook.UseCase(name: 'Leading Widgets', type: AppListTile)
Widget appListTileLeading(BuildContext context) {
  return Scaffold(
    body: ListView(
      children: [
        // Icon (24dp)
        AppListTile(
          leading: const Icon(Icons.settings, size: 24),
          title: 'Settings',
          subtitle: 'App preferences',
          onTap: () {},
        ),
        const Divider(height: 1),
        // Avatar (40dp)
        AppListTile(
          leading: const CircleAvatar(radius: 20, child: Icon(Icons.person)),
          title: 'John Doe',
          subtitle: 'Software Engineer',
          onTap: () {},
        ),
        const Divider(height: 1),
        // Checkbox
        AppListTile(
          leading: Checkbox(
            value: context.knobs.boolean(
              label: 'Checkbox checked',
              initialValue: false,
            ),
            onChanged: (_) {},
          ),
          title: 'Select item',
          subtitle: 'Optional description',
          onTap: () {},
        ),
        const Divider(height: 1),
        // Image thumbnail
        AppListTile(
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: NetworkImage('https://picsum.photos/100'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: 'Photo Album',
          subtitle: 'Summer vacation 2024',
          onTap: () {},
        ),
      ],
    ),
  );
}

// ============================================================================
// Story 4: With Trailing Widgets
// ============================================================================

/// List tiles with various trailing widgets.
@widgetbook.UseCase(name: 'Trailing Widgets', type: AppListTile)
Widget appListTileTrailing(BuildContext context) {
  return Scaffold(
    body: ListView(
      children: [
        // Chevron icon (navigation)
        AppListTile(
          leading: const Icon(Icons.account_circle),
          title: 'Profile',
          subtitle: 'View your profile',
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        const Divider(height: 1),
        // Info icon
        AppListTile(
          leading: const Icon(Icons.info_outline),
          title: 'About',
          trailing: const Icon(Icons.info),
          onTap: () {},
        ),
        const Divider(height: 1),
        // Switch toggle
        AppListTile(
          leading: const Icon(Icons.notifications),
          title: 'Notifications',
          subtitle: 'Enable push notifications',
          trailing: Switch(
            value: context.knobs.boolean(
              label: 'Notifications enabled',
              initialValue: true,
            ),
            onChanged: (_) {},
          ),
        ),
        const Divider(height: 1),
        // Text (timestamp)
        AppListTile(
          leading: const CircleAvatar(child: Icon(Icons.message)),
          title: 'New Message',
          subtitle: 'Hey, how are you?',
          trailing: const Text('2:30 PM', style: TextStyle(fontSize: 12)),
          onTap: () {},
        ),
        const Divider(height: 1),
        // Icon button
        AppListTile(
          leading: const Icon(Icons.favorite),
          title: 'Favorites',
          subtitle: '5 items',
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Story 5: States - Default, Selected, Disabled, Hover, Pressed
// ============================================================================

/// List tiles in various interaction states.
@widgetbook.UseCase(name: 'States', type: AppListTile)
Widget appListTileStates(BuildContext context) {
  final selectedState = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );
  final enabledState = context.knobs.boolean(
    label: 'Enabled',
    initialValue: true,
  );

  return Scaffold(
    body: ListView(
      children: [
        // Default state
        AppListTile(
          leading: const Icon(Icons.home),
          title: 'Home',
          subtitle: 'Default state',
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        const Divider(height: 1),
        // Selected state
        AppListTile(
          leading: const Icon(Icons.star),
          title: 'Favorites',
          subtitle: 'Selected state',
          trailing: const Icon(Icons.chevron_right),
          selected: selectedState,
          onTap: () {},
        ),
        const Divider(height: 1),
        // Disabled state
        AppListTile(
          leading: const Icon(Icons.block),
          title: 'Disabled',
          subtitle: 'Cannot interact',
          trailing: const Icon(Icons.chevron_right),
          enabled: enabledState,
          onTap: () {},
        ),
        const Divider(height: 1),
        // Pressed state (has ripple on tap)
        AppListTile(
          leading: const Icon(Icons.touch_app),
          title: 'Press Me',
          subtitle: 'Tap to see ripple effect',
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
      ],
    ),
  );
}

// ============================================================================
// Story 6: Dense Mode - Compact layout
// ============================================================================

/// Dense mode list tiles with reduced height.
@widgetbook.UseCase(name: 'Dense Mode', type: AppListTile)
Widget appListTileDense(BuildContext context) {
  final denseMode = context.knobs.boolean(
    label: 'Dense Mode',
    initialValue: true,
  );

  return Scaffold(
    appBar: AppBar(
      title: Text(denseMode ? 'Dense Mode (48dp)' : 'Regular Mode (56dp)'),
    ),
    body: ListView(
      children: [
        AppListTile(
          leading: const Icon(Icons.inbox, size: 20),
          title: 'Inbox',
          trailing: const Text('24'),
          dense: denseMode,
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const Icon(Icons.send, size: 20),
          title: 'Sent',
          trailing: const Text('8'),
          dense: denseMode,
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const Icon(Icons.drafts, size: 20),
          title: 'Drafts',
          trailing: const Text('3'),
          dense: denseMode,
          onTap: () {},
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Dense two-line (64dp vs 72dp)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        AppListTile(
          leading: const Icon(Icons.folder, size: 20),
          title: 'Documents',
          subtitle: '24 files',
          trailing: const Icon(Icons.chevron_right),
          dense: denseMode,
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const Icon(Icons.photo, size: 20),
          title: 'Photos',
          subtitle: '156 items',
          trailing: const Icon(Icons.chevron_right),
          dense: denseMode,
          onTap: () {},
        ),
      ],
    ),
  );
}

// ============================================================================
// Story 7: Common Patterns - Real-world examples
// ============================================================================

/// Common list tile patterns used in real apps.
@widgetbook.UseCase(name: 'Common Patterns', type: AppListTile)
Widget appListTilePatterns(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Settings List',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        AppListTile(
          leading: const Icon(Icons.wifi),
          title: 'Wi-Fi',
          subtitle: 'MyNetwork',
          trailing: const Icon(Icons.chevron_right),
          onTap: () {},
        ),
        AppListTile(
          leading: const Icon(Icons.bluetooth),
          title: 'Bluetooth',
          subtitle: 'Off',
          trailing: Switch(value: false, onChanged: (_) {}),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Contact List',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        AppListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
          ),
          title: 'Alice Johnson',
          subtitle: 'Hey, are you free tomorrow?',
          trailing: const Text('2 min ago'),
          onTap: () {},
        ),
        AppListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=4'),
          ),
          title: 'Bob Williams',
          subtitle: 'Thanks for the help!',
          trailing: const Text('1 hour ago'),
          onTap: () {},
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Navigation Menu',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        AppListTile(
          leading: const Icon(Icons.home),
          title: 'Home',
          onTap: () {},
        ),
        AppListTile(
          leading: const Icon(Icons.person),
          title: 'Profile',
          onTap: () {},
        ),
        AppListTile(
          leading: const Icon(Icons.settings),
          title: 'Settings',
          onTap: () {},
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Selectable List',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        AppListTile(
          leading: Checkbox(value: true, onChanged: (_) {}),
          title: 'Item 1',
          subtitle: 'First selected item',
          onTap: () {},
        ),
        AppListTile(
          leading: Checkbox(value: false, onChanged: (_) {}),
          title: 'Item 2',
          subtitle: 'Second unselected item',
          onTap: () {},
        ),
      ],
    ),
  );
}

// ============================================================================
// Story 8: Theme Variations - Light/Dark modes
// ============================================================================

/// List tiles in different theme modes.
@widgetbook.UseCase(name: 'Theme Variations', type: AppListTile)
Widget appListTileThemes(BuildContext context) {
  return Scaffold(
    body: ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Theme automatically adapts to light/dark mode.\nUse the theme switcher in Widgetbook toolbar.',
            textAlign: TextAlign.center,
          ),
        ),
        const Divider(),
        AppListTile(
          leading: const Icon(Icons.brightness_6),
          title: 'Theme Mode',
          subtitle: 'Automatically adapts to light/dark',
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const Icon(Icons.star),
          title: 'Selected Item',
          subtitle: 'Shows secondaryContainer background',
          selected: true,
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const Icon(Icons.palette),
          title: 'Custom Tile Color',
          subtitle: 'Using primaryContainer',
          tileColor: Theme.of(context).colorScheme.primaryContainer,
          onTap: () {},
        ),
        const Divider(height: 1),
        AppListTile(
          leading: const Icon(Icons.color_lens),
          title: 'Custom Selected Color',
          subtitle: 'Using tertiaryContainer',
          selected: true,
          selectedTileColor: Theme.of(context).colorScheme.tertiaryContainer,
          onTap: () {},
        ),
      ],
    ),
  );
}

// ============================================================================
// Story 9: Interactive Playground - Full customization
// ============================================================================

/// Interactive playground to customize all list tile properties.
@widgetbook.UseCase(name: 'Interactive Playground', type: AppListTile)
Widget appListTilePlayground(BuildContext context) {
  // Title and subtitle
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'List Item Title',
  );
  final subtitle = context.knobs.string(
    label: 'Subtitle',
    initialValue: 'Optional subtitle text',
  );
  final showSubtitle = context.knobs.boolean(
    label: 'Show Subtitle',
    initialValue: true,
  );

  // Leading widget options
  final leadingType = context.knobs.object.dropdown(
    label: 'Leading Widget',
    options: ['None', 'Icon', 'Avatar', 'Checkbox'],
    labelBuilder: (option) => option,
    initialOption: 'Icon',
  );

  // Trailing widget options
  final trailingType = context.knobs.object.dropdown(
    label: 'Trailing Widget',
    options: ['None', 'Icon', 'Chevron', 'Switch', 'Text'],
    labelBuilder: (option) => option,
    initialOption: 'Chevron',
  );

  // States
  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final dense = context.knobs.boolean(label: 'Dense Mode', initialValue: false);
  final isThreeLine = context.knobs.boolean(
    label: 'Three Line',
    initialValue: false,
  );

  // Build leading widget
  Widget? leading;
  switch (leadingType) {
    case 'Icon':
      leading = const Icon(Icons.star);
    case 'Avatar':
      leading = const CircleAvatar(child: Icon(Icons.person));
    case 'Checkbox':
      leading = Checkbox(value: selected, onChanged: (_) {});
    case 'None':
      leading = null;
  }

  // Build trailing widget
  Widget? trailing;
  switch (trailingType) {
    case 'Icon':
      trailing = const Icon(Icons.info);
    case 'Chevron':
      trailing = const Icon(Icons.chevron_right);
    case 'Switch':
      trailing = Switch(value: selected, onChanged: (_) {});
    case 'Text':
      trailing = const Text('12:30');
    case 'None':
      trailing = null;
  }

  return Scaffold(
    appBar: AppBar(title: const Text('Interactive Playground')),
    body: ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Use the knobs panel to customize the list tile properties.',
            textAlign: TextAlign.center,
          ),
        ),
        const Divider(),
        AppListTile(
          leading: leading,
          title: title,
          subtitle: showSubtitle ? subtitle : null,
          trailing: trailing,
          selected: selected,
          enabled: enabled,
          dense: dense,
          isThreeLine: isThreeLine,
          onTap: () {},
        ),
      ],
    ),
  );
}
