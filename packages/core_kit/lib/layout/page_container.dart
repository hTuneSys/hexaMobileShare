// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/widgets.dart';

import '../theme/app_spacing.dart';

/// A layout widget that wraps page content with consistent padding
/// and max-width constraints for better readability on large screens.
///
/// [PageContainer] provides responsive padding that adapts to screen size:
/// - Mobile (< 600dp): 16dp padding
/// - Tablet (600dp - 840dp): 24dp padding
/// - Desktop (> 840dp): 32dp padding + max-width constraint
///
/// Example:
/// ```dart
/// PageContainer(
///   child: Column(
///     children: [
///       Text('Page Title'),
///       Text('Page content goes here...'),
///     ],
///   ),
/// )
/// ```
///
/// With custom max-width:
/// ```dart
/// PageContainer(
///   maxWidth: 800,
///   child: FormContent(),
/// )
/// ```
class PageContainer extends StatelessWidget {
  /// The widget to display inside the container.
  final Widget child;

  /// Maximum width of the content area.
  ///
  /// When the screen is wider than this value, content will be
  /// centered and constrained to this width. Set to `null` to
  /// disable max-width constraint.
  ///
  /// Defaults to 1200.0 logical pixels.
  final double? maxWidth;

  /// Custom padding to override responsive padding behavior.
  ///
  /// If provided, this padding will be used instead of the
  /// responsive padding based on screen size.
  final EdgeInsetsGeometry? padding;

  /// Whether to center the content when screen width exceeds [maxWidth].
  ///
  /// Defaults to `true`.
  final bool center;

  /// Whether to wrap content in a [SafeArea] widget.
  ///
  /// Defaults to `true`.
  final bool useSafeArea;

  /// Whether to apply SafeArea to the top.
  ///
  /// Only effective when [useSafeArea] is `true`.
  /// Defaults to `true`.
  final bool safeAreaTop;

  /// Whether to apply SafeArea to the bottom.
  ///
  /// Only effective when [useSafeArea] is `true`.
  /// Defaults to `true`.
  final bool safeAreaBottom;

  /// Whether to apply SafeArea to the left.
  ///
  /// Only effective when [useSafeArea] is `true`.
  /// Defaults to `true`.
  final bool safeAreaLeft;

  /// Whether to apply SafeArea to the right.
  ///
  /// Only effective when [useSafeArea] is `true`.
  /// Defaults to `true`.
  final bool safeAreaRight;

  /// Creates a [PageContainer] with responsive padding and max-width.
  const PageContainer({
    required this.child,
    this.maxWidth = 1200.0,
    this.padding,
    this.center = true,
    this.useSafeArea = true,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.safeAreaLeft = true,
    this.safeAreaRight = true,
    super.key,
  });

  /// Creates a [PageContainer] without max-width constraint.
  ///
  /// Content will expand to fill available width with only
  /// responsive padding applied.
  const PageContainer.fluid({
    required this.child,
    this.padding,
    this.useSafeArea = true,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.safeAreaLeft = true,
    this.safeAreaRight = true,
    super.key,
  }) : maxWidth = null,
       center = false;

  /// Creates a [PageContainer] with narrow max-width (800dp).
  ///
  /// Ideal for forms, articles, and content that benefits from
  /// shorter line lengths for readability.
  const PageContainer.narrow({
    required this.child,
    this.padding,
    this.center = true,
    this.useSafeArea = true,
    this.safeAreaTop = true,
    this.safeAreaBottom = true,
    this.safeAreaLeft = true,
    this.safeAreaRight = true,
    super.key,
  }) : maxWidth = 800.0;

  /// Material Design 3 breakpoints
  static const double _mobileBreakpoint = 600.0;
  static const double _tabletBreakpoint = 840.0;

  /// Returns responsive padding based on screen width.
  EdgeInsetsGeometry _getResponsivePadding(double screenWidth) {
    if (screenWidth < _mobileBreakpoint) {
      // Mobile: 16dp
      return const EdgeInsets.symmetric(horizontal: AppSpacing.md);
    } else if (screenWidth < _tabletBreakpoint) {
      // Tablet: 24dp
      return const EdgeInsets.symmetric(horizontal: AppSpacing.lg);
    } else {
      // Desktop: 32dp
      return const EdgeInsets.symmetric(horizontal: AppSpacing.xl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final effectivePadding = padding ?? _getResponsivePadding(screenWidth);

        Widget content = Padding(padding: effectivePadding, child: child);

        // Apply max-width constraint if specified
        if (maxWidth != null) {
          content = ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth!),
            child: content,
          );

          // Center content horizontally if enabled (content starts from top)
          if (center) {
            content = Align(alignment: Alignment.topCenter, child: content);
          }
        }

        // Apply SafeArea if enabled
        if (useSafeArea) {
          content = SafeArea(
            top: safeAreaTop,
            bottom: safeAreaBottom,
            left: safeAreaLeft,
            right: safeAreaRight,
            child: content,
          );
        }

        return content;
      },
    );
  }
}
