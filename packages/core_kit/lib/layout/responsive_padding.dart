// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/widgets.dart';

import '../theme/app_spacing.dart';

/// Breakpoint values for responsive design following Material Design 3.
///
/// These values correspond to Material Design 3 window size classes:
/// - Compact: < 600dp (mobile)
/// - Medium: 600-839dp (tablet portrait, small tablet)
/// - Expanded: >= 840dp (tablet landscape, desktop)
///
/// We use slightly different values as specified in Issue #39:
/// - Mobile: < 600dp
/// - Tablet: 600-1023dp
/// - Desktop: >= 1024dp
class ResponsiveBreakpoints {
  const ResponsiveBreakpoints._();

  /// Default mobile breakpoint width (< 600dp)
  static const double mobile = 600.0;

  /// Default tablet breakpoint width (< 1024dp)
  static const double tablet = 1024.0;
}

/// A widget that provides adaptive padding based on screen size breakpoints.
///
/// [ResponsivePadding] automatically adjusts padding values based on the
/// current screen width, using breakpoints for mobile, tablet, and desktop.
///
/// This widget is useful for:
/// - Page edge padding that adapts to screen size
/// - Card content padding that varies by device
/// - Section spacing that respects device form factor
/// - Form field margins that scale appropriately
///
/// ## Breakpoint Detection
///
/// The widget uses the following default breakpoints:
/// - **Mobile**: width < 600dp
/// - **Tablet**: 600dp <= width < 1024dp
/// - **Desktop**: width >= 1024dp
///
/// You can customize these breakpoints using [mobileBreakpoint] and
/// [tabletBreakpoint] parameters.
///
/// ## Example
///
/// ```dart
/// ResponsivePadding(
///   mobilePadding: EdgeInsets.all(AppSpacing.sm),
///   tabletPadding: EdgeInsets.all(AppSpacing.md),
///   desktopPadding: EdgeInsets.all(AppSpacing.lg),
///   child: MyContent(),
/// )
/// ```
///
/// ## Named Constructors
///
/// For convenience, several named constructors are provided:
/// - [ResponsivePadding.all] - Same padding for all sides per breakpoint
/// - [ResponsivePadding.symmetric] - Horizontal/vertical padding per breakpoint
/// - [ResponsivePadding.horizontal] - Only horizontal padding per breakpoint
/// - [ResponsivePadding.vertical] - Only vertical padding per breakpoint
class ResponsivePadding extends StatelessWidget {
  /// Creates a responsive padding widget.
  ///
  /// The [child] parameter is required.
  ///
  /// Padding values are applied based on the current screen breakpoint:
  /// - [mobilePadding] for screens smaller than [mobileBreakpoint]
  /// - [tabletPadding] for screens between [mobileBreakpoint] and [tabletBreakpoint]
  /// - [desktopPadding] for screens larger than or equal to [tabletBreakpoint]
  ///
  /// If a specific breakpoint padding is null, [padding] is used as fallback.
  /// If [padding] is also null, [EdgeInsets.zero] is used.
  const ResponsivePadding({
    required this.child,
    this.padding,
    this.mobilePadding,
    this.tabletPadding,
    this.desktopPadding,
    this.mobileBreakpoint = ResponsiveBreakpoints.mobile,
    this.tabletBreakpoint = ResponsiveBreakpoints.tablet,
    super.key,
  });

  /// Creates responsive padding with the same value for all sides.
  ///
  /// Uses [AppSpacing] values for consistent Material Design 3 spacing.
  ///
  /// Example:
  /// ```dart
  /// ResponsivePadding.all(
  ///   mobile: AppSpacing.sm,
  ///   tablet: AppSpacing.md,
  ///   desktop: AppSpacing.lg,
  ///   child: Content(),
  /// )
  /// ```
  factory ResponsivePadding.all({
    required Widget child,
    double mobile = AppSpacing.sm,
    double tablet = AppSpacing.md,
    double desktop = AppSpacing.lg,
    double mobileBreakpoint = ResponsiveBreakpoints.mobile,
    double tabletBreakpoint = ResponsiveBreakpoints.tablet,
    Key? key,
  }) {
    return ResponsivePadding(
      key: key,
      mobilePadding: EdgeInsets.all(mobile),
      tabletPadding: EdgeInsets.all(tablet),
      desktopPadding: EdgeInsets.all(desktop),
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
      child: child,
    );
  }

  /// Creates responsive padding with symmetric horizontal and vertical values.
  ///
  /// Example:
  /// ```dart
  /// ResponsivePadding.symmetric(
  ///   mobileHorizontal: AppSpacing.sm,
  ///   mobileVertical: AppSpacing.xs,
  ///   tabletHorizontal: AppSpacing.md,
  ///   tabletVertical: AppSpacing.sm,
  ///   desktopHorizontal: AppSpacing.lg,
  ///   desktopVertical: AppSpacing.md,
  ///   child: Content(),
  /// )
  /// ```
  factory ResponsivePadding.symmetric({
    required Widget child,
    double mobileHorizontal = AppSpacing.sm,
    double mobileVertical = AppSpacing.xs,
    double tabletHorizontal = AppSpacing.md,
    double tabletVertical = AppSpacing.sm,
    double desktopHorizontal = AppSpacing.lg,
    double desktopVertical = AppSpacing.md,
    double mobileBreakpoint = ResponsiveBreakpoints.mobile,
    double tabletBreakpoint = ResponsiveBreakpoints.tablet,
    Key? key,
  }) {
    return ResponsivePadding(
      key: key,
      mobilePadding: EdgeInsets.symmetric(
        horizontal: mobileHorizontal,
        vertical: mobileVertical,
      ),
      tabletPadding: EdgeInsets.symmetric(
        horizontal: tabletHorizontal,
        vertical: tabletVertical,
      ),
      desktopPadding: EdgeInsets.symmetric(
        horizontal: desktopHorizontal,
        vertical: desktopVertical,
      ),
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
      child: child,
    );
  }

