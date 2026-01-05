// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Interactive Playground - Main customization interface
@widgetbook.UseCase(name: 'Interactive Playground', type: AppToast)
Widget appToastPlayground(BuildContext context) {
  // Message text knob
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'This is a customizable toast message',
  );

  // Toast type dropdown
  final toastTypeString = context.knobs.object.dropdown<String>(
    label: 'Toast Type',
    options: ['neutral', 'success', 'error', 'warning', 'info'],
    labelBuilder: (option) => option.toUpperCase(),
  );

  // Position dropdown
  final positionString = context.knobs.object.dropdown<String>(
    label: 'Position',
    options: ['top', 'center', 'bottom'],
    labelBuilder: (option) => option.toUpperCase(),
  );

  // Show icon knob
  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );

  // Icon selection (when showIcon is true)
  final iconIndex = context.knobs.int.slider(
    label: 'Icon (if enabled)',
    initialValue: 0,
    min: 0,
    max: 9,
    divisions: 9,
    description: 'Check/Error/Warn/Info/Star/Fav/Down/Up/Bell/Copy',
  );

  // Duration slider (1-8 seconds)
  final durationSeconds = context.knobs.double.slider(
    label: 'Duration (seconds)',
    initialValue: 2.0,
    min: 1.0,
    max: 8.0,
    divisions: 7,
  );

  // Map type string to ToastType enum
  ToastType getToastType() {
    switch (toastTypeString) {
      case 'success':
        return ToastType.success;
      case 'error':
        return ToastType.error;
      case 'warning':
        return ToastType.warning;
      case 'info':
        return ToastType.info;
      default:
        return ToastType.neutral;
    }
  }

  // Map position string to ToastPosition enum
  ToastPosition getPosition() {
    switch (positionString) {
      case 'top':
        return ToastPosition.top;
      case 'center':
        return ToastPosition.center;
      default:
        return ToastPosition.bottom;
    }
  }

  // Icon options
  final icons = [
    Icons.check_circle,
    Icons.error,
    Icons.warning,
    Icons.info,
    Icons.star,
    Icons.favorite,
    Icons.download,
    Icons.cloud_upload,
    Icons.notifications,
    Icons.copy,
  ];

  // Get icon based on type or custom selection
  IconData? getIcon() {
    if (!showIcon) return null;

    // If type is not neutral, use type-specific icon
    if (toastTypeString != 'neutral') {
      switch (toastTypeString) {
        case 'success':
          return Icons.check_circle;
        case 'error':
          return Icons.error;
        case 'warning':
          return Icons.warning;
        case 'info':
          return Icons.info;
        default:
          return null;
      }
    }

    // Otherwise use custom selected icon
    return icons[iconIndex];
  }

  return Scaffold(
    appBar: AppBar(title: const Text('Interactive Playground')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Customize settings in the Knobs panel ÔåÆ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Type: ${toastTypeString.toUpperCase()}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            'Position: ${positionString.toUpperCase()}',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            'Duration: ${durationSeconds.toStringAsFixed(1)}s',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            icon: const Icon(Icons.play_arrow),
            label: const Text('Show Toast'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            onPressed: () {
              AppToast.show(
                context,
                message: message,
                type: getToastType(),
                position: getPosition(),
                icon: getIcon(),
                duration: Duration(
                  milliseconds: (durationSeconds * 1000).round(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            icon: const Icon(Icons.clear_all),
            label: const Text('Clear All Toasts'),
            onPressed: () {
              AppToast.clearAll();
            },
          ),
        ],
      ),
    ),
  );
}

/// Interactive playground for basic toast.
@widgetbook.UseCase(name: 'Basic Toast', type: AppToast)
Widget appToastBasic(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'This is a toast message',
  );

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: false,
  );

  final positionIndex = context.knobs.int.slider(
    label: 'Position',
    initialValue: 2,
    min: 0,
    max: 2,
    divisions: 2,
    description: '0=Top, 1=Center, 2=Bottom',
  );

  final positions = [
    ToastPosition.top,
    ToastPosition.center,
    ToastPosition.bottom,
  ];
  final position = positions[positionIndex];

  final duration = context.knobs.int.slider(
    label: 'Duration (seconds)',
    initialValue: 2,
    min: 1,
    max: 5,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Basic Toast - Interactive')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Adjust knobs and tap button to show toast',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              AppToast.show(
                context,
                message: message,
                icon: showIcon ? Icons.notifications : null,
                position: position,
                duration: Duration(seconds: duration),
              );
            },
            child: const Text('Show Toast'),
          ),
        ],
      ),
    ),
  );
}

