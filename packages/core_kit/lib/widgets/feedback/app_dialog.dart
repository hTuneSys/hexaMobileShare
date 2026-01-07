// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_radius.dart';
import '../../theme/app_spacing.dart';

/// A Material Design 3 dialog component that displays modal content.
///
/// [AppDialog] provides a modal overlay that interrupts the user's workflow
/// to present critical information or request important decisions.
///
/// The dialog supports:
/// - Optional title and icon
/// - Scrollable content area
/// - Up to 3 action buttons
/// - Dismissal via backdrop tap, back button, or ESC key
/// - Responsive sizing for mobile, tablet, and desktop
/// - Full-screen variant for mobile devices
/// - Custom content builder for complex layouts
///
/// Example - Basic Alert:
/// ```dart
/// AppDialog.show(
///   context: context,
///   title: 'Success',
///   content: 'Your changes have been saved.',
///   actions: [
///     AppDialogAction(
///       label: 'OK',
///       onPressed: () => Navigator.of(context).pop(),
///     ),
///   ],
/// );
/// ```
///
/// Example - Confirmation Dialog:
/// ```dart
/// AppDialog.show(
///   context: context,
///   title: 'Delete Item',
///   content: 'Are you sure you want to delete this item? This action cannot be undone.',
///   actions: [
///     AppDialogAction(
///       label: 'Cancel',
///       isSecondary: true,
///       onPressed: () => Navigator.of(context).pop(false),
///     ),
///     AppDialogAction(
///       label: 'Delete',
///       isDestructive: true,
///       onPressed: () => Navigator.of(context).pop(true),
///     ),
///   ],
/// );
/// ```
class AppDialog extends StatelessWidget {
  /// Creates a Material Design 3 dialog.
  const AppDialog({
    super.key,
    this.title,
    this.icon,
    this.content,
    this.contentBuilder,
    this.actions = const [],
    this.isDismissible = true,
    this.isFullScreen = false,
    this.barrierColor,
    this.scrollable = true,
  }) : assert(
         content != null || contentBuilder != null,
         'Either content or contentBuilder must be provided',
       );

  /// The title displayed at the top of the dialog.
  ///
  /// Uses [TextTheme.headlineSmall] from the current theme.
  final String? title;

  /// Optional icon displayed above the title.
  ///
  /// Useful for alert, warning, or success dialogs.
  final Widget? icon;

  /// The text content of the dialog.
  ///
  /// Uses [TextTheme.bodyMedium] from the current theme.
  /// For complex content, use [contentBuilder] instead.
  final String? content;

  /// Custom content builder for complex dialog layouts.
  ///
  /// Use this when [content] is not sufficient for your needs.
  /// The builder provides the [BuildContext] for accessing theme data.
  final Widget Function(BuildContext)? contentBuilder;

  /// List of action buttons displayed at the bottom of the dialog.
  ///
  /// Typically contains 1-3 actions. Actions are displayed in a row
  /// with appropriate spacing and styling.
  final List<AppDialogAction> actions;

  /// Whether the dialog can be dismissed by tapping the barrier (backdrop).
  ///
  /// Defaults to `true`. When `false`, the user must interact with
  /// an action button to dismiss the dialog.
  final bool isDismissible;

  /// Whether to display the dialog in full-screen mode.
  ///
  /// Useful for mobile devices when displaying complex content or forms.
  /// Defaults to `false`.
  final bool isFullScreen;

  /// Custom barrier (backdrop) color.
  ///
  /// Defaults to Material Design 3 scrim color (black @ 32% opacity).
  final Color? barrierColor;

  /// Whether the content area should be scrollable.
  ///
  /// Defaults to `true`. When content exceeds the maximum height,
  /// it becomes scrollable automatically.
  final bool scrollable;

  /// Shows a dialog using Material Design 3 specifications.
  ///
  /// Returns a [Future] that resolves to the value passed to [Navigator.pop]
  /// when the dialog is dismissed.
  ///
  /// Example:
  /// ```dart
  /// final result = await AppDialog.show<bool>(
  ///   context: context,
  ///   title: 'Confirm',
  ///   content: 'Do you want to continue?',
  ///   actions: [
  ///     AppDialogAction(
  ///       label: 'Cancel',
  ///       onPressed: () => Navigator.of(context).pop(false),
  ///     ),
  ///     AppDialogAction(
  ///       label: 'Continue',
  ///       onPressed: () => Navigator.of(context).pop(true),
  ///     ),
  ///   ],
  /// );
  /// if (result == true) {
  ///   // User confirmed
  /// }
  /// ```
  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    Widget? icon,
    String? content,
    Widget Function(BuildContext)? contentBuilder,
    List<AppDialogAction> actions = const [],
    bool isDismissible = true,
    bool isFullScreen = false,
    Color? barrierColor,
    bool scrollable = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      barrierColor: barrierColor,
      builder: (context) => AppDialog(
        title: title,
        icon: icon,
        content: content,
        contentBuilder: contentBuilder,
        actions: actions,
        isDismissible: isDismissible,
        isFullScreen: isFullScreen,
        scrollable: scrollable,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Handle ESC key dismissal
    return CallbackShortcuts(
      bindings: isDismissible
          ? {
              const SingleActivator(LogicalKeyboardKey.escape): () {
                Navigator.of(context).pop();
              },
            }
          : {},
      child: Focus(
        autofocus: true,
        child: isFullScreen
            ? _buildFullScreenDialog(context, theme, colorScheme, textTheme)
            : _buildStandardDialog(context, theme, colorScheme, textTheme),
      ),
    );
  }

