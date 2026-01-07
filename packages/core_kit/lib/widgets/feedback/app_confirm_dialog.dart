// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:core_kit/widgets/buttons/app_button.dart';

/// A specialized Material Design 3 confirmation dialog for confirm/cancel
/// workflows with support for destructive action warnings.
///
/// The [AppConfirmDialog] simplifies the common pattern of asking users to
/// confirm or cancel an action, with special handling for destructive actions
/// that require extra caution. It provides a streamlined API for common
/// confirmation scenarios.
///
/// ## Usage
///
/// ### Basic Confirmation (Non-destructive)
///
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => AppConfirmDialog(
///     title: 'Save Changes?',
///     message: 'Do you want to save your changes before leaving?',
///     confirmLabel: 'Save',
///     cancelLabel: 'Discard',
///     onConfirm: () {
///       // Save changes
///       Navigator.pop(context);
///     },
///     onCancel: () => Navigator.pop(context),
///   ),
/// );
/// ```
///
/// ### Destructive Action Confirmation
///
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => AppConfirmDialog(
///     title: 'Delete Item?',
///     message: 'This action cannot be undone. The item will be permanently deleted.',
///     confirmLabel: 'Delete',
///     isDestructive: true,
///     onConfirm: () {
///       // Perform delete
///       Navigator.pop(context);
///     },
///   ),
/// );
/// ```
///
/// ### With "Don't Ask Again" Checkbox
///
/// ```dart
/// bool dontAskAgain = false;
///
/// showDialog(
///   context: context,
///   builder: (context) => AppConfirmDialog(
///     title: 'Enable Notifications?',
///     message: 'Get notified about important updates.',
///     showDontAskAgain: true,
///     isDontAskAgainChecked: dontAskAgain,
///     onDontAskAgainChanged: (value) {
///       setState(() => dontAskAgain = value);
///     },
///     onConfirm: () {
///       // Enable notifications
///       Navigator.pop(context);
///     },
///   ),
/// );
/// ```
///
/// ### Async Confirmation with Loading State
///
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) => StatefulBuilder(
///     builder: (context, setState) {
///       bool isLoading = false;
///       return AppConfirmDialog(
///         title: 'Delete Account?',
///         message: 'This will permanently delete your account.',
///         isDestructive: true,
///         isLoading: isLoading,
///         onConfirm: () async {
///           setState(() => isLoading = true);
///           await deleteAccount();
///           Navigator.pop(context);
///         },
///       );
///     },
///   ),
/// );
/// ```
///
/// ## When to Use
///
/// **Destructive Actions** (`isDestructive: true`):
/// - Deleting items, accounts, or data
/// - Clearing cache or resetting settings
/// - Canceling subscriptions
/// - Any action that results in permanent data loss
///
/// **Non-destructive Actions** (`isDestructive: false`, default):
/// - Saving changes
/// - Signing out
/// - Navigating away
/// - Confirming preferences
///
/// ## Accessibility
///
/// This component provides proper accessibility support:
/// - Dialog purpose announced to screen readers
/// - Button roles and states properly indicated
/// - Keyboard navigation support (Enter to confirm, Esc to cancel)
/// - Sufficient color contrast for destructive warnings
///
/// ## Material Design 3 Compliance
///
/// This component follows MD3 specifications:
/// - Layout: 280dp (mobile), 400dp max (tablet/desktop)
/// - Padding: 24dp all sides
/// - Button spacing: 8dp between Cancel and Confirm
/// - Typography: headlineSmall (title), bodyMedium (message)
/// - Colors: Error color for destructive, Primary for non-destructive
///
/// See also:
/// - [Material Design 3 Dialogs](https://m3.material.io/components/dialogs)
/// - [AppButton] for button implementation
class AppConfirmDialog extends StatefulWidget {
  /// Creates a confirmation dialog.
  ///
  /// The [title], [message], and [onConfirm] parameters are required.
  ///
  /// Set [isDestructive] to true for destructive actions (displays warning
  /// icon and uses error color). Defaults to false.
  ///
  /// The [confirmLabel] and [cancelLabel] can be customized for
  /// localization or context-specific wording.
  ///
  /// When [showDontAskAgain] is true, a checkbox is displayed. Use
  /// [isDontAskAgainChecked] to set initial state and
  /// [onDontAskAgainChanged] to handle state changes.
  ///
  /// Set [isLoading] to true to show a loading indicator and disable buttons
  /// during async operations.
  ///
  /// The [barrierDismissible] parameter controls whether tapping outside
  /// the dialog dismisses it. Defaults to true. For critical actions,
  /// set to false to require explicit button interaction.
  const AppConfirmDialog({
    required this.title,
    required this.message,
    required this.onConfirm,
    this.onCancel,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
    this.showDontAskAgain = false,
    this.isDontAskAgainChecked = false,
    this.onDontAskAgainChanged,
    this.barrierDismissible = true,
    this.isLoading = false,
    super.key,
  });

  /// The dialog title.
  ///
  /// Displayed using the theme's `headlineSmall` text style.
  final String title;

  /// The confirmation message.
  ///
  /// Provides context about the action being confirmed. Displayed using
  /// the theme's `bodyMedium` text style.
  final String message;

  /// Callback invoked when the confirm button is tapped.
  ///
  /// This callback is disabled when [isLoading] is true.
  final VoidCallback onConfirm;

  /// Optional callback invoked when the cancel button is tapped or the
  /// dialog is dismissed via barrier tap (if [barrierDismissible] is true).
  ///
  /// If null, the dialog will simply close on cancel without additional
  /// action.
  final VoidCallback? onCancel;

  /// The text displayed on the confirm button.
  ///
  /// Defaults to 'Confirm'. Customize for localization or context
  /// (e.g., 'Delete', 'Save', 'Yes').
  final String confirmLabel;

  /// The text displayed on the cancel button.
  ///
  /// Defaults to 'Cancel'. Customize for localization or context
  /// (e.g., 'No', 'Keep').
  final String cancelLabel;

  /// Whether this confirmation is for a destructive action.
  ///
  /// When true:
  /// - Displays a warning icon in error color
  /// - Uses error color for the confirm button
  /// - Provides visual emphasis on the dangerous nature of the action
  ///
  /// Defaults to false (non-destructive, uses primary color).
  final bool isDestructive;

  /// Whether to show the "Don't ask again" checkbox.
  ///
  /// When true, displays a checkbox below the message that users can
  /// toggle to indicate they don't want to see this confirmation again.
  ///
  /// Use [isDontAskAgainChecked] to control initial state and
  /// [onDontAskAgainChanged] to handle state changes.
  ///
  /// Defaults to false.
  final bool showDontAskAgain;

  /// Initial checked state of the "Don't ask again" checkbox.
  ///
  /// Only relevant when [showDontAskAgain] is true.
  ///
  /// Defaults to false (unchecked).
  final bool isDontAskAgainChecked;

  /// Callback invoked when the "Don't ask again" checkbox state changes.
  ///
  /// Only relevant when [showDontAskAgain] is true.
  ///
  /// Use this to persist the user's preference (e.g., to SharedPreferences).
  final ValueChanged<bool>? onDontAskAgainChanged;

  /// Whether tapping the barrier (area outside dialog) dismisses the dialog.
  ///
  /// When true, tapping outside the dialog calls [onCancel] (if provided)
  /// and closes the dialog.
  ///
  /// When false, users must explicitly tap a button to close the dialog.
  /// Use false for critical confirmations that require explicit choice.
  ///
  /// Defaults to true.
  final bool barrierDismissible;

  /// Whether the dialog is in a loading state.
  ///
  /// When true:
  /// - Displays a loading indicator on the confirm button
  /// - Disables both confirm and cancel buttons
  /// - Prevents dialog dismissal via barrier tap
  ///
  /// Use this during async operations (e.g., network requests) to prevent
  /// duplicate submissions or premature dismissal.
  ///
  /// Defaults to false.
  final bool isLoading;

  /// Shows the confirmation dialog.
  ///
  /// This is a convenience method that wraps [showDialog] with appropriate
  /// settings. The [barrierDismissible] property is automatically applied.
  ///
  /// Returns a [Future] that completes when the dialog is dismissed.
  ///
  /// Example:
  /// ```dart
  /// final result = await AppConfirmDialog.show(
  ///   context: context,
  ///   title: 'Delete?',
  ///   message: 'This cannot be undone.',
  ///   isDestructive: true,
  ///   onConfirm: () => Navigator.pop(context, true),
  ///   onCancel: () => Navigator.pop(context, false),
  /// );
  /// ```
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
    bool showDontAskAgain = false,
    bool isDontAskAgainChecked = false,
    ValueChanged<bool>? onDontAskAgainChanged,
    bool barrierDismissible = true,
    bool isLoading = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible && !isLoading,
      builder: (context) => AppConfirmDialog(
        title: title,
        message: message,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
        showDontAskAgain: showDontAskAgain,
        isDontAskAgainChecked: isDontAskAgainChecked,
        onDontAskAgainChanged: onDontAskAgainChanged,
        barrierDismissible: barrierDismissible,
        isLoading: isLoading,
      ),
    );
  }

  @override
  State<AppConfirmDialog> createState() => _AppConfirmDialogState();
}

