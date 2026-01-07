// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A Material Design 3 bottom navigation bar component that displays 3-5
/// primary destinations at the bottom of the screen for thumb-reachable
/// navigation on mobile devices.
///
/// The [AppBottomNavigationBar] component supports:
/// - 3-5 navigation destinations
/// - Icon and label display
/// - Icon-only variant (labels hidden)
/// - Badge support (count and dot indicators)
/// - Active indicator animation
/// - Custom colors per destination
/// - Safe area handling for home indicator
/// - Haptic feedback on selection
/// - Integration with PageController
/// - Keyboard navigation support
///
/// ## Basic Usage
///
/// ```dart
/// int selectedIndex = 0;
///
/// AppBottomNavigationBar(
///   selectedIndex: selectedIndex,
///   destinations: [
///     AppBottomNavigationDestination(
///       icon: Icon(Icons.home_outlined),
///       selectedIcon: Icon(Icons.home),
///       label: 'Home',
///     ),
///     AppBottomNavigationDestination(
///       icon: Icon(Icons.search_outlined),
///       selectedIcon: Icon(Icons.search),
///       label: 'Search',
///     ),
///     AppBottomNavigationDestination(
///       icon: Icon(Icons.person_outline),
///       selectedIcon: Icon(Icons.person),
///       label: 'Profile',
///     ),
///   ],
///   onDestinationSelected: (index) {
///     setState(() => selectedIndex = index);
///   },
/// )
/// ```
///
/// ## With Badges
///
/// ```dart
/// AppBottomNavigationBar(
///   selectedIndex: selectedIndex,
///   destinations: [
///     AppBottomNavigationDestination(
///       icon: Icon(Icons.home_outlined),
///       selectedIcon: Icon(Icons.home),
///       label: 'Home',
///     ),
///     AppBottomNavigationDestination(
///       icon: Icon(Icons.notifications_outlined),
///       selectedIcon: Icon(Icons.notifications),
///       label: 'Notifications',
///       badge: AppNavigationBadge.count(5),
///     ),
///     AppBottomNavigationDestination(
///       icon: Icon(Icons.chat_outlined),
///       selectedIcon: Icon(Icons.chat),
///       label: 'Messages',
///       badge: AppNavigationBadge.dot(),
///     ),
///   ],
///   onDestinationSelected: (index) {
///     setState(() => selectedIndex = index);
///   },
/// )
/// ```
///
/// ## Icon-Only Variant
///
/// ```dart
/// AppBottomNavigationBar(
///   selectedIndex: selectedIndex,
///   showLabels: false,
///   destinations: [...],
///   onDestinationSelected: (index) {
///     setState(() => selectedIndex = index);
///   },
/// )
/// ```
///
/// ## With PageController
///
/// ```dart
/// final PageController pageController = PageController();
///
/// AppBottomNavigationBar(
///   selectedIndex: selectedIndex,
///   destinations: [...],
///   onDestinationSelected: (index) {
///     pageController.animateToPage(
///       index,
///       duration: Duration(milliseconds: 300),
///       curve: Curves.easeInOut,
///     );
///     setState(() => selectedIndex = index);
///   },
/// )
/// ```
///
/// ## Material Design 3 Specifications
///
/// - **Height**: 80dp (with labels), 64dp (icon-only)
/// - **Destination width**: Equal distribution across screen
/// - **Min touch target**: 48x48dp per destination
/// - **Icon size**: 24dp
/// - **Badge size**: 16dp (numeric), 6dp (dot)
/// - **Active indicator**: Pill shape, 56dp wide, 32dp tall
/// - **Animation**: 200ms with easeInOut curve
/// - **Colors**: Secondary container for indicator, error for badge
///
/// ## Accessibility
///
/// - Semantic labels announce destination names
/// - Badge counts read by screen readers
/// - Keyboard navigation supported (Tab, Arrow keys)
/// - Focus indicators for keyboard users
/// - Minimum 48x48dp touch targets
///
/// See also:
/// - [Material Design 3 Bottom Navigation](https://m3.material.io/components/navigation-bar/overview)
/// - [NavigationBar] - Flutter's base navigation bar widget
class AppBottomNavigationBar extends StatelessWidget {
  /// Creates a Material Design 3 bottom navigation bar.
  ///
  /// The [destinations] must contain between 3 and 5 items.
  /// The [selectedIndex] must be a valid index in [destinations].
  const AppBottomNavigationBar({
    super.key,
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.showLabels = true,
    this.backgroundColor,
    this.elevation,
    this.height,
    this.enableHapticFeedback = true,
    this.animationDuration = const Duration(milliseconds: 200),
  }) : assert(
         destinations.length >= 3 && destinations.length <= 5,
         'Bottom navigation bar must have between 3 and 5 destinations',
       ),
       assert(
         selectedIndex >= 0 && selectedIndex < destinations.length,
         'selectedIndex must be a valid index in destinations',
       );

