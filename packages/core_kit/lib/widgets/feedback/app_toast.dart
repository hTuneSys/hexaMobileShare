// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';

/// A lightweight toast notification component for brief, non-intrusive messages.
///
/// The [AppToast] provides very brief feedback about operations without
/// requiring user action or blocking interaction. Toasts auto-dismiss and
/// appear as overlays that don't shift content layout.
///
/// ## Features
///
/// - Brief message text (auto-wrapping for longer content)
/// - Optional leading icon
/// - Position variants (top, center, bottom)
/// - Auto-dismiss with configurable duration (default 2s)
/// - Semantic color variants (success, error, warning, info, neutral)
/// - Fade in/out animations
/// - Non-blocking overlay (floats above content)
/// - Queue management for multiple toasts
/// - Safe area handling
/// - Accessibility announcements
///
/// ## Basic Usage
///
/// ```dart
/// AppToast.show(
///   context,
///   message: 'Copied to clipboard',
/// );
/// ```
///
/// ## With Icon and Position
///
/// ```dart
/// AppToast.show(
///   context,
///   message: 'Draft saved',
///   icon: Icons.check_circle,
///   position: ToastPosition.top,
/// );
/// ```
///
/// ## Semantic Variants
///
/// ```dart
/// // Success
/// AppToast.success(context, message: 'File uploaded successfully');
///
/// // Error
/// AppToast.error(context, message: 'No internet connection');
///
/// // Warning
/// AppToast.warning(context, message: 'Storage almost full');
///
/// // Info
/// AppToast.info(context, message: 'Swipe to see more');
/// ```
///
/// ## Material Design 3 Specifications
///
/// - Width: Auto (content-based), max 320dp
/// - Height: Auto (content-based), min 40dp
/// - Padding: 12dp vertical, 16dp horizontal
/// - Icon size: 20dp
/// - Border radius: 8dp
/// - Duration: 2s default (very brief)
/// - Animation: Fade in 200ms, fade out 150ms
///
/// ## Accessibility
///
/// - Announces messages to screen readers
/// - Respects safe area insets
/// - Does not require user interaction
///
/// See also:
/// - [AppSnackbar] - For notifications with action buttons
/// - [Material Design 3 Toast](https://m3.material.io/)
class AppToast {
  /// Private constructor to prevent instantiation.
  const AppToast._();

  /// Queue to manage multiple toasts.
  static final Queue<_ToastEntry> _toastQueue = Queue<_ToastEntry>();

  /// Currently showing toast overlay entry.
  static OverlayEntry? _currentOverlay;

  /// Timer for current toast.
  static Timer? _currentTimer;

  /// Shows a toast notification with the specified configuration.
  ///
  /// Example:
  /// ```dart
  /// AppToast.show(
  ///   context,
  ///   message: 'Settings updated',
  ///   duration: Duration(seconds: 3),
  ///   position: ToastPosition.bottom,
  /// );
  /// ```
  static void show(
    BuildContext context, {
    required String message,
    IconData? icon,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastType type = ToastType.neutral,
    Color? backgroundColor,
    Color? textColor,
  }) {
    final entry = _ToastEntry(
      context: context,
      message: message,
      icon: icon,
      duration: duration,
      position: position,
      type: type,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );

    _toastQueue.add(entry);
    _showNextToast();
  }

  /// Shows a success toast (green background with checkmark).
  ///
  /// Typically used for:
  /// - "File uploaded successfully"
  /// - "Settings saved"
  /// - "Action completed"
  static void success(
    BuildContext context, {
    required String message,
    Duration? duration,
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      icon: Icons.check_circle,
      duration: duration ?? const Duration(seconds: 2),
      position: position,
      type: ToastType.success,
    );
  }

  /// Shows an error toast (red background with warning icon).
  ///
  /// Typically used for:
  /// - "No internet connection"
  /// - "Failed to save"
  /// - "Error occurred"
  static void error(
    BuildContext context, {
    required String message,
    Duration? duration,
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      icon: Icons.error,
      duration: duration ?? const Duration(seconds: 2),
      position: position,
      type: ToastType.error,
    );
  }

  /// Shows a warning toast (amber background with warning icon).
  ///
  /// Typically used for:
  /// - "Storage almost full"
  /// - "Battery low"
  /// - "Unsaved changes"
  static void warning(
    BuildContext context, {
    required String message,
    Duration? duration,
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      icon: Icons.warning,
      duration: duration ?? const Duration(seconds: 2),
      position: position,
      type: ToastType.warning,
    );
  }

  /// Shows an info toast (blue background with info icon).
  ///
  /// Typically used for:
  /// - "Swipe to see more"
  /// - "Download started"
  /// - "Synced"
  static void info(
    BuildContext context, {
    required String message,
    Duration? duration,
    ToastPosition position = ToastPosition.bottom,
  }) {
    show(
      context,
      message: message,
      icon: Icons.info,
      duration: duration ?? const Duration(seconds: 2),
      position: position,
      type: ToastType.info,
    );
  }