  /// Creates responsive padding for horizontal sides only.
  ///
  /// Useful for page edge padding that only applies to left and right.
  ///
  /// Example:
  /// ```dart
  /// ResponsivePadding.horizontal(
  ///   mobile: AppSpacing.md,
  ///   tablet: AppSpacing.lg,
  ///   desktop: AppSpacing.xl,
  ///   child: PageContent(),
  /// )
  /// ```
  factory ResponsivePadding.horizontal({
    required Widget child,
    double mobile = AppSpacing.md,
    double tablet = AppSpacing.lg,
    double desktop = AppSpacing.xl,
    double mobileBreakpoint = ResponsiveBreakpoints.mobile,
    double tabletBreakpoint = ResponsiveBreakpoints.tablet,
    Key? key,
  }) {
    return ResponsivePadding(
      key: key,
      mobilePadding: EdgeInsets.symmetric(horizontal: mobile),
      tabletPadding: EdgeInsets.symmetric(horizontal: tablet),
      desktopPadding: EdgeInsets.symmetric(horizontal: desktop),
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
      child: child,
    );
  }

  /// Creates responsive padding for vertical sides only.
  ///
  /// Useful for content spacing that only applies to top and bottom.
  ///
  /// Example:
  /// ```dart
  /// ResponsivePadding.vertical(
  ///   mobile: AppSpacing.sm,
  ///   tablet: AppSpacing.md,
  ///   desktop: AppSpacing.lg,
  ///   child: SectionContent(),
  /// )
  /// ```
  factory ResponsivePadding.vertical({
    required Widget child,
    double mobile = AppSpacing.sm,
    double tablet = AppSpacing.md,
    double desktop = AppSpacing.lg,
    double mobileBreakpoint = ResponsiveBreakpoints.mobile,
    double tabletBreakpoint = ResponsiveBreakpoints.tablet,
    Key? key,
  }) {
    return ResponsivePadding(
      key: key,
      mobilePadding: EdgeInsets.symmetric(vertical: mobile),
      tabletPadding: EdgeInsets.symmetric(vertical: tablet),
      desktopPadding: EdgeInsets.symmetric(vertical: desktop),
      mobileBreakpoint: mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint,
      child: child,
    );
  }

  /// The widget to wrap with responsive padding.
  final Widget child;

  /// Fallback padding when specific breakpoint padding is not provided.
  ///
  /// If null and no breakpoint-specific padding is set, [EdgeInsets.zero]
  /// is used.
  final EdgeInsetsGeometry? padding;

  /// Padding to apply on mobile screens (width < [mobileBreakpoint]).
  ///
  /// If null, falls back to [padding].
  final EdgeInsetsGeometry? mobilePadding;

  /// Padding to apply on tablet screens
  /// ([mobileBreakpoint] <= width < [tabletBreakpoint]).
  ///
  /// If null, falls back to [padding].
  final EdgeInsetsGeometry? tabletPadding;

  /// Padding to apply on desktop screens (width >= [tabletBreakpoint]).
  ///
  /// If null, falls back to [padding].
  final EdgeInsetsGeometry? desktopPadding;

  /// The width threshold for mobile devices.
  ///
  /// Screens with width less than this value are considered mobile.
  /// Defaults to [ResponsiveBreakpoints.mobile] (600dp).
  final double mobileBreakpoint;

  /// The width threshold for tablet devices.
  ///
  /// Screens with width greater than or equal to this value are considered
  /// desktop. Screens between [mobileBreakpoint] and this value are tablet.
  /// Defaults to [ResponsiveBreakpoints.tablet] (1024dp).
  final double tabletBreakpoint;

  /// Determines the current device type based on screen width.
  DeviceType _getDeviceType(double width) {
    if (width < mobileBreakpoint) {
      return DeviceType.mobile;
    } else if (width < tabletBreakpoint) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  /// Gets the appropriate padding for the given device type.
  EdgeInsetsGeometry _getPaddingForDevice(DeviceType deviceType) {
    final EdgeInsetsGeometry? specificPadding = switch (deviceType) {
      DeviceType.mobile => mobilePadding,
      DeviceType.tablet => tabletPadding,
      DeviceType.desktop => desktopPadding,
    };

    return specificPadding ?? padding ?? EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final deviceType = _getDeviceType(width);
    final effectivePadding = _getPaddingForDevice(deviceType);

    return Padding(padding: effectivePadding, child: child);
  }
}

/// Represents the device type based on screen width breakpoints.
enum DeviceType {
  /// Mobile device (width < 600dp by default)
  mobile,

  /// Tablet device (600dp <= width < 1024dp by default)
  tablet,

  /// Desktop device (width >= 1024dp by default)
  desktop,
}
