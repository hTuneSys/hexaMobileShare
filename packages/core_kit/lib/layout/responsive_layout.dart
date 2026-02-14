// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

// =============================================================================
// 1. M3 Layout Grid Data — Margins, Gutters, and Columns
// =============================================================================

/// Material Design 3 layout grid specifications.
///
/// Provides centralized access to M3-compliant margins, gutters, and
/// column counts based on [WindowSizeClass].
class AppLayoutGrid {
  const AppLayoutGrid._();

  /// Returns the M3 recommended outer margin for the given [sizeClass].
  static double margin(WindowSizeClass sizeClass) {
    switch (sizeClass) {
      case WindowSizeClass.compact:
        return 16.0;
      default:
        return 24.0;
    }
  }

  /// Returns the M3 recommended gutter (spacing between columns)
  /// for the given [sizeClass].
  static double gutter(WindowSizeClass sizeClass) {
    switch (sizeClass) {
      case WindowSizeClass.compact:
        return 16.0;
      default:
        return 24.0;
    }
  }

  /// Returns the M3 recommended column count for the given [sizeClass].
  static int columns(WindowSizeClass sizeClass) {
    switch (sizeClass) {
      case WindowSizeClass.compact:
        return 4;
      default:
        return 12;
    }
  }
}

// =============================================================================
// 2. WindowSizeClass — Material Design 3 Window Size Classes
// =============================================================================

/// Material Design 3 window size classes for responsive layout adaptation.
///
/// These classes define how layouts should adapt based on the available
/// window width, following the [M3 Layout Guidelines](https://m3.material.io/foundations/layout).
///
/// | Class       | Width Range  | Layout Pattern         | Navigation   |
/// |-------------|-------------|------------------------|--------------|
/// | compact     | 0–599dp     | Single pane            | Bottom bar   |
/// | medium      | 600–839dp   | List-detail possible   | Rail         |
/// | expanded    | 840–1199dp  | List-detail            | Drawer       |
/// | large       | 1200–1599dp | Multi-pane             | Drawer       |
/// | extraLarge  | 1600dp+     | Multi-pane             | Drawer       |
///
/// Example:
/// ```dart
/// final sizeClass = AppBreakpoints.fromWidth(screenWidth);
/// switch (sizeClass) {
///   case WindowSizeClass.compact:
///     return MobileLayout();
///   case WindowSizeClass.medium:
///     return TabletLayout();
///   default:
///     return DesktopLayout();
/// }
/// ```
enum WindowSizeClass {
  /// Small phones in portrait mode (0–599dp).
  compact,

  /// Large phones in landscape, small tablets in portrait (600–839dp).
  medium,

  /// Tablets in landscape, small desktops (840–1199dp).
  expanded,

  /// Standard desktops (1200–1599dp).
  large,

  /// Large desktops and ultra-wide screens (1600dp+).
  extraLarge,
}

// =============================================================================
// 3. AppBreakpoints — Material Design 3 Breakpoint Constants
// =============================================================================

/// Material Design 3 breakpoint constants and utilities.
///
/// Provides a single source of truth for all responsive breakpoint values
/// in the application. All breakpoints follow the official M3 specifications.
///
/// Use [fromWidth] to determine the [WindowSizeClass] for a given width,
/// or use the convenience helpers [isMobile], [isTablet], [isDesktop]
/// for simplified 3-tier detection.
///
/// Example:
/// ```dart
/// // 5-tier detection
/// final sizeClass = AppBreakpoints.fromWidth(screenWidth);
///
/// // 3-tier convenience
/// if (AppBreakpoints.isMobile(screenWidth)) {
///   // Mobile layout
/// }
/// ```
class AppBreakpoints {
  const AppBreakpoints._();

  /// Compact breakpoint start (0dp).
  ///
  /// Applies to: small phones in portrait mode.
  static const double compact = 0;

  /// Medium breakpoint start (600dp).
  ///
  /// Applies to: large phones in landscape, small tablets in portrait.
  static const double medium = 600;

  /// Expanded breakpoint start (840dp).
  ///
  /// Applies to: tablets in landscape, small desktops.
  static const double expanded = 840;

  /// Large breakpoint start (1200dp).
  ///
  /// Applies to: standard desktops.
  static const double large = 1200;

  /// Extra large breakpoint start (1600dp).
  ///
  /// Applies to: large desktops and ultra-wide screens.
  static const double extraLarge = 1600;

  /// M3 recommended max content width for medium screens.
  static const double maxContentMedium = 600;

  /// M3 recommended max content width for expanded+ screens.
  static const double maxContentExpanded = 840;

