// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A Material Design 3 scaffold wrapper that provides consistent app-wide
/// defaults for layout structure, theming, and safe area handling.
///
/// [CoreScaffold] wraps Flutter's [Scaffold] widget with pre-configured
/// defaults following Material Design 3 guidelines, reducing boilerplate
/// and ensuring visual consistency across all app screens.
///
/// ## Features
///
/// - **Consistent Theming**: Automatically applies MD3 surface colors
/// - **Safe Area Handling**: Optional safe area padding for body content
/// - **Full Scaffold Support**: All [Scaffold] properties are exposed
/// - **Centralized Configuration**: Change scaffold behavior app-wide
///
/// ## Basic Usage
///
/// ```dart
/// CoreScaffold(
///   body: Center(
///     child: Text('Hello World'),
///   ),
/// )
/// ```
///
/// ## With App Bar
///
/// ```dart
/// CoreScaffold(
///   appBar: AppAppBar(title: 'My Screen'),
///   body: ListView.builder(
///     itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
///   ),
/// )
/// ```
///
/// ## With Bottom Navigation
///
/// ```dart
/// CoreScaffold(
///   body: _pages[_selectedIndex],
///   bottomNavigationBar: AppBottomNavigationBar(
///     selectedIndex: _selectedIndex,
///     destinations: [...],
///     onDestinationSelected: (index) => setState(() => _selectedIndex = index),
///   ),
/// )
/// ```
///
/// ## With FAB
///
/// ```dart
/// CoreScaffold(
///   body: content,
///   floatingActionButton: AppFab(
///     icon: Icons.add,
///     onPressed: () => _addItem(),
///   ),
/// )
/// ```
///
/// ## With Drawer
///
/// ```dart
/// CoreScaffold(
///   appBar: AppAppBar(title: 'Home'),
///   drawer: AppDrawer(
///     destinations: [...],
///     selectedIndex: 0,
///     onDestinationSelected: (index) => _navigate(index),
///   ),
///   body: content,
/// )
/// ```
///
/// ## Full-Featured Example
///
/// ```dart
/// CoreScaffold(
///   appBar: AppAppBar(title: 'Dashboard'),
///   drawer: AppDrawer(...),
///   body: DashboardContent(),
///   bottomNavigationBar: AppBottomNavigationBar(...),
///   floatingActionButton: AppFab.extended(
///     icon: Icons.add,
///     label: 'New Item',
///     onPressed: () {},
///   ),
///   floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
/// )
/// ```
///
/// ## Material Design 3 Specifications
///
/// - **Background**: Uses `colorScheme.surface` by default
/// - **App Bar Surface**: Uses `colorScheme.surfaceContainer`
/// - **Safe Area**: Enabled by default to avoid system UI overlap
/// - **Keyboard Resize**: Enabled by default for form inputs
///
/// ## Safe Area Behavior
///
/// When [useSafeArea] is true (default), the body content is wrapped in a
/// [SafeArea] widget to avoid system UI elements like:
/// - Status bar (top)
/// - Navigation bar (bottom)
/// - Camera notch/cutout
/// - Rounded corners
///
/// ```dart
/// CoreScaffold(
///   useSafeArea: false, // Disable safe area for edge-to-edge content
///   body: ImageGallery(),
/// )
/// ```
///
/// See also:
/// - [Scaffold] - Flutter's base scaffold widget
/// - [Material Design 3 Scaffold](https://m3.material.io/foundations/layout/canonical-layouts/overview)
class CoreScaffold extends StatelessWidget {
  /// Creates a Material Design 3 scaffold with app-wide defaults.
  ///
  /// The [body] parameter is typically required for meaningful content.
  const CoreScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.useSafeArea = true,
  });

  /// An app bar to display at the top of the scaffold.
  ///
  /// Typically an [AppAppBar] widget for MD3 consistency.
  final PreferredSizeWidget? appBar;

  /// The primary content of the scaffold.
  ///
  /// When [useSafeArea] is true (default), this widget is wrapped in a
  /// [SafeArea] to avoid system UI elements.
  final Widget? body;

  /// A floating action button to display.
  ///
  /// Typically an [AppFab] widget for MD3 consistency.
  final Widget? floatingActionButton;

  /// The location of the [floatingActionButton].
  ///
  /// Defaults to [FloatingActionButtonLocation.endFloat] when not specified.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Animator for the [floatingActionButton] position changes.
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// Persistent footer buttons displayed above the [bottomNavigationBar].
  final List<Widget>? persistentFooterButtons;

  /// Alignment of [persistentFooterButtons].
  final AlignmentDirectional persistentFooterAlignment;

  /// A navigation drawer to display on the leading edge.
  ///
  /// Typically an [AppDrawer] widget for MD3 consistency.
  final Widget? drawer;

  /// Called when the [drawer] is opened or closed.
  final DrawerCallback? onDrawerChanged;

  /// A navigation drawer to display on the trailing edge.
  final Widget? endDrawer;

  /// Called when the [endDrawer] is opened or closed.
  final DrawerCallback? onEndDrawerChanged;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  ///
  /// Typically an [AppBottomNavigationBar] widget for MD3 consistency.
  final Widget? bottomNavigationBar;

  /// A persistent bottom sheet to display.
  final Widget? bottomSheet;

  /// The background color of the scaffold.
  ///
  /// If null, defaults to [ColorScheme.surface] for MD3 compliance.
  final Color? backgroundColor;

  /// Whether the [body] should resize when the keyboard appears.
  ///
  /// Defaults to true for form inputs to remain visible.
  final bool resizeToAvoidBottomInset;

  /// Whether this scaffold is the primary scaffold in the widget tree.
  ///
  /// When true, the app bar receives the system status bar height as padding.
  final bool primary;

  /// Determines the drag start behavior for the drawer.
  final DragStartBehavior drawerDragStartBehavior;

  /// Whether the [body] extends behind the [bottomNavigationBar].
  ///
  /// Useful for transparent bottom bars or immersive experiences.
  final bool extendBody;

  /// Whether the [body] extends behind the [appBar].
  ///
  /// Useful for large images or immersive headers.
  final bool extendBodyBehindAppBar;

  /// The color of the scrim applied when a drawer is open.
  final Color? drawerScrimColor;

  /// The width of the area within which a horizontal swipe opens the drawer.
  final double? drawerEdgeDragWidth;

  /// Whether the [drawer] can be opened with a swipe gesture.
  final bool drawerEnableOpenDragGesture;

  /// Whether the [endDrawer] can be opened with a swipe gesture.
  final bool endDrawerEnableOpenDragGesture;

  /// Whether to apply [SafeArea] padding to the [body].
  ///
  /// Defaults to true to automatically handle system UI overlap.
  /// Set to false for edge-to-edge content like full-screen images.
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ?? theme.colorScheme.surface;

    // Wrap body with SafeArea if enabled
    final effectiveBody = body != null && useSafeArea
        ? SafeArea(
            // Don't apply top padding if there's an app bar
            top: appBar == null,
            // Don't apply bottom padding if there's a bottom navigation bar
            bottom: bottomNavigationBar == null && !extendBody,
            child: body!,
          )
        : body;

    return Scaffold(
      appBar: appBar,
      body: effectiveBody,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      persistentFooterAlignment: persistentFooterAlignment,
      drawer: drawer,
      onDrawerChanged: onDrawerChanged,
      endDrawer: endDrawer,
      onEndDrawerChanged: onEndDrawerChanged,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      backgroundColor: effectiveBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
    );
  }
}
