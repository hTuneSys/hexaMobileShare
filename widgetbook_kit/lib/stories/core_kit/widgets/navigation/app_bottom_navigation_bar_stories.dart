// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive playground for exploring all AppBottomNavigationBar properties
/// with real-time configuration through knobs.
@widgetbook.UseCase(
  name: 'Interactive Playground',
  type: AppBottomNavigationBar,
)
Widget interactivePlayground(BuildContext context) {
  final destinationCount = context.knobs.int.slider(
    label: 'Destination Count',
    initialValue: 3,
    min: 3,
    max: 5,
  );

  final showLabels = context.knobs.boolean(
    label: 'Show Labels',
    initialValue: true,
  );

  final enableHapticFeedback = context.knobs.boolean(
    label: 'Enable Haptic Feedback',
    initialValue: true,
  );

  final height = context.knobs.doubleOrNull.slider(
    label: 'Height',
    initialValue: null,
    min: 64,
    max: 100,
  );

  final showBadges = context.knobs.boolean(
    label: 'Show Badges',
    initialValue: false,
  );

  final badgeType = context.knobs.object.dropdown(
    label: 'Badge Type',
    options: ['dot', 'count'],
    initialOption: 'count',
  );

  return _NavigationBarDemo(
    destinationCount: destinationCount,
    showLabels: showLabels,
    enableHapticFeedback: enableHapticFeedback,
    elevation: null,
    height: height,
    showBadges: showBadges,
    badgeType: badgeType,
  );
}

/// Standard 3-destination bottom navigation bar for simple apps.
@widgetbook.UseCase(name: '3 Destinations', type: AppBottomNavigationBar)
Widget threeDestinations(BuildContext context) {
  return _NavigationBarDemo(destinationCount: 3, showLabels: true);
}

/// Standard 5-destination bottom navigation bar for complex apps.
@widgetbook.UseCase(name: '5 Destinations', type: AppBottomNavigationBar)
Widget fiveDestinations(BuildContext context) {
  return _NavigationBarDemo(destinationCount: 5, showLabels: true);
}

/// Bottom navigation with count badges showing notification numbers.
@widgetbook.UseCase(name: 'With Count Badges', type: AppBottomNavigationBar)
Widget withCountBadges(BuildContext context) {
  return _NavigationBarDemo(
    destinationCount: 4,
    showLabels: true,
    showBadges: true,
    badgeType: 'count',
  );
}

/// Bottom navigation with dot badge indicators for unread/new content states.
///
/// Demonstrates Material Design 3 dot badges that:
/// - Display as small circular dots (~6dp diameter)
/// - Use Material Design 3 error color for high visibility
/// - Position near top-right of destination icon without overlap
/// - Remain visible in both selected and unselected states
/// - Maintain alignment in icon-only mode (labels hidden)
/// - Do not interfere with active indicator animations
///
/// This story shows:
/// - 5 destinations with 3 displaying dot badges
/// - Clear visual distinction between destinations with/without badges
/// - Stable badge positioning during selection changes
/// - Badge visibility across different navigation states
@widgetbook.UseCase(name: 'With Dot Badges', type: AppBottomNavigationBar)
Widget withDotBadges(BuildContext context) {
  return const _DotBadgesDemo();
}

/// Compact icon-only variant without labels for minimal UI.
@widgetbook.UseCase(name: 'Icon Only (No Labels)', type: AppBottomNavigationBar)
Widget iconOnly(BuildContext context) {
  return _NavigationBarDemo(destinationCount: 4, showLabels: false);
}

