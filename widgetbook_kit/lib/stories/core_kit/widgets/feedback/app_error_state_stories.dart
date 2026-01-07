// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppErrorState] component.
///
/// Demonstrates various configurations and use cases for the Material Design 3
/// error state component, including different error types, variants, and action buttons.

@widgetbook.UseCase(name: 'Interactive Playground', type: AppErrorState)
Widget appErrorStatePlayground(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Something went wrong',
  );
  final description = context.knobs.string(
    label: 'Description',
    initialValue: 'An unexpected error occurred. Please try again.',
  );
  final errorType = context.knobs.object.dropdown<AppErrorType>(
    label: 'Error Type',
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
  );
  final variant = context.knobs.object.dropdown<AppErrorStateVariant>(
    label: 'Variant',
    options: const [
      AppErrorStateVariant.fullScreen,
      AppErrorStateVariant.compact,
    ],
    labelBuilder: (v) {
      switch (v) {
        case AppErrorStateVariant.fullScreen:
          return 'Full Screen';
        case AppErrorStateVariant.compact:
          return 'Compact';
      }
    },
  );
  final errorCode = context.knobs.stringOrNull(
    label: 'Error Code',
    initialValue: 'ERR_001',
  );
  final showRetry = context.knobs.boolean(
    label: 'Show Retry Button',
    initialValue: true,
  );
  final retryButtonLabel = context.knobs.string(
    label: 'Retry Button Label',
    initialValue: 'Retry',
  );
  final showSecondary = context.knobs.boolean(
    label: 'Show Secondary Button',
    initialValue: false,
  );
  final secondaryButtonLabel = context.knobs.string(
    label: 'Secondary Button Label',
    initialValue: 'Go Back',
  );
  final showStackTrace = context.knobs.boolean(
    label: 'Show Stack Trace',
    initialValue: false,
  );

  StackTrace? sampleStackTrace;
  if (showStackTrace) {
    try {
      throw Exception('Sample exception');
    } catch (e, stackTrace) {
      sampleStackTrace = stackTrace;
    }
  }

  return Scaffold(
    body: AppErrorState(
      title: title,
      description: description,
      errorType: errorType,
      variant: variant,
      errorCode: errorCode,
      onRetry: showRetry ? () => debugPrint('Retry tapped') : null,
      retryButtonLabel: retryButtonLabel,
      onSecondaryAction: showSecondary
          ? () => debugPrint('Secondary tapped')
          : null,
      secondaryButtonLabel: secondaryButtonLabel,
      showStackTrace: showStackTrace,
      stackTrace: sampleStackTrace,
    ),
  );
}

@widgetbook.UseCase(name: 'Network Error', type: AppErrorState)
Widget appErrorStateNetwork(BuildContext context) {
  return Scaffold(
    body: AppErrorState.network(
      onRetry: () {
        debugPrint('Retry network request');
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Server Error (500)', type: AppErrorState)
Widget appErrorStateServerError(BuildContext context) {
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

@widgetbook.UseCase(name: 'Not Found (404)', type: AppErrorState)
Widget appErrorStateNotFound(BuildContext context) {
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

@widgetbook.UseCase(name: 'Permission Denied', type: AppErrorState)
Widget appErrorStatePermissionDenied(BuildContext context) {
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

@widgetbook.UseCase(name: 'Generic Error', type: AppErrorState)
Widget appErrorStateGeneric(BuildContext context) {
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

@widgetbook.UseCase(name: 'Full-Screen Variant', type: AppErrorState)
Widget appErrorStateFullScreen(BuildContext context) {
  return Scaffold(
    body: AppErrorState.network(
      variant: AppErrorStateVariant.fullScreen,
      onRetry: () {
        debugPrint('Retry');
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Compact Variant', type: AppErrorState)
Widget appErrorStateCompact(BuildContext context) {
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
              border: Border.all(color: Colors.grey),
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

@widgetbook.UseCase(name: 'Timeout Error', type: AppErrorState)
Widget appErrorStateTimeout(BuildContext context) {
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
Widget appErrorStateAuthentication(BuildContext context) {
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
