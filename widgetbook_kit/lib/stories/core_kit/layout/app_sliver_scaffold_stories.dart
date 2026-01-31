// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/gestures.dart' as api_pointer;
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Interactive Playground', type: AppSliverScaffold)
Widget appSliverScaffoldPlayground(BuildContext context) {
  // --- Knobs for AppSliverScaffold layout ---
  final titleText = context.knobs.string(
    label: 'Title Text',
    initialValue: 'Sliver Scaffold',
  );

  final expandedHeight = context.knobs.double.slider(
    label: 'Expanded Height',
    initialValue: 200,
    min: 100,
    max: 500,
  );

  final collapsedHeight = context.knobs.double.slider(
    label: 'Collapsed Height',
    initialValue: kToolbarHeight,
    min: kToolbarHeight,
    max: 100,
  );

  final pinned = context.knobs.boolean(label: 'Pinned', initialValue: true);

  final floating = context.knobs.boolean(
    label: 'Floating',
    initialValue: false,
  );

  final snap = context.knobs.boolean(
    label: 'Snap',
    description: 'Only active when Floating is enabled',
    initialValue: false,
  );

  final showScrim = context.knobs.boolean(
    label: 'Show Scrim (Gradient Overlay)',
    initialValue: false,
  );

  final parallaxRatio = context.knobs.double.slider(
    label: 'Parallax Ratio',
    initialValue: 0.5,
    min: 0.0,
    max: 1.0,
  );

  final hasActions = context.knobs.boolean(
    label: 'Show Actions',
    initialValue: true,
  );

  final backgroundType = context.knobs.object.dropdown(
    label: 'Flexible Space Background',
    options: ['Image', 'Gradient', 'Solid Color', 'None'],
    labelBuilder: (value) => value,
  );

  final contentType = context.knobs.object.dropdown(
    label: 'Content Type',
    options: ['List', 'Grid', 'Mixed'],
    labelBuilder: (value) => value,
  );

  // --- Knobs for Standard Scaffold Features ---
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

  // --- Helper Builders ---

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

  Widget? buildFlexibleSpace(BuildContext context) {
    switch (backgroundType) {
      case 'Image':
        return Image.network(
          'https://picsum.photos/800/600',
          fit: BoxFit.cover,
        );
      case 'Gradient':
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.deepPurple, Colors.orangeAccent],
            ),
          ),
        );
      case 'Solid Color':
        return Container(color: Theme.of(context).colorScheme.primaryContainer);
      case 'None':
      default:
        return null;
    }
  }

  List<Widget> buildSlivers(BuildContext context) {
    final sectionHeaderStyle = Theme.of(context).textTheme.titleMedium
        ?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        );

    if (contentType == 'List') {
      return [
        SliverPadding(
          padding: AppSpacing.edgeInsetsAllMd,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  child: AppListTile(
                    title: 'List Item ${index + 1}',
                    subtitle: 'Subtitle for item ${index + 1}',
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
                      child: Text('${index + 1}'),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
              childCount: 25,
            ),
          ),
        ),
      ];
    } else if (contentType == 'Grid') {
      return [
        SliverPadding(
          padding: AppSpacing.edgeInsetsAllMd,
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => AppCard(
                padding: EdgeInsets.zero,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.grid_view,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const Gap.sm(),
                      Text(
                        'Item ${index + 1}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
              childCount: 12,
            ),
          ),
        ),
      ];
    } else {
      // Mixed
      return [
        SliverToBoxAdapter(
          child: AppSectionHeader(
            title: 'Featured Items',
            textStyle: sectionHeaderStyle,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: AppSpacing.edgeInsetsHMd,
              itemCount: 10,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.only(
                  right: AppSpacing.sm,
                  bottom: AppSpacing.xs,
                ),
                child: SizedBox(
                  width: 150,
                  child: AppCard(
                    padding: AppSpacing.edgeInsetsAllSm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 32,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Card ${index + 1}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          'Subtitle',
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
            ),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: SectionHeaderDelegate(
            height: 48.0,
            child: AppSectionHeader(
              title: 'More Content',
              backgroundColor: Theme.of(context).colorScheme.surface,
              textStyle: sectionHeaderStyle,
            ),
          ),
        ),
        SliverPadding(
          padding: AppSpacing.edgeInsetsAllMd,
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSpacing.sm,
              crossAxisSpacing: AppSpacing.sm,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => AppCard(
                padding: EdgeInsets.zero,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.grid_view,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const Gap.sm(),
                      Text(
                        'Item ${index + 1}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
              childCount: 12,
            ),
          ),
        ),
      ];
    }
  }

  return AppSliverScaffold(
    key: ValueKey('AppSliverScaffold_${floating}_${snap}_$pinned'),
    title: Text(titleText),
    expandedHeight: expandedHeight,
    collapsedHeight: collapsedHeight,
    pinned: pinned,
    floating: floating,
    snap: snap && floating,
    useSafeArea: useSafeArea,
    showScrim: showScrim,
    parallaxRatio: parallaxRatio,
    actions: hasActions
        ? [
            AppIconButton(
              icon: Icons.search,
              tooltip: 'Search',
              onPressed: () {},
            ),
            AppIconButton(
              icon: Icons.more_vert,
              tooltip: 'More options',
              onPressed: () {},
            ),
          ]
        : null,
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
    floatingActionButton: buildFab(),
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
    flexibleSpace: buildFlexibleSpace(context),
    slivers: buildSlivers(context),
  );
}

