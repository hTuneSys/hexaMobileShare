// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/feedback/app_confirm_dialog.dart';

/// Widgetbook stories for [AppConfirmDialog] component.
///
/// Demonstrates various configurations and use cases for the Material Design 3
/// confirmation dialog component, including destructive actions, async operations,
/// and custom button labels.

@widgetbook.UseCase(name: 'Interactive Playground', type: AppConfirmDialog)
Widget appConfirmDialogPlayground(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Confirm Action?',
  );
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'Are you sure you want to proceed with this action?',
  );
  final confirmLabel = context.knobs.string(
    label: 'Confirm Label',
    initialValue: 'Confirm',
  );
  final cancelLabel = context.knobs.string(
    label: 'Cancel Label',
    initialValue: 'Cancel',
  );
  final isDestructive = context.knobs.boolean(
    label: 'Destructive',
    initialValue: false,
  );
  final barrierDismissible = context.knobs.boolean(
    label: 'Barrier Dismissible',
    initialValue: true,
  );
  final showDontAskAgain = context.knobs.boolean(
    label: 'Show Don\'t Ask Again',
    initialValue: false,
  );
  final isLoading = context.knobs.boolean(
    label: 'Loading',
    initialValue: false,
  );

  return Center(
    child: ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: barrierDismissible,
          builder: (dialogContext) => AppConfirmDialog(
            title: title,
            message: message,
            confirmLabel: confirmLabel,
            cancelLabel: cancelLabel,
            isDestructive: isDestructive,
            barrierDismissible: barrierDismissible,
            showDontAskAgain: showDontAskAgain,
            isLoading: isLoading,
            onConfirm: () {
              debugPrint('Confirmed');
              Navigator.pop(dialogContext);
            },
            onCancel: () {
              debugPrint('Cancelled');
              Navigator.pop(dialogContext);
            },
            onDontAskAgainChanged: showDontAskAgain
                ? (value) => debugPrint('Don\'t ask again: $value')
                : null,
          ),
        );
      },
      child: const Text('Show Confirm Dialog'),
    ),
  );
}

@widgetbook.UseCase(name: 'Basic Confirmation', type: AppConfirmDialog)
Widget appConfirmDialogBasic(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AppConfirmDialog(
            title: 'Save Changes?',
            message: 'Do you want to save your changes before leaving?',
            confirmLabel: 'Save',
            cancelLabel: 'Discard',
            onConfirm: () {
              debugPrint('Confirmed: Save');
              Navigator.pop(dialogContext);
            },
            onCancel: () {
              debugPrint('Cancelled: Discard');
              Navigator.pop(dialogContext);
            },
          ),
        );
      },
      child: const Text('Show Basic Confirmation'),
    ),
  );
}

@widgetbook.UseCase(name: 'Destructive Action', type: AppConfirmDialog)
Widget appConfirmDialogDestructive(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AppConfirmDialog(
            title: 'Delete Item?',
            message:
                'This action cannot be undone. The item will be permanently deleted from your account.',
            confirmLabel: 'Delete',
            isDestructive: true,
            onConfirm: () {
              debugPrint('Destructive action confirmed: Delete');
              Navigator.pop(dialogContext);
            },
            onCancel: () {
              debugPrint('Destructive action cancelled');
              Navigator.pop(dialogContext);
            },
          ),
        );
      },
      child: const Text('Show Delete Confirmation'),
    ),
  );
}

@widgetbook.UseCase(name: 'Sign Out Confirmation', type: AppConfirmDialog)
Widget appConfirmDialogSignOut(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AppConfirmDialog(
            title: 'Sign Out?',
            message: 'Are you sure you want to sign out of your account?',
            confirmLabel: 'Sign Out',
            cancelLabel: 'Stay',
            onConfirm: () {
              debugPrint('User signed out');
              Navigator.pop(dialogContext);
            },
            onCancel: () {
              debugPrint('Sign out cancelled');
              Navigator.pop(dialogContext);
            },
          ),
        );
      },
      child: const Text('Show Sign Out Dialog'),
    ),
  );
}

@widgetbook.UseCase(name: 'Discard Changes', type: AppConfirmDialog)
Widget appConfirmDialogDiscardChanges(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AppConfirmDialog(
            title: 'Discard Changes?',
            message:
                'You have unsaved changes. If you leave now, your changes will be lost.',
            confirmLabel: 'Discard',
            cancelLabel: 'Keep Editing',
            isDestructive: true,
            onConfirm: () {
              debugPrint('Changes discarded');
              Navigator.pop(dialogContext);
            },
            onCancel: () {
              debugPrint('Continue editing');
              Navigator.pop(dialogContext);
            },
          ),
        );
      },
      child: const Text('Show Discard Changes Dialog'),
    ),
  );
}

@widgetbook.UseCase(name: "Don't Ask Again", type: AppConfirmDialog)
Widget appConfirmDialogDontAskAgain(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AppConfirmDialog(
            title: 'Enable Notifications?',
            message: 'Get notified about important updates and new features.',
            confirmLabel: 'Enable',
            cancelLabel: 'Not Now',
            showDontAskAgain: true,
            onConfirm: () {
              debugPrint('Notifications enabled');
              Navigator.pop(dialogContext);
            },
            onCancel: () {
              debugPrint('Notifications not enabled');
              Navigator.pop(dialogContext);
            },
            onDontAskAgainChanged: (value) {
              debugPrint('Don\'t ask again: $value');
            },
          ),
        );
      },
      child: const Text('Show Notification Dialog'),
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Button Labels', type: AppConfirmDialog)
Widget appConfirmDialogCustomLabels(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (dialogContext) => AppConfirmDialog(
            title: 'Enable Dark Mode?',
            message: 'Would you like to enable dark mode?',
            confirmLabel: 'Yes',
            cancelLabel: 'No',
            onConfirm: () {
              debugPrint('Confirmed: Yes');
              Navigator.pop(dialogContext);
            },
            onCancel: () {
              debugPrint('Cancelled: No');
              Navigator.pop(dialogContext);
            },
          ),
        );
      },
      child: const Text('Show Custom Labels Dialog'),
    ),
  );
}

@widgetbook.UseCase(name: 'Non-Dismissible (Critical)', type: AppConfirmDialog)
Widget appConfirmDialogNonDismissible(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'This dialog cannot be dismissed by tapping outside',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (dialogContext) => AppConfirmDialog(
                title: 'Critical Action Required',
                message:
                    'Your session has expired. You must re-authenticate to continue.',
                confirmLabel: 'Re-authenticate',
                cancelLabel: 'Sign Out',
                barrierDismissible: false,
                isDestructive: true,
                onConfirm: () {
                  debugPrint('Re-authentication initiated');
                  Navigator.pop(dialogContext);
                },
                onCancel: () {
                  debugPrint('User signed out');
                  Navigator.pop(dialogContext);
                },
              ),
            );
          },
          child: const Text('Show Critical Action Dialog'),
        ),
      ],
    ),
  );
}
