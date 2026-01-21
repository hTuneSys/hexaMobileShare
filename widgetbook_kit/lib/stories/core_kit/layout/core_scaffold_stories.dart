// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Expose ALL component properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: CoreScaffold)
Widget coreScaffoldPlayground(BuildContext context) {
  // Knobs for all CoreScaffold properties
  final showAppBar = context.knobs.boolean(
    label: 'Show App Bar',
    initialValue: true,
  );

  final appBarTitle = context.knobs.string(
    label: 'App Bar Title',
    initialValue: 'My App',
  );

  final showBottomNavigation = context.knobs.boolean(
    label: 'Show Bottom Navigation',
    initialValue: false,
  );

  final showFab = context.knobs.boolean(label: 'Show FAB', initialValue: false);

  final fabVariant = context.knobs.object.dropdown(
    label: 'FAB Variant',
    options: const ['default', 'small', 'large', 'extended'],
    labelBuilder: (value) => value,
  );

  final showDrawer = context.knobs.boolean(
    label: 'Show Drawer',
    initialValue: false,
  );

  final useSafeArea = context.knobs.boolean(
    label: 'Use Safe Area',
    initialValue: true,
  );

  final extendBody = context.knobs.boolean(
    label: 'Extend Body',
    initialValue: false,
  );

  final extendBodyBehindAppBar = context.knobs.boolean(
    label: 'Extend Body Behind App Bar',
    initialValue: false,
  );

  final resizeToAvoidBottomInset = context.knobs.boolean(
    label: 'Resize To Avoid Bottom Inset',
    initialValue: true,
  );

  final useCustomBackgroundColor = context.knobs.boolean(
    label: 'Use Custom Background Color',
    initialValue: false,
  );

  // Build FAB based on variant
  Widget? buildFab() {
    if (!showFab) return null;

    switch (fabVariant) {
      case 'small':
        return AppFab.small(icon: Icons.add, onPressed: () {});
      case 'large':
        return AppFab.large(icon: Icons.add, onPressed: () {});
      case 'extended':
        return AppFab.extended(
          icon: Icons.add,
          label: 'Add Item',
          onPressed: () {},
        );
      default:
        return AppFab(icon: Icons.add, onPressed: () {});
    }
  }

  return CoreScaffold(
    appBar: showAppBar ? AppAppBar(title: appBarTitle) : null,
    drawer: showDrawer
        ? AppDrawer(
            header: const AppDrawerHeader(
              name: 'My App',
              email: 'user@example.com',
            ),
            destinations: const [
              AppDrawerDestination(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: 'Home',
              ),
              AppDrawerDestination(
                icon: Icons.settings_outlined,
                selectedIcon: Icons.settings,
                label: 'Settings',
              ),
            ],
            selectedIndex: 0,
            onDestinationSelected: (_) {},
          )
        : null,
    body: Container(
      color: useCustomBackgroundColor
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              'CoreScaffold Body Content',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Use the knobs panel to customize the scaffold',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ),
    bottomNavigationBar: showBottomNavigation
        ? AppBottomNavigationBar(
            selectedIndex: 0,
            destinations: const [
              AppBottomNavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              AppBottomNavigationDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search),
                label: 'Search',
              ),
              AppBottomNavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onDestinationSelected: (_) {},
          )
        : null,
    floatingActionButton: buildFab(),
    useSafeArea: useSafeArea,
    extendBody: extendBody,
    extendBodyBehindAppBar: extendBodyBehindAppBar,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    backgroundColor: useCustomBackgroundColor
        ? Theme.of(context).colorScheme.surfaceContainerHighest
        : null,
  );
}

/// Basic Scaffold - Simple scaffold with body only
@widgetbook.UseCase(name: 'Basic Scaffold', type: CoreScaffold)
Widget coreScaffoldBasic(BuildContext context) {
  // Knobs for basic scaffold properties
  final useSafeArea = context.knobs.boolean(
    label: 'Use Safe Area',
    initialValue: true,
  );

  final resizeToAvoidBottomInset = context.knobs.boolean(
    label: 'Resize To Avoid Bottom Inset',
    initialValue: true,
  );

  return CoreScaffold(
    useSafeArea: useSafeArea,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.widgets_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Basic CoreScaffold',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'A simple scaffold with only body content',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),
  );
}

/// With App Bar - Scaffold with AppAppBar integration
@widgetbook.UseCase(name: 'With App Bar', type: CoreScaffold)
Widget coreScaffoldWithAppBar(BuildContext context) {
  // Knobs for app bar properties
  final appBarTitle = context.knobs.string(
    label: 'App Bar Title',
    initialValue: 'App Bar Example',
  );

  final showSearchAction = context.knobs.boolean(
    label: 'Show Search Action',
    initialValue: true,
  );

  final showMoreAction = context.knobs.boolean(
    label: 'Show More Action',
    initialValue: true,
  );

  final centerTitle = context.knobs.boolean(
    label: 'Center Title',
    initialValue: false,
  );

  return CoreScaffold(
    appBar: AppAppBar(
      title: appBarTitle,
      centerTitle: centerTitle,
      actions: [
        if (showSearchAction)
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        if (showMoreAction)
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ],
    ),
    body: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => AppListTile(
        title: 'List Item ${index + 1}',
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          child: Text('${index + 1}'),
        ),
        onTap: () {},
      ),
    ),
  );
}

