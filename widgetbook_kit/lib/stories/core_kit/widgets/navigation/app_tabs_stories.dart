// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground for AppTabs with all props exposed as knobs.
@widgetbook.UseCase(name: 'Interactive Playground', type: AppTabs)
Widget appTabsPlayground(BuildContext context) {
  final tabCount = int.parse(
    context.knobs.object.dropdown(
      label: 'Tab Count',
      options: ['2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
      initialOption: '3',
    ),
  );

  final variantString = context.knobs.object.dropdown(
    label: 'Variant',
    options: ['textOnly', 'iconOnly', 'iconAndText'],
    initialOption: 'iconAndText',
  );

  final indicatorStyleString = context.knobs.object.dropdown(
    label: 'Indicator Style',
    options: ['underline', 'pill'],
    initialOption: 'underline',
  );

  final isScrollable = context.knobs.boolean(
    label: 'Scrollable',
    initialValue: false,
  );

  final showBadges = context.knobs.boolean(
    label: 'Show Badges',
    initialValue: false,
  );

  final customIndicatorColor = context.knobs.boolean(
    label: 'Custom Indicator Color',
    initialValue: false,
  );

  // Generate tabs based on count
  final tabs = List.generate(
    tabCount,
    (index) => AppTabItem(
      label: _getTabLabel(index),
      icon: _getTabIcon(index),
      badgeCount: showBadges ? (index == 1 ? 3 : 0) : 0,
    ),
  );

  final variantEnum = variantString == 'textOnly'
      ? AppTabVariant.textOnly
      : variantString == 'iconOnly'
      ? AppTabVariant.iconOnly
      : AppTabVariant.iconAndText;

  final indicatorStyleEnum = indicatorStyleString == 'pill'
      ? AppTabIndicatorStyle.pill
      : AppTabIndicatorStyle.underline;

  return Scaffold(
    appBar: AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(
          variantEnum == AppTabVariant.iconAndText ? 64 : 48,
        ),
        child: AppTabs(
          tabs: tabs,
          variant: variantEnum,
          indicatorStyle: indicatorStyleEnum,
          isScrollable: isScrollable,
          indicatorColor: customIndicatorColor ? Colors.green : null,
          onTabSelected: (index) {
            debugPrint('Tab selected: $index');
          },
        ),
      ),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Use knobs to customize the tabs',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            'Tap a tab to see selection',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    ),
  );
}

/// Basic text-only tabs with 3 tabs.
@widgetbook.UseCase(name: 'Text Only (3 Tabs)', type: AppTabs)
Widget appTabsTextOnly(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: AppTabs(
          tabs: const [
            AppTabItem(label: 'Today'),
            AppTabItem(label: 'This Week'),
            AppTabItem(label: 'This Month'),
          ],
          variant: AppTabVariant.textOnly,
          onTabSelected: (index) {
            debugPrint('Selected tab: $index');
          },
        ),
      ),
    ),
    body: const Center(child: Text('Tab content goes here')),
  );
}

/// Icon and text tabs showing common time periods.
@widgetbook.UseCase(name: 'Icon and Text', type: AppTabs)
Widget appTabsIconAndText(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppTabs(
          tabs: const [
            AppTabItem(label: 'Today', icon: Icons.today),
            AppTabItem(label: 'Week', icon: Icons.date_range),
            AppTabItem(label: 'Month', icon: Icons.calendar_month),
          ],
          variant: AppTabVariant.iconAndText,
          onTabSelected: (index) {
            debugPrint('Selected tab: $index');
          },
        ),
      ),
    ),
    body: const Center(child: Text('Tab content goes here')),
  );
}

/// Icon-only tabs without labels.
@widgetbook.UseCase(name: 'Icon Only', type: AppTabs)
Widget appTabsIconOnly(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: AppTabs(
          tabs: const [
            AppTabItem(
              label: 'List',
              icon: Icons.list,
              semanticLabel: 'List view',
            ),
            AppTabItem(
              label: 'Grid',
              icon: Icons.grid_view,
              semanticLabel: 'Grid view',
            ),
            AppTabItem(
              label: 'Calendar',
              icon: Icons.calendar_view_day,
              semanticLabel: 'Calendar view',
            ),
          ],
          variant: AppTabVariant.iconOnly,
          onTabSelected: (index) {
            debugPrint('Selected tab: $index');
          },
        ),
      ),
    ),
    body: const Center(child: Text('Tab content goes here')),
  );
}

