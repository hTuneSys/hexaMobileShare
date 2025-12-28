// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';

/// A Material Design 3 error state component that displays error information
/// with actionable recovery steps.
///
/// The [AppErrorState] component transforms technical errors into user-friendly
/// messages with clear next steps. It provides semantic error types, customizable
/// actions, and follows Material Design 3 guidelines for error communication.
///
/// ## Usage
///
/// ```dart
/// // Basic error state
/// AppErrorState(
///   title: 'Something went wrong',
///   description: 'Please try again later.',
///   onRetry: () => retryOperation(),
/// )
///
/// // Network error with named constructor
/// AppErrorState.network(
///   onRetry: () => retryNetworkRequest(),
/// )
///
/// // Server error with secondary action
/// AppErrorState.serverError(
///   onRetry: () => retryRequest(),
///   onSecondaryAction: () => contactSupport(),
///   secondaryButtonLabel: 'Contact Support',
/// )
///
/// // Compact variant for inline display
/// AppErrorState(
///   title: 'Failed to load',
///   description: 'Check your connection.',
///   variant: AppErrorStateVariant.compact,
///   onRetry: () => reload(),
/// )
/// ```
///
/// ## When to Use Each Error Type
///
/// **Network** ([AppErrorType.network]):
/// - No internet connection
/// - Connection timeout
/// - DNS resolution failures
///
/// **Server** ([AppErrorType.server]):
/// - 500 Internal Server Error
/// - 502 Bad Gateway
/// - 503 Service Unavailable
///
/// **Not Found** ([AppErrorType.notFound]):
/// - 404 Not Found
/// - Resource deleted or moved
/// - Invalid URL
///
/// **Permission** ([AppErrorType.permission]):
/// - 403 Forbidden
/// - Authentication required
/// - Insufficient permissions
///
/// **Generic** ([AppErrorType.generic]):
/// - Unknown errors
/// - Custom error scenarios
/// - Validation errors
///
/// ## Accessibility
///
/// This component automatically provides proper accessibility support:
/// - Semantic error announcements for screen readers
/// - Live region updates for dynamic errors
/// - Proper button accessibility via AppButton
/// - High contrast error colors
///
/// ## Material Design 3 Compliance
///
/// This component follows MD3 specifications:
/// - Error colors from theme's error color scheme
/// - Typography: headlineSmall/titleLarge for titles, bodyLarge/bodyMedium for descriptions
/// - Icon sizes: 64dp (full-screen), 48dp (compact)
/// - Spacing: 16dp, 8dp, 24dp following MD3 layout guidelines
///
/// See also:
/// - [Material Design 3 Error Handling](https://m3.material.io/foundations/content-design/error-messages)
/// - [AppErrorType] for available error types
/// - [AppErrorStateVariant] for display variants
class AppErrorState extends StatelessWidget {
  /// Creates an error state component.
  ///
  /// The [title] and [description] parameters are required and provide
  /// the main error messaging to users.
  ///
  /// Use [errorType] to specify the semantic type of error, which determines
  /// the icon and color scheme. Defaults to [AppErrorType.generic].
  ///
  /// Provide [onRetry] to show a retry button. Provide [onSecondaryAction]
  /// to show a secondary action button (e.g., "Go Back", "Contact Support").
  ///
  /// Set [variant] to [AppErrorStateVariant.compact] for inline display,
  /// or use [AppErrorStateVariant.fullScreen] (default) for centered display.
  const AppErrorState({
    required this.title,
    required this.description,
    this.errorType = AppErrorType.generic,
    this.onRetry,
    this.onSecondaryAction,
    this.retryButtonLabel = 'Retry',
    this.secondaryButtonLabel = 'Go Back',
    this.errorCode,
    this.stackTrace,
    this.showStackTrace = false,
    this.variant = AppErrorStateVariant.fullScreen,
    super.key,
  });

  /// Creates a network error state.
  ///
  /// Displays a "No internet connection" message with a wifi-off icon.
  ///
  /// Example:
  /// ```dart
  /// AppErrorState.network(
  ///   onRetry: () => retryNetworkRequest(),
  /// )
  /// ```
  const AppErrorState.network({
    this.title = 'No internet connection',
    this.description = 'Check your connection and try again.',
    this.onRetry,
    this.onSecondaryAction,
    this.retryButtonLabel = 'Retry',
    this.secondaryButtonLabel = 'Go Back',
    this.errorCode,
    this.stackTrace,
    this.showStackTrace = false,
    this.variant = AppErrorStateVariant.fullScreen,
    super.key,
  }) : errorType = AppErrorType.network;

