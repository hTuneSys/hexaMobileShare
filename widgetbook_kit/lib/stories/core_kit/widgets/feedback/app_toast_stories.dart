// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Widgetbook stories for [AppToast] component.
///
/// Demonstrates various configurations and use cases for the Material Design 3
/// toast notification system, including different types, positions, and durations.

@widgetbook.UseCase(name: 'Interactive Playground', type: AppToast)
Widget appToastPlayground(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'This is a customizable toast message',
  );
  final toastType = context.knobs.object.dropdown<ToastType>(
    label: 'Toast Type',
    options: const [
      ToastType.neutral,
      ToastType.success,
      ToastType.error,
      ToastType.warning,
      ToastType.info,
    ],
    labelBuilder: (type) {
      switch (type) {
        case ToastType.neutral:
          return 'Neutral';
        case ToastType.success:
          return 'Success';
        case ToastType.error:
          return 'Error';
        case ToastType.warning:
          return 'Warning';
        case ToastType.info:
          return 'Info';
      }
    },
  );
  final position = context.knobs.object.dropdown<ToastPosition>(
    label: 'Position',
    options: const [
      ToastPosition.top,
      ToastPosition.center,
      ToastPosition.bottom,
    ],
    labelBuilder: (pos) {
      switch (pos) {
        case ToastPosition.top:
          return 'Top';
        case ToastPosition.center:
          return 'Center';
        case ToastPosition.bottom:
          return 'Bottom';
      }
    },
  );
  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );
  final iconOption = context.knobs.object.dropdown<IconData>(
    label: 'Icon',
    options: const [
      Icons.check_circle,
      Icons.error,
      Icons.warning,
      Icons.info,
      Icons.star,
      Icons.favorite,
      Icons.download,
      Icons.notifications,
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
      if (icon == Icons.star) {
        return 'star';
      }
      if (icon == Icons.favorite) {
        return 'favorite';
      }
      if (icon == Icons.download) {
        return 'download';
      }
      if (icon == Icons.notifications) {
        return 'notifications';
      }
      return 'check_circle';
    },
  );
  final durationSeconds = context.knobs.double.slider(
    label: 'Duration (seconds)',
    initialValue: 2.0,
    min: 1.0,
    max: 8.0,
    divisions: 7,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Interactive Playground')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppToast.show(
            context,
            message: message,
            type: toastType,
            position: position,
            icon: showIcon ? iconOption : null,
            duration: Duration(milliseconds: (durationSeconds * 1000).round()),
          );
        },
        child: const Text('Show Toast'),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Basic Toast', type: AppToast)
Widget appToastBasic(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Basic Toast')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppToast.show(context, message: 'This is a basic toast message');
        },
        child: const Text('Show Basic Toast'),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Success Toast', type: AppToast)
Widget appToastSuccess(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Success Toast')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppToast.success(
            context,
            message: 'Operation completed successfully',
          );
        },
        child: const Text('Show Success Toast'),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Error Toast', type: AppToast)
Widget appToastError(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Error Toast')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppToast.error(context, message: 'An error occurred');
        },
        child: const Text('Show Error Toast'),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Warning Toast', type: AppToast)
Widget appToastWarning(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Warning Toast')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppToast.warning(context, message: 'Warning: Check your settings');
        },
        child: const Text('Show Warning Toast'),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Info Toast', type: AppToast)
Widget appToastInfo(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Info Toast')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppToast.info(context, message: 'Here is some helpful information');
        },
        child: const Text('Show Info Toast'),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Top Position', type: AppToast)
Widget appToastTopPosition(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Top Position')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppToast.show(
            context,
            message: 'Toast at top position',
            position: ToastPosition.top,
            icon: Icons.arrow_upward,
          );
        },
        child: const Text('Show Toast at Top'),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Center Position', type: AppToast)
Widget appToastCenterPosition(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Center Position')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppToast.show(
            context,
            message: 'Toast at center position',
            position: ToastPosition.center,
            icon: Icons.center_focus_strong,
          );
        },
        child: const Text('Show Toast at Center'),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Long Message', type: AppToast)
Widget appToastLongMessage(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Long Message')),
    body: Center(
      child: ElevatedButton(
        onPressed: () {
          AppToast.show(
            context,
            message:
                'This is a very long toast message that demonstrates how text wraps when it exceeds the maximum width.',
            type: ToastType.info,
            icon: Icons.info,
          );
        },
        child: const Text('Show Long Message Toast'),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Toast Queue', type: AppToast)
Widget appToastQueue(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Toast Queue')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              AppToast.success(context, message: 'First toast');
              AppToast.info(context, message: 'Second toast');
              AppToast.warning(context, message: 'Third toast');
            },
            child: const Text('Show 3 Toasts in Queue'),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              AppToast.clearAll();
            },
            child: const Text('Clear All Toasts'),
          ),
        ],
      ),
    ),
  );
}
