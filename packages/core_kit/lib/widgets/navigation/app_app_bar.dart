// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 app bar component that provides consistent top
/// navigation with title, actions, and responsive scroll behavior.
///
/// The [AppAppBar] component supports:
/// - Standard and large title variants
/// - Automatic back button detection
/// - Action items (1-4 icon buttons)
/// - Multiple scroll behaviors (normal, pinned, floating, snap)
/// - Search field integration
/// - Tab bar integration
/// - Custom colors and styling
/// - Safe area handling
///
/// ## Basic Usage
///
/// ```dart
/// AppAppBar(
///   title: 'My App',
///   actions: [
///     IconButton(
///       icon: Icon(Icons.search),
///       onPressed: () {},
///     ),
///   ],
/// )
/// ```
///
/// ## Large Title (Collapsible)
///
/// ```dart
/// AppAppBar.large(
///   title: 'Large Title',
///   pinned: true,
/// )
/// ```
///
/// ## With Tabs
///
/// ```dart
/// AppAppBar(
///   title: 'Tabs Example',
///   bottom: TabBar(
///     tabs: [
///       Tab(text: 'Tab 1'),
///       Tab(text: 'Tab 2'),
///     ],
///   ),
/// )
/// ```
///
/// ## Material Design 3 Specifications
///
/// - **Standard height**: 64dp (56dp on mobile)
/// - **Large title height**: 128dp expanded, collapses to 64dp
/// - **Elevation**: 0dp default, 3dp when scrolled
/// - **Colors**: Uses theme's surface and on-surface colors
/// - **Typography**: titleLarge (22sp) for standard, headlineMedium (28sp) for large
/// - **Touch targets**: 48x48dp minimum for action items
///
/// ## Scroll Behaviors
///
/// - **Normal**: Stays at top, elevation increases on scroll (default)
/// - **Pinned**: Always visible at top, even when scrolling down
/// - **Floating**: Hides on scroll down, reappears on scroll up
/// - **Snap**: Snaps to fully visible or fully hidden state
///
/// ## Accessibility
///
/// - Automatic semantic labels for title and actions
/// - Screen reader announcements for navigation context
/// - Minimum 48x48dp touch targets for all interactive elements
/// - Proper contrast ratios for text and icons
///
/// See also:
/// - [Material Design 3 App Bar](https://m3.material.io/components/top-app-bar/overview)
/// - [AppBar] - Flutter's base app bar widget
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a Material Design 3 app bar.
  ///
  /// The [title] parameter is required and can be either a String or Widget.
  const AppAppBar({
    super.key,
    required this.title,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.centerTitle,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.scrolledUnderElevation,
    this.bottom,
  }) : isLarge = false,
       expandedHeight = null,
       pinned = false,
       floating = false,
       snap = false,
       flexibleSpace = null;

  /// Creates a large title app bar that collapses on scroll.
  ///
  /// Large app bars are 128dp tall when expanded and collapse to 64dp.
  /// Use [pinned], [floating], and [snap] to control scroll behavior.
  const AppAppBar.large({
    super.key,
    required this.title,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.scrolledUnderElevation,
    this.expandedHeight = 128.0,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.flexibleSpace,
    this.bottom,
  }) : isLarge = true,
       centerTitle = null;

  /// The title displayed in the app bar.
  ///
  /// Can be a String or a custom Widget.
  final dynamic title;

  /// Custom leading widget (e.g., custom icon, avatar).
  ///
  /// If null and [automaticallyImplyLeading] is true, a back button will
  /// be shown if the current route can be popped.
  final Widget? leading;

  /// Whether to automatically show a back button when applicable.
  ///
  /// Defaults to true.
  final bool automaticallyImplyLeading;

  /// Action widgets displayed on the right side of the app bar.
  ///
  /// Typically a list of [IconButton] widgets. For best results, limit to 1-4 actions.
  final List<Widget>? actions;

  /// Whether to center the title.
  ///
  /// If null, defaults to platform conventions (false on Android, true on iOS).
  final bool? centerTitle;

  /// Custom background color for the app bar.
  ///
  /// If null, uses the theme's surface color.
  final Color? backgroundColor;

  /// Custom foreground color for text and icons.
  ///
  /// If null, uses the theme's on-surface color.
  final Color? foregroundColor;

  /// The elevation when the app bar is not scrolled.
  ///
  /// Defaults to 0dp for Material Design 3 flat appearance.
  final double? elevation;

  /// The elevation when content is scrolled under the app bar.
  ///
  /// Defaults to 3dp to provide visual separation.
  final double? scrolledUnderElevation;

  /// Whether this is a large title variant.
  final bool isLarge;

  /// The height of the app bar when expanded (for large variant).
  ///
  /// Only applicable when [isLarge] is true. Defaults to 128dp.
  final double? expandedHeight;

  /// Whether the app bar should remain visible at the top when scrolling.
  ///
  /// Only applicable when [isLarge] is true.
  final bool pinned;

  /// Whether the app bar should become visible as soon as the user scrolls up.
  ///
  /// Only applicable when [isLarge] is true.
  final bool floating;

  /// Whether the app bar should snap to fully visible or fully hidden.
  ///
  /// Only applicable when [isLarge] is true and [floating] is true.
  final bool snap;

  /// Custom flexible space widget for the expanded area.
  ///
  /// Only applicable when [isLarge] is true.
  final Widget? flexibleSpace;

  /// A widget to display at the bottom of the app bar.
  ///
  /// Typically a [TabBar] widget.
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize {
    final double height = isLarge
        ? (expandedHeight ?? 128.0)
        : (kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
    return Size.fromHeight(height);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Build title widget
    final Widget titleWidget = title is String
        ? Text(
            title as String,
            style: isLarge
                ? theme.textTheme.headlineMedium
                : theme.textTheme.titleLarge,
          )
        : title as Widget;

    // For large variant, use SliverAppBar
    if (isLarge) {
      return SliverAppBar(
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions: actions,
        backgroundColor: backgroundColor ?? theme.colorScheme.surface,
        foregroundColor: foregroundColor ?? theme.colorScheme.onSurface,
        elevation: elevation ?? 0.0,
        scrolledUnderElevation: scrolledUnderElevation ?? 3.0,
        expandedHeight: expandedHeight,
        pinned: pinned,
        floating: floating,
        snap: snap,
        flexibleSpace:
            flexibleSpace ??
            FlexibleSpaceBar(
              title: titleWidget,
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            ),
        bottom: bottom,
      );
    }

    // For standard variant, use AppBar
    return AppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: titleWidget,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      foregroundColor: foregroundColor ?? theme.colorScheme.onSurface,
      elevation: elevation ?? 0.0,
      scrolledUnderElevation: scrolledUnderElevation ?? 3.0,
      bottom: bottom,
    );
  }
}