/// Interactive playground for toast with custom icon.
@widgetbook.UseCase(name: 'With Custom Icon', type: AppToast)
Widget appToastWithIcon(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'Toast with icon',
  );

  final iconIndex = context.knobs.int.slider(
    label: 'Icon',
    initialValue: 0,
    min: 0,
    max: 7,
    divisions: 7,
    description: 'Download/Favorite/Star/Check/Info/Warning/Error/Upload',
  );

  final icons = [
    Icons.download,
    Icons.favorite,
    Icons.star,
    Icons.check_circle,
    Icons.info,
    Icons.warning,
    Icons.error,
    Icons.cloud_upload,
  ];

  return Scaffold(
    appBar: AppBar(title: const Text('Custom Icon - Interactive')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icons[iconIndex], size: 48, color: Colors.grey),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              AppToast.show(context, message: message, icon: icons[iconIndex]);
            },
            child: const Text('Show Toast'),
          ),
        ],
      ),
    ),
  );
}

/// Interactive playground for success toast.
@widgetbook.UseCase(name: 'Success Toast', type: AppToast)
Widget appToastSuccess(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'Operation completed successfully',
  );

  final positionIndex = context.knobs.int.slider(
    label: 'Position',
    initialValue: 2,
    min: 0,
    max: 2,
    divisions: 2,
    description: '0=Top, 1=Center, 2=Bottom',
  );

  final positions = [
    ToastPosition.top,
    ToastPosition.center,
    ToastPosition.bottom,
  ];

  return Scaffold(
    appBar: AppBar(title: const Text('Success Toast - Interactive')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, size: 64, color: Colors.green),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              AppToast.success(
                context,
                message: message,
                position: positions[positionIndex],
              );
            },
            child: const Text('Show Success Toast'),
          ),
        ],
      ),
    ),
  );
}

/// Interactive playground for error toast.
@widgetbook.UseCase(name: 'Error Toast', type: AppToast)
Widget appToastError(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'An error occurred',
  );

  final positionIndex = context.knobs.int.slider(
    label: 'Position',
    initialValue: 2,
    min: 0,
    max: 2,
    divisions: 2,
    description: '0=Top, 1=Center, 2=Bottom',
  );

  final positions = [
    ToastPosition.top,
    ToastPosition.center,
    ToastPosition.bottom,
  ];

  return Scaffold(
    appBar: AppBar(title: const Text('Error Toast - Interactive')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, size: 64, color: Colors.red),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              AppToast.error(
                context,
                message: message,
                position: positions[positionIndex],
              );
            },
            child: const Text('Show Error Toast'),
          ),
        ],
      ),
    ),
  );
}

/// Interactive playground for warning toast.
@widgetbook.UseCase(name: 'Warning Toast', type: AppToast)
Widget appToastWarning(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'Warning: Check your settings',
  );

  final positionIndex = context.knobs.int.slider(
    label: 'Position',
    initialValue: 2,
    min: 0,
    max: 2,
    divisions: 2,
    description: '0=Top, 1=Center, 2=Bottom',
  );

  final positions = [
    ToastPosition.top,
    ToastPosition.center,
    ToastPosition.bottom,
  ];

  return Scaffold(
    appBar: AppBar(title: const Text('Warning Toast - Interactive')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.warning, size: 64, color: Colors.orange),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              AppToast.warning(
                context,
                message: message,
                position: positions[positionIndex],
              );
            },
            child: const Text('Show Warning Toast'),
          ),
        ],
      ),
    ),
  );
}