  /// Creates a server error state (500).
  ///
  /// Displays a "Server error" message with an error icon.
  ///
  /// Example:
  /// ```dart
  /// AppErrorState.serverError(
  ///   onRetry: () => retryRequest(),
  ///   onSecondaryAction: () => contactSupport(),
  ///   secondaryButtonLabel: 'Contact Support',
  /// )
  /// ```
  const AppErrorState.serverError({
    this.title = 'Server error',
    this.description = "We're working on it. Try again later.",
    this.onRetry,
    this.onSecondaryAction,
    this.retryButtonLabel = 'Retry',
    this.secondaryButtonLabel = 'Contact Support',
    this.errorCode,
    this.stackTrace,
    this.showStackTrace = false,
    this.variant = AppErrorStateVariant.fullScreen,
    super.key,
  }) : errorType = AppErrorType.server;

  /// Creates a not found error state (404).
  ///
  /// Displays a "Page not found" message with a search-off icon.
  ///
  /// Example:
  /// ```dart
  /// AppErrorState.notFound(
  ///   onSecondaryAction: () => Navigator.pop(context),
  ///   secondaryButtonLabel: 'Go Back',
  /// )
  /// ```
  const AppErrorState.notFound({
    this.title = 'Page not found',
    this.description = 'It may have been moved or deleted.',
    this.onRetry,
    this.onSecondaryAction,
    this.retryButtonLabel = 'Retry',
    this.secondaryButtonLabel = 'Go Back',
    this.errorCode,
    this.stackTrace,
    this.showStackTrace = false,
    this.variant = AppErrorStateVariant.fullScreen,
    super.key,
  }) : errorType = AppErrorType.notFound;

  /// Creates a permission denied error state.
  ///
  /// Displays a "Permission denied" message with a block icon.
  ///
  /// Example:
  /// ```dart
  /// AppErrorState.permissionDenied(
  ///   description: 'Please grant camera access in Settings.',
  ///   onSecondaryAction: () => openAppSettings(),
  ///   secondaryButtonLabel: 'Open Settings',
  /// )
  /// ```
  const AppErrorState.permissionDenied({
    this.title = 'Permission denied',
    this.description = 'You do not have permission to access this resource.',
    this.onRetry,
    this.onSecondaryAction,
    this.retryButtonLabel = 'Retry',
    this.secondaryButtonLabel = 'Go Back',
    this.errorCode,
    this.stackTrace,
    this.showStackTrace = false,
    this.variant = AppErrorStateVariant.fullScreen,
    super.key,
  }) : errorType = AppErrorType.permission;

  /// The error title displayed prominently.
  ///
  /// This should be a short, clear description of what went wrong.
  /// Uses theme's headlineSmall (full-screen) or titleLarge (compact).
  final String title;

  /// The error description providing more context.
  ///
  /// This should explain the error and suggest next steps.
  /// Uses theme's bodyLarge (full-screen) or bodyMedium (compact).
  final String description;

  /// The semantic type of error.
  ///
  /// Determines the icon and color scheme. Defaults to [AppErrorType.generic].
  final AppErrorType errorType;

  /// Callback invoked when the retry button is pressed.
  ///
  /// If null, the retry button will not be displayed.
  final VoidCallback? onRetry;

  /// Callback invoked when the secondary action button is pressed.
  ///
  /// If null, the secondary button will not be displayed.
  final VoidCallback? onSecondaryAction;

  /// Label for the retry button.
  ///
  /// Defaults to "Retry".
  final String retryButtonLabel;

  /// Label for the secondary action button.
  ///
  /// Defaults to "Go Back".
  final String secondaryButtonLabel;

  /// Optional error code to display.
  ///
  /// When provided, displays below the description in a monospace font.
  final String? errorCode;

  /// Optional stack trace for debugging.
  ///
  /// Only displayed when [showStackTrace] is true and running in debug mode.
  final StackTrace? stackTrace;

  /// Whether to show the stack trace in debug builds.
  ///
  /// Defaults to false. Stack trace is only shown when [kDebugMode] is true.
  final bool showStackTrace;

  /// The display variant of the error state.
  ///
  /// Defaults to [AppErrorStateVariant.fullScreen].
  final AppErrorStateVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine icon based on error type
    final icon = _getIconForErrorType();

    // Determine icon color based on error type
    final iconColor = _getIconColorForErrorType(colorScheme);

