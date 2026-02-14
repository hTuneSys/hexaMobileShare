// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for the Responsive Layout system.
///
/// Demonstrates Material Design 3 responsive breakpoints, adaptive layouts,
/// and responsive utilities following the project requirements.

// =============================================================================
@widgetbook.UseCase(name: 'Interactive Playground', type: ResponsiveLayout)
Widget responsiveLayoutPlayground(BuildContext context) {
  final title = context.knobs.string(
    label: 'Dashboard Title',
    initialValue: 'Dashboard',
  );

  final baseSpacing = context.knobs.double.slider(
    label: 'Base Spacing',
    initialValue: AppSpacing.md,
    min: 8,
    max: 32,
  );

  final limitWidth = context.knobs.boolean(
    label: 'Limit Desktop Width',
    initialValue: true,
  );

  return ResponsiveBuilder(
    builder: (ctx, sizeClass) {
      final isCompact = sizeClass == WindowSizeClass.compact;
      final spacing = ctx.responsiveSpacing(baseSpacing);

      Widget content = SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppLayoutGrid.margin(sizeClass),
          vertical: ctx.responsiveSpacing(AppSpacing.lg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppH1(title),
                if (!isCompact)
                  AppChip.assist(
                    label: sizeClass.name.toUpperCase(),
                    icon: _sizeClassIcon(sizeClass),
                  ),
              ],
            ),
            VGap(spacing),
            // Adaptive Stats Grid
            ResponsiveGridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              compactColumns: 1,
              mediumColumns: 2,
              expandedColumns: 4,
              spacing: spacing,
              padding: EdgeInsets.zero,
              children: [
                _buildStatCard(ctx, 'Total Users', '1,284', Icons.people),
                _buildStatCard(ctx, 'Active Now', '542', Icons.bolt),
                _buildStatCard(ctx, 'Revenue', '\$12,4k', Icons.payments),
                _buildStatCard(ctx, 'Growth', '+12%', Icons.trending_up),
              ],
            ),
            VGap(spacing),
            // Multi-Value Demo Card
            AppCard(
              color: ctx.responsiveValue(
                compact: Theme.of(
                  ctx,
                ).colorScheme.primaryContainer.withValues(alpha: 0.2),
                medium: Theme.of(
                  ctx,
                ).colorScheme.secondaryContainer.withValues(alpha: 0.2),
                expanded: Theme.of(
                  ctx,
                ).colorScheme.tertiaryContainer.withValues(alpha: 0.2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLabel.large('System Intelligence'),
                  const VGap.xs(),
                  AppBodyText(
                    'This container uses context.responsiveValue to change its '
                    'color and context.responsiveSpacing (currently ${spacing.toStringAsFixed(1)}dp) '
                    'to manage its internal and external gaps.',
                  ),
                ],
              ),
            ),
          ],
        ),
      );

      if (limitWidth) {
        content = MaxWidthContainer.standard(child: content);
      }

      return content;
    },
  );
}

Widget _buildStatCard(
  BuildContext ctx,
  String label,
  String val,
  IconData icon,
) {
  return AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppLabel.small(
              label,
              color: Theme.of(ctx).colorScheme.onSurfaceVariant,
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(ctx).colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Theme.of(ctx).colorScheme.primary,
                size: ctx.responsiveValue(
                  compact: 16,
                  medium: 18,
                  expanded: 20,
                ),
              ),
            ),
          ],
        ),
        const VGap.xs(),
        AppH3(val),
      ],
    ),
  );
}

// =============================================================================
// Breakpoint System Demo
// =============================================================================

/// Breakpoint System — shows sizes, margins, gutters, and columns
@widgetbook.UseCase(name: 'Breakpoint System', type: ResponsiveLayout)
Widget responsiveLayoutM3Grid(BuildContext context) {
  final showOverlay = context.knobs.boolean(
    label: 'Show Grid Overlay',
    initialValue: true,
  );

  // Fixed values to strictly demonstrate the MD3 system
  return _ResponsiveGridLayout(
    showOverlay: showOverlay,
    compactItems: 2,
    mediumItems: 3,
    expandedItems: 4,
  );
}

class _ResponsiveGridLayout extends StatelessWidget {
  final bool showOverlay;
  final int compactItems;
  final int mediumItems;
  final int expandedItems;

