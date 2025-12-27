// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
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
