// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 snackbar component for brief, dismissible notifications.
///
/// The [AppSnackbar] provides lightweight feedback about operations without
/// blocking user interaction. Snackbars appear at the bottom of the screen
/// and can include an optional action button.
///
/// ## Features
///
/// - Brief notification messages
/// - Optional action button (e.g., "Undo", "Retry")
/// - Optional leading icon
/// - Auto-dismiss with configurable duration
/// - Manual dismiss via swipe gesture
/// - Semantic color variants (success, error, warning, info)
/// - Queue management for multiple snackbars
/// - Safe area handling (avoids bottom navigation and FAB)
///
/// ## Basic Usage
///
/// ```dart
/// ScaffoldMessenger.of(context).showSnackBar(
///   AppSnackbar.build(
///     message: 'Item deleted',
///   ),
/// );
/// ```
///
/// ## With Action Button
///
/// ```dart
/// ScaffoldMessenger.of(context).showSnackBar(
///   AppSnackbar.build(
///     message: 'Email archived',
///     actionLabel: 'UNDO',
///     onActionPressed: () {
///       // Restore email
///     },
///   ),
/// );
/// ```
///
/// ## Semantic Variants
///
/// ```dart
/// // Success
/// AppSnackbar.success(context, message: 'Settings saved successfully');
///
/// // Error
/// AppSnackbar.error(context, message: 'Network error, tap to retry');
///
/// // Warning
/// AppSnackbar.warning(context, message: 'Storage almost full');
///
/// // Info
/// AppSnackbar.info(context, message: 'Downloaded 3 files');
/// ```
///
/// ## Material Design 3 Specifications
///
/// - Width: Full width minus 16dp margins (mobile), max 560dp (desktop)
/// - Height: 48dp single-line, 68dp multi-line
/// - Padding: 16dp vertical, 16dp horizontal
/// - Duration: 4s default (short), 10s with action (long)
/// - Animation: Slide up (150ms), fade out (75ms)
/// - Colors: Inverse surface background, inverse on-surface text
///
/// ## Accessibility
///
/// - Announces messages to screen readers
/// - Minimum touch target of 48x48dp for action button
/// - Swipe gesture for manual dismissal
/// - Respects system animation settings
///
/// See also:
/// - [Material Design 3 Snackbar](https://m3.material.io/components/snackbar)
/// - [SnackBar] - Flutter's base snackbar widget
/// - [ScaffoldMessenger] - Manager for showing snackbars
class AppSnackbar {
  /// Creates a Material Design 3 snackbar.
  ///
  /// Use [AppSnackbar.build] to create a SnackBar widget, or use
  /// convenience methods like [success], [error], [warning], [info]
  /// to show snackbars directly.
  const AppSnackbar._();

  /// Builds a SnackBar widget with the specified configuration.
  ///
  /// Use this method when you need the SnackBar widget directly,
  /// or prefer to use [ScaffoldMessenger.showSnackBar] manually.
  ///
  /// Example:
  /// ```dart
  /// ScaffoldMessenger.of(context).showSnackBar(
  ///   AppSnackbar.build(
  ///     message: 'Settings saved',
  ///     actionLabel: 'VIEW',
  ///     onActionPressed: () => Navigator.push(...),
  ///   ),
  /// );
  /// ```
  static SnackBar build({
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    IconData? icon,
    Duration duration = const Duration(seconds: 4),
    AppSnackbarType type = AppSnackbarType.standard,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    DismissDirection dismissDirection = DismissDirection.down,
    VoidCallback? onDismissed,
  }) {
    return SnackBar(
      content: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 24, color: _getIconColor(type)),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(message, maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
      action: actionLabel != null && onActionPressed != null
          ? SnackBarAction(label: actionLabel, onPressed: onActionPressed)
          : null,
      duration: duration,
      behavior: behavior,
      dismissDirection: dismissDirection,
      backgroundColor: _getBackgroundColor(type),
      showCloseIcon: actionLabel == null,
      onVisible: () {
        // Callback when snackbar becomes visible
      },
    );
  }

  /// Shows a standard snackbar with default styling.
  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    IconData? icon,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      build(
        message: message,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        icon: icon,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  /// Shows a success snackbar (green background).
  ///
  /// Typically used for successful operations like:
  /// - "Settings saved successfully"
  /// - "File uploaded"
  /// - "Account created"
  static void success(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      build(
        message: message,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        icon: Icons.check_circle,
        type: AppSnackbarType.success,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  /// Shows an error snackbar (red background).
  ///
  /// Typically used for error notifications like:
  /// - "Network error, tap to retry"
  /// - "Failed to save changes"
  /// - "Invalid credentials"
  static void error(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      build(
        message: message,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        icon: Icons.error,
        type: AppSnackbarType.error,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  /// Shows a warning snackbar (amber background).
  ///
  /// Typically used for warnings like:
  /// - "Storage almost full"
  /// - "Unsaved changes"
  /// - "Battery low"
  static void warning(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      build(
        message: message,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        icon: Icons.warning,
        type: AppSnackbarType.warning,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  /// Shows an info snackbar (blue background).
  ///
  /// Typically used for informational messages like:
  /// - "Downloaded 3 files"
  /// - "You're offline. Changes will sync when online."
  /// - "New version available"
  static void info(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      build(
        message: message,
        actionLabel: actionLabel,
        onActionPressed: onActionPressed,
        icon: Icons.info,
        type: AppSnackbarType.info,
        duration: duration ?? const Duration(seconds: 4),
      ),
    );
  }

  /// Dismisses the currently showing snackbar.
  static void dismiss(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Clears all queued snackbars.
  static void clearQueue(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  // Helper method to get background color based on type
  static Color? _getBackgroundColor(AppSnackbarType type) {
    switch (type) {
      case AppSnackbarType.success:
        return const Color(0xFF2E7D32); // Green 800
      case AppSnackbarType.error:
        return const Color(0xFFC62828); // Red 800
      case AppSnackbarType.warning:
        return const Color(0xFFF57C00); // Orange 800
      case AppSnackbarType.info:
        return const Color(0xFF1976D2); // Blue 700
      case AppSnackbarType.standard:
        return null; // Uses theme default (inverse surface)
    }
  }

  // Helper method to get icon color based on type
  static Color _getIconColor(AppSnackbarType type) {
    switch (type) {
      case AppSnackbarType.success:
        return Colors.white;
      case AppSnackbarType.error:
        return Colors.white;
      case AppSnackbarType.warning:
        return Colors.white;
      case AppSnackbarType.info:
        return Colors.white;
      case AppSnackbarType.standard:
        return Colors.white70;
    }
  }
}

/// Defines the visual type/variant of the snackbar.
enum AppSnackbarType {
  /// Standard snackbar with default inverse surface color.
  standard,

  /// Success snackbar with green background.
  success,

  /// Error snackbar with red background.
  error,

  /// Warning snackbar with amber/orange background.
  warning,

  /// Info snackbar with blue background.
  info,
}
