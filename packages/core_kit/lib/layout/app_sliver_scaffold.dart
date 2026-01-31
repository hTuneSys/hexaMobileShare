// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A callback that reports the current collapse ratio of the SliverAppBar.
/// 0.0 means fully expanded, 1.0 means fully collapsed.
typedef CollapseStateCallback = void Function(double collapseRatio);

/// A scaffold that uses a [CustomScrollView] with a [SliverAppBar] to provide
/// advanced scrolling effects like collapsing headers, parallax, and sticky sections.
///
/// This component follows Material Design 3 guidelines for large top app bars.
///
/// **For sticky headers**, use [SectionHeaderDelegate] from `app_section_header.dart`.
class AppSliverScaffold extends StatefulWidget {
  /// Creates an [AppSliverScaffold].
  const AppSliverScaffold({
    required this.slivers,
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.flexibleSpace,
    this.expandedHeight = 200.0,
    this.collapsedHeight = kToolbarHeight,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.parallaxRatio = 0.5,
    this.showScrim = false,
    this.accessibilityLabel,
    this.onRefresh,
    this.onScroll,
    this.backgroundColor,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.primary = true,
    this.resizeToAvoidBottomInset,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.controller,
    this.useSafeArea = true,
  });

  /// The title to display in the app bar.
  final Widget? title;

  /// A widget to display before the title.
  final Widget? leading;

  /// A list of implementation widgets to display in a row after the title.
  final List<Widget>? actions;

  /// The widget to display behind the toolbar in the expanded state.
  final Widget? flexibleSpace;

  /// The height of the app bar when fully expanded.
  final double expandedHeight;

  /// The height of the app bar when fully collapsed.
  final double collapsedHeight;

  /// Whether the app bar should remain visible at the start of the scroll view.
  final bool pinned;

  /// Whether the app bar should become visible as soon as the user scrolls towards the app bar.
  final bool floating;

  /// Whether the app bar should snap into view when [floating] is true.
  final bool snap;

  /// The parallax scroll ratio for the flexible space.
  ///
  /// A value of 0.0 means no parallax (content scrolls with the page).
  /// A value of 1.0 means full parallax (content stays fixed).
  /// Default is 0.5 for a balanced parallax effect.
  final double parallaxRatio;

  /// Whether to show a gradient scrim overlay on the flexible space.
  ///
  /// When true, adds a dark gradient at the bottom of images/backgrounds
  /// to improve text legibility. Recommended for profile headers and hero images.
  final bool showScrim;

  /// Accessibility label for screen readers.
  ///
  /// When provided, wraps the scaffold in a Semantics widget to announce
  /// the content structure to assistive technologies.
  final String? accessibilityLabel;

  /// The slivers to place inside the [CustomScrollView].
  final List<Widget> slivers;

  /// A callback that triggers when a pull-to-refresh gesture occurs.
  final Future<void> Function()? onRefresh;

  /// A callback that reports the collapse ratio of the app bar during scroll.
  final CollapseStateCallback? onScroll;

  /// The background color of the scaffold.
  final Color? backgroundColor;

  /// A drawer to display on the leading side.
  final Widget? drawer;

  /// Called when the [drawer] is opened or closed.
  final DrawerCallback? onDrawerChanged;

  /// A drawer to display on the trailing side.
  final Widget? endDrawer;

  /// Called when the [endDrawer] is opened or closed.
  final DrawerCallback? onEndDrawerChanged;

  /// A bottom navigation bar to display.
  final Widget? bottomNavigationBar;

  /// A persistent bottom sheet to display.
  final Widget? bottomSheet;

  /// A floating action button to display.
  final Widget? floatingActionButton;

  /// The location of the [floatingActionButton].
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Animator for the [floatingActionButton] position changes.
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// Persistent footer buttons displayed above the [bottomNavigationBar].
  final List<Widget>? persistentFooterButtons;

  /// Alignment of [persistentFooterButtons].
  final AlignmentDirectional persistentFooterAlignment;

  /// Whether this scaffold is the primary scaffold in the widget tree.
  final bool primary;

  /// Whether the body should resize when the keyboard appears.
  final bool? resizeToAvoidBottomInset;

  /// Whether the body extends behind the [bottomNavigationBar].
  final bool extendBody;

  /// Whether the body extends behind the [appBar].
  final bool extendBodyBehindAppBar;

  /// Determines the drag start behavior for the drawer.
  final DragStartBehavior drawerDragStartBehavior;

  /// The color of the scrim applied when a drawer is open.
  final Color? drawerScrimColor;

  /// The width of the area within which a horizontal swipe opens the drawer.
  final double? drawerEdgeDragWidth;

  /// Whether the [drawer] can be opened with a swipe gesture.
  final bool drawerEnableOpenDragGesture;

  /// Whether the [endDrawer] can be opened with a swipe gesture.
  final bool endDrawerEnableOpenDragGesture;

  /// An optional scroll controller.
  final ScrollController? controller;

  /// Whether to wrap the content in a [SafeArea].
  final bool useSafeArea;

  @override
  State<AppSliverScaffold> createState() => _AppSliverScaffoldState();
}