/// Interactive playground for info toast.
@widgetbook.UseCase(name: 'Info Toast', type: AppToast)
Widget appToastInfo(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'Here is some helpful information',
  );

  final positionIndex = context.knobs.int.slider(
    label: 'Position',
    initialValue: 2,
    min: 0,
    max: 2,
    divisions: 2,
    description: '0=Top, 1=Center, 2=Bottom',
  );

  final positions = [
    ToastPosition.top,
    ToastPosition.center,
    ToastPosition.bottom,
  ];

  return Scaffold(
    appBar: AppBar(title: const Text('Info Toast - Interactive')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info, size: 64, color: Colors.blue),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              AppToast.info(
                context,
                message: message,
                position: positions[positionIndex],
              );
            },
            child: const Text('Show Info Toast'),
          ),
        ],
      ),
    ),
  );
}

/// Interactive playground for toast with long message.
@widgetbook.UseCase(name: 'Long Message Toast', type: AppToast)
Widget appToastLongMessage(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue:
        'This is a very long toast message that demonstrates how text wraps when it exceeds the maximum width. The toast will automatically wrap to multiple lines.',
  );

  final typeIndex = context.knobs.int.slider(
    label: 'Type',
    initialValue: 0,
    min: 0,
    max: 4,
    divisions: 4,
    description: 'Neutral/Success/Error/Warning/Info',
  );

  final types = [
    ToastType.neutral,
    ToastType.success,
    ToastType.error,
    ToastType.warning,
    ToastType.info,
  ];

  return Scaffold(
    appBar: AppBar(title: const Text('Long Message - Interactive')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Adjust message length and see how it wraps',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              AppToast.show(context, message: message, type: types[typeIndex]);
            },
            child: const Text('Show Long Message'),
          ),
        ],
      ),
    ),
  );
}

/// Interactive playground for toast queue management.
@widgetbook.UseCase(name: 'Toast Queue', type: AppToast)
Widget appToastQueue(BuildContext context) {
  final count = context.knobs.int.slider(
    label: 'Number of Toasts',
    initialValue: 3,
    min: 1,
    max: 6,
  );

  final useTypes = context.knobs.boolean(
    label: 'Use Different Types',
    initialValue: true,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Toast Queue - Interactive')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              'Multiple toasts will be shown sequentially',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              if (useTypes) {
                final methods = [
                  (String msg) => AppToast.success(context, message: msg),
                  (String msg) => AppToast.info(context, message: msg),
                  (String msg) => AppToast.warning(context, message: msg),
                  (String msg) => AppToast.error(context, message: msg),
                ];
                for (int i = 0; i < count; i++) {
                  methods[i % methods.length]('Toast ${i + 1} of $count');
                }
              } else {
                for (int i = 0; i < count; i++) {
                  AppToast.show(context, message: 'Toast ${i + 1} of $count');
                }
              }
            },
            child: Text('Show $count Toasts'),
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

/// Interactive playground for duration variants.
@widgetbook.UseCase(name: 'Duration Variants', type: AppToast)
Widget appToastDuration(BuildContext context) {
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'Toast message',
  );

  final duration = context.knobs.int.slider(
    label: 'Duration (seconds)',
    initialValue: 2,
    min: 1,
    max: 8,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Duration Variants - Interactive')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Duration: $duration seconds',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              AppToast.show(
                context,
                message: message,
                duration: Duration(seconds: duration),
              );
            },
            child: const Text('Show Toast'),
          ),
        ],
      ),
    ),
  );
}

/// Interactive playground for common use case: copied to clipboard.
@widgetbook.UseCase(name: 'Copied to Clipboard', type: AppToast)
Widget appToastCopied(BuildContext context) {
  final message = context.knobs.string(
    label: 'Toast Message',
    initialValue: 'Copied to clipboard',
  );

  final contentType = context.knobs.int.slider(
    label: 'Content Type',
    initialValue: 0,
    min: 0,
    max: 2,
    divisions: 2,
    description: 'Link/Email/Phone',
  );

  final contents = [
    'https://example.com/share/abc123',
    'user@example.com',
    '+1 234 567 8900',
  ];

  final icons = [Icons.link, Icons.email, Icons.phone];

  return Scaffold(
    appBar: AppBar(title: const Text('Copied - Interactive')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
              contents[contentType],
              style: const TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              AppToast.success(context, message: message);
            },
            icon: Icon(icons[contentType]),
            label: const Text('Copy to Clipboard'),
          ),
        ],
      ),
    ),
  );
}