  /// Builds a standard Material Design 3 dialog.
  Widget _buildStandardDialog(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.xlRadius, // M3 extra-large (28dp)
      ),
      elevation: 3,
      backgroundColor: colorScheme.surface,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: _getDialogWidth(context),
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (icon != null || title != null) ...[
              _buildHeader(context, colorScheme, textTheme),
            ],
            Flexible(child: _buildContent(context, colorScheme, textTheme)),
            if (actions.isNotEmpty) ...[
              _buildActions(context, colorScheme, textTheme),
            ],
          ],
        ),
      ),
    );
  }

  /// Builds a full-screen dialog variant.
  Widget _buildFullScreenDialog(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: isDismissible ? () => Navigator.of(context).pop() : null,
        ),
        title: title != null
            ? Text(
                title!,
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onSurface,
                ),
              )
            : null,
        actions: actions.isNotEmpty
            ? actions
                  .map(
                    (action) => TextButton(
                      onPressed: action.onPressed,
                      child: Text(
                        action.label,
                        style: TextStyle(
                          color: action.isDestructive
                              ? colorScheme.error
                              : colorScheme.primary,
                        ),
                      ),
                    ),
                  )
                  .toList()
            : null,
      ),
      body: _buildContent(context, colorScheme, textTheme),
    );
  }

  /// Builds the dialog header (icon + title).
  Widget _buildHeader(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg, // 24dp
        AppSpacing.lg, // 24dp
        AppSpacing.lg, // 24dp
        AppSpacing.md, // 16dp
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(color: colorScheme.secondary, size: 24.0),
              child: icon!,
            ),
            const SizedBox(height: AppSpacing.md), // 16dp
          ],
          if (title != null)
            Text(
              title!,
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }

  /// Builds the dialog content area.
  Widget _buildContent(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    final contentWidget = contentBuilder != null
        ? contentBuilder!(context)
        : content != null
        ? Text(
            content!,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          )
        : const SizedBox.shrink();

    if (scrollable && !isFullScreen) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg), // 24dp
        child: contentWidget,
      );
    }

    return Padding(
      padding: isFullScreen
          ? const EdgeInsets.all(AppSpacing.lg) // 24dp
          : const EdgeInsets.symmetric(horizontal: AppSpacing.lg), // 24dp
      child: contentWidget,
    );
  }

  /// Builds the dialog action buttons.
  Widget _buildActions(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg, // 24dp
        AppSpacing.md, // 16dp
        AppSpacing.lg, // 24dp
        AppSpacing.lg, // 24dp
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          for (int i = 0; i < actions.length; i++) ...[
            if (i > 0) const SizedBox(width: AppSpacing.sm), // 8dp
            Flexible(
              child: _buildActionButton(
                context,
                actions[i],
                colorScheme,
                textTheme,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Builds a single action button.
  Widget _buildActionButton(
    BuildContext context,
    AppDialogAction action,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    if (action.isSecondary) {
      return TextButton(onPressed: action.onPressed, child: Text(action.label));
    }

    if (action.isDestructive) {
      return FilledButton(
        onPressed: action.onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.error,
          foregroundColor: colorScheme.onError,
        ),
        child: Text(action.label),
      );
    }

    return FilledButton(onPressed: action.onPressed, child: Text(action.label));
  }

  /// Gets the appropriate dialog width based on screen size.
  double _getDialogWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) {
      // Mobile
      return 280.0;
    } else {
      // Tablet/Desktop
      return 560.0;
    }
  }
}

/// Represents an action button in an [AppDialog].
///
/// Each action has a label and an optional callback function.
/// Actions can be styled as primary, secondary, or destructive.
class AppDialogAction {
  /// Creates a dialog action.
  const AppDialogAction({
    required this.label,
    required this.onPressed,
    this.isSecondary = false,
    this.isDestructive = false,
  }) : assert(
         !(isSecondary && isDestructive),
         'An action cannot be both secondary and destructive',
       );

  /// The text label displayed on the action button.
  final String label;

  /// Callback invoked when the action button is pressed.
  ///
  /// Typically closes the dialog by calling [Navigator.pop].
  final VoidCallback? onPressed;

  /// Whether this is a secondary (text button) action.
  ///
  /// Secondary actions are typically used for "Cancel" or dismissive actions.
  /// Defaults to `false`.
  final bool isSecondary;

  /// Whether this is a destructive action.
  ///
  /// Destructive actions are styled with error colors to indicate
  /// potentially dangerous operations (e.g., "Delete", "Remove").
  /// Defaults to `false`.
  final bool isDestructive;
}
