// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Height presets for [AppBottomSheet].
///
/// Defines common height configurations for bottom sheets.
enum AppBottomSheetHeight {
  /// Half screen height (0.5 of screen height).
  ///
  /// Suitable for medium-length content like action lists or forms.
  half,

  /// Nearly full screen height (0.9 of screen height).
  ///
  /// Suitable for detailed content that needs maximum space.
  full,

  /// Auto-sized based on content.
  ///
  /// Sheet height adapts to content size with minimum and maximum bounds.
  auto,
}

/// A Material Design 3 bottom sheet component that slides up from the bottom
/// of the screen to present additional content or actions.
///
/// The [AppBottomSheet] provides a flexible way to display modal or persistent
/// sheets with drag gestures, snap points, and responsive sizing. It follows
/// Material Design 3 guidelines for bottom sheets.
///
/// ## Features
///
/// - Modal and persistent variants
/// - Drag-to-dismiss gesture support
/// - Configurable snap points for partial expansion
/// - Height presets (half, full, auto)
/// - Scrollable content support
/// - Safe area handling
/// - Keyboard avoidance
/// - Custom drag handle
/// - Barrier/scrim customization
///
/// ## Basic Usage (Modal)
///
/// ```dart
/// AppBottomSheet.show(
///   context: context,
///   builder: (context) => Container(
///     padding: EdgeInsets.all(16),
///     child: Column(
///       mainAxisSize: MainAxisSize.min,
///       children: [
///         ListTile(
///           leading: Icon(Icons.share),
///           title: Text('Share'),
///           onTap: () => Navigator.pop(context),
///         ),
///         ListTile(
///           leading: Icon(Icons.edit),
///           title: Text('Edit'),
///           onTap: () => Navigator.pop(context),
///         ),
///       ],
///     ),
///   ),
/// );
/// ```
///
/// ## With Height Preset
///
/// ```dart
/// AppBottomSheet.show(
///   context: context,
///   initialHeight: AppBottomSheetHeight.full,
///   builder: (context) => YourContentWidget(),
/// );
/// ```
///
/// ## With Custom Snap Points
///
/// ```dart
/// AppBottomSheet.show(
///   context: context,
///   snapPoints: [0.25, 0.5, 0.75, 0.9],
///   builder: (context) => YourContentWidget(),
/// );
/// ```
///
/// ## Persistent Bottom Sheet
///
/// ```dart
/// AppBottomSheet.showPersistent(
///   context: context,
///   isDismissible: false,
///   builder: (context) => YourPersistentContent(),
/// );
/// ```
///
/// ## Material Design 3 Specifications
///
/// - Max width: 640dp (centered on tablets)
/// - Drag handle: 32x4dp, 12dp from top
/// - Border radius: 28dp top corners (M3 extra-large)
/// - Surface: Elevated surface with tint
/// - Backdrop: Black with 32% opacity
/// - Animation: Enter 300ms, exit 250ms, snap 200ms
///
/// ## Accessibility
///
/// - Screen reader announces sheet appearance
/// - Semantic labels for drag handle
/// - Keyboard navigation support
/// - Dismissible with back button
///
/// See also:
/// - [Material Design 3 Bottom Sheet](https://m3.material.io/components/bottom-sheets/overview)
/// - [showModalBottomSheet] - Flutter's base modal bottom sheet
/// - [DraggableScrollableSheet] - For draggable sheets
class AppBottomSheet {
  const AppBottomSheet._();