/// Basic Usage - Simple pinned header with content
@widgetbook.UseCase(name: 'Basic Usage', type: AppSliverScaffold)
Widget basicSliverScaffold(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Basic Sliver',
  );

  final pinned = context.knobs.boolean(label: 'Pinned', initialValue: true);

  final useSafeArea = context.knobs.boolean(
    label: 'Use Safe Area',
    initialValue: true,
  );

  return AppSliverScaffold(
    title: Text(title),
    pinned: pinned,
    useSafeArea: useSafeArea,
    expandedHeight: 64.0,
    slivers: [
      SliverPadding(
        padding: AppSpacing.edgeInsetsAllMd,
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                child: AppListTile(
                  title: 'Item ${index + 1}',
                  subtitle: 'Basic list item description',
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
            ),
            childCount: 20,
          ),
        ),
      ),
    ],
  );
}

/// Large Title Header - iOS-style with search action
@widgetbook.UseCase(name: 'Large Title Header', type: AppSliverScaffold)
Widget largeTitleSliverScaffold(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Large Header',
  );

  return AppSliverScaffold(
    title: Text(title),
    pinned: true,
    expandedHeight: 160.0,
    slivers: [
      SliverPadding(
        padding: AppSpacing.edgeInsetsAllMd,
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: AppCard(
                child: AppListTile(
                  title: 'List Item ${index + 1}',
                  subtitle: 'Subtitle for item ${index + 1}',
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.secondaryContainer,
                    child: Text('${index + 1}'),
                  ),
                  onTap: () {},
                ),
              ),
            ),
            childCount: 20,
          ),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Profile Parallax', type: AppSliverScaffold)
Widget profileParallaxScaffold(BuildContext context) {
  final userName = context.knobs.string(
    label: 'User Name',
    initialValue: 'Jane Doe',
  );

  final userRole = context.knobs.string(
    label: 'Role',
    initialValue: 'Senior Flutter Developer',
  );

  final showScrim = context.knobs.boolean(
    label: 'Show Scrim (Gradient Overlay)',
    initialValue: true,
  );

  final parallaxRatio = context.knobs.double.slider(
    label: 'Parallax Ratio',
    initialValue: 0.5,
    min: 0.0,
    max: 1.0,
  );

  return AppSliverScaffold(
    expandedHeight: 320,
    pinned: true,
    showScrim: showScrim,
    parallaxRatio: parallaxRatio,
    accessibilityLabel: 'User profile header',
    title: Text(userName),
    flexibleSpace: Image.network(
      'https://picsum.photos/id/1/800/600',
      fit: BoxFit.cover,
    ),
    slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: AppSpacing.edgeInsetsAllMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                  const Gap.md(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          userRole,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  AppOutlinedButton(onPressed: () {}, label: 'Edit'),
                ],
              ),
              const Gap.md(),

              const Text(
                'Bio: Passionate about building beautiful, high-performance mobile applications with Flutter. Open source contributor and tech speaker.',
              ),
            ],
          ),
        ),
      ),
      SliverPadding(
        padding: AppSpacing.edgeInsetsHMd,
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AppSpacing.sm,
            crossAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.0,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) => AppCard(
              padding: EdgeInsets.zero,
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.folder_open,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const Gap.sm(),
                    Text(
                      'Project ${index + 1}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
            childCount: 12,
          ),
        ),
      ),
      const SliverToBoxAdapter(child: Gap.lg()),
    ],
  );
}

@widgetbook.UseCase(name: 'Sticky Section Headers', type: AppSliverScaffold)
Widget stickyHeaderScaffold(BuildContext context) {
  final sectionCount = context.knobs.int.slider(
    label: 'Section Count',
    initialValue: 5,
    min: 1,
    max: 10,
  );

  return AppSliverScaffold(
    title: const Text('Inventories'),
    slivers: [
      for (int i = 0; i < sectionCount; i++) ...[
        SliverPersistentHeader(
          pinned: true,
          delegate: SectionHeaderDelegate(
            height: 48,
            child: AppSectionHeader(
              title: 'Inventory ${String.fromCharCode(65 + i)}',
              backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
              textStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => AppListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHigh,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              title: 'List ${index + 1}',
              trailing: AppIconButton(
                icon: Icons.chevron_right,
                tooltip: 'View details',
                onPressed: () {},
              ),
            ),
            childCount: 5,
          ),
        ),
      ],
    ],
  );
}

