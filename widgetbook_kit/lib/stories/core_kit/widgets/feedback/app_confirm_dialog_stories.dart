// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/feedback/app_confirm_dialog.dart';

// 1. Basic Confirmation - Non-destructive confirmation dialog
@widgetbook.UseCase(name: 'Basic Confirmation', type: AppConfirmDialog)
Widget basicConfirmationStory(BuildContext context) {
  return _BasicConfirmationDemo();
}

class _BasicConfirmationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = context.knobs.string(
      label: 'Title',
      initialValue: 'Save Changes?',
    );
    final message = context.knobs.string(
      label: 'Message',
      initialValue: 'Do you want to save your changes before leaving?',
    );
    final confirmLabel = context.knobs.string(
      label: 'Confirm Label',
      initialValue: 'Save',
    );
    final cancelLabel = context.knobs.string(
      label: 'Cancel Label',
      initialValue: 'Discard',
    );

    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AppConfirmDialog(
              title: title,
              message: message,
              confirmLabel: confirmLabel,
              cancelLabel: cancelLabel,
              onConfirm: () {
                debugPrint('✅ Confirmed: $confirmLabel');
                Navigator.pop(context);
              },
              onCancel: () {
                debugPrint('❌ Cancelled: $cancelLabel');
                Navigator.pop(context);
              },
            ),
          );
        },
        child: const Text('Show Basic Confirmation'),
      ),
    );
  }
}

// 2. Destructive Action - Delete scenario with warning
@widgetbook.UseCase(name: 'Destructive Action', type: AppConfirmDialog)
Widget destructiveActionStory(BuildContext context) {
  return _DestructiveActionDemo();
}

class _DestructiveActionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = context.knobs.string(
      label: 'Title',
      initialValue: 'Delete Item?',
    );
    final message = context.knobs.string(
      label: 'Message',
      initialValue:
          'This action cannot be undone. The item will be permanently deleted from your account.',
    );
    final confirmLabel = context.knobs.string(
      label: 'Confirm Label',
      initialValue: 'Delete',
    );

    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AppConfirmDialog(
              title: title,
              message: message,
              confirmLabel: confirmLabel,
              isDestructive: true,
              onConfirm: () {
                debugPrint('🗑️ Destructive action confirmed: Delete');
                Navigator.pop(context);
              },
              onCancel: () {
                debugPrint('❌ Destructive action cancelled');
                Navigator.pop(context);
              },
            ),
          );
        },
        child: const Text('Show Delete Confirmation'),
      ),
    );
  }
}

// 3. Sign Out Confirmation - With barrier dismissal options
@widgetbook.UseCase(name: 'Sign Out Confirmation', type: AppConfirmDialog)
Widget signOutConfirmationStory(BuildContext context) {
  return _SignOutConfirmationDemo();
}

class _SignOutConfirmationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final barrierDismissible = context.knobs.boolean(
      label: 'Barrier Dismissible',
      initialValue: true,
    );

    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: barrierDismissible,
            builder: (context) => AppConfirmDialog(
              title: 'Sign Out?',
              message: 'Are you sure you want to sign out of your account?',
              confirmLabel: 'Sign Out',
              cancelLabel: 'Stay',
              barrierDismissible: barrierDismissible,
              onConfirm: () {
                debugPrint('👋 User signed out');
                Navigator.pop(context);
              },
              onCancel: () {
                debugPrint('✋ Sign out cancelled');
                Navigator.pop(context);
              },
            ),
          );
        },
        child: const Text('Show Sign Out Dialog'),
      ),
    );
  }
}

// 4. Discard Changes - Unsaved changes warning
@widgetbook.UseCase(name: 'Discard Changes', type: AppConfirmDialog)
Widget discardChangesStory(BuildContext context) {
  return _DiscardChangesDemo();
}

class _DiscardChangesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final confirmLabel = context.knobs.string(
      label: 'Confirm Label',
      initialValue: 'Discard',
    );
    final cancelLabel = context.knobs.string(
      label: 'Cancel Label',
      initialValue: 'Keep Editing',
    );

    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AppConfirmDialog(
              title: 'Discard Changes?',
              message:
                  'You have unsaved changes. If you leave now, your changes will be lost.',
              confirmLabel: confirmLabel,
              cancelLabel: cancelLabel,
              isDestructive: true,
              onConfirm: () {
                debugPrint('🗑️ Changes discarded');
                Navigator.pop(context);
              },
              onCancel: () {
                debugPrint('✏️ Continue editing');
                Navigator.pop(context);
              },
            ),
          );
        },
        child: const Text('Show Discard Changes Dialog'),
      ),
    );
  }
}

// 5. Don't Ask Again - With checkbox for persistent preference
@widgetbook.UseCase(name: "Don't Ask Again", type: AppConfirmDialog)
Widget dontAskAgainStory(BuildContext context) {
  return const _DontAskAgainDemo();
}

class _DontAskAgainDemo extends StatefulWidget {
  const _DontAskAgainDemo();

  @override
  State<_DontAskAgainDemo> createState() => _DontAskAgainDemoState();
}

class _DontAskAgainDemoState extends State<_DontAskAgainDemo> {
  bool _dontAskAgain = false;