  /// Resolves the [WindowSizeClass] for the given screen [width].
  ///
  /// Returns the appropriate M3 window size class based on the width
  /// in density-independent pixels (dp).
  ///
  /// Example:
  /// ```dart
  /// final sizeClass = AppBreakpoints.fromWidth(
  ///   MediaQuery.sizeOf(context).width,
  /// );
  /// ```
  static WindowSizeClass fromWidth(double width) {
    if (width >= extraLarge) return WindowSizeClass.extraLarge;
    if (width >= large) return WindowSizeClass.large;
    if (width >= expanded) return WindowSizeClass.expanded;
    if (width >= medium) return WindowSizeClass.medium;
    return WindowSizeClass.compact;
  }

  /// Returns `true` if [width] falls in the compact range (< 600dp).
  ///
  /// Convenience helper for simplified 3-tier responsive logic.
  static bool isMobile(double width) => width < medium;

  /// Returns `true` if [width] falls in the medium range (600dp–839dp).
  ///
  /// Convenience helper for simplified 3-tier responsive logic.
  static bool isTablet(double width) => width >= medium && width < expanded;

  /// Returns `true` if [width] falls in the expanded+ range (>= 840dp).
  ///
  /// Convenience helper for simplified 3-tier responsive logic.
  static bool isDesktop(double width) => width >= expanded;
}

// =============================================================================
// 4. CustomBreakpoints — User-Defined Breakpoints
// =============================================================================

/// Custom breakpoint definitions for non-standard responsive layouts.
///
/// Use this when the default M3 breakpoints in [AppBreakpoints] don't fit
/// your layout requirements.
///
/// Example:
/// ```dart
/// const gameBreakpoints = CustomBreakpoints(
///   medium: 480,
///   expanded: 768,
///   large: 1024,
///   extraLarge: 1440,
/// );
///
/// final sizeClass = gameBreakpoints.fromWidth(screenWidth);
/// ```
class CustomBreakpoints {
  /// Creates custom breakpoint definitions.
  ///
  /// All values are in density-independent pixels (dp).
  /// Values must satisfy: [medium] < [expanded] < [large] < [extraLarge].
  const CustomBreakpoints({
    this.medium = AppBreakpoints.medium,
    this.expanded = AppBreakpoints.expanded,
    this.large = AppBreakpoints.large,
    this.extraLarge = AppBreakpoints.extraLarge,
  }) : assert(medium > 0, 'medium must be > 0'),
       assert(expanded > medium, 'expanded must be > medium'),
       assert(large > expanded, 'large must be > expanded'),
       assert(extraLarge > large, 'extraLarge must be > large');

  /// Width threshold for medium window size class.
  final double medium;

  /// Width threshold for expanded window size class.
  final double expanded;

  /// Width threshold for large window size class.
  final double large;

  /// Width threshold for extra large window size class.
  final double extraLarge;

  /// Resolves the [WindowSizeClass] for the given [width]
  /// using these custom breakpoints.
  WindowSizeClass fromWidth(double width) {
    if (width >= extraLarge) return WindowSizeClass.extraLarge;
    if (width >= large) return WindowSizeClass.large;
    if (width >= expanded) return WindowSizeClass.expanded;
    if (width >= medium) return WindowSizeClass.medium;
    return WindowSizeClass.compact;
  }
}

// =============================================================================
// 5. ResponsiveBuilder — Different Widgets Per Breakpoint
// =============================================================================

/// Renders different widget trees based on the current M3 breakpoint.
///
/// Provides two usage patterns:
/// 1. **Builder callback** — full control with [builder] function.
/// 2. **Named slots** — supply separate widgets per breakpoint.
///
/// When using named slots, the widget falls back to the nearest smaller
/// variant if a specific breakpoint widget is not provided.
///
/// Example (builder):
/// ```dart
/// ResponsiveBuilder(
///   builder: (context, sizeClass) {
///     return Text('Current: $sizeClass');
///   },
/// )
/// ```
///
/// Example (named slots):
/// ```dart
/// ResponsiveBuilder(
///   compact: MobileLayout(),
///   medium: TabletLayout(),
///   expanded: DesktopLayout(),
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  /// Creates a responsive builder.
  ///
  /// Either [builder] or at least [compact] must be provided.
  const ResponsiveBuilder({
    super.key,
    this.builder,
    this.compact,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
  }) : assert(
         builder != null || compact != null,
         'Either builder or compact widget must be provided',
       );

  /// Builder function receiving the current [WindowSizeClass].
  ///
  /// When provided, this takes priority over named slot widgets.
  final Widget Function(BuildContext, WindowSizeClass)? builder;

  /// Widget for compact screens (0–599dp).
  final Widget? compact;

  /// Widget for medium screens (600–839dp).
  /// Falls back to [compact] if not provided.
  final Widget? medium;

  /// Widget for expanded screens (840–1199dp).
  /// Falls back to [medium] → [compact] if not provided.
  final Widget? expanded;

  /// Widget for large screens (1200–1599dp).
  /// Falls back to [expanded] → [medium] → [compact] if not provided.
  final Widget? large;

  /// Widget for extra large screens (1600dp+).
  /// Falls back to [large] → [expanded] → [medium] → [compact].
  final Widget? extraLarge;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sizeClass = AppBreakpoints.fromWidth(width);

    if (builder != null) {
      return builder!(context, sizeClass);
    }

    return _resolveWidget(sizeClass);
  }

  /// Resolves the widget for the given [sizeClass] with cascade fallback.
  Widget _resolveWidget(WindowSizeClass sizeClass) {
    switch (sizeClass) {
      case WindowSizeClass.extraLarge:
        return extraLarge ?? large ?? expanded ?? medium ?? compact!;
      case WindowSizeClass.large:
        return large ?? expanded ?? medium ?? compact!;
      case WindowSizeClass.expanded:
        return expanded ?? medium ?? compact!;
      case WindowSizeClass.medium:
        return medium ?? compact!;
      case WindowSizeClass.compact:
        return compact!;
    }
  }
}

