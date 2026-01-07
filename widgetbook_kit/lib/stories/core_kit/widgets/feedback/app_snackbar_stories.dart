// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppSnackbar] component.
///
/// Demonstrates various configurations and use cases for the Material Design 3
/// snackbar notification system, including different types, actions, and behaviors.

@widgetbook.UseCase(name: 'Interactive Playground', type: AppSnackbar)
Widget appSnackbarPlayground(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'This is a customizable snackbar message',
  );
  final actionLabel = context.knobs.stringOrNull(
    label: 'Action Label',
    initialValue: 'UNDO',
  );
  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );
  final snackbarType = context.knobs.object.dropdown<AppSnackbarType>(
    label: 'Snackbar Type',
    options: const [
      AppSnackbarType.standard,
      AppSnackbarType.success,
      AppSnackbarType.error,
      AppSnackbarType.warning,
      AppSnackbarType.info,
    ],
    labelBuilder: (type) {
      switch (type) {
        case AppSnackbarType.standard:
          return 'Standard';
        case AppSnackbarType.success:
          return 'Success';
        case AppSnackbarType.error:
          return 'Error';
        case AppSnackbarType.warning:
          return 'Warning';
        case AppSnackbarType.info:
          return 'Info';
      }
    },
  );
  final iconOption = context.knobs.object.dropdown<IconData>(
    label: 'Icon',
    options: const [
      Icons.check_circle,
      Icons.error,
      Icons.warning,
      Icons.info,
      Icons.notifications,
      Icons.download,
      Icons.upload,
    ],
    labelBuilder: (icon) {
      if (icon == Icons.check_circle) {
        return 'check_circle';
      }
      if (icon == Icons.error) {
        return 'error';
      }
      if (icon == Icons.warning) {
        return 'warning';
      }
      if (icon == Icons.info) {
        return 'info';
      }
      if (icon == Icons.notifications) {
        return 'notifications';
      }
      if (icon == Icons.download) {
        return 'download';
      }
      if (icon == Icons.upload) {
        return 'upload';
      }
      return 'notifications';
    },
  );
  final durationSeconds = context.knobs.double.slider(
    label: 'Duration (seconds)',
    initialValue: 4.0,
    min: 2.0,
    max: 10.0,
    divisions: 8,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Interactive Playground')),
    body: Center(
      child: ElevatedButton(
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
              icon: showIcon ? iconOption : null,
              duration: Duration(
                milliseconds: (durationSeconds * 1000).round(),
              ),
              type: snackbarType,
            ),
          );
        },
        child: const Text('Show Snackbar'),
      ),
    ),
  );
}

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