  @override
  Widget build(BuildContext context) {
    final showCheckbox = context.knobs.boolean(
      label: 'Show Checkbox',
      initialValue: true,
    );
    final initialChecked = context.knobs.boolean(
      label: 'Initial Checked State',
      initialValue: false,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t ask again preference: $_dontAskAgain',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AppConfirmDialog(
                  title: 'Enable Notifications?',
                  message:
                      'Get notified about important updates and new features.',
                  confirmLabel: 'Enable',
                  cancelLabel: 'Not Now',
                  showDontAskAgain: showCheckbox,
                  isDontAskAgainChecked: initialChecked,
                  onDontAskAgainChanged: (value) {
                    setState(() => _dontAskAgain = value);
                    debugPrint('📋 Don\'t ask again: $value');
                  },
                  onConfirm: () {
                    debugPrint('🔔 Notifications enabled');
                    Navigator.pop(dialogContext);
                  },
                  onCancel: () {
                    debugPrint('🔕 Notifications not enabled');
                    Navigator.pop(dialogContext);
                  },
                ),
              );
            },
            child: const Text('Show Notification Dialog'),
          ),
        ],
      ),
    );
  }
}

// 6. Async Confirmation with Loading - Simulates async operation
@widgetbook.UseCase(name: 'Async with Loading', type: AppConfirmDialog)
Widget asyncLoadingStory(BuildContext context) {
  return const _AsyncLoadingDemo();
}

class _AsyncLoadingDemo extends StatefulWidget {
  const _AsyncLoadingDemo();

  @override
  State<_AsyncLoadingDemo> createState() => _AsyncLoadingDemoState();
}

class _AsyncLoadingDemoState extends State<_AsyncLoadingDemo> {
  bool _isLoading = false;

  Future<void> _simulateAsyncOperation() async {
    setState(() => _isLoading = true);
    debugPrint('⏳ Starting async operation...');

    // Simulate network request or heavy operation
    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);
    debugPrint('✅ Async operation completed');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: !_isLoading,
            builder: (dialogContext) => StatefulBuilder(
              builder: (builderContext, setDialogState) {
                return AppConfirmDialog(
                  title: 'Delete Account?',
                  message:
                      'This will permanently delete your account and all associated data. This action cannot be undone.',
                  confirmLabel: 'Delete Account',
                  isDestructive: true,
                  isLoading: _isLoading,
                  barrierDismissible: !_isLoading,
                  onConfirm: () async {
                    await _simulateAsyncOperation();
                    if (mounted && builderContext.mounted) {
                      Navigator.pop(dialogContext);
                      ScaffoldMessenger.of(builderContext).showSnackBar(
                        const SnackBar(
                          content: Text('Account deleted successfully'),
                        ),
                      );
                    }
                  },
                  onCancel: () {
                    debugPrint('❌ Account deletion cancelled');
                    Navigator.pop(dialogContext);
                  },
                );
              },
            ),
          );
        },
        child: const Text('Show Async Delete Dialog'),
      ),
    );
  }
}

// 7. Custom Button Labels - Demonstrates localization support
@widgetbook.UseCase(name: 'Custom Button Labels', type: AppConfirmDialog)
Widget customButtonLabelsStory(BuildContext context) {
  return _CustomButtonLabelsDemo();
}

class _CustomButtonLabelsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labelPreset = context.knobs.string(
      label: 'Label Preset',
      initialValue: 'English (Default)',
    );

    String confirmLabel;
    String cancelLabel;
    String title;
    String message;

    switch (labelPreset) {
      case 'Yes/No':
        confirmLabel = 'Yes';
        cancelLabel = 'No';
        title = 'Enable Dark Mode?';
        message = 'Would you like to enable dark mode?';
        break;
      case 'Proceed/Go Back':
        confirmLabel = 'Proceed';
        cancelLabel = 'Go Back';
        title = 'Proceed to Checkout?';
        message = 'You have 3 items in your cart.';
        break;
      case 'Accept/Reject':
        confirmLabel = 'Accept';
        cancelLabel = 'Reject';
        title = 'Accept Terms?';
        message = 'Please review and accept the terms of service.';
        break;
      case 'Continue/Stop':
        confirmLabel = 'Continue';
        cancelLabel = 'Stop';
        title = 'Continue Download?';
        message = 'Large file detected. This may take several minutes.';
        break;
      default:
        confirmLabel = 'Confirm';
        cancelLabel = 'Cancel';
        title = 'Confirm Action?';
        message = 'Please confirm to proceed with this action.';
    }

    return Center(
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AppConfirmDialog(
              title: title,
              message: message,
              confirmLabel: confirmLabel,
              cancelLabel: cancelLabel,
              onConfirm: () {
                debugPrint('✅ Confirmed: $confirmLabel');
                Navigator.pop(context);
              },
              onCancel: () {
                debugPrint('❌ Cancelled: $cancelLabel');
                Navigator.pop(context);
              },
            ),
          );
        },
        child: const Text('Show Custom Labels Dialog'),
      ),
    );
  }
}

// 8. Non-Dismissible Dialog - Critical action requiring explicit choice
@widgetbook.UseCase(name: 'Non-Dismissible (Critical)', type: AppConfirmDialog)
Widget nonDismissibleStory(BuildContext context) {
  return _NonDismissibleDemo();
}

class _NonDismissibleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '⚠️ This dialog cannot be dismissed by tapping outside.\nYou must explicitly choose an option.',
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
                builder: (context) => AppConfirmDialog(
                  title: 'Critical Action Required',
                  message:
                      'Your session has expired. You must re-authenticate to continue. This is a security measure to protect your account.',
                  confirmLabel: 'Re-authenticate',
                  cancelLabel: 'Sign Out',
                  barrierDismissible: false,
                  isDestructive: true,
                  onConfirm: () {
                    debugPrint('🔐 Re-authentication initiated');
                    Navigator.pop(context);
                  },
                  onCancel: () {
                    debugPrint('👋 User signed out');
                    Navigator.pop(context);
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
}