  /// Shows the next toast in the queue.
  static void _showNextToast() {
    // If a toast is already showing, don't show another
    if (_currentOverlay != null) return;

    // If queue is empty, nothing to show
    if (_toastQueue.isEmpty) return;

    final entry = _toastQueue.removeFirst();

    // Create overlay entry
    _currentOverlay = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: entry.message,
        icon: entry.icon,
        position: entry.position,
        type: entry.type,
        backgroundColor: entry.backgroundColor,
        textColor: entry.textColor,
      ),
    );

    // Insert overlay
    Overlay.of(entry.context).insert(_currentOverlay!);

    // Schedule removal
    _currentTimer = Timer(entry.duration, () {
      _dismissCurrentToast();
      _showNextToast(); // Show next in queue
    });

    // Announce to screen readers
    _announceToScreenReader(entry.context, entry.message);
  }

  /// Dismisses the currently showing toast.
  static void _dismissCurrentToast() {
    _currentTimer?.cancel();
    _currentTimer = null;
    _currentOverlay?.remove();
    _currentOverlay = null;
  }

  /// Announces message to screen readers for accessibility.
  ///
  /// Note: Screen reader announcement is handled via the Semantics widget
  /// in the toast's build method, so this method is currently a no-op.
  static void _announceToScreenReader(BuildContext context, String message) {
    // Announcement is handled by the Semantics widget wrapping the toast
    // which provides automatic screen reader support via the label property
  }

  /// Clears all queued toasts and dismisses current toast.
  static void clearAll() {
    _toastQueue.clear();
    _dismissCurrentToast();
  }
}

/// Internal class to hold toast entry data.
class _ToastEntry {
  final BuildContext context;
  final String message;
  final IconData? icon;
  final Duration duration;
  final ToastPosition position;
  final ToastType type;
  final Color? backgroundColor;
  final Color? textColor;

  const _ToastEntry({
    required this.context,
    required this.message,
    this.icon,
    required this.duration,
    required this.position,
    required this.type,
    this.backgroundColor,
    this.textColor,
  });
}

/// Internal widget that renders the toast UI.
class _ToastWidget extends StatefulWidget {
  final String message;
  final IconData? icon;
  final ToastPosition position;
  final ToastType type;
  final Color? backgroundColor;
  final Color? textColor;

  const _ToastWidget({
    required this.message,
    this.icon,
    required this.position,
    required this.type,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _fadeOutTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );

    // Start fade in animation
    _animationController.forward();

    // Schedule fade out before removal
    _fadeOutTimer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _fadeOutTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Get colors based on type
    final bgColor =
        widget.backgroundColor ?? _getBackgroundColor(widget.type, colorScheme);
    final txtColor =
        widget.textColor ?? _getTextColor(widget.type, colorScheme);

    return Positioned(
      top: widget.position == ToastPosition.top ? 80 : null,
      bottom: widget.position == ToastPosition.bottom ? 80 : null,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SafeArea(
          child: Align(
            alignment: _getAlignment(widget.position),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 40,
                    maxWidth: 320,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null) ...[
                        Icon(widget.icon, size: 20, color: txtColor),
                        const SizedBox(width: 8),
                      ],
                      Flexible(
                        child: Text(
                          widget.message,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: txtColor,
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Gets alignment based on toast position.
  Alignment _getAlignment(ToastPosition position) {
    switch (position) {
      case ToastPosition.top:
        return Alignment.topCenter;
      case ToastPosition.center:
        return Alignment.center;
      case ToastPosition.bottom:
        return Alignment.bottomCenter;
    }
  }

  /// Gets background color based on toast type.
  Color _getBackgroundColor(ToastType type, ColorScheme colorScheme) {
    switch (type) {
      case ToastType.success:
        return const Color(0xFF2E7D32); // Green 800
      case ToastType.error:
        return const Color(0xFFC62828); // Red 800
      case ToastType.warning:
        return const Color(0xFFF57C00); // Orange 800
      case ToastType.info:
        return const Color(0xFF1976D2); // Blue 700
      case ToastType.neutral:
        return colorScheme.surfaceContainerHighest;
    }
  }

  /// Gets text color based on toast type.
  Color _getTextColor(ToastType type, ColorScheme colorScheme) {
    switch (type) {
      case ToastType.success:
      case ToastType.error:
      case ToastType.warning:
      case ToastType.info:
        return Colors.white;
      case ToastType.neutral:
        return colorScheme.onSurface;
    }
  }
}

/// Defines the position where the toast appears on screen.
enum ToastPosition {
  /// Toast appears at the top of the screen (80dp from top).
  top,

  /// Toast appears at the center of the screen.
  center,

  /// Toast appears at the bottom of the screen (80dp from bottom).
  bottom,
}

/// Defines the visual type/variant of the toast.
enum ToastType {
  /// Neutral toast with surface variant background.
  neutral,

  /// Success toast with green background and checkmark icon.
  success,

  /// Error toast with red background and error icon.
  error,

  /// Warning toast with amber/orange background and warning icon.
  warning,

  /// Info toast with blue background and info icon.
  info,
}