class _AppSliverScaffoldState extends State<AppSliverScaffold> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
    if (widget.onScroll != null) {
      _scrollController.addListener(_handleScroll);
    }
  }

  @override
  void didUpdateWidget(AppSliverScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.onScroll != null) {
        _scrollController.removeListener(_handleScroll);
      }
      _scrollController = widget.controller ?? ScrollController();
      if (widget.onScroll != null) {
        _scrollController.addListener(_handleScroll);
      }
    }
  }

  @override
  void dispose() {
    if (widget.onScroll != null) {
      _scrollController.removeListener(_handleScroll);
    }
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;

    final offset = _scrollController.offset;
    final range = widget.expandedHeight - widget.collapsedHeight;
    final ratio = (offset / range).clamp(0.0, 1.0);

    widget.onScroll?.call(ratio);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget body = CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverAppBar(
          leading: widget.leading,
          actions: widget.actions,
          expandedHeight: widget.expandedHeight,
          collapsedHeight: widget.collapsedHeight,
          pinned: widget.pinned,
          floating: widget.floating,
          snap: widget.snap && widget.floating,
          backgroundColor: colorScheme.surface,
          surfaceTintColor: colorScheme.surfaceTint,
          flexibleSpace: widget.title != null
              ? Semantics(
                  header: true,
                  label: widget.accessibilityLabel ?? 'App header',
                  child: _buildFlexibleSpace(),
                )
              : _buildFlexibleSpace(),
        ),
        ...widget.slivers,
      ],
    );

    if (widget.onRefresh != null) {
      body = RefreshIndicator(onRefresh: widget.onRefresh!, child: body);
    }

    if (widget.useSafeArea) {
      body = SafeArea(
        top: false, // SliverAppBar handles top safe area
        bottom: widget.bottomNavigationBar == null,
        child: body,
      );
    }

    return Scaffold(
      backgroundColor: widget.backgroundColor ?? colorScheme.surface,
      drawer: widget.drawer,
      onDrawerChanged: widget.onDrawerChanged,
      endDrawer: widget.endDrawer,
      onEndDrawerChanged: widget.onEndDrawerChanged,
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: widget.bottomSheet,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
      floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
      persistentFooterButtons: widget.persistentFooterButtons,
      persistentFooterAlignment: widget.persistentFooterAlignment,
      primary: widget.primary,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      extendBody: widget.extendBody,
      extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      drawerDragStartBehavior: widget.drawerDragStartBehavior,
      drawerScrimColor: widget.drawerScrimColor,
      drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
      body: body,
    );
  }

  /// Builds the flexible space bar with optional scrim and configurable parallax.
  Widget _buildFlexibleSpace() {
    Widget? background;

    if (widget.flexibleSpace != null) {
      background = _FadeOnScroll(child: widget.flexibleSpace!);

      // Add scrim gradient overlay if enabled
      if (widget.showScrim) {
        background = Stack(
          fit: StackFit.expand,
          children: [
            background,
            // Gradient scrim for text legibility
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                  stops: [0.6, 1.0],
                ),
              ),
            ),
          ],
        );
      }
    }

    // Use custom parallax ratio if provided, otherwise default to none mode
    final collapseMode = widget.parallaxRatio == 0.0
        ? CollapseMode.none
        : widget.parallaxRatio == 1.0
        ? CollapseMode.pin
        : CollapseMode.parallax;

    return FlexibleSpaceBar(
      title: widget.title,
      background: background,
      collapseMode: collapseMode,
      stretchModes: const [
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
      ],
    );
  }
}

/// {@template sticky_header_delegate}
/// **DEPRECATED**: Use `SectionHeaderDelegate` from `app_section_header.dart` instead.
///
/// This class is kept for backward compatibility only.
/// For sticky section headers in slivers, use:
/// ```dart
/// import 'package:core_kit/widgets/surfaces/app_section_header.dart';
///
/// SliverPersistentHeader(
///   pinned: true,
///   delegate: SectionHeaderDelegate(
///     child: AppSectionHeader(title: 'Section'),
///   ),
/// )
/// ```
/// {@endtemplate}
@Deprecated(
  'Use SectionHeaderDelegate from app_section_header.dart instead. '
  'This will be removed in v2.0.0.',
)
class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// {@macro sticky_header_delegate}
  const StickyHeaderDelegate({
    required this.child,
    this.minHeight = 48.0,
    this.maxHeight = 48.0,
  });

  /// The widget to display as the header.
  final Widget child;

  /// The minimum height of the header.
  final double minHeight;

  /// The maximum height of the header.
  final double maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _FadeOnScroll extends StatelessWidget {
  const _FadeOnScroll({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();

        if (settings == null) return child;

        final deltaExtent = settings.maxExtent - settings.minExtent;
        if (deltaExtent == 0) return child;

        // 0.0 -> Expanded, 1.0 -> Collapsed
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);

        // Start fading out at 40% collapse, fully transparent at 90%
        // This ensures content is gone before the app bar is fully collapsed
        // preventing overlap with the title
        final opacity = 1.0 - const Interval(0.4, 0.9).transform(t);

        return Opacity(opacity: opacity, child: child);
      },
    );
  }
}