  const _ResponsiveGridLayout({
    required this.showOverlay,
    required this.compactItems,
    required this.mediumItems,
    required this.expandedItems,
  });

  @override
  Widget build(BuildContext context) {
    final sizeClass = context.windowSizeClass;
    final margin = AppLayoutGrid.margin(sizeClass);
    final gutter = AppLayoutGrid.gutter(sizeClass);
    final columns = AppLayoutGrid.columns(sizeClass);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Content Layer
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: context.responsiveSpacing(AppSpacing.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: margin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppH3('M3 Breakpoint System'),
                    const VGap.md(),
                    _GridInfoCard(),
                  ],
                ),
              ),
              const VGap.lg(),
              ResponsiveGridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                compactColumns: compactItems,
                mediumColumns: mediumItems,
                expandedColumns: expandedItems,
                spacing: gutter,
                padding: EdgeInsets.symmetric(horizontal: margin),
                children: List.generate(
                  12,
                  (index) => _GridDemoItem(index: index),
                ),
              ),
              const Gap.xxl(),
            ],
          ),
        ),

        // Grid Overlay Layer (In-file implementation for DRY/Project Rules)
        if (showOverlay)
          IgnorePointer(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Row(
                children: List.generate(columns * 2 - 1, (index) {
                  if (index.isEven) {
                    return Expanded(
                      child: Container(
                        color: Colors.red.withValues(alpha: 0.08),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 1,
                              color: Colors.blue.withValues(alpha: 0.1),
                            ),
                            Container(
                              width: 1,
                              color: Colors.blue.withValues(alpha: 0.1),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      width: gutter,
                      color: Colors.blue.withValues(alpha: 0.05),
                    );
                  }
                }),
              ),
            ),
          ),
      ],
    );
  }
}

class _GridInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeClass = context.windowSizeClass;
    final margin = AppLayoutGrid.margin(sizeClass);
    final gutter = AppLayoutGrid.gutter(sizeClass);
    final columns = AppLayoutGrid.columns(sizeClass);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _sizeClassIcon(sizeClass),
                color: Theme.of(context).colorScheme.primary,
              ),
              const HGap.md(),
              AppLabel.large('Size Class: ${sizeClass.name.toUpperCase()}'),
            ],
          ),
          const VGap.sm(),
          AppCaption(
            text:
                'Columns: $columns | Margin: ${margin}dp | Gutter: ${gutter}dp',
          ),
        ],
      ),
    );
  }
}

class _GridDemoItem extends StatelessWidget {
  final int index;

  const _GridDemoItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      elevation: 0,
      color: Theme.of(
        context,
      ).colorScheme.primaryContainer.withValues(alpha: 0.7),
      shape: AppRadius.smShape.copyWith(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: SizedBox(
        height: 120,
        child: Center(
          child: AppLabel.large(
            'Item ${index + 1}',
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// Adaptive Navigation
// =============================================================================

/// Responsive Navigation — bottom nav (compact) → rail (medium) → drawer
/// (expanded)
@widgetbook.UseCase(name: 'Adaptive Navigation', type: ResponsiveLayout)
Widget responsiveLayoutNavigation(BuildContext context) {
  final selectedIndex = context.knobs.int.slider(
    label: 'Selected Tab',
    initialValue: 0,
    min: 0,
    max: 3,
  );

  final destinations = [
    const AppBottomNavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    const AppBottomNavigationDestination(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    const AppBottomNavigationDestination(
      icon: Icon(Icons.notifications),
      label: 'Alerts',
    ),
    const AppBottomNavigationDestination(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  final drawerDestinations = [
    const AppDrawerDestination(icon: Icons.home, label: 'Home'),
    const AppDrawerDestination(icon: Icons.search, label: 'Search'),
    const AppDrawerDestination(icon: Icons.notifications, label: 'Alerts'),
    const AppDrawerDestination(icon: Icons.person, label: 'Profile'),
  ];

  final railDestinations = destinations
      .map((d) => NavigationRailDestination(icon: d.icon, label: Text(d.label)))
      .toList();

  // (Drawer items used directly in AppDrawer via destinations)

  Widget content(String label) {
    return Center(
      child: AppCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppH2(label),
            const VGap.sm(),
            ResponsiveBuilder(
              builder: (ctx, sizeClass) =>
                  AppBodyText('Navigation: ${_navType(sizeClass)}'),
            ),
          ],
        ),
      ),
    );
  }

  return ResponsiveLayout(
    // Compact: bottom navigation bar
    compact: CoreScaffold(
      body: content('Bottom Navigation (Compact)'),
      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (idx) => {},
        destinations: destinations,
      ),
    ),
    // Medium: navigation rail
    medium: CoreScaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            destinations: railDestinations,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: content('Navigation Rail (Medium)')),
        ],
      ),
    ),
    // Expanded: navigation drawer
    expanded: CoreScaffold(
      body: Row(
        children: [
          AppDrawer(
            selectedIndex: selectedIndex,
            destinations: drawerDestinations,
            onDestinationSelected: (idx) => {},
            header: const AppDrawerHeader(
              name: 'Menu',
              email: 'MD3 Navigation',
            ),
          ),
          Expanded(child: content('Navigation Drawer (Expanded)')),
        ],
      ),
    ),
  );
}

