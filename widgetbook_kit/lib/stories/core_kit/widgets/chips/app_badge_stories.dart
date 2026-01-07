// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Interactive Playground - Expose ALL AppBadge properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppBadge)
Widget appBadgePlayground(BuildContext context) {
  // Badge type
  final badgeType = context.knobs.object.dropdown(
    label: 'Badge Type',
    options: const ['numeric', 'dot'],
    labelBuilder: (value) => value,
  );

  // Numeric badge properties
  final count = context.knobs.int.slider(
    label: 'Count',
    initialValue: 5,
    min: 0,
    max: 150,
  );

  final autoHide = context.knobs.boolean(
    label: 'Auto Hide (when count=0)',
    initialValue: true,
  );

  final isLarge = context.knobs.boolean(
    label: 'Large Size',
    initialValue: false,
  );

  // Position
  final position = context.knobs.object.dropdown(
    label: 'Position',
    options: [
      BadgePosition.topEnd,
      BadgePosition.topStart,
      BadgePosition.bottomEnd,
      BadgePosition.bottomStart,
    ],
    labelBuilder: (pos) => pos.toString().split('.').last,
  );

  // Offset
  final hasCustomOffset = context.knobs.boolean(
    label: 'Custom Offset',
    initialValue: false,
  );

  final offsetX = hasCustomOffset
      ? context.knobs.double.slider(
          label: 'Offset X',
          initialValue: 0,
          min: -20,
          max: 20,
        )
      : 0.0;

  final offsetY = hasCustomOffset
      ? context.knobs.double.slider(
          label: 'Offset Y',
          initialValue: 0,
          min: -20,
          max: 20,
        )
      : 0.0;

  // Colors
  final hasCustomColors = context.knobs.boolean(
    label: 'Custom Colors',
    initialValue: false,
  );

  final backgroundColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Background Color',
          initialValue: Colors.red,
        )
      : null;

  final textColor = hasCustomColors && badgeType == 'numeric'
      ? context.knobs.colorOrNull(
          label: 'Text Color',
          initialValue: Colors.white,
        )
      : null;

  // Child widget
  final childIcon = context.knobs.object.dropdown(
    label: 'Child Icon',
    options: const [
      Icons.notifications,
      Icons.mail,
      Icons.shopping_cart,
      Icons.message,
    ],
    labelBuilder: (icon) => icon.toString().split('.').last,
  );

  final badge = badgeType == 'dot'
      ? AppBadge.dot(
          position: position,
          offset: hasCustomOffset ? Offset(offsetX, offsetY) : null,
          backgroundColor: backgroundColor,
          child: IconButton(icon: Icon(childIcon, size: 32), onPressed: () {}),
        )
      : AppBadge(
          count: count,
          position: position,
          offset: hasCustomOffset ? Offset(offsetX, offsetY) : null,
          autoHide: autoHide,
          isLarge: isLarge,
          backgroundColor: backgroundColor,
          textColor: textColor,
          child: IconButton(icon: Icon(childIcon, size: 32), onPressed: () {}),
        );

  return Center(child: badge);
}

/// Numeric Badge - Badge with count display
@widgetbook.UseCase(name: 'Numeric Badge', type: AppBadge)
Widget appBadgeNumeric(BuildContext context) {
  return Center(
    child: AppBadge(
      count: 5,
      child: IconButton(
        icon: const Icon(Icons.notifications, size: 32),
        onPressed: () {},
      ),
    ),
  );
}

/// Dot Badge - Simple indicator without count
@widgetbook.UseCase(name: 'Dot Badge', type: AppBadge)
Widget appBadgeDot(BuildContext context) {
  return Center(
    child: AppBadge.dot(
      child: IconButton(
        icon: const Icon(Icons.message, size: 32),
        onPressed: () {},
      ),
    ),
  );
}

/// Large Badge - Larger size variant for numeric badge
@widgetbook.UseCase(name: 'Large Size', type: AppBadge)
Widget appBadgeLarge(BuildContext context) {
  return Center(
    child: AppBadge(
      count: 12,
      isLarge: true,
      child: IconButton(
        icon: const Icon(Icons.shopping_cart, size: 32),
        onPressed: () {},
      ),
    ),
  );
}

/// Max Count - Shows 99+ for counts over 99
@widgetbook.UseCase(name: 'Max Count (99+)', type: AppBadge)
Widget appBadgeMaxCount(BuildContext context) {
  return Center(
    child: AppBadge(
      count: 150,
      child: IconButton(
        icon: const Icon(Icons.mail, size: 32),
        onPressed: () {},
      ),
    ),
  );
}

/// Custom Colors - Badge with custom background and text colors
@widgetbook.UseCase(name: 'Custom Colors', type: AppBadge)
Widget appBadgeCustomColors(BuildContext context) {
  return Center(
    child: AppBadge(
      count: 8,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      child: IconButton(
        icon: const Icon(Icons.check_circle, size: 32),
        onPressed: () {},
      ),
    ),
  );
}

/// Custom Position - Badge positioned at different corners
@widgetbook.UseCase(name: 'Custom Position', type: AppBadge)
Widget appBadgeCustomPosition(BuildContext context) {
  return Center(
    child: AppBadge(
      count: 3,
      position: BadgePosition.bottomEnd,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.image, size: 40),
      ),
    ),
  );
}

/// Auto-Hide - Badge automatically hides when count is zero
@widgetbook.UseCase(name: 'Auto-Hide (Count=0)', type: AppBadge)
Widget appBadgeAutoHide(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBadge(
          count: 0,
          autoHide: true,
          child: IconButton(
            icon: const Icon(Icons.notifications, size: 32),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Badge is hidden because count = 0',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

/// On Avatar - Dot badge on user avatar for status indicator
@widgetbook.UseCase(name: 'On Avatar (Status)', type: AppBadge)
Widget appBadgeOnAvatar(BuildContext context) {
  return Center(
    child: AppBadge.dot(
      backgroundColor: Colors.green,
      child: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[300],
        child: const Icon(Icons.person, size: 36),
      ),
    ),
  );
}

/// On Navigation - Badge on navigation icon
@widgetbook.UseCase(name: 'On Navigation Icon', type: AppBadge)
Widget appBadgeOnNavigation(BuildContext context) {
  return Center(
    child: AppBadge(
      count: 12,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.inbox, size: 24),
      ),
    ),
  );
}