/// Bottom navigation with custom theme colors demonstrating how to customize
/// the appearance through Material Design 3 color scheme tokens.
///
/// This shows how to apply custom colors to:
/// - Surface (navigation bar background)
/// - SecondaryContainer (active indicator background)
/// - OnSecondaryContainer (selected icon and label color)
/// - OnSurfaceVariant (unselected icon and label color)
@widgetbook.UseCase(name: 'Custom Colors', type: AppBottomNavigationBar)
Widget customColors(BuildContext context) {
  // Surface color (navigation bar background)
  final surfaceColor = context.knobs.colorOrNull(
    label: 'Surface Color',
    initialValue: Colors.deepPurple.shade50,
  );

  // Secondary container color (active indicator background)
  final secondaryContainerColor = context.knobs.colorOrNull(
    label: 'Secondary Container',
    initialValue: Colors.deepPurple.shade200,
  );

  // On secondary container color (selected icon/label)
  final onSecondaryContainerColor = context.knobs.colorOrNull(
    label: 'On Secondary Container',
    initialValue: Colors.deepPurple.shade900,
  );

  // On surface variant color (unselected icon/label)
  final onSurfaceVariantColor = context.knobs.colorOrNull(
    label: 'On Surface Variant',
    initialValue: Colors.deepPurple.shade400,
  );

  final customTheme = Theme.of(context).copyWith(
    colorScheme: Theme.of(context).colorScheme.copyWith(
      surface: surfaceColor,
      secondaryContainer: secondaryContainerColor,
      onSecondaryContainer: onSecondaryContainerColor,
      onSurfaceVariant: onSurfaceVariantColor,
    ),
  );

  return Theme(
    data: customTheme,
    child: _NavigationBarDemo(destinationCount: 4, showLabels: true),
  );
}

/// Bottom navigation integrated with PageController for content switching.
@widgetbook.UseCase(name: 'With Page Controller', type: AppBottomNavigationBar)
Widget withPageController(BuildContext context) {
  return const _PageControllerDemo();
}

/// Stateful demo widget that manages navigation state and page content.
class _NavigationBarDemo extends StatefulWidget {
  const _NavigationBarDemo({
    required this.destinationCount,
    this.showLabels = true,
    this.enableHapticFeedback = true,
    this.elevation,
    this.height,
    this.showBadges = false,
    this.badgeType = 'count',
  });

  final int destinationCount;
  final bool showLabels;
  final bool enableHapticFeedback;
  final double? elevation;
  final double? height;
  final bool showBadges;
  final String badgeType;

  @override
  State<_NavigationBarDemo> createState() => _NavigationBarDemoState();
}

class _NavigationBarDemoState extends State<_NavigationBarDemo> {
  int _selectedIndex = 0;

  List<AppBottomNavigationDestination> _getDestinations() {
    final allDestinations = [
      AppBottomNavigationDestination(
        icon: const Icon(Icons.home_outlined),
        selectedIcon: const Icon(Icons.home),
        label: 'Home',
        badge: widget.showBadges && widget.badgeType == 'dot'
            ? const AppNavigationBadge.dot()
            : null,
      ),
      AppBottomNavigationDestination(
        icon: const Icon(Icons.search_outlined),
        selectedIcon: const Icon(Icons.search),
        label: 'Search',
        badge: widget.showBadges && widget.badgeType == 'dot'
            ? const AppNavigationBadge.dot()
            : null,
      ),
      AppBottomNavigationDestination(
        icon: const Icon(Icons.favorite_outline),
        selectedIcon: const Icon(Icons.favorite),
        label: 'Favorites',
        badge: widget.showBadges && widget.badgeType == 'count'
            ? const AppNavigationBadge.count(3)
            : (widget.showBadges && widget.badgeType == 'dot'
                  ? const AppNavigationBadge.dot()
                  : null),
      ),
      AppBottomNavigationDestination(
        icon: const Icon(Icons.notifications_outlined),
        selectedIcon: const Icon(Icons.notifications),
        label: 'Notifications',
        badge: widget.showBadges && widget.badgeType == 'count'
            ? const AppNavigationBadge.count(12)
            : (widget.showBadges && widget.badgeType == 'dot'
                  ? const AppNavigationBadge.dot()
                  : null),
      ),
      AppBottomNavigationDestination(
        icon: const Icon(Icons.person_outline),
        selectedIcon: const Icon(Icons.person),
        label: 'Profile',
      ),
    ];

    return allDestinations.take(widget.destinationCount).toList();
  }

