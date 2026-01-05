// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground for AppDrawer component.
///
/// Allows real-time exploration of all AppDrawer properties.
@widgetbook.UseCase(name: 'Interactive Playground', type: AppDrawer)
Widget appDrawerInteractivePlayground(BuildContext context) {
  final showHeader = context.knobs.boolean(
    label: 'Show Header',
    initialValue: true,
  );

  final showBadges = context.knobs.boolean(
    label: 'Show Badges',
    initialValue: true,
  );

  final showFooter = context.knobs.boolean(
    label: 'Show Footer',
    initialValue: true,
  );

  final useSections = context.knobs.boolean(
    label: 'Use Sections',
    initialValue: false,
  );

  final drawerWidth = context.knobs.double.slider(
    label: 'Drawer Width',
    initialValue: 360,
    min: 256,
    max: 400,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('AppDrawer Playground')),
    drawer: AppDrawer(
      width: drawerWidth,
      header: showHeader
          ? const AppDrawerHeader(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, color: Colors.white),
              ),
              name: 'John Doe',
              email: 'john.doe@example.com',
            )
          : null,
      destinations: useSections
          ? []
          : [
              const AppDrawerDestination(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Home',
              ),
              AppDrawerDestination(
                icon: Icons.notifications_outlined,
                selectedIcon: Icons.notifications,
                label: 'Notifications',
                badge: showBadges,
                badgeLabel: '3',
              ),
              const AppDrawerDestination(
                icon: Icons.message_outlined,
                selectedIcon: Icons.message,
                label: 'Messages',
              ),
              const AppDrawerDestination(
                icon: Icons.favorite_outline,
                selectedIcon: Icons.favorite,
                label: 'Favorites',
              ),
            ],
      sections: useSections
          ? [
              AppDrawerSection(
                title: 'Main',
                startIndex: 0,
                destinations: [
                  const AppDrawerDestination(
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    label: 'Home',
                  ),
                  AppDrawerDestination(
                    icon: Icons.notifications_outlined,
                    selectedIcon: Icons.notifications,
                    label: 'Notifications',
                    badge: showBadges,
                    badgeLabel: '3',
                  ),
                ],
              ),
              const AppDrawerSection(
                title: 'Social',
                startIndex: 2,
                destinations: [
                  AppDrawerDestination(
                    icon: Icons.message_outlined,
                    selectedIcon: Icons.message,
                    label: 'Messages',
                  ),
                  AppDrawerDestination(
                    icon: Icons.favorite_outline,
                    selectedIcon: Icons.favorite,
                    label: 'Favorites',
                  ),
                ],
              ),
            ]
          : null,
      selectedIndex: 0,
      onDestinationSelected: (index) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Selected destination: $index')));
      },
      footer: showFooter
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Settings'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Sign Out'),
                  onTap: () {},
                ),
              ],
            )
          : null,
    ),
    body: const Center(child: Text('Open drawer to see AppDrawer')),
  );
}

/// Basic drawer with menu items.
@widgetbook.UseCase(name: 'Basic Drawer', type: AppDrawer)
Widget appDrawerBasic(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Basic Drawer')),
    drawer: AppDrawer(
      destinations: const [
        AppDrawerDestination(
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
          label: 'Home',
        ),
        AppDrawerDestination(
          icon: Icons.explore_outlined,
          selectedIcon: Icons.explore,
          label: 'Explore',
        ),
        AppDrawerDestination(
          icon: Icons.notifications_outlined,
          selectedIcon: Icons.notifications,
          label: 'Notifications',
        ),
        AppDrawerDestination(
          icon: Icons.message_outlined,
          selectedIcon: Icons.message,
          label: 'Messages',
        ),
      ],
      selectedIndex: 0,
      onDestinationSelected: (index) {
        Navigator.of(context).pop();
      },
    ),
    body: const Center(child: Text('Basic drawer with menu items')),
  );
}