/// With Bottom Navigation - Scaffold with AppBottomNavigationBar
@widgetbook.UseCase(name: 'With Bottom Navigation', type: CoreScaffold)
Widget coreScaffoldWithBottomNav(BuildContext context) {
  // Knobs for bottom navigation properties
  final showAppBar = context.knobs.boolean(
    label: 'Show App Bar',
    initialValue: true,
  );

  final destinationCount = context.knobs.object.dropdown(
    label: 'Destination Count',
    options: const [3, 4, 5],
    labelBuilder: (value) => '$value destinations',
  );

  final destinations = <AppBottomNavigationDestination>[
    const AppBottomNavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Home',
    ),
    const AppBottomNavigationDestination(
      icon: Icon(Icons.explore_outlined),
      selectedIcon: Icon(Icons.explore),
      label: 'Explore',
    ),
    const AppBottomNavigationDestination(
      icon: Icon(Icons.bookmark_outline),
      selectedIcon: Icon(Icons.bookmark),
      label: 'Saved',
    ),
    const AppBottomNavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Profile',
    ),
    const AppBottomNavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ].take(destinationCount).toList();

  return CoreScaffold(
    appBar: showAppBar ? const AppAppBar(title: 'Bottom Navigation') : null,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.navigation_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text('Home Screen', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Navigate between tabs using the bottom bar',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: AppBottomNavigationBar(
      selectedIndex: 0,
      destinations: destinations,
      onDestinationSelected: (_) {},
    ),
  );
}

/// With FAB - Scaffold with AppFab variants
@widgetbook.UseCase(name: 'With FAB', type: CoreScaffold)
Widget coreScaffoldWithFab(BuildContext context) {
  // Knobs for FAB properties
  final fabVariant = context.knobs.object.dropdown(
    label: 'FAB Variant',
    options: const ['default', 'small', 'large', 'extended'],
    labelBuilder: (value) => value,
  );

  final fabLabel = context.knobs.string(
    label: 'FAB Label (for extended)',
    initialValue: 'New Note',
  );

  final fabPosition = context.knobs.object.dropdown(
    label: 'FAB Position',
    options: const ['endFloat', 'centerFloat', 'endDocked', 'centerDocked'],
    labelBuilder: (value) => value,
  );

  FloatingActionButtonLocation getFabLocation() {
    switch (fabPosition) {
      case 'centerFloat':
        return FloatingActionButtonLocation.centerFloat;
      case 'endDocked':
        return FloatingActionButtonLocation.endDocked;
      case 'centerDocked':
        return FloatingActionButtonLocation.centerDocked;
      default:
        return FloatingActionButtonLocation.endFloat;
    }
  }

  return _WithFabContent(
    fabVariant: fabVariant,
    fabLabel: fabLabel,
    fabLocation: getFabLocation(),
  );
}

/// Stateful widget for interactive FAB story
class _WithFabContent extends StatefulWidget {
  const _WithFabContent({
    required this.fabVariant,
    required this.fabLabel,
    required this.fabLocation,
  });

  final String fabVariant;
  final String fabLabel;
  final FloatingActionButtonLocation fabLocation;

  @override
  State<_WithFabContent> createState() => _WithFabContentState();
}

class _WithFabContentState extends State<_WithFabContent> {
  final List<String> _notes = List.generate(3, (i) => 'Note ${i + 1}');

  void _addNote() {
    setState(() {
      _notes.add('Note ${_notes.length + 1}');
    });
  }

