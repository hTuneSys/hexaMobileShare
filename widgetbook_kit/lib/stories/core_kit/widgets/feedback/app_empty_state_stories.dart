// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppEmptyState] component.
///
/// Demonstrates various configurations and use cases for the Material Design 3
/// empty state component, including basic states, with icons, with illustrations,
/// with actions, and compact mode.

@widgetbook.UseCase(name: 'Default (Title Only)', type: AppEmptyState)
Widget buildAppEmptyStateDefaultUseCase(BuildContext context) {
  return const Center(child: AppEmptyState(title: 'No Items Found'));
}

@widgetbook.UseCase(name: 'With Description', type: AppEmptyState)
Widget buildAppEmptyStateWithDescriptionUseCase(BuildContext context) {
  return const Center(
    child: AppEmptyState(
      title: 'Your Cart is Empty',
      description: 'Looks like you haven\'t added any items to your cart yet.',
    ),
  );
}

@widgetbook.UseCase(name: 'With Icon', type: AppEmptyState)
Widget buildAppEmptyStateWithIconUseCase(BuildContext context) {
  return const Center(
    child: AppEmptyState(
      title: 'No Connection',
      description: 'Please check your internet connection and try again.',
      icon: Icons.wifi_off_rounded,
    ),
  );
}

@widgetbook.UseCase(name: 'With Illustration', type: AppEmptyState)
Widget buildAppEmptyStateWithIllustrationUseCase(BuildContext context) {
  return const Center(
    child: AppEmptyState(
      title: 'Order Success!',
      description: 'Your order has been placed successfully.',
      illustration: Icon(Icons.check_circle, size: 100, color: Colors.green),
    ),
  );
}

@widgetbook.UseCase(name: 'With Primary Action', type: AppEmptyState)
Widget buildAppEmptyStateWithPrimaryActionUseCase(BuildContext context) {
  return Center(
    child: AppEmptyState(
      title: 'No Items Found',
      description: 'Start adding items to your collection.',
      icon: Icons.inbox_outlined,
      primaryButtonText: 'Add Item',
      onPrimaryPressed: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Add Item pressed!')));
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Full Actions (Shopping Cart)', type: AppEmptyState)
Widget buildAppEmptyStateFullActionsUseCase(BuildContext context) {
  return Center(
    child: AppEmptyState(
      title: 'Your Cart is Empty',
      description: 'Looks like you haven\'t added anything to your cart yet.',
      icon: Icons.shopping_cart_outlined,
      primaryButtonText: 'Start Shopping',
      onPrimaryPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Start Shopping pressed!')),
        );
      },
      secondaryButtonText: 'View Wishlist',
      onSecondaryPressed: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('View Wishlist pressed!')));
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Compact Mode', type: AppEmptyState)
Widget buildAppEmptyStateCompactUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      height: 300,
      child: Card(
        child: AppEmptyState(
          title: 'No Notifications',
          description: 'You are all caught up!',
          icon: Icons.notifications_off_outlined,
          compact: true,
          primaryButtonText: 'Refresh',
          onPrimaryPressed: () {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Refresh pressed!')));
          },
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'No Connection Error', type: AppEmptyState)
Widget buildAppEmptyStateNoConnectionUseCase(BuildContext context) {
  return Center(
    child: AppEmptyState(
      title: 'No Internet Connection',
      description:
          'Please check your connection and try again. Make sure Wi-Fi or mobile data is enabled.',
      icon: Icons.wifi_off_rounded,
      primaryButtonText: 'Retry',
      onPrimaryPressed: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Retrying connection...')));
      },
    ),
  );
}

@widgetbook.UseCase(name: 'Search No Results', type: AppEmptyState)
Widget buildAppEmptyStateSearchNoResultsUseCase(BuildContext context) {
  return const Center(
    child: AppEmptyState(
      title: 'No Results Found',
      description:
          'Try adjusting your search or filters to find what you\'re looking for.',
      icon: Icons.search_off,
    ),
  );
}
