// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

@widgetbook.UseCase(name: 'Default (Title Only)', type: AppEmptyState)
Widget defaultAppEmptyState(BuildContext context) {
  return const AppEmptyState(title: 'No Items Found');
}

@widgetbook.UseCase(name: 'With Description', type: AppEmptyState)
Widget withDescription(BuildContext context) {
  return const AppEmptyState(
    title: 'Your Cart is Empty',
    description: 'Looks like you haven\'t added any items to your cart yet.',
  );
}

@widgetbook.UseCase(name: 'With Icon', type: AppEmptyState)
Widget withIcon(BuildContext context) {
  return const AppEmptyState(
    title: 'No Connection',
    description: 'Please check your internet connection and try again.',
    icon: Icons.wifi_off_rounded,
  );
}

@widgetbook.UseCase(name: 'With Illustration', type: AppEmptyState)
Widget withIllustration(BuildContext context) {
  return const AppEmptyState(
    title: 'Order Success!',
    description: 'Your order has been placed successfully.',
    illustration: Icon(Icons.check_circle, size: 100, color: Colors.green),
  );
}

@widgetbook.UseCase(name: 'Full Actions (Shopping Cart)', type: AppEmptyState)
Widget fullActions(BuildContext context) {
  return AppEmptyState(
    title: 'Your Cart is Empty',
    description: 'Looks like you haven\'t added anything to your cart yet.',
    icon: Icons.shopping_cart_outlined,
    primaryButtonText: 'Start Shopping',
    onPrimaryPressed: () {},
    secondaryButtonText: 'View Wishlist',
    onSecondaryPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Compact Mode', type: AppEmptyState)
Widget compactMode(BuildContext context) {
  return SizedBox(
    width: 300,
    height: 300,
    child: Card(
      child: AppEmptyState(
        title: 'No Notifications',
        description: 'You are all caught up!',
        icon: Icons.notifications_off_outlined,
        compact: true,
        primaryButtonText: 'Refresh',
        onPrimaryPressed: () {},
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Interactive Playground', type: AppEmptyState)
Widget interactivePlayground(BuildContext context) {
  // Text Content Knobs
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'No Items Found',
  );

  final showDescription = context.knobs.boolean(
    label: 'Show Description',
    initialValue: true,
  );

  final description = context.knobs.string(
    label: 'Description',
    initialValue: 'Add items to get started with your collection.',
  );

  // Visual Elements
  final visualType = context.knobs.object.dropdown(
    label: 'Visual Type',
    options: ['None', 'Icon', 'Illustration'],
    initialOption: 'Icon',
  );

  final iconType = context.knobs.object.dropdown(
    label: 'Icon Type',
    options: [
      'shopping_cart',
      'wifi_off',
      'notifications_off',
      'inbox',
      'search',
      'folder_open',
    ],
    initialOption: 'shopping_cart',
  );

  // Get icon based on selection
  IconData? getIcon() {
    switch (iconType) {
      case 'shopping_cart':
        return Icons.shopping_cart_outlined;
      case 'wifi_off':
        return Icons.wifi_off_rounded;
      case 'notifications_off':
        return Icons.notifications_off_outlined;
      case 'inbox':
        return Icons.inbox_outlined;
      case 'search':
        return Icons.search_off;
      case 'folder_open':
        return Icons.folder_open_outlined;
      default:
        return Icons.help_outline;
    }
  }

  // Buttons Configuration
  final showPrimaryButton = context.knobs.boolean(
    label: 'Show Primary Button',
    initialValue: true,
  );

  final primaryButtonText = context.knobs.string(
    label: 'Primary Button Text',
    initialValue: 'Get Started',
  );

  final showSecondaryButton = context.knobs.boolean(
    label: 'Show Secondary Button',
    initialValue: false,
  );

  final secondaryButtonText = context.knobs.string(
    label: 'Secondary Button Text',
    initialValue: 'Learn More',
  );

  // Layout Options
  final compact = context.knobs.boolean(
    label: 'Compact Mode',
    initialValue: false,
  );

  return AppEmptyState(
    title: title,
    description: showDescription ? description : null,
    icon: visualType == 'Icon' ? getIcon() : null,
    illustration: visualType == 'Illustration'
        ? const Icon(
            Icons.celebration_outlined,
            size: 100,
            color: Colors.purple,
          )
        : null,
    primaryButtonText: showPrimaryButton ? primaryButtonText : null,
    onPrimaryPressed: showPrimaryButton
        ? () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Primary button pressed!')),
            );
          }
        : null,
    secondaryButtonText: showSecondaryButton ? secondaryButtonText : null,
    onSecondaryPressed: showSecondaryButton
        ? () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Secondary button pressed!')),
            );
          }
        : null,
    compact: compact,
  );
}