  Widget _buildFab() {
    switch (widget.fabVariant) {
      case 'small':
        return AppFab.small(icon: Icons.add, onPressed: _addNote);
      case 'large':
        return AppFab.large(icon: Icons.add, onPressed: _addNote);
      case 'extended':
        return AppFab.extended(
          icon: Icons.add,
          label: widget.fabLabel,
          onPressed: _addNote,
        );
      default:
        return AppFab(icon: Icons.add, onPressed: _addNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      appBar: AppAppBar(title: 'FAB Example (${_notes.length} notes)'),
      body: _notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_add_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notes yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the FAB to add your first note',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notes.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          child: Icon(
                            Icons.note_outlined,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _notes[index],
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'Added via FAB button',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            setState(() {
                              _notes.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: widget.fabLocation,
    );
  }
}

/// With Drawer - Scaffold with AppDrawer integration
@widgetbook.UseCase(name: 'With Drawer', type: CoreScaffold)
Widget coreScaffoldWithDrawer(BuildContext context) {
  // Knobs for drawer properties
  final drawerUserName = context.knobs.string(
    label: 'User Name',
    initialValue: 'John Doe',
  );

  final drawerUserEmail = context.knobs.string(
    label: 'User Email',
    initialValue: 'john.doe@example.com',
  );

  final showEndDrawer = context.knobs.boolean(
    label: 'Use End Drawer Instead',
    initialValue: false,
  );

  final drawerEnableDragGesture = context.knobs.boolean(
    label: 'Enable Drag Gesture',
    initialValue: true,
  );

  final drawer = AppDrawer(
    header: AppDrawerHeader(
      name: drawerUserName,
      email: drawerUserEmail,
      avatar: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: Text(
          drawerUserName.isNotEmpty ? drawerUserName[0].toUpperCase() : 'U',
        ),
      ),
    ),
    destinations: const [
      AppDrawerDestination(
        icon: Icons.inbox_outlined,
        selectedIcon: Icons.inbox,
        label: 'Inbox',
        badge: true,
        badgeLabel: '12',
      ),
      AppDrawerDestination(
        icon: Icons.send_outlined,
        selectedIcon: Icons.send,
        label: 'Sent',
      ),
      AppDrawerDestination(
        icon: Icons.favorite_outline,
        selectedIcon: Icons.favorite,
        label: 'Favorites',
      ),
      AppDrawerDestination(
        icon: Icons.delete_outline,
        selectedIcon: Icons.delete,
        label: 'Trash',
      ),
    ],
    selectedIndex: 0,
    onDestinationSelected: (_) {},
  );

  return CoreScaffold(
    appBar: AppAppBar(
      title: 'Drawer Example',
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: Icon(showEndDrawer ? Icons.menu_open : Icons.menu),
          onPressed: () => showEndDrawer
              ? Scaffold.of(ctx).openEndDrawer()
              : Scaffold.of(ctx).openDrawer(),
        ),
      ),
    ),
    drawer: showEndDrawer ? null : drawer,
    endDrawer: showEndDrawer ? drawer : null,
    drawerEnableOpenDragGesture: drawerEnableDragGesture,
    endDrawerEnableOpenDragGesture: drawerEnableDragGesture,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_open,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Drawer Navigation',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Open the drawer using the menu icon',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Full-featured Example - All features combined
@widgetbook.UseCase(name: 'Full-featured Example', type: CoreScaffold)
Widget coreScaffoldFullFeatured(BuildContext context) {
  // Knobs for full-featured example
  final appBarTitle = context.knobs.string(
    label: 'App Bar Title',
    initialValue: 'Dashboard',
  );

  final showDrawer = context.knobs.boolean(
    label: 'Show Drawer',
    initialValue: true,
  );

  final showBottomNav = context.knobs.boolean(
    label: 'Show Bottom Navigation',
    initialValue: true,
  );

  final showFab = context.knobs.boolean(label: 'Show FAB', initialValue: true);

  final useSafeArea = context.knobs.boolean(
    label: 'Use Safe Area',
    initialValue: true,
  );

  return CoreScaffold(
    useSafeArea: useSafeArea,
    appBar: AppAppBar(
      title: appBarTitle,
      leading: showDrawer
          ? Builder(
              builder: (ctx) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(ctx).openDrawer(),
              ),
            )
          : null,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
      ],
    ),
    drawer: showDrawer
        ? AppDrawer(
            header: AppDrawerHeader(
              name: 'My App',
              email: 'Version 1.0.0',
              avatar: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.apps,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            destinations: const [
              AppDrawerDestination(
                icon: Icons.dashboard_outlined,
                selectedIcon: Icons.dashboard,
                label: 'Dashboard',
              ),
              AppDrawerDestination(
                icon: Icons.analytics_outlined,
                selectedIcon: Icons.analytics,
                label: 'Analytics',
              ),
              AppDrawerDestination(
                icon: Icons.settings_outlined,
                selectedIcon: Icons.settings,
                label: 'Settings',
              ),
            ],
            selectedIndex: 0,
            onDestinationSelected: (_) {},
          )
        : null,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome Back!',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Here is your dashboard overview',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '1,234',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Total Users',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 32,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '567',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          'Orders',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Recent Activity',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ...List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppCard(
                child: AppListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.secondaryContainer,
                    child: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  title: 'Activity ${index + 1}',
                  subtitle: 'Description of this activity item',
                  trailing: Text(
                    '${index + 1}h ago',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    bottomNavigationBar: showBottomNav
        ? AppBottomNavigationBar(
            selectedIndex: 0,
            destinations: const [
              AppBottomNavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              AppBottomNavigationDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search),
                label: 'Search',
              ),
              AppBottomNavigationDestination(
                icon: Icon(Icons.notifications_outlined),
                selectedIcon: Icon(Icons.notifications),
                label: 'Alerts',
                badge: AppNavigationBadge.count(3),
              ),
              AppBottomNavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            onDestinationSelected: (_) {},
          )
        : null,
    floatingActionButton: showFab
        ? AppFab(icon: Icons.add, onPressed: () {})
        : null,
  );
}