/// Scrollable tabs with 12 tabs for overflow scenarios.
@widgetbook.UseCase(name: 'Scrollable (12 Tabs)', type: AppTabs)
Widget appTabsScrollable(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppTabs(
          tabs: const [
            AppTabItem(label: 'January', icon: Icons.calendar_today),
            AppTabItem(label: 'February', icon: Icons.calendar_today),
            AppTabItem(label: 'March', icon: Icons.calendar_today),
            AppTabItem(label: 'April', icon: Icons.calendar_today),
            AppTabItem(label: 'May', icon: Icons.calendar_today),
            AppTabItem(label: 'June', icon: Icons.calendar_today),
            AppTabItem(label: 'July', icon: Icons.calendar_today),
            AppTabItem(label: 'August', icon: Icons.calendar_today),
            AppTabItem(label: 'September', icon: Icons.calendar_today),
            AppTabItem(label: 'October', icon: Icons.calendar_today),
            AppTabItem(label: 'November', icon: Icons.calendar_today),
            AppTabItem(label: 'December', icon: Icons.calendar_today),
          ],
          variant: AppTabVariant.iconAndText,
          isScrollable: true,
          onTabSelected: (index) {
            debugPrint('Selected tab: $index');
          },
        ),
      ),
    ),
    body: const Center(child: Text('Tab content goes here')),
  );
}

/// Tabs with badge indicators showing notification counts.
@widgetbook.UseCase(name: 'With Badges', type: AppTabs)
Widget appTabsWithBadges(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppTabs(
          tabs: const [
            AppTabItem(label: 'All', icon: Icons.inbox, badgeCount: 0),
            AppTabItem(
              label: 'Unread',
              icon: Icons.mark_email_unread,
              badgeCount: 12,
            ),
            AppTabItem(label: 'Starred', icon: Icons.star, badgeCount: 3),
          ],
          variant: AppTabVariant.iconAndText,
          onTabSelected: (index) {
            debugPrint('Selected tab: $index');
          },
        ),
      ),
    ),
    body: const Center(child: Text('Tab content goes here')),
  );
}

/// Tabs with custom indicator color (green instead of primary).
@widgetbook.UseCase(name: 'Custom Indicator Color', type: AppTabs)
Widget appTabsCustomIndicatorColor(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppTabs(
          tabs: const [
            AppTabItem(label: 'Active', icon: Icons.check_circle),
            AppTabItem(label: 'Pending', icon: Icons.pending),
            AppTabItem(label: 'Completed', icon: Icons.done_all),
          ],
          variant: AppTabVariant.iconAndText,
          indicatorColor: Colors.green,
          onTabSelected: (index) {
            debugPrint('Selected tab: $index');
          },
        ),
      ),
    ),
    body: const Center(child: Text('Tab content goes here')),
  );
}

/// Tabs with pill-style indicator instead of underline.
@widgetbook.UseCase(name: 'Pill Indicator', type: AppTabs)
Widget appTabsPillIndicator(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppTabs(
          tabs: const [
            AppTabItem(label: 'Posts', icon: Icons.article),
            AppTabItem(label: 'About', icon: Icons.info),
            AppTabItem(label: 'Photos', icon: Icons.photo),
          ],
          variant: AppTabVariant.iconAndText,
          indicatorStyle: AppTabIndicatorStyle.pill,
          onTabSelected: (index) {
            debugPrint('Selected tab: $index');
          },
        ),
      ),
    ),
    body: const Center(child: Text('Tab content goes here')),
  );
}

// Helper functions for generating tab data
String _getTabLabel(int index) {
  const labels = [
    'Home',
    'Search',
    'Favorites',
    'Profile',
    'Settings',
    'Messages',
    'Notifications',
    'Calendar',
    'Photos',
    'Videos',
    'Music',
    'More',
  ];
  return labels[index % labels.length];
}

IconData _getTabIcon(int index) {
  const icons = [
    Icons.home,
    Icons.search,
    Icons.favorite,
    Icons.person,
    Icons.settings,
    Icons.message,
    Icons.notifications,
    Icons.calendar_today,
    Icons.photo,
    Icons.video_library,
    Icons.music_note,
    Icons.more_horiz,
  ];
  return icons[index % icons.length];
}