// =============================================================================
// 6. ResponsiveValue<T> — Generic Value Resolver Per Breakpoint
// =============================================================================

/// Returns different values based on the current M3 breakpoint.
///
/// Generic utility for resolving any type of value (numbers, strings,
/// EdgeInsets, colors, etc.) per breakpoint with cascade fallback.
///
/// When a value for a specific breakpoint is not provided, it falls back
/// to the nearest smaller breakpoint's value.
///
/// Example:
/// ```dart
/// final columns = const ResponsiveValue<int>(
///   compact: 1,
///   medium: 2,
///   expanded: 3,
/// ).resolve(context);
///
/// final padding = const ResponsiveValue<double>(
///   compact: AppSpacing.sm,
///   medium: AppSpacing.md,
///   expanded: AppSpacing.lg,
/// ).resolve(context);
/// ```
class ResponsiveValue<T> {
  /// Creates a responsive value resolver.
  ///
  /// [compact] is required and serves as the base fallback value.
  const ResponsiveValue({
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
  });

  /// Value for compact screens (0–599dp). Always required as fallback.
  final T compact;

  /// Value for medium screens (600–839dp). Falls back to [compact].
  final T? medium;

  /// Value for expanded screens (840–1199dp). Falls back to [medium].
  final T? expanded;

  /// Value for large screens (1200–1599dp). Falls back to [expanded].
  final T? large;

  /// Value for extra large screens (1600dp+). Falls back to [large].
  final T? extraLarge;

  /// Resolves the value for the current screen size.
  ///
  /// Uses [MediaQuery] to determine the current width and returns
  /// the appropriate value with cascade fallback.
  T resolve(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sizeClass = AppBreakpoints.fromWidth(width);
    return resolveForClass(sizeClass);
  }

  /// Resolves the value for a specific [WindowSizeClass].
  ///
  /// Useful when you already have the size class and want to avoid
  /// repeated [MediaQuery] lookups.
  T resolveForClass(WindowSizeClass sizeClass) {
    switch (sizeClass) {
      case WindowSizeClass.extraLarge:
        return extraLarge ?? large ?? expanded ?? medium ?? compact;
      case WindowSizeClass.large:
        return large ?? expanded ?? medium ?? compact;
      case WindowSizeClass.expanded:
        return expanded ?? medium ?? compact;
      case WindowSizeClass.medium:
        return medium ?? compact;
      case WindowSizeClass.compact:
        return compact;
    }
  }
}

// =============================================================================
// 7. ResponsiveGridView — Adaptive Column Count Grid
// =============================================================================

/// A responsive grid that adapts its column count based on screen size.
///
/// Uses [AppSpacing] defaults for consistent grid spacing. The column count
/// changes at M3 breakpoints for optimal content display.
///
/// M3 recommended column counts:
/// - Compact: 2 columns (default)
/// - Medium: 3 columns (default)
/// - Expanded: 4 columns (default)
/// - Large/Extra Large: follows expanded count
///
/// Example:
/// ```dart
/// ResponsiveGridView(
///   children: items.map((item) => ItemCard(item: item)).toList(),
/// )
/// ```
class ResponsiveGridView extends StatelessWidget {
  /// Creates a responsive grid view.
  const ResponsiveGridView({
    super.key,
    required this.children,
    this.compactColumns = 2,
    this.mediumColumns = 3,
    this.expandedColumns = 4,
    this.largeColumns,
    this.extraLargeColumns,
    this.spacing,
    this.runSpacing,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.childAspectRatio = 1.0,
  });

  /// The grid items to display.
  final List<Widget> children;

