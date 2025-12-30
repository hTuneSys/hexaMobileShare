// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// 1. Numeric badge on icon button (notification count)
@widgetbook.UseCase(name: 'Numeric Badge on Icon', type: AppBadge)
Widget numericBadgeOnIcon(BuildContext context) {
  final count = context.knobs.int.slider(
    label: 'Count',
    initialValue: 5,
    min: 0,
    max: 150,
  );

  final icon = context.knobs.object.dropdown(
    label: 'Icon',
    options: const [
      Icons.notifications,
      Icons.mail,
      Icons.message,
      Icons.shopping_cart,
    ],
    labelBuilder: (icon) => icon.toString().split('.').last,
  );

  return Center(
    child: AppBadge(
      count: count,
      child: IconButton(icon: Icon(icon, size: 32), onPressed: () {}),
    ),
  );
}

// 2. Dot badge on navigation tab
@widgetbook.UseCase(name: 'Dot Badge', type: AppBadge)
Widget dotBadge(BuildContext context) {
  final backgroundColor = context.knobs.colorOrNull(
    label: 'Dot color',
    initialValue: Colors.green,
  );

  final childType = context.knobs.object.dropdown(
    label: 'Child type',
    options: const ['avatar', 'icon', 'navigation_tab'],
    labelBuilder: (type) => type.replaceAll('_', ' '),
  );

  Widget buildChild() {
    switch (childType) {
      case 'avatar':
        return CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey[300],
          child: const Icon(Icons.person, size: 36),
        );
      case 'navigation_tab':
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Tab'),
        );
      default: // icon
        return const Icon(Icons.message, size: 32);
    }
  }

  return Center(
    child: AppBadge.dot(backgroundColor: backgroundColor, child: buildChild()),
  );
}

// 3. Badge with custom position offset
@widgetbook.UseCase(name: 'Custom Position', type: AppBadge)
Widget customPosition(BuildContext context) {
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

  final offsetX = context.knobs.double.slider(
    label: 'Offset X',
    initialValue: 0,
    min: -20,
    max: 20,
  );

  final offsetY = context.knobs.double.slider(
    label: 'Offset Y',
    initialValue: 0,
    min: -20,
    max: 20,
  );

  final count = context.knobs.int.slider(
    label: 'Count',
    initialValue: 3,
    min: 0,
    max: 99,
  );

  return Center(
    child: AppBadge(
      count: count,
      position: position,
      offset: Offset(offsetX, offsetY),
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

// 4. Badge with max count overflow (99+)
@widgetbook.UseCase(name: 'Max Count Overflow', type: AppBadge)
Widget maxCountOverflow(BuildContext context) {
  final count = context.knobs.int.slider(
    label: 'Count',
    initialValue: 100,
    min: 0,
    max: 9999,
  );

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBadge(
          count: count,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mail, size: 32),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          count > 99 ? 'Shows "99+"' : 'Shows "$count"',
          style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// 5. Large badge variant
@widgetbook.UseCase(name: 'Size Variants', type: AppBadge)
Widget sizeVariants(BuildContext context) {
  final isLarge = context.knobs.boolean(
    label: 'Large size',
    initialValue: false,
  );

  final count = context.knobs.int.slider(
    label: 'Count',
    initialValue: 5,
    min: 0,
    max: 99,
  );

  return Center(
    child: AppBadge(
      count: count,
      isLarge: isLarge,
      child: IconButton(
        icon: const Icon(Icons.shopping_cart, size: 32),
        onPressed: () {},
      ),
    ),
  );
}

// 6. Badge with custom colors
@widgetbook.UseCase(name: 'Custom Colors', type: AppBadge)
Widget customColors(BuildContext context) {
  final backgroundColor = context.knobs.colorOrNull(
    label: 'Background color',
    initialValue: Colors.green,
  );

  final textColor = context.knobs.colorOrNull(
    label: 'Text color',
    initialValue: Colors.white,
  );

  final count = context.knobs.int.slider(
    label: 'Count',
    initialValue: 3,
    min: 0,
    max: 99,
  );

  final colorScheme = context.knobs.object.dropdown(
    label: 'Quick color schemes',
    options: const ['success', 'warning', 'error', 'info', 'custom'],
    labelBuilder: (scheme) => scheme,
  );

  Color? getBgColor() {
    if (colorScheme == 'custom') return backgroundColor;
    switch (colorScheme) {
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'error':
        return Colors.red;
      case 'info':
        return Colors.blue;
      default:
        return backgroundColor;
    }
  }

  return Center(
    child: AppBadge(
      count: count,
      backgroundColor: getBgColor(),
      textColor: textColor,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check_circle, size: 32),
      ),
    ),
  );
}

// 7. Badge auto-hiding at zero count
@widgetbook.UseCase(name: 'Auto-Hide Behavior', type: AppBadge)
Widget autoHideBehavior(BuildContext context) {
  final count = context.knobs.int.slider(
    label: 'Count',
    initialValue: 0,
    min: 0,
    max: 10,
  );

  final autoHide = context.knobs.boolean(
    label: 'Auto-hide when count = 0',
    initialValue: true,
  );

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBadge(
          count: count,
          autoHide: autoHide,
          child: const Icon(Icons.notifications, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          count == 0 && autoHide ? 'Badge is hidden' : 'Badge is visible',
          style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// 8. Multiple badges on different elements
@widgetbook.UseCase(name: 'Multiple Badges', type: AppBadge)
Widget multipleBadges(BuildContext context) {
  final badgeType = context.knobs.object.dropdown(
    label: 'Badge type',
    options: const ['notifications', 'messages', 'cart', 'user_status'],
    labelBuilder: (type) => type.replaceAll('_', ' '),
  );

  final count = context.knobs.int.slider(
    label: 'Count',
    initialValue: 12,
    min: 0,
    max: 99,
  );

  Widget buildBadge() {
    switch (badgeType) {
      case 'notifications':
        return AppBadge(
          count: count,
          child: IconButton(
            icon: const Icon(Icons.notifications, size: 28),
            onPressed: () {},
          ),
        );
      case 'messages':
        return AppBadge(
          count: count,
          child: IconButton(
            icon: const Icon(Icons.mail, size: 28),
            onPressed: () {},
          ),
        );
      case 'cart':
        return AppBadge(
          count: count,
          backgroundColor: Colors.green,
          child: IconButton(
            icon: const Icon(Icons.shopping_cart, size: 28),
            onPressed: () {},
          ),
        );
      case 'user_status':
        // Only show online status knob when user_status is selected
        final isOnline = context.knobs.boolean(
          label: 'Online status',
          initialValue: true,
        );
        return AppBadge.dot(
          backgroundColor: isOnline ? Colors.green : Colors.grey,
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, size: 36),
          ),
        );
      default:
        return AppBadge(
          count: count,
          child: const Icon(Icons.notifications, size: 28),
        );
    }
  }

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          badgeType.replaceAll('_', ' ').toUpperCase(),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        buildBadge(),
      ],
    ),
  );
}