  @override
  Widget build(BuildContext context) {
    final destinations = _getDestinations();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForIndex(_selectedIndex),
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              destinations[_selectedIndex].label,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Destination ${_selectedIndex + 1} of ${destinations.length}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: _selectedIndex,
        destinations: destinations,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        showLabels: widget.showLabels,
        enableHapticFeedback: widget.enableHapticFeedback,
        elevation: widget.elevation,
        height: widget.height,
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.search;
      case 2:
        return Icons.favorite;
      case 3:
        return Icons.notifications;
      case 4:
        return Icons.person;
      default:
        return Icons.circle;
    }
  }
}

/// Demo with PageController integration for smooth page transitions.
class _PageControllerDemo extends StatefulWidget {
  const _PageControllerDemo();

  @override
  State<_PageControllerDemo> createState() => _PageControllerDemoState();
}

class _PageControllerDemoState extends State<_PageControllerDemo> {
  int _selectedIndex = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildPage(context, 'Home', Icons.home, Colors.blue),
          _buildPage(context, 'Search', Icons.search, Colors.green),
          _buildPage(context, 'Library', Icons.library_music, Colors.purple),
          _buildPage(context, 'Profile', Icons.person, Colors.orange),
        ],
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: _selectedIndex,
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
            icon: Icon(Icons.library_music_outlined),
            selectedIcon: Icon(Icons.library_music),
            label: 'Library',
          ),
          AppBottomNavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildPage(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return Container(
      color: color.withValues(alpha: 0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: color),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Swipe or tap navigation to switch pages',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Demo widget specifically for showcasing dot badge indicators.
///
/// This widget demonstrates:
/// - 5 destinations where 3 have dot badges (Search, Library, Notifications)
/// - 2 destinations without badges (Home, Profile) for visual comparison
/// - Dot badges remain visible in selected and unselected states
/// - Proper badge positioning that doesn't interfere with icons or labels
/// - Stable layout during active indicator animations
class _DotBadgesDemo extends StatefulWidget {
  const _DotBadgesDemo();

  @override
  State<_DotBadgesDemo> createState() => _DotBadgesDemoState();
}

class _DotBadgesDemoState extends State<_DotBadgesDemo> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final destinations = _getDestinations();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIconForIndex(_selectedIndex),
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              destinations[_selectedIndex].label,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(
        selectedIndex: _selectedIndex,
        destinations: destinations,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  List<AppBottomNavigationDestination> _getDestinations() {
    return const [
      AppBottomNavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Home',
        // No badge - home is always current/viewed
      ),
      AppBottomNavigationDestination(
        icon: Icon(Icons.search_outlined),
        selectedIcon: Icon(Icons.search),
        label: 'Search',
        badge: AppNavigationBadge.dot(), // Dot badge: new search results
        tooltip: 'Search (new results available)',
      ),
      AppBottomNavigationDestination(
        icon: Icon(Icons.video_library_outlined),
        selectedIcon: Icon(Icons.video_library),
        label: 'Library',
        badge: AppNavigationBadge.dot(), // Dot badge: new content in library
        tooltip: 'Library (new content available)',
      ),
      AppBottomNavigationDestination(
        icon: Icon(Icons.notifications_outlined),
        selectedIcon: Icon(Icons.notifications),
        label: 'Notifications',
        badge: AppNavigationBadge.dot(), // Dot badge: unread notifications
        tooltip: 'Notifications (unread)',
      ),
      AppBottomNavigationDestination(
        icon: Icon(Icons.person_outline),
        selectedIcon: Icon(Icons.person),
        label: 'Profile',
        // No badge - profile doesn't need content indicators
      ),
    ];
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.search;
      case 2:
        return Icons.video_library;
      case 3:
        return Icons.notifications;
      case 4:
        return Icons.person;
      default:
        return Icons.circle;
    }
  }
}