  /// Number of columns on compact screens (default: 2).
  final int compactColumns;

  /// Number of columns on medium screens (default: 3).
  final int mediumColumns;

  /// Number of columns on expanded screens (default: 4).
  final int expandedColumns;

  /// Number of columns on large screens. Falls back to [expandedColumns].
  final int? largeColumns;

  /// Number of columns on extra large screens. Falls back to [largeColumns].
  final int? extraLargeColumns;

  /// Spacing between grid items.
  ///
  /// Defaults to [AppLayoutGrid.gutter] based on current size class.
  final double? spacing;

  /// Vertical spacing between rows. Falls back to [spacing] or
  /// [AppLayoutGrid.gutter].
  final double? runSpacing;

  /// Optional padding around the grid.
  ///
  /// Defaults to [AppLayoutGrid.margin] for outer padding if not provided.
  final EdgeInsetsGeometry? padding;

  /// Whether the grid should shrink-wrap its content.
  final bool shrinkWrap;

  /// Scroll physics for the grid.
  final ScrollPhysics? physics;

  /// Aspect ratio of each grid child (default: 1.0).
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sizeClass = AppBreakpoints.fromWidth(width);
    final columns = _resolveColumns(sizeClass);
    final gutter = spacing ?? AppLayoutGrid.gutter(sizeClass);
    final margin = padding ?? EdgeInsets.all(AppLayoutGrid.margin(sizeClass));

    return GridView.count(
      crossAxisCount: columns,
      crossAxisSpacing: gutter,
      mainAxisSpacing: runSpacing ?? gutter,
      padding: margin,
      shrinkWrap: shrinkWrap,
      physics: physics,
      childAspectRatio: childAspectRatio,
      children: children,
    );
  }

  /// Resolves column count with cascade fallback.
  int _resolveColumns(WindowSizeClass sizeClass) {
    switch (sizeClass) {
      case WindowSizeClass.extraLarge:
        return extraLargeColumns ?? largeColumns ?? expandedColumns;
      case WindowSizeClass.large:
        return largeColumns ?? expandedColumns;
      case WindowSizeClass.expanded:
        return expandedColumns;
      case WindowSizeClass.medium:
        return mediumColumns;
      case WindowSizeClass.compact:
        return compactColumns;
    }
  }
}

// =============================================================================
// 8. AppLayoutGridContainer — M3 Adaptive Grid Layout Wrapper
// =============================================================================

/// A wrapper widget that provides M3-compliant margins and gutters.
///
/// Automatically applies the correct padding (margins) based on the
/// current [WindowSizeClass].
class AppLayoutGridContainer extends StatelessWidget {
  /// Creates an adaptive layout grid container.
  const AppLayoutGridContainer({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth,
  });

  /// The widget to display within the grid.
  final Widget child;

  /// Optional custom padding. If provided, replaces M3 margins.
  final EdgeInsetsGeometry? padding;

  /// Optional max width constraint.
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final sizeClass = context.windowSizeClass;
    final margin = padding ?? EdgeInsets.all(AppLayoutGrid.margin(sizeClass));

    Widget content = Padding(padding: margin, child: child);

    if (maxWidth != null) {
      content = MaxWidthContainer(maxWidth: maxWidth!, child: content);
    }

    return content;
  }
}

// =============================================================================
// 10. ResponsiveLayout — Switch Entire Layouts By Breakpoint
// =============================================================================

/// Switches entire layout structures based on the current M3 breakpoint.
///
/// Unlike [ResponsiveBuilder], this widget is specifically designed for
/// switching between fundamentally different layout structures
/// (e.g., bottom navigation on mobile vs side navigation on desktop).
///
/// Falls back to the nearest smaller variant when a specific breakpoint
/// layout is not provided.
///
/// M3 Layout Patterns:
/// - **Compact:** Single pane with bottom navigation
/// - **Medium:** List-detail with navigation rail
/// - **Expanded:** List-detail with navigation drawer
///
/// Example:
/// ```dart
/// ResponsiveLayout(
///   compact: Scaffold(
///     body: ContentList(),
///     bottomNavigationBar: AppBottomNavigationBar(...),
///   ),
///   medium: Row(
///     children: [
///       NavigationRail(...),
///       Expanded(child: ContentList()),
///     ],
///   ),
///   expanded: Row(
///     children: [
///       AppDrawer(...),
///       Expanded(child: ContentList()),
///       Expanded(child: DetailView()),
///     ],
///   ),
/// )
/// ```
class ResponsiveLayout extends StatelessWidget {
  /// Creates a responsive layout.
  ///
  /// [compact] is required and serves as the base layout.
  const ResponsiveLayout({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
  });

  /// Layout for compact screens (0–599dp). Always required.
  final Widget compact;

