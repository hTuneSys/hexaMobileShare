// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// 1. Network Error with Retry
@widgetbook.UseCase(name: 'Network Error', type: AppErrorState)
Widget networkErrorStory(BuildContext context) {
  return Scaffold(
    body: AppErrorState.network(
      onRetry: () {
        // Simulate retry action
        debugPrint('Retry network request');
      },
    ),
  );
}

// 2. Server Error (500)
@widgetbook.UseCase(name: 'Server Error (500)', type: AppErrorState)
Widget serverErrorStory(BuildContext context) {
  return Scaffold(
    body: AppErrorState.serverError(
      errorCode: 'ERR_500',
      onRetry: () {
        debugPrint('Retry server request');
      },
      onSecondaryAction: () {
        debugPrint('Contact support');
      },
      secondaryButtonLabel: 'Contact Support',
    ),
  );
}

// 3. Not Found Error (404)
@widgetbook.UseCase(name: 'Not Found (404)', type: AppErrorState)
Widget notFoundErrorStory(BuildContext context) {
  return Scaffold(
    body: AppErrorState.notFound(
      errorCode: 'ERR_404',
      onSecondaryAction: () {
        debugPrint('Go back');
      },
      secondaryButtonLabel: 'Go Back',
    ),
  );
}

// 4. Permission Denied Error
@widgetbook.UseCase(name: 'Permission Denied', type: AppErrorState)
Widget permissionDeniedStory(BuildContext context) {
  return Scaffold(
    body: AppErrorState.permissionDenied(
      description: 'Please grant camera access in Settings to continue.',
      onRetry: () {
        debugPrint('Retry permission check');
      },
      onSecondaryAction: () {
        debugPrint('Open settings');
      },
      secondaryButtonLabel: 'Open Settings',
    ),
  );
}

// 5. Generic Error with Custom Message
@widgetbook.UseCase(name: 'Generic Error', type: AppErrorState)
Widget genericErrorStory(BuildContext context) {
  return Scaffold(
    body: AppErrorState(
      title: 'Payment Failed',
      description:
          'Your payment could not be processed. Please check your payment method and try again.',
      errorType: AppErrorType.generic,
      errorCode: 'PAYMENT_ERR_001',
      onRetry: () {
        debugPrint('Retry payment');
      },
      onSecondaryAction: () {
        debugPrint('Update payment method');
      },
      retryButtonLabel: 'Try Again',
      secondaryButtonLabel: 'Update Payment',
    ),
  );
}

// 6. Full-Screen Variant (Default)
@widgetbook.UseCase(name: 'Full-Screen Variant', type: AppErrorState)
Widget fullScreenVariantStory(BuildContext context) {
  return Scaffold(
    body: AppErrorState.network(
      variant: AppErrorStateVariant.fullScreen,
      onRetry: () {
        debugPrint('Retry');
      },
    ),
  );
}

