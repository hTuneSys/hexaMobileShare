// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/widgets.dart';

/// A mixin for automatically tracking screen views in Flutter applications.
///
/// Mix this into your [State] class to enable automatic screen view tracking
/// when the widget is displayed. The mixin tracks:
/// - Screen name (from route or manual override)
/// - Screen parameters
/// - Time spent on screen
/// - Screen entry/exit events
///
/// ## Usage
///
/// ### Basic Usage
///
/// ```dart
/// class MyScreen extends StatefulWidget {
///   const MyScreen({super.key});
///
///   @override
///   State<MyScreen> createState() => _MyScreenState();
/// }
///
/// class _MyScreenState extends State<MyScreen> with ScreenTrackingMixin {
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(title: const Text('My Screen')),
///       body: const Center(child: Text('Content')),
///     );
///   }
/// }
/// ```
///
/// ### With Custom Screen Name
///
/// ```dart
/// class _MyScreenState extends State<MyScreen> with ScreenTrackingMixin {
///   @override
///   String get screenName => 'custom_screen_name';
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(title: const Text('My Screen')),
///       body: const Center(child: Text('Content')),
///     );
///   }
/// }
/// ```
///
/// ### With Screen Parameters
///
/// ```dart
/// class ProductDetailScreen extends StatefulWidget {
///   const ProductDetailScreen({super.key, required this.productId});
///
///   final String productId;
///
///   @override
///   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
/// }
///
/// class _ProductDetailScreenState extends State<ProductDetailScreen>
///     with ScreenTrackingMixin {
///   @override
///   String get screenName => 'product_detail';
///
///   @override
///   Map<String, dynamic> get screenParameters => {
///         'product_id': widget.productId,
///         'source': 'direct',
///       };
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(title: const Text('Product Details')),
///       body: Center(child: Text('Product: ${widget.productId}')),
///     );
///   }
/// }
/// ```
///
/// ## How It Works
///
/// 1. **Automatic Tracking**: Screen views are tracked automatically when the
///    widget is inserted into the widget tree.
/// 2. **Screen Name Detection**: By default, the screen name is extracted from
///    the route name. Override [screenName] for custom names.
/// 3. **Time Tracking**: The mixin records when the screen was first shown and
///    calculates time-on-screen when the widget is disposed.
/// 4. **Parameters**: Additional screen parameters can be tracked by overriding
///    [screenParameters].
///
/// ## Best Practices
///
/// - Use snake_case for screen names (e.g., `home_screen`, `product_detail`)
/// - Keep screen names consistent across platforms
/// - Include relevant parameters for better analytics insights
/// - Avoid tracking sensitive user data in parameters
///
/// See also:
/// - [AnalyticsService] for manual event tracking
/// - [AnalyticsEvent] for custom analytics events
mixin ScreenTrackingMixin<T extends StatefulWidget> on State<T> {
  /// The timestamp when the screen was first displayed.
  DateTime? _screenEntryTime;

  /// The name of the screen to track.
  ///
  /// By default, this extracts the route name from [ModalRoute].
  /// Override this getter to provide a custom screen name.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// String get screenName => 'home_screen';
  /// ```
  String get screenName {
    final route = ModalRoute.of(context);
    if (route != null && route.settings.name != null) {
      return route.settings.name!;
    }
    return runtimeType.toString();
  }

  /// Additional parameters to track with the screen view.
  ///
  /// Override this getter to provide custom parameters that describe
  /// the current state or context of the screen.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// Map<String, dynamic> get screenParameters => {
  ///   'user_id': currentUserId,
  ///   'category': selectedCategory,
  ///   'filter': activeFilter,
  /// };
  /// ```
  Map<String, dynamic> get screenParameters => {};

  /// Whether to enable debug logging for screen tracking.
  ///
  /// When true, screen tracking events will be logged to the console.
  /// Useful for debugging and verifying tracking implementation.
  bool get enableDebugLogging => false;

  @override
  void initState() {
    super.initState();
    _screenEntryTime = DateTime.now();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Track screen view when dependencies change (first time widget is built)
    if (_screenEntryTime != null) {
      _trackScreenView();
    }
  }

  @override
  void dispose() {
    _trackScreenExit();
    super.dispose();
  }

  /// Tracks the screen view event.
  ///
  /// This is called automatically when the widget is first displayed.
  /// Can be called manually to re-track the screen view if needed.
  void _trackScreenView() {
    final parameters = <String, dynamic>{
      ...screenParameters,
      'screen_name': screenName,
      'timestamp': _screenEntryTime?.toIso8601String(),
    };

    if (enableDebugLogging) {
      debugPrint('📊 Screen View: $screenName');
      debugPrint('   Parameters: $parameters');
    }

    // TODO: Integrate with actual analytics service
    // AnalyticsService.instance.logScreenView(
    //   screenName: screenName,
    //   parameters: parameters,
    // );
  }

  /// Tracks the screen exit event with time-on-screen.
  ///
  /// This is called automatically when the widget is disposed.
  void _trackScreenExit() {
    if (_screenEntryTime == null) return;

    final timeOnScreen = DateTime.now().difference(_screenEntryTime!);
    final parameters = <String, dynamic>{
      ...screenParameters,
      'screen_name': screenName,
      'time_on_screen_seconds': timeOnScreen.inSeconds,
      'time_on_screen_milliseconds': timeOnScreen.inMilliseconds,
    };

    if (enableDebugLogging) {
      debugPrint('📊 Screen Exit: $screenName');
      debugPrint('   Time on screen: ${timeOnScreen.inSeconds}s');
      debugPrint('   Parameters: $parameters');
    }

    // TODO: Integrate with actual analytics service
    // AnalyticsService.instance.logEvent(
    //   name: 'screen_exit',
    //   parameters: parameters,
    // );
  }

  /// Manually track a screen view.
  ///
  /// This can be useful if you need to re-track the screen view
  /// after a significant state change.
  ///
  /// Example:
  /// ```dart
  /// void onTabChanged(int tabIndex) {
  ///   setState(() {
  ///     _currentTab = tabIndex;
  ///   });
  ///   trackScreenView(); // Re-track with updated parameters
  /// }
  /// ```
  void trackScreenView() {
    _trackScreenView();
  }
}