  /// Layout for medium screens (600–839dp). Falls back to [compact].
  final Widget? medium;

  /// Layout for expanded screens (840–1199dp). Falls back to [medium].
  final Widget? expanded;

  /// Layout for large screens (1200–1599dp). Falls back to [expanded].
  final Widget? large;

  /// Layout for extra large screens (1600dp+). Falls back to [large].
  final Widget? extraLarge;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final sizeClass = AppBreakpoints.fromWidth(width);

    switch (sizeClass) {
      case WindowSizeClass.extraLarge:
        return extraLarge ?? large ?? expanded ?? medium ?? compact;
      case WindowSizeClass.large:
        return large ?? expanded ?? medium ?? compact;
      case WindowSizeClass.expanded:
        return expanded ?? medium ?? compact;
      case WindowSizeClass.medium:
        return medium ?? compact;
      case WindowSizeClass.compact:
        return compact;
    }
  }
}

// =============================================================================
// 10. ScreenMetrics — Screen Measurement Data
// =============================================================================

/// Immutable screen measurement data including dimensions, orientation,
/// and M3 window size class.
///
/// Created by [ScreenSizeProvider] and accessible via
/// `ScreenSizeProvider.of(context)` or `context.screenMetrics`.
///
/// Example:
/// ```dart
/// final metrics = ScreenSizeProvider.of(context);
/// print('Width: ${metrics.width}');
/// print('Size class: ${metrics.windowSizeClass}');
/// print('Diagonal: ${metrics.diagonal}');
/// ```
class ScreenMetrics {
  /// Creates screen metrics from the given dimensions.
  const ScreenMetrics({
    required this.width,
    required this.height,
    required this.orientation,
    required this.windowSizeClass,
  });

  /// Screen width in density-independent pixels.
  final double width;

  /// Screen height in density-independent pixels.
  final double height;

  /// Current device orientation.
  final Orientation orientation;

  /// M3 window size class based on [width].
  final WindowSizeClass windowSizeClass;

  /// Screen diagonal in density-independent pixels.
  double get diagonal => math.sqrt(width * width + height * height);

  /// Returns `true` if the screen is in portrait orientation.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Returns `true` if the screen is in landscape orientation.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Returns `true` if the screen width is in the compact range.
  bool get isMobile => AppBreakpoints.isMobile(width);

  /// Returns `true` if the screen width is in the medium/expanded range.
  bool get isTablet => AppBreakpoints.isTablet(width);

  /// Returns `true` if the screen width is in the large+ range.
  bool get isDesktop => AppBreakpoints.isDesktop(width);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ScreenMetrics &&
        other.width == width &&
        other.height == height &&
        other.orientation == orientation &&
        other.windowSizeClass == windowSizeClass;
  }

  @override
  int get hashCode => Object.hash(width, height, orientation, windowSizeClass);

  @override
  String toString() =>
      'ScreenMetrics(${width.toStringAsFixed(0)}x'
      '${height.toStringAsFixed(0)}, '
      '$windowSizeClass, $orientation)';
}

// =============================================================================
// 11. ScreenSizeProvider — InheritedWidget for Screen Metrics
// =============================================================================

/// An [InheritedWidget] that provides [ScreenMetrics] to its descendants.
///
/// Wraps the widget tree and exposes screen dimensions, orientation,
/// and M3 window size class via [ScreenSizeProvider.of] or
/// `context.screenMetrics`.
///
/// Example:
/// ```dart
/// // Wrap your app or a subtree
/// ScreenSizeProvider(
///   child: MyApp(),
/// )
///
/// // Access metrics anywhere below
/// final metrics = ScreenSizeProvider.of(context);
/// if (metrics.isMobile) {
///   // Mobile-specific logic
/// }
/// ```
class ScreenSizeProvider extends StatelessWidget {
  /// Creates a screen size provider.
  const ScreenSizeProvider({super.key, required this.child});

  /// The widget below this provider in the tree.
  final Widget child;

  /// Retrieves the [ScreenMetrics] from the nearest ancestor provider.
  ///
  /// Throws if no [ScreenSizeProvider] is found in the widget tree.
  /// Use [maybeOf] for a nullable version.
  static ScreenMetrics of(BuildContext context) {
    final data = context
        .dependOnInheritedWidgetOfExactType<_ScreenMetricsScope>();
    assert(
      data != null,
      'ScreenSizeProvider.of() called without a ScreenSizeProvider ancestor.',
    );
    return data!.metrics;
  }

  /// Retrieves the [ScreenMetrics] from the nearest ancestor provider,
  /// or `null` if no provider exists.
  static ScreenMetrics? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ScreenMetricsScope>()
        ?.metrics;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final orientation = mediaQuery.orientation;

