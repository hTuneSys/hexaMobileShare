// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';

/// Defines the scroll physics behavior for [AppScrollView].
enum AppScrollPhysicsType {
  /// iOS-style bounce effect.
  bounce,

  /// Android-style clamp effect.
  clamp,

  /// Disables scrolling.
  never,

  /// Always allows scrolling even when content fits.
  always,
}

/// An enhanced scrollable container with pull-to-refresh,
/// scroll-to-top button, and configurable scroll physics.
///
/// Wraps [SingleChildScrollView] with common scroll features
/// following Material Design 3 guidelines.
///
/// Example:
/// ```dart
/// AppScrollView(
///   enablePullToRefresh: true,
///   onRefresh: () async => fetchData(),
///   enableScrollToTop: true,
///   child: Column(children: items),
/// )
/// ```
class AppScrollView extends StatefulWidget {
  /// The scrollable content.
  final Widget child;

  /// Scroll direction. Defaults to [Axis.vertical].
  final Axis scrollDirection;

  /// Scroll physics type. Defaults to [AppScrollPhysicsType.clamp].
  final AppScrollPhysicsType physics;

  /// Optional external scroll controller.
  final ScrollController? controller;

  /// Whether to enable pull-to-refresh. Defaults to false.
  final bool enablePullToRefresh;

  /// Callback triggered on pull-to-refresh.
  final Future<void> Function()? onRefresh;

  /// Whether to show scroll-to-top button. Defaults to false.
  final bool enableScrollToTop;

  /// Scroll offset threshold for showing the scroll-to-top button.
  /// Defaults to 200.0.
  final double scrollToTopThreshold;

  /// Content padding.
  final EdgeInsetsGeometry? padding;

  /// Whether to reverse the scroll direction. Defaults to false.
  final bool reverse;

  /// Whether to wrap content with [SafeArea]. Defaults to true.
  final bool handleSafeArea;

  /// Callback with scroll metrics on scroll events.
  final void Function(ScrollMetrics)? onScroll;

  /// Accessibility label for screen readers.
  final String? semanticLabel;

  /// Creates an [AppScrollView].
  const AppScrollView({
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.physics = AppScrollPhysicsType.clamp,
    this.controller,
    this.enablePullToRefresh = false,
    this.onRefresh,
    this.enableScrollToTop = false,
    this.scrollToTopThreshold = 200.0,
    this.padding,
    this.reverse = false,
    this.handleSafeArea = true,
    this.onScroll,
    this.semanticLabel,
    super.key,
  });

  @override
  State<AppScrollView> createState() => _AppScrollViewState();
}

class _AppScrollViewState extends State<AppScrollView> {
  late ScrollController _scrollController;
  bool _ownsController = false;
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void didUpdateWidget(AppScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _disposeController();
      _initController();
    }
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  void _initController() {
    if (widget.controller != null) {
      _scrollController = widget.controller!;
      _ownsController = false;
    } else {
      _scrollController = ScrollController();
      _ownsController = true;
    }
    _scrollController.addListener(_onScrollUpdate);
  }

  void _disposeController() {
    _scrollController.removeListener(_onScrollUpdate);
    if (_ownsController) {
      _scrollController.dispose();
    }
  }

  void _onScrollUpdate() {
    if (widget.onScroll != null && _scrollController.hasClients) {
      widget.onScroll!(_scrollController.position);
    }

    if (widget.enableScrollToTop && _scrollController.hasClients) {
      final shouldShow =
          _scrollController.offset >= widget.scrollToTopThreshold;
      if (shouldShow != _showScrollToTop) {
        setState(() => _showScrollToTop = shouldShow);
      }
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  ScrollPhysics _resolvePhysics() {
    return switch (widget.physics) {
      AppScrollPhysicsType.bounce => const BouncingScrollPhysics(),
      AppScrollPhysicsType.clamp => const ClampingScrollPhysics(),
      AppScrollPhysicsType.never => const NeverScrollableScrollPhysics(),
      AppScrollPhysicsType.always => const AlwaysScrollableScrollPhysics(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget content = SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: widget.scrollDirection,
      physics: _resolvePhysics(),
      padding: widget.padding,
      reverse: widget.reverse,
      child: widget.child,
    );

    if (widget.enablePullToRefresh && widget.onRefresh != null) {
      content = RefreshIndicator(
        onRefresh: widget.onRefresh!,
        color: colorScheme.primary,
        child: content,
      );
    }

    if (widget.handleSafeArea) {
      content = SafeArea(child: content);
    }

    if (widget.semanticLabel != null) {
      content = Semantics(label: widget.semanticLabel, child: content);
    }

    if (widget.enableScrollToTop) {
      content = Stack(
        children: [
          content,
          Positioned(
            right: AppSpacing.md,
            bottom: AppSpacing.md,
            child: AnimatedOpacity(
              opacity: _showScrollToTop ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _showScrollToTop
                  ? FloatingActionButton.small(
                      onPressed: _scrollToTop,
                      backgroundColor: colorScheme.primaryContainer,
                      foregroundColor: colorScheme.onPrimaryContainer,
                      child: const Icon(Icons.arrow_upward),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      );
    }

    return content;
  }
}