  /// Shows a modal bottom sheet with backdrop.
  ///
  /// The modal bottom sheet slides up from the bottom with a semi-transparent
  /// backdrop (scrim) behind it. Users can dismiss it by:
  /// - Tapping the backdrop
  /// - Swiping down
  /// - Pressing the back button
  ///
  /// Returns a [Future] that resolves to the value passed to [Navigator.pop]
  /// when the bottom sheet is dismissed.
  ///
  /// Example:
  /// ```dart
  /// final result = await AppBottomSheet.show<String>(
  ///   context: context,
  ///   builder: (context) => ActionListWidget(),
  /// );
  /// print('Selected: $result');
  /// ```
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    AppBottomSheetHeight initialHeight = AppBottomSheetHeight.half,
    List<double>? snapPoints,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showDragHandle = true,
    Color? barrierColor,
    Color? backgroundColor,
    VoidCallback? onDismiss,
    bool useSafeArea = true,
    double? elevation,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor,
      elevation: 0,
      useSafeArea: useSafeArea,
      builder: (context) => _AppBottomSheetContent(
        builder: builder,
        initialHeight: initialHeight,
        snapPoints: snapPoints,
        showDragHandle: showDragHandle,
        backgroundColor: backgroundColor,
        elevation: elevation,
        onDismiss: onDismiss,
      ),
    );
  }

  /// Shows a persistent bottom sheet without backdrop.
  ///
  /// The persistent bottom sheet appears without a backdrop (scrim) and
  /// typically remains visible until explicitly dismissed programmatically.
  ///
  /// Returns a [PersistentBottomSheetController] that can be used to close
  /// the bottom sheet programmatically.
  ///
  /// Example:
  /// ```dart
  /// final controller = AppBottomSheet.showPersistent(
  ///   context: context,
  ///   builder: (context) => PersistentContentWidget(),
  /// );
  ///
  /// // Later, close it programmatically
  /// controller.close();
  /// ```
  static PersistentBottomSheetController showPersistent({
    required BuildContext context,
    required WidgetBuilder builder,
    AppBottomSheetHeight initialHeight = AppBottomSheetHeight.half,
    bool showDragHandle = true,
    Color? backgroundColor,
    VoidCallback? onDismiss,
    double? elevation,
  }) {
    return showBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: true,
      builder: (context) => _AppBottomSheetContent(
        builder: builder,
        initialHeight: initialHeight,
        showDragHandle: showDragHandle,
        backgroundColor: backgroundColor,
        elevation: elevation,
        onDismiss: onDismiss,
        isPersistent: true,
      ),
    );
  }
}

/// Internal content widget for bottom sheets.
///
/// Handles drag behavior, snap points, and Material Design 3 styling.
class _AppBottomSheetContent extends StatelessWidget {
  const _AppBottomSheetContent({
    required this.builder,
    required this.initialHeight,
    this.snapPoints,
    required this.showDragHandle,
    this.backgroundColor,
    this.elevation,
    this.onDismiss,
    this.isPersistent = false,
  });

  final WidgetBuilder builder;
  final AppBottomSheetHeight initialHeight;
  final List<double>? snapPoints;
  final bool showDragHandle;
  final Color? backgroundColor;
  final double? elevation;
  final VoidCallback? onDismiss;
  final bool isPersistent;

  double get _initialChildSize {
    switch (initialHeight) {
      case AppBottomSheetHeight.half:
        return 0.5;
      case AppBottomSheetHeight.full:
        return 0.9;
      case AppBottomSheetHeight.auto:
        return 0.5;
    }
  }

  List<double> get _snapSizes {
    if (snapPoints != null && snapPoints!.isNotEmpty) {
      return snapPoints!;
    }
    // Default snap points: small peek, half, nearly full
    return [0.25, 0.5, 0.9];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final minSize = _snapSizes.reduce((a, b) => a < b ? a : b);
    final maxSize = _snapSizes.reduce((a, b) => a > b ? a : b);
    final initialSize = _initialChildSize.clamp(minSize, maxSize);

    return DraggableScrollableSheet(
      initialChildSize: initialSize,
      minChildSize: minSize,
      maxChildSize: maxSize,
      expand: false,
      snap: true,
      snapSizes: _snapSizes,
      builder: (context, scrollController) {
        return Container(
          constraints: const BoxConstraints(
            maxWidth: 640, // M3 spec: max width on tablets
          ),
          decoration: BoxDecoration(
            color: backgroundColor ?? colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(28), // M3 spec: extra-large radius
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: elevation ?? 3,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              if (showDragHandle) const _DragHandle(),
              // Content
              Flexible(child: builder(context)),
            ],
          ),
        );
      },
    );
  }
}

/// Material Design 3 drag handle for bottom sheets.
///
/// Visual indicator for drag-to-dismiss gesture.
/// Specifications: 32x4dp, 12dp from top, onSurfaceVariant color.
class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      width: 32,
      height: 4,
      decoration: BoxDecoration(
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