    final metrics = ScreenMetrics(
      width: size.width,
      height: size.height,
      orientation: orientation,
      windowSizeClass: AppBreakpoints.fromWidth(size.width),
    );

    return _ScreenMetricsScope(metrics: metrics, child: child);
  }
}

/// Internal inherited widget holding [ScreenMetrics].
class _ScreenMetricsScope extends InheritedWidget {
  const _ScreenMetricsScope({required this.metrics, required super.child});

  final ScreenMetrics metrics;

  @override
  bool updateShouldNotify(_ScreenMetricsScope oldWidget) =>
      metrics != oldWidget.metrics;
}

// =============================================================================
// 12. AppOrientationBuilder — Orientation + Responsive Integration
// =============================================================================

/// Builds widgets based on both device orientation and M3 window size class.
///
/// Provides two usage patterns:
/// 1. **Builder callback** — full control with orientation and size class.
/// 2. **Named slots** — supply separate widgets for portrait/landscape.
///
/// Example (builder):
/// ```dart
/// AppOrientationBuilder(
///   builder: (context, orientation, sizeClass) {
///     if (orientation == Orientation.landscape &&
///         sizeClass == WindowSizeClass.compact) {
///       return CompactLandscapeLayout();
///     }
///     return DefaultLayout();
///   },
/// )
/// ```
///
/// Example (named slots):
/// ```dart
/// AppOrientationBuilder(
///   portrait: PortraitLayout(),
///   landscape: LandscapeLayout(),
/// )
/// ```
class AppOrientationBuilder extends StatelessWidget {
  /// Creates an orientation-aware builder.
  ///
  /// Either [builder] or at least [portrait] must be provided.
  const AppOrientationBuilder({
    super.key,
    this.builder,
    this.portrait,
    this.landscape,
  }) : assert(
         builder != null || portrait != null,
         'Either builder or portrait widget must be provided',
       );

  /// Builder receiving orientation and window size class.
  final Widget Function(BuildContext, Orientation, WindowSizeClass)? builder;

  /// Widget for portrait orientation. Falls back when [landscape] is null.
  final Widget? portrait;

  /// Widget for landscape orientation. Falls back to [portrait].
  final Widget? landscape;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final sizeClass = AppBreakpoints.fromWidth(mediaQuery.size.width);

    if (builder != null) {
      return builder!(context, orientation, sizeClass);
    }

    if (orientation == Orientation.landscape) {
      return landscape ?? portrait!;
    }
    return portrait!;
  }
}

// =============================================================================
// 13. MaxWidthContainer — Constrained Width Wrapper
// =============================================================================

/// A lightweight container that constrains its child to a maximum width.
///
/// Unlike [PageContainer], this widget provides only width constraint
/// and optional centering without padding or SafeArea logic.
///
/// Useful for preventing content from stretching too wide on large screens
/// while maintaining a clean, focused layout.
///
/// Example:
/// ```dart
/// MaxWidthContainer(
///   maxWidth: 800,
///   child: Column(
///     children: [
///       Text('Constrained content'),
///     ],
///   ),
/// )
///
/// // Full-width on mobile, constrained on desktop
/// MaxWidthContainer(
///   child: ArticleContent(),
/// )
/// ```
class MaxWidthContainer extends StatelessWidget {
  /// Creates a max-width constrained container.
  const MaxWidthContainer({
    super.key,
    required this.child,
    this.maxWidth = AppBreakpoints.large,
    this.center = true,
  });

  /// The widget to constrain.
  final Widget child;

  /// Maximum width in density-independent pixels.
  ///
  /// Defaults to [AppBreakpoints.large] (1200dp).
  final double maxWidth;

  /// Whether to center the child when the screen is wider than [maxWidth].
  ///
  /// Defaults to `true`.
  final bool center;

  /// Named constructor for narrow content (max 600dp).
  ///
  /// Follows M3 recommendation for medium screen content width.
  const MaxWidthContainer.narrow({
    super.key,
    required this.child,
    this.center = true,
  }) : maxWidth = AppBreakpoints.maxContentMedium;

  /// Named constructor for standard content (max 840dp).
  ///
  /// Follows M3 recommendation for expanded screen content width.
  const MaxWidthContainer.standard({
    super.key,
    required this.child,
    this.center = true,
  }) : maxWidth = AppBreakpoints.maxContentExpanded;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: center ? Alignment.topCenter : Alignment.topLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}

// =============================================================================
// 14. ResponsiveIconSize — Adaptive Icon Sizing
// =============================================================================

