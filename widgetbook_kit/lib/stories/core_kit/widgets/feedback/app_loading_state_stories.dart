// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook/widgetbook.dart';

@widgetbook.UseCase(name: 'Interactive Playground', type: AppLoadingState)
Widget interactivePlayground(BuildContext context) {
  final variantOptions = [
    LoadingVariant.circular,
    LoadingVariant.linear,
    LoadingVariant.skeleton,
    LoadingVariant.overlay,
    LoadingVariant.inline,
  ];

  final variant = context.knobs.object.dropdown(
    label: 'Variant',
    options: variantOptions,
    labelBuilder: (v) => v.name,
    initialOption: LoadingVariant.circular,
  );

  final sizeOptions = [
    LoadingSize.small,
    LoadingSize.medium,
    LoadingSize.large,
  ];

  final size = context.knobs.object.dropdown(
    label: 'Size',
    options: sizeOptions,
    labelBuilder: (s) => s.name,
    initialOption: LoadingSize.medium,
  );

  final progress = context.knobs.doubleOrNull.slider(
    label: 'Progress',
    initialValue: 0.65,
    min: 0.0,
    max: 1.0,
  );

  final message = context.knobs.stringOrNull(
    label: 'Message',
    initialValue: null,
  );

  final showPercentage = context.knobs.boolean(
    label: 'Show Percentage',
    initialValue: false,
  );

  final showCancelButton = context.knobs.boolean(
    label: 'Show Cancel Button',
    initialValue: false,
  );

  final customColor = context.knobs.colorOrNull(
    label: 'Custom Color',
    initialValue: null,
  );

  return AppLoadingState(
    variant: variant,
    size: size,
    progress: progress,
    message: message,
    showPercentage: showPercentage,
    onCancel: showCancelButton ? () {} : null,
    color: customColor,
  );
}

@widgetbook.UseCase(
  name: 'Circular Spinner (Indeterminate)',
  type: AppLoadingState,
)
Widget circularSpinner(BuildContext context) {
  return const AppLoadingState(
    variant: LoadingVariant.circular,
    size: LoadingSize.medium,
  );
}

@widgetbook.UseCase(
  name: 'Linear Progress Bar (Determinate)',
  type: AppLoadingState,
)
Widget linearProgressBar(BuildContext context) {
  return const AppLoadingState(
    variant: LoadingVariant.linear,
    progress: 0.65,
    showPercentage: true,
  );
}

@widgetbook.UseCase(name: 'Skeleton Screen (List Items)', type: AppLoadingState)
Widget skeletonScreen(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16),
    child: AppLoadingState(variant: LoadingVariant.skeleton),
  );
}

@widgetbook.UseCase(name: 'Full-Screen Loading Overlay', type: AppLoadingState)
Widget fullScreenOverlay(BuildContext context) {
  return const AppLoadingState(
    variant: LoadingVariant.overlay,
    message: 'Loading data...',
  );
}

@widgetbook.UseCase(
  name: 'Inline Loading (Within Button)',
  type: AppLoadingState,
)
Widget inlineLoading(BuildContext context) {
  return Center(
    child: FilledButton(
      onPressed: null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          AppLoadingState(variant: LoadingVariant.inline),
          SizedBox(width: 8),
          Text('Loading...'),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Loading with Custom Message', type: AppLoadingState)
Widget loadingWithMessage(BuildContext context) {
  return const AppLoadingState(
    variant: LoadingVariant.circular,
    size: LoadingSize.large,
    message: 'Please wait while we process your request',
  );
}

@widgetbook.UseCase(
  name: 'Loading with Progress Percentage',
  type: AppLoadingState,
)
Widget loadingWithPercentage(BuildContext context) {
  return const AppLoadingState(
    variant: LoadingVariant.linear,
    progress: 0.75,
    showPercentage: true,
    message: 'Uploading file...',
  );
}

@widgetbook.UseCase(name: 'Loading with Cancel Button', type: AppLoadingState)
Widget loadingWithCancel(BuildContext context) {
  return AppLoadingState(
    variant: LoadingVariant.circular,
    size: LoadingSize.medium,
    message: 'Processing...',
    onCancel: () {
      // Cancel callback
    },
  );
}