    // Determine icon size based on variant
    final iconSize = variant == AppErrorStateVariant.fullScreen ? 64.0 : 48.0;

    // Determine typography based on variant
    final titleStyle = variant == AppErrorStateVariant.fullScreen
        ? theme.textTheme.headlineSmall
        : theme.textTheme.titleLarge;

    final descriptionStyle = variant == AppErrorStateVariant.fullScreen
        ? theme.textTheme.bodyLarge
        : theme.textTheme.bodyMedium;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Error icon
        Icon(icon, size: iconSize, color: iconColor),
        const SizedBox(height: 16),

        // Error title
        Text(
          title,
          style: titleStyle?.copyWith(color: colorScheme.onSurface),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),

        // Error description
        Text(
          description,
          style: descriptionStyle?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),

        // Error code (if provided)
        if (errorCode != null) ...[
          const SizedBox(height: 8),
          Text(
            'Error code: $errorCode',
            style: theme.textTheme.labelSmall?.copyWith(
              fontFamily: 'monospace',
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],

        // Stack trace (debug only)
        if (kDebugMode && showStackTrace && stackTrace != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                stackTrace.toString(),
                style: theme.textTheme.labelSmall?.copyWith(
                  fontFamily: 'monospace',
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
        ],

        // Action buttons
        if (onRetry != null || onSecondaryAction != null) ...[
          const SizedBox(height: 24),
          _buildActionButtons(),
        ],
      ],
    );

    // Wrap with accessibility
    final accessibleContent = Semantics(
      label: 'Error: $title. $description',
      liveRegion: true,
      child: Padding(padding: const EdgeInsets.all(16.0), child: content),
    );

    // Apply variant layout
    if (variant == AppErrorStateVariant.fullScreen) {
      return Center(child: accessibleContent);
    }

    return accessibleContent;
  }

  /// Builds the action buttons row.
  Widget _buildActionButtons() {
    // If only retry button
    if (onRetry != null && onSecondaryAction == null) {
      return AppButton.filled(label: retryButtonLabel, onPressed: onRetry);
    }

    // If only secondary button
    if (onRetry == null && onSecondaryAction != null) {
      return AppButton.outlined(
        label: secondaryButtonLabel,
        onPressed: onSecondaryAction,
      );
    }

    // Both buttons
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppButton.text(
          label: secondaryButtonLabel,
          onPressed: onSecondaryAction,
        ),
        const SizedBox(width: 8),
        AppButton.filled(label: retryButtonLabel, onPressed: onRetry),
      ],
    );
  }

  /// Returns the appropriate icon for the error type.
  IconData _getIconForErrorType() {
    return switch (errorType) {
      AppErrorType.network => Icons.wifi_off,
      AppErrorType.server => Icons.error_outline,
      AppErrorType.notFound => Icons.search_off,
      AppErrorType.permission => Icons.block,
      AppErrorType.generic => Icons.error,
    };
  }

  /// Returns the appropriate icon color for the error type.
  Color _getIconColorForErrorType(ColorScheme colorScheme) {
    return switch (errorType) {
      AppErrorType.network => colorScheme.error,
      AppErrorType.server => colorScheme.error,
      AppErrorType.notFound => colorScheme.primary,
      AppErrorType.permission => colorScheme.tertiary, // Warning color
      AppErrorType.generic => colorScheme.error,
    };
  }
}

/// Semantic error types for [AppErrorState].
///
/// Each type provides appropriate icons and visual styling to communicate
/// the nature of the error to users.
enum AppErrorType {
  /// Network-related errors (no connection, timeout, DNS failure).
  ///
  /// Icon: wifi_off
  /// Color: error
  network,

  /// Server-side errors (500, 502, 503).
  ///
  /// Icon: error_outline
  /// Color: error
  server,

  /// Resource not found errors (404).
  ///
  /// Icon: search_off
  /// Color: primary
  notFound,

  /// Permission and authorization errors (403).
  ///
  /// Icon: block
  /// Color: tertiary (warning)
  permission,

  /// Generic or unknown errors.
  ///
  /// Icon: error
  /// Color: error
  generic,
}

/// Display variants for [AppErrorState].
///
/// Controls the layout and sizing of the error state component.
enum AppErrorStateVariant {
  /// Full-screen variant with centered content.
  ///
  /// Uses larger typography and icon sizes. Best for dedicated error pages.
  fullScreen,

  /// Compact variant for inline display.
  ///
  /// Uses smaller typography and icon sizes. Best for error states within
  /// cards, lists, or other constrained layouts.
  compact,
}