// =============================================================================
// Adaptive Column Layout
// =============================================================================

/// Adaptive Column Layout — 1/2/3 columns switching
@widgetbook.UseCase(name: 'Adaptive Column Layout', type: ResponsiveLayout)
Widget responsiveLayoutColumns(BuildContext context) {
  final itemCount = context.knobs.int.slider(
    label: 'Item Count',
    initialValue: 6,
    min: 1,
    max: 12,
  );

  Widget buildItem(int index) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCard(
            elevation: 0,
            color: Colors.primaries[index % Colors.primaries.length].withValues(
              alpha: 0.3,
            ),
            shape: AppRadius.xsShape,
            child: SizedBox(
              height: 80,
              child: Center(child: AppLabel.large('Item ${index + 1}')),
            ),
          ),
          const VGap.sm(),
          AppCaption(text: 'Content card ${index + 1}'),
        ],
      ),
    );
  }

  final items = List.generate(itemCount, buildItem);

  return SingleChildScrollView(
    padding: EdgeInsets.all(AppSpacing.md),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ResponsiveBuilder(
          builder: (ctx, sizeClass) {
            final columns = switch (sizeClass) {
              WindowSizeClass.compact => 1,
              WindowSizeClass.medium => 2,
              _ => 3,
            };
            return AppCard(
              child: AppBodyText(
                'Layout: $columns column(s) | '
                '${sizeClass.name.toUpperCase()}',
              ),
            );
          },
        ),
        const VGap.md(),
        ResponsiveLayout(
          // 1 column on compact
          compact: Column(
            children: items
                .map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: AppSpacing.sm),
                    child: item,
                  ),
                )
                .toList(),
          ),
          // 2 columns on medium
          medium: Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: items
                .map(
                  (item) => SizedBox(
                    width:
                        (MediaQuery.sizeOf(context).width - AppSpacing.md * 3) /
                        2,
                    child: item,
                  ),
                )
                .toList(),
          ),
          // 3 columns on expanded
          expanded: Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: items
                .map(
                  (item) => SizedBox(
                    width:
                        (MediaQuery.sizeOf(context).width - AppSpacing.md * 4) /
                        3,
                    child: item,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// Responsive Grid
// =============================================================================

/// Responsive Grid — ResponsiveGridView 2/3/4 columns with knobs
@widgetbook.UseCase(name: 'Responsive Grid', type: ResponsiveLayout)
Widget responsiveLayoutGrid(BuildContext context) {
  final compactCols = context.knobs.int.slider(
    label: 'Compact Columns',
    initialValue: 2,
    min: 1,
    max: 4,
  );

  final mediumCols = context.knobs.int.slider(
    label: 'Medium Columns',
    initialValue: 3,
    min: 1,
    max: 6,
  );

  final expandedCols = context.knobs.int.slider(
    label: 'Expanded Columns',
    initialValue: 4,
    min: 1,
    max: 8,
  );

  final itemCount = context.knobs.int.slider(
    label: 'Item Count',
    initialValue: 12,
    min: 1,
    max: 24,
  );

  final spacingValue = context.knobs.double.slider(
    label: 'Spacing',
    initialValue: AppSpacing.md,
    min: 0,
    max: 32,
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.all(AppSpacing.md),
        child: ResponsiveBuilder(
          builder: (ctx, sizeClass) {
            final columns = switch (sizeClass) {
              WindowSizeClass.compact => compactCols,
              WindowSizeClass.medium => mediumCols,
              _ => expandedCols,
            };
            return AppCard(
              child: AppBodyText(
                'Grid: $columns columns | '
                'Spacing: ${spacingValue.toStringAsFixed(0)}dp | '
                '${sizeClass.name}',
              ),
            );
          },
        ),
      ),
      Expanded(
        child: ResponsiveGridView(
          compactColumns: compactCols,
          mediumColumns: mediumCols,
          expandedColumns: expandedCols,
          spacing: spacingValue,
          padding: EdgeInsets.all(AppSpacing.md),
          children: List.generate(
            itemCount,
            (i) => AppCard(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.grid_view,
                    size: ResponsiveIconSize.resolve(context),
                    color: Colors.primaries[i % Colors.primaries.length],
                  ),
                  const VGap.xs(),
                  AppCaption(text: 'Item ${i + 1}'),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// =============================================================================
// Orientation-Aware Layout
// =============================================================================

/// Orientation-Aware Layout — portrait vs landscape switching
@widgetbook.UseCase(name: 'Orientation Awareness', type: ResponsiveLayout)
Widget responsiveLayoutOrientation(BuildContext context) {
  return AppOrientationBuilder(
    builder: (ctx, orientation, sizeClass) {
      final isLand = orientation == Orientation.landscape;

      return SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              child: Row(
                children: [
                  Icon(
                    isLand
                        ? Icons.stay_current_landscape
                        : Icons.stay_current_portrait,
                    size: ResponsiveIconSize.resolve(ctx),
                  ),
                  const HGap.md(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppLabel.large(isLand ? 'Landscape' : 'Portrait'),
                      AppCaption(
                        text:
                            'Window: ${sizeClass.name} | '
                            '${MediaQuery.sizeOf(ctx).width.toStringAsFixed(0)}x'
                            '${MediaQuery.sizeOf(ctx).height.toStringAsFixed(0)}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const VGap.lg(),
            if (isLand)
              // Landscape: side-by-side layout
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppCard(
                      child: Column(
                        children: [
                          const AppLabel.large('Left Panel'),
                          const VGap.sm(),
                          const AppCaption(
                            text: 'Landscape mode uses side-by-side panels',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const HGap.md(),
                  Expanded(
                    child: AppCard(
                      child: Column(
                        children: [
                          const AppLabel.large('Right Panel'),
                          const VGap.sm(),
                          const AppCaption(
                            text: 'Content spreads horizontally',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            else
              // Portrait: stacked layout
              Column(
                children: [
                  AppCard(
                    child: Column(
                      children: [
                        const AppLabel.large('Top Section'),
                        const VGap.sm(),
                        const AppCaption(
                          text: 'Portrait mode stacks content vertically',
                        ),
                      ],
                    ),
                  ),
                  const VGap.md(),
                  AppCard(
                    child: Column(
                      children: [
                        const AppLabel.large('Bottom Section'),
                        const VGap.sm(),
                        AppCaption(
                          text: 'Content stacks vertically for readability',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    },
  );
}

// =============================================================================
// Constrained Width Layout
// =============================================================================

/// Constrained Width Layout — MaxWidthContainer + PageContainer
@widgetbook.UseCase(name: 'Content Constraint', type: ResponsiveLayout)
Widget responsiveLayoutConstrained(BuildContext context) {
  final containerType = context.knobs.object.dropdown(
    label: 'Container Type',
    options: const ['default', 'narrow', 'standard', 'custom'],
    labelBuilder: (value) => value,
  );

  final customMaxWidth = context.knobs.double.slider(
    label: 'Custom Max Width',
    initialValue: 1000,
    min: 300,
    max: 1600,
  );

  final centerContent = context.knobs.boolean(
    label: 'Center Content',
    initialValue: true,
  );

  Widget content = Builder(
    builder: (ctx) {
      final width = MediaQuery.sizeOf(ctx).width;
      return SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLabel.large('Constrained Content'),
                  const VGap.sm(),
                  AppCaption(
                    text: 'Screen width: ${width.toStringAsFixed(0)}dp',
                  ),
                  AppCaption(
                    text:
                        'Container: $containerType | '
                        'Centered: $centerContent',
                  ),
                ],
              ),
            ),
            const VGap.md(),
            AppCard(
              color: Theme.of(
                ctx,
              ).colorScheme.primaryContainer.withValues(alpha: 0.5),
              elevation: 0,
              shape: AppRadius.smShape,
              child: const SizedBox(
                height: 100,
                child: Center(child: AppBodyText('Fills container width')),
              ),
            ),
            const VGap.md(),
            Row(
              children: List.generate(
                3,
                (i) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                    child: AppCard(
                      child: Center(child: AppBodyText('Column ${i + 1}')),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  switch (containerType) {
    case 'narrow':
      return MaxWidthContainer.narrow(center: centerContent, child: content);
    case 'standard':
      return MaxWidthContainer.standard(center: centerContent, child: content);
    case 'custom':
      return MaxWidthContainer(
        maxWidth: customMaxWidth,
        center: centerContent,
        child: content,
      );
    default:
      return MaxWidthContainer(center: centerContent, child: content);
  }
}

// =============================================================================
// Responsive Typography
// =============================================================================

/// Responsive Typography — text scaling demo
@widgetbook.UseCase(name: 'Responsive Typography', type: ResponsiveLayout)
Widget responsiveLayoutTypography(BuildContext context) {
  return ResponsiveBuilder(
    builder: (ctx, sizeClass) {
      final theme = Theme.of(ctx);

      return SingleChildScrollView(
        padding: EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              child: AppBodyText(
                'Window: ${sizeClass.name} | '
                'Width: ${MediaQuery.sizeOf(ctx).width.toStringAsFixed(0)}dp',
              ),
            ),
            const VGap.lg(),
            Text(
              'Display Large',
              style: theme.responsiveTextStyle(
                ctx,
                theme.textTheme.displayLarge,
              ),
            ),
            const VGap.md(),
            Text(
              'Headline Medium',
              style: theme.responsiveTextStyle(
                ctx,
                theme.textTheme.headlineMedium,
              ),
            ),
            const VGap.md(),
            Text(
              'Title Large',
              style: theme.responsiveTextStyle(ctx, theme.textTheme.titleLarge),
            ),
            const VGap.md(),
            Text(
              'Body Large — Lorem ipsum dolor sit amet, consectetur '
              'adipiscing elit. Sed do eiusmod tempor incididunt.',
              style: theme.responsiveTextStyle(ctx, theme.textTheme.bodyLarge),
            ),
            const VGap.md(),
            Text(
              'Body Medium — Lorem ipsum dolor sit amet, consectetur '
              'adipiscing elit.',
              style: theme.responsiveTextStyle(ctx, theme.textTheme.bodyMedium),
            ),
            const VGap.md(),
            Text(
              'Label Small',
              style: theme.responsiveTextStyle(ctx, theme.textTheme.labelSmall),
            ),
            const VGap.lg(),
            // Scale factor info
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppLabel.large('Scale Factors'),
                  const VGap.sm(),
                  const AppCaption(
                    text:
                        'Compact: 0.9x | Medium: 1.0x | '
                        'Expanded: 1.0x | Large: 1.1x',
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

// =============================================================================
// Helpers (private)
// =============================================================================

// =============================================================================
// Helpers (private)
// =============================================================================

String _navType(WindowSizeClass sizeClass) {
  return switch (sizeClass) {
    WindowSizeClass.compact => 'Bottom Bar',
    WindowSizeClass.medium => 'Navigation Rail',
    _ => 'Navigation Drawer',
  };
}

IconData _sizeClassIcon(WindowSizeClass sizeClass) {
  return switch (sizeClass) {
    WindowSizeClass.compact => Icons.smartphone,
    WindowSizeClass.medium => Icons.tablet,
    WindowSizeClass.expanded => Icons.tablet_mac,
    WindowSizeClass.large => Icons.desktop_windows,
    WindowSizeClass.extraLarge => Icons.tv,
  };
}
