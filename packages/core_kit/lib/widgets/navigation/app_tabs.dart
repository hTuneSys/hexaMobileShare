// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Defines the visual style of the tab indicator.
enum AppTabIndicatorStyle {
  /// Underline indicator (2dp height, 3dp below content).
  underline,

  /// Pill indicator (full tab height, rounded background).
  pill,
}

/// Defines the content type displayed in tabs.
enum AppTabVariant {
  /// Text-only tabs.
  textOnly,

  /// Icon-only tabs.
  iconOnly,

  /// Icon and text tabs.
  iconAndText,
}

/// Represents a single tab item with optional icon, label, and badge.
class AppTabItem {
  /// Creates an [AppTabItem].
  const AppTabItem({
    required this.label,
    this.icon,
    this.badgeCount = 0,
    this.semanticLabel,
  });

  /// The text label displayed on the tab.
  final String label;

  /// Optional icon displayed on the tab.
  final IconData? icon;

  /// Badge count displayed on the tab (0 means no badge).
  final int badgeCount;

  /// Optional semantic label for accessibility.
  final String? semanticLabel;
}

/// A Material Design 3 tab bar component for horizontal navigation.
///
/// AppTabs provides tab-based navigation between related content sections
/// following Material Design 3 specifications.
///
/// Example usage:
/// ```dart
/// AppTabs(
///   tabs: [
///     AppTabItem(label: 'Today', icon: Icons.today),
///     AppTabItem(label: 'Week', icon: Icons.date_range),
///     AppTabItem(label: 'Month', icon: Icons.calendar_month),
///   ],
///   onTabSelected: (index) {
///     print('Selected tab: $index');
///   },
/// )
/// ```
class AppTabs extends StatefulWidget {
  /// Creates an [AppTabs] widget.
  const AppTabs({
    required this.tabs,
    this.selectedIndex = 0,
    this.onTabSelected,
    this.variant = AppTabVariant.iconAndText,
    this.indicatorStyle = AppTabIndicatorStyle.underline,
    this.indicatorColor,
    this.isScrollable = false,
    this.controller,
    super.key,
  }) : assert(
         isScrollable
             ? tabs.length >= 2
             : (tabs.length >= 2 && tabs.length <= 6),
         isScrollable
             ? 'AppTabs must have at least 2 tabs'
             : 'AppTabs must have between 2 and 6 tabs',
       ),
       assert(
         selectedIndex >= 0 && selectedIndex < tabs.length,
         'selectedIndex must be within tabs range',
       );

  /// List of tab items to display.
  final List<AppTabItem> tabs;

  /// Currently selected tab index.
  final int selectedIndex;

  /// Callback fired when a tab is selected.
  final ValueChanged<int>? onTabSelected;

  /// Visual variant of the tabs.
  final AppTabVariant variant;

  /// Style of the tab indicator.
  final AppTabIndicatorStyle indicatorStyle;

  /// Custom color for the indicator. Defaults to primary color.
  final Color? indicatorColor;

  /// Whether tabs should scroll horizontally when they overflow.
  ///
  /// If false, tabs will have equal width distribution.
  final bool isScrollable;

  /// Optional [TabController] for external control.
  final TabController? controller;

  @override
  State<AppTabs> createState() => _AppTabsState();
}

class _AppTabsState extends State<AppTabs> with SingleTickerProviderStateMixin {
  late TabController _controller;
  bool _isInternalController = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void didUpdateWidget(AppTabs oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle tab count changes
    if (oldWidget.tabs.length != widget.tabs.length ||
        oldWidget.controller != widget.controller) {
      _disposeInternalController();
      _initializeController();
    } else if (oldWidget.selectedIndex != widget.selectedIndex) {
      // Update selected index
      _controller.animateTo(widget.selectedIndex);
    }
  }

  @override
  void dispose() {
    _disposeInternalController();
    super.dispose();
  }

  void _initializeController() {
    if (widget.controller != null) {
      _controller = widget.controller!;
      _isInternalController = false;
    } else {
      _controller = TabController(
        length: widget.tabs.length,
        vsync: this,
        initialIndex: widget.selectedIndex,
      );
      _isInternalController = true;
    }

    _controller.addListener(_handleTabSelection);
  }

  void _disposeInternalController() {
    _controller.removeListener(_handleTabSelection);
    if (_isInternalController) {
      _controller.dispose();
    }
  }

  void _handleTabSelection() {
    if (_controller.indexIsChanging) {
      widget.onTabSelected?.call(_controller.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: TabBar(
        controller: _controller,
        isScrollable: widget.isScrollable,
        tabAlignment: widget.isScrollable ? TabAlignment.start : null,
        indicatorColor: widget.indicatorColor ?? colorScheme.primary,
        indicatorWeight: widget.indicatorStyle == AppTabIndicatorStyle.underline
            ? 2.0
            : 0.0,
        indicator: widget.indicatorStyle == AppTabIndicatorStyle.pill
            ? BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(100),
              )
            : null,
        labelColor: colorScheme.primary,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        labelStyle: theme.textTheme.titleSmall,
        unselectedLabelStyle: theme.textTheme.titleSmall,
        dividerColor: Colors.transparent,
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return colorScheme.primary.withValues(alpha: 0.12);
          }
          if (states.contains(WidgetState.hovered)) {
            return colorScheme.primary.withValues(alpha: 0.08);
          }
          if (states.contains(WidgetState.focused)) {
            return colorScheme.primary.withValues(alpha: 0.12);
          }
          return null;
        }),
        tabs: widget.tabs.map((tabItem) {
          return _buildTab(context, tabItem);
        }).toList(),
      ),
    );
  }

  Widget _buildTab(BuildContext context, AppTabItem tabItem) {
    final theme = Theme.of(context);

    Widget content;

    switch (widget.variant) {
      case AppTabVariant.textOnly:
        content = Text(tabItem.label);
        break;

      case AppTabVariant.iconOnly:
        content = Icon(tabItem.icon ?? Icons.tab, size: 24);
        break;

      case AppTabVariant.iconAndText:
        content = Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tabItem.icon ?? Icons.tab, size: 24),
            const SizedBox(height: 8),
            Text(tabItem.label),
          ],
        );
        break;
    }

    // Add badge if count > 0
    if (tabItem.badgeCount > 0) {
      content = Stack(
        clipBehavior: Clip.none,
        children: [
          content,
          Positioned(
            right: -8,
            top: -4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.error,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
              child: Center(
                child: Text(
                  tabItem.badgeCount > 99 ? '99+' : '${tabItem.badgeCount}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onError,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Wrap in semantic container
    return Semantics(
      label: tabItem.semanticLabel ?? tabItem.label,
      button: true,
      selected: _controller.index == widget.tabs.indexOf(tabItem),
      child: ExcludeSemantics(
        child: Tab(
          height: _getTabHeight(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: content,
          ),
        ),
      ),
    );
  }

  double _getTabHeight() {
    switch (widget.variant) {
      case AppTabVariant.textOnly:
        return 48;
      case AppTabVariant.iconOnly:
        return 48;
      case AppTabVariant.iconAndText:
        return 64;
    }
  }
}