@widgetbook.UseCase(name: 'Pull to Refresh', type: AppSliverScaffold)
Widget pullToRefreshScaffold(BuildContext context) {
  // Enable pull-to-refresh for mouse users in web/desktop contexts
  return ScrollConfiguration(
    behavior: ScrollConfiguration.of(context).copyWith(
      dragDevices: {
        api_pointer.PointerDeviceKind.touch,
        api_pointer.PointerDeviceKind.mouse,
      },
    ),
    child: AppSliverScaffold(
      title: const Text('Pull to Refresh'),
      pinned: true,
      onRefresh: () async {
        // Simulate network delay
        await Future.delayed(const Duration(seconds: 2));
      },
      slivers: [
        SliverPadding(
          padding: AppSpacing.edgeInsetsAllMd,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: AppCard(
                  child: AppListTile(
                    title: 'Refreshable Item ${index + 1}',
                    subtitle: 'Subtitle for item ${index + 1}',
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
                      child: Text('${index + 1}'),
                    ),
                    onTap: () {},
                  ),
                ),
              ),
              childCount: 20,
            ),
          ),
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Flexible Space', type: AppSliverScaffold)
Widget customFlexibleSpaceScaffold(BuildContext context) {
  final expandedHeight = context.knobs.double.slider(
    label: 'Expanded Height',
    initialValue: 250,
    min: 150,
    max: 400,
  );

  final startColor = context.knobs.color(
    label: 'Start Color',
    initialValue: Colors.blue,
  );

  final endColor = context.knobs.color(
    label: 'End Color',
    initialValue: Colors.purple,
  );

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );

  return AppSliverScaffold(
    title: const Text('Custom Header'),
    expandedHeight: expandedHeight,
    pinned: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [startColor, endColor],
        ),
      ),
      child: Center(
        child: showIcon
            ? const Icon(Icons.star, size: 80, color: Colors.white)
            : null,
      ),
    ),
    slivers: [
      SliverFillRemaining(
        child: Center(
          child: Text(
            'Scroll Content',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'Multi-Sliver Coordination', type: AppSliverScaffold)
Widget multiSliverScaffold(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;

  // Navigation Knobs
  final showDrawer = context.knobs.boolean(
    label: 'Show Drawer',
    initialValue: true,
  );
  final showBottomNav = context.knobs.boolean(
    label: 'Show Bottom Navigation',
    initialValue: true,
  );
  final showFab = context.knobs.boolean(label: 'Show FAB', initialValue: true);

  return AppSliverScaffold(
    title: const Text('Dashboard'),
    expandedHeight: 120, // Reduced height as per dashboard style
    pinned: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(color: colorScheme.surface),
    ),
    // Navigation Integration
    drawer: showDrawer
        ? AppDrawer(
            header: AppDrawerHeader(
              name: 'My App',
              email: 'Version 1.0.0',
              avatar: CircleAvatar(
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(Icons.apps, color: colorScheme.onPrimaryContainer),
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

    // Scrollable Content
    slivers: [
      // 1. Welcome Section
      SliverToBoxAdapter(
        child: Padding(
          padding: AppSpacing.edgeInsetsAllMd,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome Back!', style: textTheme.headlineMedium),
              const Gap.sm(),
              Text(
                'Here is your dashboard overview',
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),

      // 2. Stats Grid
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            AppCard(
              child: Padding(
                padding: AppSpacing.edgeInsetsAllMd,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 32,
                      color: colorScheme.primary,
                    ),
                    const Gap.sm(),
                    Text('1,234', style: textTheme.headlineSmall),
                    Text(
                      'Total Users',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppCard(
              child: Padding(
                padding: AppSpacing.edgeInsetsAllMd,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 32,
                      color: colorScheme.secondary,
                    ),
                    const Gap.sm(),
                    Text('567', style: textTheme.headlineSmall),
                    Text(
                      'Orders',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppCard(
              child: Padding(
                padding: AppSpacing.edgeInsetsAllMd,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inventory_2_outlined,
                      size: 32,
                      color: colorScheme.tertiary,
                    ),
                    const Gap.sm(),
                    Text('2500', style: textTheme.headlineSmall),
                    Text(
                      'Total Inventories',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppCard(
              child: Padding(
                padding: AppSpacing.edgeInsetsAllMd,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.visibility_outlined,
                      size: 32,
                      color: colorScheme.error,
                    ),
                    const Gap.sm(),
                    Text('89k', style: textTheme.headlineSmall),
                    Text(
                      'Visits',
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // 3. Sticky Divider for Recent Activity
      SliverPersistentHeader(
        pinned: true,
        delegate: SectionHeaderDelegate(
          height: 60,
          child: AppSectionHeader(
            title: 'Recent Activity',
            backgroundColor: colorScheme.surface,
            textStyle: textTheme.titleLarge,
            minHeight: 60,
          ),
        ),
      ),

      // 4. Activity List
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            child: AppCard(
              child: AppListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.secondaryContainer,
                  child: Icon(
                    Icons.person_outline,
                    color: colorScheme.onSecondaryContainer,
                  ),
                ),
                title: 'Activity ${index + 1}',
                subtitle: 'Description of this activity item',
                trailing: Text(
                  '${index + 1}h ago',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          childCount: 10,
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(bottom: AppSpacing.xxxl + AppSpacing.md),
      ),
    ],
  );
}