// 7. Compact Variant (Inline)
@widgetbook.UseCase(name: 'Compact Variant', type: AppErrorState)
Widget compactVariantStory(BuildContext context) {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'This is some content above the error state.',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: AppErrorState(
              title: 'Failed to load comments',
              description: 'Check your connection and try again.',
              errorType: AppErrorType.network,
              variant: AppErrorStateVariant.compact,
              onRetry: () {
                debugPrint('Retry loading comments');
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'This is some content below the error state.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    ),
  );
}

// 8. Error with Stack Trace (Debug)
@widgetbook.UseCase(name: 'With Stack Trace (Debug)', type: AppErrorState)
Widget errorWithStackTraceStory(BuildContext context) {
  // Create a sample stack trace
  StackTrace? sampleStackTrace;
  try {
    throw Exception('Sample exception for demonstration');
  } catch (e, stackTrace) {
    sampleStackTrace = stackTrace;
  }

  return Scaffold(
    body: AppErrorState(
      title: 'Unexpected Error',
      description:
          'An unexpected error occurred. This should only be visible in debug mode.',
      errorType: AppErrorType.generic,
      errorCode: 'DEBUG_ERR_001',
      stackTrace: sampleStackTrace,
      showStackTrace: true,
      onRetry: () {
        debugPrint('Retry');
      },
    ),
  );
}

// Additional Real-World Examples

@widgetbook.UseCase(name: 'Timeout Error', type: AppErrorState)
Widget timeoutErrorStory(BuildContext context) {
  return Scaffold(
    body: AppErrorState(
      title: 'Request timed out',
      description:
          'The request took too long to complete. Check your connection and retry.',
      errorType: AppErrorType.network,
      errorCode: 'TIMEOUT_ERR',
      onRetry: () {
        debugPrint('Retry request');
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Authentication Error', type: AppErrorState)
Widget authenticationErrorStory(BuildContext context) {
  return Scaffold(
    body: AppErrorState(
      title: 'Session expired',
      description:
          'Your session has expired. Please sign in again to continue.',
      errorType: AppErrorType.permission,
      onSecondaryAction: () {
        debugPrint('Sign in again');
      },
      secondaryButtonLabel: 'Sign In',
    ),
  );
}

// Interactive Playground - Experiment with all properties
@widgetbook.UseCase(name: 'Interactive Playground', type: AppErrorState)
Widget interactivePlaygroundStory(BuildContext context) {
  return Scaffold(
    body: AppErrorState(
      title: context.knobs.string(
        label: 'Title',
        initialValue: 'Something went wrong',
        description: 'Error title displayed to the user',
      ),
      description: context.knobs.string(
        label: 'Description',
        initialValue: 'An unexpected error occurred. Please try again.',
        description: 'Detailed error description',
      ),

      errorType: context.knobs.object.dropdown<AppErrorType>(
        label: 'Error Type',
        initialOption: AppErrorType.network,
        options: const [
          AppErrorType.network,
          AppErrorType.server,
          AppErrorType.notFound,
          AppErrorType.permission,
          AppErrorType.generic,
        ],
        labelBuilder: (type) {
          switch (type) {
            case AppErrorType.network:
              return 'Network';
            case AppErrorType.server:
              return 'Server';
            case AppErrorType.notFound:
              return 'Not Found';
            case AppErrorType.permission:
              return 'Permission';
            case AppErrorType.generic:
              return 'Generic';
          }
        },
      ),
      variant: context.knobs.object.dropdown<AppErrorStateVariant>(
        label: 'Variant',
        initialOption: AppErrorStateVariant.fullScreen,
        options: const [
          AppErrorStateVariant.fullScreen,
          AppErrorStateVariant.compact,
        ],
        labelBuilder: (variant) {
          switch (variant) {
            case AppErrorStateVariant.fullScreen:
              return 'Full Screen';
            case AppErrorStateVariant.compact:
              return 'Compact';
          }
        },
      ),
      errorCode: context.knobs.stringOrNull(
        label: 'Error Code',
        initialValue: 'ERR_001',
        description: 'Optional error code for debugging',
      ),
      onRetry:
          context.knobs.boolean(
            label: 'Show Retry Button',
            initialValue: true,
            description: 'Display retry action button',
          )
          ? () => debugPrint('Retry button tapped')
          : null,
      retryButtonLabel: context.knobs.string(
        label: 'Retry Button Label',
        initialValue: 'Retry',
        description: 'Custom label for retry button',
      ),
      onSecondaryAction:
          context.knobs.boolean(
            label: 'Show Secondary Button',
            initialValue: false,
            description: 'Display secondary action button',
          )
          ? () => debugPrint('Secondary button tapped')
          : null,
      secondaryButtonLabel: context.knobs.string(
        label: 'Secondary Button Label',
        initialValue: 'Go Back',
        description: 'Custom label for secondary button',
      ),
      showStackTrace: context.knobs.boolean(
        label: 'Show Stack Trace',
        initialValue: false,
        description: 'Display stack trace (debug mode only)',
      ),
    ),
  );
}