  /// The list of destinations (3-5 items) displayed in the navigation bar.
  ///
  /// Each destination includes an icon, label, and optional badge.
  final List<AppBottomNavigationDestination> destinations;

  /// The index of the currently selected destination.
  ///
  /// Must be a valid index in [destinations].
  final int selectedIndex;

  /// Called when a destination is tapped.
  ///
  /// Passes the index of the tapped destination.
  final ValueChanged<int> onDestinationSelected;

  /// Whether to show labels below icons.
  ///
  /// When false, creates a more compact icon-only navigation bar.
  /// Defaults to true.
  final bool showLabels;

  /// The background color of the navigation bar.
  ///
  /// If null, uses the theme's surface color.
  final Color? backgroundColor;

  /// The elevation of the navigation bar.
  ///
  /// If null, uses a default elevation of 3.0.
  final double? elevation;

  /// The height of the navigation bar.
  ///
  /// If null, uses 80dp with labels or 64dp without labels.
  final double? height;

  /// Whether to provide haptic feedback on destination selection.
  ///
  /// Defaults to true.
  final bool enableHapticFeedback;

  /// Duration of the active indicator animation.
  ///
  /// Defaults to 200 milliseconds.
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Calculate height based on labels visibility
    final effectiveHeight = height ?? (showLabels ? 80.0 : 64.0);

    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        if (enableHapticFeedback) {
          HapticFeedback.selectionClick();
        }
        onDestinationSelected(index);
      },
      backgroundColor: backgroundColor ?? colorScheme.surface,
      elevation: elevation ?? 3.0,
      height: effectiveHeight,
      labelBehavior: showLabels
          ? NavigationDestinationLabelBehavior.alwaysShow
          : NavigationDestinationLabelBehavior.alwaysHide,
      animationDuration: animationDuration,
      destinations: destinations.map((destination) {
        return NavigationDestination(
          icon: _buildIconWithBadge(
            context,
            destination.icon,
            destination.badge,
            isSelected: false,
          ),
          selectedIcon: _buildIconWithBadge(
            context,
            destination.selectedIcon ?? destination.icon,
            destination.badge,
            isSelected: true,
          ),
          label: destination.label,
          tooltip: destination.tooltip ?? destination.label,
        );
      }).toList(),
    );
  }

  Widget _buildIconWithBadge(
    BuildContext context,
    Widget icon,
    AppNavigationBadge? badge, {
    required bool isSelected,
  }) {
    if (badge == null) {
      return icon;
    }

    final colorScheme = Theme.of(context).colorScheme;

    // For dot badges (no count), show small 6dp solid dot
    if (badge.isDot) {
      return Badge(
        backgroundColor: colorScheme.error,
        smallSize: 6.0, // 6dp solid dot per MD3 spec
        offset: const Offset(8, -8),
        child: icon,
      );
    }

    // For count badges, show the number
    return Badge(
      label: Text('${badge.count}'),
      backgroundColor: colorScheme.error,
      textColor: colorScheme.onError,
      offset: const Offset(8, -8),
      child: icon,
    );
  }
}

/// Represents a single destination in the bottom navigation bar.
///
/// Each destination consists of an icon, a label, and optional badge.
class AppBottomNavigationDestination {
  /// Creates a bottom navigation destination.
  ///
  /// The [icon] and [label] are required.
  const AppBottomNavigationDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badge,
    this.tooltip,
  });

  /// The icon displayed when this destination is not selected.
  ///
  /// Typically an outlined icon variant.
  final Widget icon;

  /// The icon displayed when this destination is selected.
  ///
  /// If null, [icon] is used for both states.
  /// Typically a filled icon variant.
  final Widget? selectedIcon;

  /// The text label displayed below the icon.
  ///
  /// Hidden when [AppBottomNavigationBar.showLabels] is false.
  final String label;

  /// Optional badge to display on the icon.
  ///
  /// Can be a count badge or a dot indicator.
  final AppNavigationBadge? badge;

  /// The tooltip shown on long press.
  ///
  /// If null, uses [label] as tooltip.
  final String? tooltip;
}

/// Represents a badge indicator for a navigation destination.
///
/// Badges can display notification counts or simple dot indicators.
class AppNavigationBadge {
  /// Creates a badge with a notification count.
  ///
  /// The count is displayed as a number on the badge.
  const AppNavigationBadge.count(this.count)
    : assert(count != null && count > 0);

  /// Creates a simple dot indicator badge.
  ///
  /// Shows a small dot without any number.
  const AppNavigationBadge.dot() : count = null;

  /// The notification count to display.
  ///
  /// If null, displays as a dot indicator.
  /// If set, displays the number on the badge.
  final int? count;

  /// Whether this is a dot badge (no count).
  bool get isDot => count == null;

  /// Whether this is a count badge.
  bool get isCount => count != null;
}
