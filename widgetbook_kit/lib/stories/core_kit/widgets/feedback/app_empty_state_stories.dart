// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppEmptyState] component.
///
/// Demonstrates various configurations and use cases for the Material Design 3
/// empty state component, including basic states, with icons, with illustrations,
/// with actions, and compact mode.

@widgetbook.UseCase(name: 'Interactive Playground', type: AppEmptyState)
Widget appEmptyStatePlayground(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'No Items Found',
  );
  final description = context.knobs.stringOrNull(
    label: 'Description',
    initialValue: 'Start adding items to your collection.',
  );
  final compact = context.knobs.boolean(label: 'Compact', initialValue: false);
  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );
  final iconOption = context.knobs.object.dropdown(
    label: 'Icon',
    options: const [
      Icons.inbox_outlined,
      Icons.search_off,
      Icons.shopping_cart_outlined,
      Icons.wifi_off_rounded,
      Icons.notifications_off_outlined,
    ],
    labelBuilder: (value) {
      if (value == Icons.inbox_outlined) {
        return 'inbox_outlined';
      }
      if (value == Icons.search_off) {
        return 'search_off';
      }
      if (value == Icons.shopping_cart_outlined) {
        return 'shopping_cart_outlined';
      }
      if (value == Icons.wifi_off_rounded) {
        return 'wifi_off_rounded';
      }
      if (value == Icons.notifications_off_outlined) {
        return 'notifications_off_outlined';
      }
      return 'inbox_outlined';
    },
  );
  final showPrimaryButton = context.knobs.boolean(
    label: 'Show Primary Button',
    initialValue: true,
  );
  final primaryButtonText = context.knobs.string(
    label: 'Primary Button Text',
    initialValue: 'Add Item',
  );
  final showSecondaryButton = context.knobs.boolean(
    label: 'Show Secondary Button',
    initialValue: false,
  );
  final secondaryButtonText = context.knobs.string(
    label: 'Secondary Button Text',
    initialValue: 'View Details',
  );

  return Center(
    child: AppEmptyState(
      title: title,
      description: description,
      icon: showIcon ? iconOption : null,
      compact: compact,
      primaryButtonText: showPrimaryButton ? primaryButtonText : null,
      onPrimaryPressed: showPrimaryButton
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$primaryButtonText pressed!')),
              );
            }
          : null,
      secondaryButtonText: showSecondaryButton ? secondaryButtonText : null,
      onSecondaryPressed: showSecondaryButton
          ? () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$secondaryButtonText pressed!')),
              );
            }
          : null,
    ),
  );
}

@widgetbook.UseCase(name: 'Default (Title Only)', type: AppEmptyState)
Widget appEmptyStateDefault(BuildContext context) {
  return const Center(child: AppEmptyState(title: 'No Items Found'));
}

@widgetbook.UseCase(name: 'With Description', type: AppEmptyState)
Widget appEmptyStateWithDescription(BuildContext context) {
  return const Center(
    child: AppEmptyState(
      title: 'Your Cart is Empty',
      description: 'Looks like you haven\'t added any items to your cart yet.',
    ),
  );
}

@widgetbook.UseCase(name: 'With Icon', type: AppEmptyState)
Widget appEmptyStateWithIcon(BuildContext context) {
  return const Center(
    child: AppEmptyState(
      title: 'No Connection',
      description: 'Please check your internet connection and try again.',
      icon: Icons.wifi_off_rounded,
    ),
  );
}

@widgetbook.UseCase(name: 'With Primary Action', type: AppEmptyState)
Widget appEmptyStateWithPrimaryAction(BuildContext context) {
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

@widgetbook.UseCase(name: 'With Both Actions', type: AppEmptyState)
Widget appEmptyStateWithBothActions(BuildContext context) {
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
Widget appEmptyStateCompact(BuildContext context) {
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
Widget appEmptyStateNoConnection(BuildContext context) {
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
Widget appEmptyStateSearchNoResults(BuildContext context) {
  return const Center(
    child: AppEmptyState(
      title: 'No Results Found',
      description:
          'Try adjusting your search or filters to find what you\'re looking for.',
      icon: Icons.search_off,
    ),
  );
}
