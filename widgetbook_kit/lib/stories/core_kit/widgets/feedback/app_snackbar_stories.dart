// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// 1. Basic Snackbar - Message only
@widgetbook.UseCase(name: 'Basic', type: AppSnackbar)
Widget appSnackbarBasic(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Basic Snackbar')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppSnackbar.show(
            context,
            message: 'This is a basic snackbar message',
          );
        },
        child: const Text('Show Basic Snackbar'),
      ),
    ),
  );
}

// 2. Snackbar with Action Button
@widgetbook.UseCase(name: 'With Action', type: AppSnackbar)
Widget appSnackbarWithAction(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Snackbar with Action')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppSnackbar.show(
            context,
            message: 'Email archived',
            actionLabel: 'UNDO',
            onActionPressed: () {
              // Restore email logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Email restored'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        },
        child: const Text('Archive Email (with Undo)'),
      ),
    ),
  );
}

// 3. Snackbar with Icon
@widgetbook.UseCase(name: 'With Icon', type: AppSnackbar)
Widget appSnackbarWithIcon(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Snackbar with Icon')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            AppSnackbar.build(
              message: 'Download started',
              icon: Icons.download,
            ),
          );
        },
        child: const Text('Start Download'),
      ),
    ),
  );
}

// 4. Success Snackbar (Green)
@widgetbook.UseCase(name: 'Success', type: AppSnackbar)
Widget appSnackbarSuccess(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Success Snackbar')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppSnackbar.success(context, message: 'Settings saved successfully');
        },
        child: const Text('Save Settings'),
      ),
    ),
  );
}

// 5. Error Snackbar (Red)
@widgetbook.UseCase(name: 'Error', type: AppSnackbar)
Widget appSnackbarError(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Error Snackbar')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppSnackbar.error(
            context,
            message: 'Network error. Please try again.',
            actionLabel: 'RETRY',
            onActionPressed: () {
              // Retry logic
            },
          );
        },
        child: const Text('Simulate Network Error'),
      ),
    ),
  );
}

// 6. Warning Snackbar (Amber/Orange)
@widgetbook.UseCase(name: 'Warning', type: AppSnackbar)
Widget appSnackbarWarning(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Warning Snackbar')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppSnackbar.warning(
            context,
            message: 'Storage almost full. Free up space.',
            actionLabel: 'MANAGE',
            onActionPressed: () {
              // Navigate to storage management
            },
          );
        },
        child: const Text('Check Storage'),
      ),
    ),
  );
}

// 7. Info Snackbar (Blue)
@widgetbook.UseCase(name: 'Info', type: AppSnackbar)
Widget appSnackbarInfo(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Info Snackbar')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppSnackbar.info(
            context,
            message: 'You are offline. Changes will sync when online.',
          );
        },
        child: const Text('Go Offline'),
      ),
    ),
  );
}

// 8. Long Message Snackbar
@widgetbook.UseCase(name: 'Long Message', type: AppSnackbar)
Widget appSnackbarLongMessage(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Long Message Snackbar')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppSnackbar.show(
            context,
            message:
                'This is a very long snackbar message that demonstrates text wrapping behavior. It can span up to two lines before being truncated.',
          );
        },
        child: const Text('Show Long Message'),
      ),
    ),
  );
}

// 9. Snackbar Queue Demonstration
@widgetbook.UseCase(name: 'Queue Demo', type: AppSnackbar)
Widget appSnackbarQueueDemo(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Snackbar Queue')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Click buttons quickly to see queue behavior',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              AppSnackbar.success(context, message: 'Task 1 completed');
            },
            child: const Text('Show Snackbar 1'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              AppSnackbar.info(context, message: 'Task 2 in progress');
            },
            child: const Text('Show Snackbar 2'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              AppSnackbar.warning(context, message: 'Task 3 needs attention');
            },
            child: const Text('Show Snackbar 3'),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              AppSnackbar.clearQueue(context);
            },
            child: const Text('Clear Queue'),
          ),
        ],
      ),
    ),
  );
}

// 10. All Variants Showcase
@widgetbook.UseCase(name: 'All Variants', type: AppSnackbar)
Widget appSnackbarAllVariants(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('All Snackbar Variants')),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Standard',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                AppSnackbar.show(context, message: 'Standard message');
              },
              child: const Text('Standard Snackbar'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Success',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                AppSnackbar.success(context, message: 'Operation successful');
              },
              child: const Text('Success Snackbar'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Error',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                AppSnackbar.error(
                  context,
                  message: 'An error occurred',
                  actionLabel: 'RETRY',
                  onActionPressed: () {},
                );
              },
              child: const Text('Error Snackbar'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Warning',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                AppSnackbar.warning(context, message: 'Warning message');
              },
              child: const Text('Warning Snackbar'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Info',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                AppSnackbar.info(context, message: 'Information message');
              },
              child: const Text('Info Snackbar'),
            ),
          ],
        ),
      ),
    ),
  );
}

// 11. Interactive Playground with Knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppSnackbar)
Widget appSnackbarPlayground(BuildContext context) {
  // Message text knob
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'This is a customizable snackbar message',
  );

  // Action label knob (nullable)
  final actionLabel = context.knobs.stringOrNull(
    label: 'Action Label (empty = no action)',
    initialValue: 'UNDO',
  );

  // Show icon knob
  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );

  // Snackbar type dropdown
  final snackbarType = context.knobs.object.dropdown<String>(
    label: 'Snackbar Type',
    options: ['standard', 'success', 'error', 'warning', 'info'],
    labelBuilder: (option) => option.toUpperCase(),
  );

  // Duration slider (2-10 seconds)
  final durationSeconds = context.knobs.double.slider(
    label: 'Duration (seconds)',
    initialValue: 4.0,
    min: 2.0,
    max: 10.0,
    divisions: 8,
  );

  // Map type to icon
  IconData? getIcon() {
    if (!showIcon) return null;
    switch (snackbarType) {
      case 'success':
        return Icons.check_circle;
      case 'error':
        return Icons.error;
      case 'warning':
        return Icons.warning;
      case 'info':
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }

  // Map type to AppSnackbarType enum
  AppSnackbarType getSnackbarType() {
    switch (snackbarType) {
      case 'success':
        return AppSnackbarType.success;
      case 'error':
        return AppSnackbarType.error;
      case 'warning':
        return AppSnackbarType.warning;
      case 'info':
        return AppSnackbarType.info;
      default:
        return AppSnackbarType.standard;
    }
  }

  return Scaffold(
    appBar: AppBar(title: const Text('Interactive Playground')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Customize settings in the Knobs panel →',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.play_arrow),
            label: const Text('Show Snackbar'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                AppSnackbar.build(
                  message: message,
                  actionLabel: (actionLabel == null || actionLabel.isEmpty)
                      ? null
                      : actionLabel,
                  onActionPressed: (actionLabel == null || actionLabel.isEmpty)
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Action pressed!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                  icon: getIcon(),
                  duration: Duration(
                    milliseconds: (durationSeconds * 1000).round(),
                  ),
                  type: getSnackbarType(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              AppSnackbar.dismiss(context);
            },
            child: const Text('Dismiss Current'),
          ),
        ],
      ),
    ),
  );
}