/// Drawer with user profile header.
@widgetbook.UseCase(name: 'With Profile Header', type: AppDrawer)
Widget appDrawerWithHeader(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Drawer with Header')),
    drawer: AppDrawer(
      header: AppDrawerHeader(
        avatar: const CircleAvatar(
          radius: 32,
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.person, size: 32, color: Colors.white),
        ),
        name: 'Jane Smith',
        email: 'jane.smith@example.com',
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Profile tapped')));
        },
      ),
      destinations: const [
        AppDrawerDestination(
          icon: Icons.dashboard_outlined,
          selectedIcon: Icons.dashboard,
          label: 'Dashboard',
        ),
        AppDrawerDestination(
          icon: Icons.person_outline,
          selectedIcon: Icons.person,
          label: 'Profile',
        ),
        AppDrawerDestination(
          icon: Icons.settings_outlined,
          selectedIcon: Icons.settings,
          label: 'Settings',
        ),
      ],
      selectedIndex: 0,
      onDestinationSelected: (index) {
        Navigator.of(context).pop();
      },
    ),
    body: const Center(child: Text('Drawer with user profile header')),
  );
}

/// Drawer with sections and dividers.
@widgetbook.UseCase(name: 'With Sections', type: AppDrawer)
Widget appDrawerWithSections(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Drawer with Sections')),
    drawer: AppDrawer(
      destinations: const [], // Empty when using sections
      sections: const [
        AppDrawerSection(
          title: 'Main Navigation',
          startIndex: 0,
          destinations: [
            AppDrawerDestination(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: 'Home',
            ),
            AppDrawerDestination(
              icon: Icons.explore_outlined,
              selectedIcon: Icons.explore,
              label: 'Explore',
            ),
          ],
        ),
        AppDrawerSection(
          title: 'Communication',
          startIndex: 2,
          destinations: [
            AppDrawerDestination(
              icon: Icons.message_outlined,
              selectedIcon: Icons.message,
              label: 'Messages',
            ),
            AppDrawerDestination(
              icon: Icons.notifications_outlined,
              selectedIcon: Icons.notifications,
              label: 'Notifications',
            ),
          ],
        ),
        AppDrawerSection(
          title: 'Settings',
          startIndex: 4,
          hasDivider: false,
          destinations: [
            AppDrawerDestination(
              icon: Icons.settings_outlined,
              selectedIcon: Icons.settings,
              label: 'Settings',
            ),
            AppDrawerDestination(
              icon: Icons.help_outline,
              selectedIcon: Icons.help,
              label: 'Help',
            ),
          ],
        ),
      ],
      selectedIndex: 0,
      onDestinationSelected: (index) {
        Navigator.of(context).pop();
      },
    ),
    body: const Center(child: Text('Drawer organized with sections')),
  );
}

/// Drawer with badges on menu items.
@widgetbook.UseCase(name: 'With Badges', type: AppDrawer)
Widget appDrawerWithBadges(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Drawer with Badges')),
    drawer: AppDrawer(
      destinations: const [
        AppDrawerDestination(
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
          label: 'Home',
        ),
        AppDrawerDestination(
          icon: Icons.notifications_outlined,
          selectedIcon: Icons.notifications,
          label: 'Notifications',
          badge: true,
          badgeLabel: '12',
        ),
        AppDrawerDestination(
          icon: Icons.message_outlined,
          selectedIcon: Icons.message,
          label: 'Messages',
          badge: true,
          badgeLabel: '5',
        ),
        AppDrawerDestination(
          icon: Icons.favorite_outline,
          selectedIcon: Icons.favorite,
          label: 'Favorites',
          badge: true,
        ),
      ],
      selectedIndex: 0,
      onDestinationSelected: (index) {
        Navigator.of(context).pop();
      },
    ),
    body: const Center(child: Text('Drawer with notification badges')),
  );
}

/// Drawer with expandable sections.
@widgetbook.UseCase(name: 'With Expandable Sections', type: AppDrawer)
Widget appDrawerWithExpandableSections(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Drawer with Expandable Sections')),
    drawer: AppDrawer(
      destinations: const [], // Empty when using sections
      sections: const [
        AppDrawerSection(
          title: 'Navigation',
          startIndex: 0,
          isExpandable: true,
          hasDivider: false,
          destinations: [
            AppDrawerDestination(
              icon: Icons.home_outlined,
              selectedIcon: Icons.home,
              label: 'Home',
            ),
            AppDrawerDestination(
              icon: Icons.explore_outlined,
              selectedIcon: Icons.explore,
              label: 'Explore',
            ),
            AppDrawerDestination(
              icon: Icons.favorite_outline,
              selectedIcon: Icons.favorite,
              label: 'Favorites',
            ),
            AppDrawerDestination(
              icon: Icons.bookmark_outline,
              selectedIcon: Icons.bookmark,
              label: 'Bookmarks',
            ),
          ],
        ),
      ],
      selectedIndex: 0,
      onDestinationSelected: (index) {
        Navigator.of(context).pop();
      },
    ),
    body: const Center(child: Text('Tap section title to expand/collapse')),
  );
}