/// Provides adaptive icon sizing based on M3 breakpoints.
///
/// Returns different icon sizes for different screen sizes, ensuring
/// icons remain visually balanced across devices.
///
/// Example:
/// ```dart
/// Icon(
///   Icons.home,
///   size: ResponsiveIconSize.resolve(context),
/// )
///
/// // Custom sizes
/// Icon(
///   Icons.settings,
///   size: ResponsiveIconSize.resolve(
///     context,
///     compact: 20,
///     medium: 24,
///     expanded: 28,
///   ),
/// )
/// ```
class ResponsiveIconSize {
  const ResponsiveIconSize._();

  /// M3 default icon size for compact screens.
  static const double defaultCompact = 20;

  /// M3 default icon size for medium screens.
  static const double defaultMedium = 24;

  /// M3 default icon size for expanded+ screens.
  static const double defaultExpanded = 28;

  /// Resolves the appropriate icon size for the current screen size.
  ///
  /// Falls back to the nearest smaller value when not specified.
  static double resolve(
    BuildContext context, {
    double compact = defaultCompact,
    double medium = defaultMedium,
    double expanded = defaultExpanded,
    double? large,
    double? extraLarge,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    final sizeClass = AppBreakpoints.fromWidth(width);

    switch (sizeClass) {
      case WindowSizeClass.extraLarge:
        return extraLarge ?? large ?? expanded;
      case WindowSizeClass.large:
        return large ?? expanded;
      case WindowSizeClass.expanded:
        return expanded;
      case WindowSizeClass.medium:
        return medium;
      case WindowSizeClass.compact:
        return compact;
    }
  }
}

// =============================================================================
// 15. ViewportHelpers — Device Form-Factor Detection
// =============================================================================

/// Utility class for detecting device form factors and viewport properties.
///
/// Provides simple boolean checks for common responsive layout decisions.
/// Uses [AppBreakpoints] and [MediaQuery] internally.
///
/// Example:
/// ```dart
/// if (ViewportHelpers.isPhone(context)) {
///   // Phone-specific logic
/// }
///
/// if (ViewportHelpers.isLandscape(context)) {
///   // Landscape-specific layout
/// }
/// ```
class ViewportHelpers {
  const ViewportHelpers._();

  /// Returns `true` if the device is a phone (compact window size).
  static bool isPhone(BuildContext context) {
    return AppBreakpoints.isMobile(MediaQuery.sizeOf(context).width);
  }

  /// Returns `true` if the device is a tablet (medium/expanded window size).
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppBreakpoints.medium && width < AppBreakpoints.large;
  }

  /// Returns `true` if the device is a desktop (large+ window size).
  static bool isDesktop(BuildContext context) {
    return AppBreakpoints.isDesktop(MediaQuery.sizeOf(context).width);
  }

  /// Returns `true` if the device is in landscape orientation.
  static bool isLandscape(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.landscape;
  }

  /// Returns `true` if the device is in portrait orientation.
  static bool isPortrait(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.portrait;
  }

  /// Returns `true` if the device may be a foldable.
  ///
  /// Uses a heuristic: medium-width device in landscape orientation
  /// suggests a foldable in unfolded state.
  static bool isFoldable(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    // Heuristic: aspect ratio close to square with medium width
    final aspectRatio = width / height;
    return width >= AppBreakpoints.medium &&
        width < AppBreakpoints.expanded &&
        aspectRatio > 0.7 &&
        aspectRatio < 1.5;
  }
}

// =============================================================================
// 16. ResponsiveExtension — BuildContext Extension Methods
// =============================================================================

/// Extension methods on [BuildContext] for convenient responsive access.
///
/// Provides quick access to screen metrics, window size class, and
/// responsive value resolution without boilerplate.
///
/// Example:
/// ```dart
/// Widget build(BuildContext context) {
///   if (context.isMobile) {
///     return MobileLayout();
///   }
///
///   final columns = context.responsiveValue<int>(
///     compact: 1,
///     medium: 2,
///     expanded: 3,
///   );
///
///   print('Screen: ${context.screenWidth}x${context.screenHeight}');
///   print('Size class: ${context.windowSizeClass}');
/// }
/// ```
extension ResponsiveExtension on BuildContext {
  /// The current M3 [WindowSizeClass] based on screen width.
  WindowSizeClass get windowSizeClass =>
      AppBreakpoints.fromWidth(MediaQuery.sizeOf(this).width);

  /// The current [ScreenMetrics] from the nearest [ScreenSizeProvider].
  ///
  /// Falls back to creating metrics from [MediaQuery] if no provider exists.
  ScreenMetrics get screenMetrics {
    final provided = ScreenSizeProvider.maybeOf(this);
    if (provided != null) return provided;

    final mediaQuery = MediaQuery.of(this);
    return ScreenMetrics(
      width: mediaQuery.size.width,
      height: mediaQuery.size.height,
      orientation: mediaQuery.orientation,
      windowSizeClass: AppBreakpoints.fromWidth(mediaQuery.size.width),
    );
  }

