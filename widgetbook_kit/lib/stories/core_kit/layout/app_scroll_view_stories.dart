// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Builds vertical sample items using [AppListTile].
List<Widget> _verticalItems(int count) {
  return List.generate(
    count,
    (i) => AppListTile(
      leading: CircleAvatar(child: Text('${i + 1}')),
      title: 'Item ${i + 1}',
      subtitle: 'Description for item ${i + 1}',
    ),
  );
}

/// Builds horizontal sample cards using [AppCard].
List<Widget> _horizontalCards(BuildContext context, int count) {
  return List.generate(
    count,
    (i) => Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: SizedBox(
          width: 100,
          child: Center(
            child: Text(
              'Card ${i + 1}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Interactive Playground', type: AppScrollView)
Widget interactivePlayground(BuildContext context) {
  final scrollDirection = context.knobs.object.dropdown(
    label: 'Scroll Direction',
    options: [Axis.vertical, Axis.horizontal],
    labelBuilder: (v) => v.name,
    initialOption: Axis.vertical,
  );

  final physics = context.knobs.object.dropdown(
    label: 'Physics',
    options: AppScrollPhysicsType.values,
    labelBuilder: (v) => v.name,
    initialOption: AppScrollPhysicsType.clamp,
  );

  final enablePullToRefresh = context.knobs.boolean(
    label: 'Enable Pull-to-Refresh',
    initialValue: false,
  );

  final enableScrollToTop = context.knobs.boolean(
    label: 'Enable Scroll-to-Top',
    initialValue: false,
  );

  final reverse = context.knobs.boolean(label: 'Reverse', initialValue: false);

  final handleSafeArea = context.knobs.boolean(
    label: 'Handle Safe Area',
    initialValue: true,
  );

  final itemCount = context.knobs.int.slider(
    label: 'Item Count',
    initialValue: 20,
    min: 5,
    max: 50,
  );

  final isHorizontal = scrollDirection == Axis.horizontal;

  return AppScrollView(
    scrollDirection: scrollDirection,
    physics: physics,
    enablePullToRefresh: enablePullToRefresh,
    onRefresh: enablePullToRefresh
        ? () => Future.delayed(const Duration(seconds: 1))
        : null,
    enableScrollToTop: enableScrollToTop,
    reverse: reverse,
    handleSafeArea: handleSafeArea,
    child: isHorizontal
        ? Row(children: _horizontalCards(context, itemCount))
        : Column(children: _verticalItems(itemCount)),
  );
}

@widgetbook.UseCase(name: 'Basic Scrollable Content', type: AppScrollView)
Widget basicScrollableContent(BuildContext context) {
  final itemCount = context.knobs.int.slider(
    label: 'Item Count',
    initialValue: 15,
    min: 5,
    max: 50,
  );

  return AppScrollView(child: Column(children: _verticalItems(itemCount)));
}

@widgetbook.UseCase(name: 'Pull-to-Refresh', type: AppScrollView)
Widget pullToRefresh(BuildContext context) {
  final refreshDelay = context.knobs.int.slider(
    label: 'Refresh Delay (seconds)',
    initialValue: 2,
    min: 1,
    max: 5,
  );

  return AppScrollView(
    enablePullToRefresh: true,
    physics:
        AppScrollPhysicsType.always, // Force scrollable even if content fits
    onRefresh: () => Future.delayed(Duration(seconds: refreshDelay)),
    child: Column(children: _verticalItems(30)),
  );
}

@widgetbook.UseCase(name: 'Scroll-to-Top Button', type: AppScrollView)
Widget scrollToTopButton(BuildContext context) {
  final threshold = context.knobs.int.slider(
    label: 'Scroll-to-Top Threshold',
    initialValue: 200,
    min: 50,
    max: 500,
  );

  return AppScrollView(
    enableScrollToTop: true,
    scrollToTopThreshold: threshold.toDouble(),
    child: Column(children: _verticalItems(30)),
  );
}

@widgetbook.UseCase(name: 'Horizontal Scroll View', type: AppScrollView)
Widget horizontalScrollView(BuildContext context) {
  final cardCount = context.knobs.int.slider(
    label: 'Card Count',
    initialValue: 10,
    min: 3,
    max: 20,
  );

  return AppScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Row(children: _horizontalCards(context, cardCount)),
  );
}

@widgetbook.UseCase(name: 'Bounce Physics', type: AppScrollView)
Widget bouncePhysics(BuildContext context) {
  final physics = context.knobs.object.dropdown(
    label: 'Physics Type',
    options: AppScrollPhysicsType.values,
    labelBuilder: (v) => v.name,
    initialOption: AppScrollPhysicsType.bounce,
  );

  return AppScrollView(
    physics: physics,
    child: Column(children: _verticalItems(30)),
  );
}

@widgetbook.UseCase(name: 'Reversed Scroll', type: AppScrollView)
Widget reversedScroll(BuildContext context) {
  final reverse = context.knobs.boolean(label: 'Reverse', initialValue: true);

  return AppScrollView(
    reverse: reverse,
    child: Column(children: _verticalItems(20)),
  );
}

@widgetbook.UseCase(name: 'With Safe Area Handling', type: AppScrollView)
Widget withSafeArea(BuildContext context) {
  final handleSafeArea = context.knobs.boolean(
    label: 'Handle Safe Area',
    initialValue: true,
  );

  return AppScrollView(
    handleSafeArea: handleSafeArea,
    padding: const EdgeInsets.all(AppSpacing.md),
    child: Column(children: _verticalItems(15)),
  );
}