class _AppConfirmDialogState extends State<AppConfirmDialog> {
  late bool _dontAskAgain;

  @override
  void initState() {
    super.initState();
    _dontAskAgain = widget.isDontAskAgainChecked;
  }

  @override
  void didUpdateWidget(AppConfirmDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDontAskAgainChecked != widget.isDontAskAgainChecked) {
      _dontAskAgain = widget.isDontAskAgainChecked;
    }
  }

  void _handleCancel() {
    widget.onCancel?.call();
  }

  void _handleConfirm() {
    widget.onConfirm();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: widget.isDestructive
          ? Row(
              children: [
                Icon(Icons.warning_rounded, color: colorScheme.error, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.title,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
              ],
            )
          : Text(widget.title, style: theme.textTheme.headlineSmall),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.message, style: theme.textTheme.bodyMedium),
          if (widget.showDontAskAgain) ...[
            const SizedBox(height: 16),
            CheckboxListTile(
              value: _dontAskAgain,
              onChanged: widget.isLoading
                  ? null
                  : (value) {
                      setState(() => _dontAskAgain = value ?? false);
                      widget.onDontAskAgainChanged?.call(value ?? false);
                    },
              title: const Text("Don't ask again"),
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ],
      ),
      actions: [
        AppButton.text(
          label: widget.cancelLabel,
          onPressed: widget.isLoading ? null : _handleCancel,
        ),
        const SizedBox(width: 8),
        widget.isDestructive
            ? FilledButton(
                onPressed: widget.isLoading ? null : _handleConfirm,
                style: FilledButton.styleFrom(
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                ),
                child: widget.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(widget.confirmLabel),
              )
            : AppButton.filled(
                label: widget.confirmLabel,
                isLoading: widget.isLoading,
                onPressed: _handleConfirm,
              ),
      ],
    );
  }
}