  /// Returns `true` if the screen is in the compact range (< 600dp).
  bool get isMobile => AppBreakpoints.isMobile(MediaQuery.sizeOf(this).width);

  /// Returns `true` if the screen is in the medium/expanded range.
  bool get isTablet => AppBreakpoints.isTablet(MediaQuery.sizeOf(this).width);

  /// Returns `true` if the screen is in the large+ range (>= 1200dp).
  bool get isDesktop => AppBreakpoints.isDesktop(MediaQuery.sizeOf(this).width);

  /// The current screen width in density-independent pixels.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// The current screen height in density-independent pixels.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// The current device orientation.
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Resolves a value based on the current M3 breakpoint.
  ///
  /// Shorthand for creating a [ResponsiveValue] and resolving it.
  ///
  /// Example:
  /// ```dart
  /// final padding = context.responsiveValue<double>(
  ///   compact: AppSpacing.sm,
  ///   medium: AppSpacing.md,
  ///   expanded: AppSpacing.lg,
  /// );
  /// ```
  T responsiveValue<T>({
    required T compact,
    T? medium,
    T? expanded,
    T? large,
    T? extraLarge,
  }) {
    return ResponsiveValue<T>(
      compact: compact,
      medium: medium,
      expanded: expanded,
      large: large,
      extraLarge: extraLarge,
    ).resolve(this);
  }

  /// Returns a text style with font size scaled by breakpoint.
  TextStyle? responsiveTextStyle(TextStyle? style) {
    return Theme.of(this).responsiveTextStyle(this, style);
  }

  /// Returns spacing scaled by the current breakpoint.
  double responsiveSpacing(double base) {
    return Theme.of(this).responsiveSpacing(this, base);
  }

  /// Returns an icon size scaled by the current breakpoint.
  double responsiveIconSize({double base = 24.0}) {
    return Theme.of(this).responsiveIconSize(this, base: base);
  }
}

// =============================================================================
// 17. ResponsiveThemeExtension — Theme Integration
// =============================================================================

/// Extension on [ThemeData] for responsive theme values.
///
/// Provides convenience methods to scale theme-related values
/// (spacing, text styles, icon sizes) based on the current breakpoint.
///
/// Example:
/// ```dart
/// final theme = Theme.of(context);
/// final spacing = theme.responsiveSpacing(context, AppSpacing.md);
/// final textStyle = theme.responsiveTextStyle(
///   context,
///   theme.textTheme.bodyLarge,
/// );
/// ```
extension ResponsiveThemeExtension on ThemeData {
  /// Returns spacing scaled by the current breakpoint.
  ///
  /// Scale factors:
  /// - Compact: 1.0x
  /// - Medium: 1.0x
  /// - Expanded: 1.25x
  /// - Large: 1.5x
  /// - Extra Large: 1.5x
  double responsiveSpacing(BuildContext context, double base) {
    final sizeClass = AppBreakpoints.fromWidth(
      MediaQuery.sizeOf(context).width,
    );

    final scaleFactor = switch (sizeClass) {
      WindowSizeClass.compact => 1.0,
      WindowSizeClass.medium => 1.0,
      WindowSizeClass.expanded => 1.25,
      WindowSizeClass.large => 1.5,
      WindowSizeClass.extraLarge => 1.5,
    };

    // Round to nearest 4dp to maintain grid alignment
    final scaledValue = base * scaleFactor;
    return (scaledValue / 4).round() * 4.0;
  }

  /// Returns a text style with font size scaled by breakpoint.
  ///
  /// Scale factors:
  /// - Compact: 0.9x
  /// - Medium: 1.0x
  /// - Expanded: 1.0x
  /// - Large: 1.1x
  /// - Extra Large: 1.1x
  TextStyle? responsiveTextStyle(BuildContext context, TextStyle? style) {
    if (style == null) return null;

    final sizeClass = AppBreakpoints.fromWidth(
      MediaQuery.sizeOf(context).width,
    );

    final scaleFactor = switch (sizeClass) {
      WindowSizeClass.compact => 0.9,
      WindowSizeClass.medium => 1.0,
      WindowSizeClass.expanded => 1.0,
      WindowSizeClass.large => 1.1,
      WindowSizeClass.extraLarge => 1.1,
    };

    return style.copyWith(fontSize: (style.fontSize ?? 14.0) * scaleFactor);
  }

  /// Returns an icon size scaled by the current breakpoint.
  double responsiveIconSize(BuildContext context, {double base = 24.0}) {
    return ResponsiveIconSize.resolve(
      context,
      compact: base * 0.83,
      medium: base,
      expanded: base * 1.17,
    );
  }
}
