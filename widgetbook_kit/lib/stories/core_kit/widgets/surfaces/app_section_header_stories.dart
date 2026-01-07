// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppSectionHeader] component.
///
/// Material Design 3 section header widget for organizing content into
/// logical groups with title and optional actions.

// ============================================================================
// Interactive Playground - MUST BE FIRST
// ============================================================================

@widgetbook.UseCase(name: 'Interactive Playground', type: AppSectionHeader)
Widget appSectionHeaderPlayground(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Section Header',
  );
  final subtitle = context.knobs.stringOrNull(label: 'Subtitle');
  final isUpperCase = context.knobs.boolean(
    label: 'Uppercase',
    initialValue: false,
  );
  final showDivider = context.knobs.boolean(
    label: 'Show Divider',
    initialValue: false,
  );
  final showLeading = context.knobs.boolean(
    label: 'Show Leading',
    initialValue: false,
  );
  final showTrailing = context.knobs.boolean(
    label: 'Show Trailing',
    initialValue: false,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSectionHeader(
        title: title,
        subtitle: subtitle,
        isUpperCase: isUpperCase,
        showDivider: showDivider,
        leading: showLeading ? const Icon(Icons.category) : null,
        trailing: showTrailing
            ? TextButton(
                onPressed: () => debugPrint('Action tapped'),
                child: const Text('View All'),
              )
            : null,
      ),
    ),
  );
}

// ============================================================================
// Variant 2: Basic
// ============================================================================

@widgetbook.UseCase(name: 'Basic', type: AppSectionHeader)
Widget basicSectionHeader(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: const AppSectionHeader(title: 'Section Title'),
    ),
  );
}

// ============================================================================
// Variant 3: With Subtitle
// ============================================================================

@widgetbook.UseCase(name: 'With Subtitle', type: AppSectionHeader)
Widget sectionHeaderWithSubtitle(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: const AppSectionHeader(
        title: 'Account Settings',
        subtitle: 'Manage your account preferences and security',
      ),
    ),
  );
}

// ============================================================================
// Variant 4: Uppercase
// ============================================================================

@widgetbook.UseCase(name: 'Uppercase', type: AppSectionHeader)
Widget uppercaseSectionHeader(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: const AppSectionHeader(title: 'Recent Items', isUpperCase: true),
    ),
  );
}

// ============================================================================
// Variant 5: With Divider
// ============================================================================

@widgetbook.UseCase(name: 'With Divider', type: AppSectionHeader)
Widget sectionHeaderWithDivider(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: const AppSectionHeader(
        title: 'Privacy Settings',
        subtitle: 'Control your data and privacy',
        showDivider: true,
        dividerPosition: DividerPosition.below,
      ),
    ),
  );
}

// ============================================================================
// Variant 6: With Leading Icon
// ============================================================================

@widgetbook.UseCase(name: 'With Leading', type: AppSectionHeader)
Widget sectionHeaderWithLeading(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: const AppSectionHeader(
        leading: Icon(Icons.settings),
        title: 'Preferences',
        subtitle: 'Customize your experience',
      ),
    ),
  );
}

// ============================================================================
// Variant 7: With Trailing Action
// ============================================================================

@widgetbook.UseCase(name: 'With Trailing', type: AppSectionHeader)
Widget sectionHeaderWithTrailing(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSectionHeader(
        title: 'Notifications',
        subtitle: '3 new notifications',
        trailing: TextButton(
          onPressed: () => debugPrint('View All tapped'),
          child: const Text('View All'),
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 8: With Background Color
// ============================================================================

@widgetbook.UseCase(name: 'With Background', type: AppSectionHeader)
Widget sectionHeaderWithBackground(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSectionHeader(
        title: 'Highlighted Section',
        subtitle: 'Important information',
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        showDivider: true,
      ),
    ),
  );
}

// ============================================================================
// Variant 9: Divider Above
// ============================================================================

@widgetbook.UseCase(name: 'Divider Above', type: AppSectionHeader)
Widget sectionHeaderDividerAbove(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: const AppSectionHeader(
        title: 'Next Section',
        subtitle: 'Continue reading below',
        showDivider: true,
        dividerPosition: DividerPosition.above,
      ),
    ),
  );
}

// ============================================================================
// Variant 10: Full Featured
// ============================================================================

@widgetbook.UseCase(name: 'Full Featured', type: AppSectionHeader)
Widget fullFeaturedSectionHeader(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSectionHeader(
        leading: Icon(Icons.star, color: Theme.of(context).colorScheme.primary),
        title: 'Featured Items',
        subtitle: 'Curated selection just for you',
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () => debugPrint('Arrow tapped'),
        ),
        showDivider: true,
        dividerPosition: DividerPosition.below,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
    ),
  );
}