/// Drawer with footer actions.
@widgetbook.UseCase(name: 'With Footer', type: AppDrawer)
Widget appDrawerWithFooter(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Drawer with Footer')),
    drawer: AppDrawer(
      destinations: const [
        AppDrawerDestination(
          icon: Icons.home_outlined,
          selectedIcon: Icons.home,
          label: 'Home',
        ),
        AppDrawerDestination(
          icon: Icons.work_outline,
          selectedIcon: Icons.work,
          label: 'Work',
        ),
        AppDrawerDestination(
          icon: Icons.school_outlined,
          selectedIcon: Icons.school,
          label: 'Education',
        ),
      ],
      selectedIndex: 0,
      onDestinationSelected: (index) {
        Navigator.of(context).pop();
      },
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Settings tapped')));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('Help & Feedback'),
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Help tapped')));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign Out'),
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Signed out')));
            },
          ),
        ],
      ),
    ),
    body: const Center(child: Text('Drawer with footer actions')),
  );
}

/// Drawer with selection states.
@widgetbook.UseCase(name: 'Selection States', type: AppDrawer)
Widget appDrawerSelectionStates(BuildContext context) {
  return _DrawerSelectionDemo();
}

class _DrawerSelectionDemo extends StatefulWidget {
  const _DrawerSelectionDemo();

  @override
  State<_DrawerSelectionDemo> createState() => _DrawerSelectionDemoState();
}

class _DrawerSelectionDemoState extends State<_DrawerSelectionDemo> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final destinations = const [
      AppDrawerDestination(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
        label: 'Home',
      ),
      AppDrawerDestination(
        icon: Icons.explore_outlined,
        selectedIcon: Icons.explore,
        label: 'Explore',
      ),
      AppDrawerDestination(
        icon: Icons.notifications_outlined,
        selectedIcon: Icons.notifications,
        label: 'Notifications',
      ),
      AppDrawerDestination(
        icon: Icons.message_outlined,
        selectedIcon: Icons.message,
        label: 'Messages',
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Selection States')),
      drawer: AppDrawer(
        destinations: destinations,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          Navigator.of(context).pop();
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected: ${destinations[_selectedIndex].label}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Text('Open drawer and select different items'),
          ],
        ),
      ),
    );
  }
}

/// RTL drawer variant.
@widgetbook.UseCase(name: 'RTL Support', type: AppDrawer)
Widget appDrawerRTL(BuildContext context) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: const Text('قائمة التنقل')),
      drawer: AppDrawer(
        header: const AppDrawerHeader(
          avatar: CircleAvatar(
            backgroundColor: Colors.indigo,
            child: Icon(Icons.person, color: Colors.white),
          ),
          name: 'محمد أحمد',
          email: 'mohamed@example.com',
        ),
        destinations: const [
          AppDrawerDestination(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
            label: 'الرئيسية',
          ),
          AppDrawerDestination(
            icon: Icons.explore_outlined,
            selectedIcon: Icons.explore,
            label: 'استكشاف',
          ),
          AppDrawerDestination(
            icon: Icons.notifications_outlined,
            selectedIcon: Icons.notifications,
            label: 'الإشعارات',
            badge: true,
            badgeLabel: '٥',
          ),
          AppDrawerDestination(
            icon: Icons.message_outlined,
            selectedIcon: Icons.message,
            label: 'الرسائل',
          ),
        ],
        selectedIndex: 0,
        onDestinationSelected: (index) {
          Navigator.of(context).pop();
        },
      ),
      body: const Center(
        child: Text('دعم اللغة العربية (من اليمين إلى اليسار)'),
      ),
    ),
  );
}
