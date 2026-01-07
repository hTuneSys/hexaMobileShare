// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppAppBar] component.
///
/// Material Design 3 app bar component that provides consistent top
/// navigation with title, actions, and responsive scroll behavior.

// ============================================================================
// Interactive Playground - MUST BE FIRST
// ============================================================================

@widgetbook.UseCase(name: 'Interactive Playground', type: AppAppBar)
Widget appAppBarPlayground(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'My App');
  final centerTitle = context.knobs.booleanOrNull(label: 'Center Title');
  final elevation = context.knobs.double.slider(
    label: 'Elevation',
    initialValue: 0.0,
    min: 0,
    max: 8,
  );
  final showActions = context.knobs.boolean(
    label: 'Show Actions',
    initialValue: true,
  );
  final showLeading = context.knobs.boolean(
    label: 'Show Leading',
    initialValue: false,
  );

  return _AppBarPreview(
    appBar: AppAppBar(
      title: title,
      centerTitle: centerTitle,
      elevation: elevation,
      leading: showLeading ? const BackButton() : null,
      actions: showActions
          ? [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ]
          : null,
    ),
  );
}

// ============================================================================
// Variant 2: Basic
// ============================================================================

@widgetbook.UseCase(name: 'Basic', type: AppAppBar)
Widget basicAppBar(BuildContext context) {
  return _AppBarPreview(appBar: const AppAppBar(title: 'My App'));
}

// ============================================================================
// Variant 3: With Back Button
// ============================================================================

@widgetbook.UseCase(name: 'With Back Button', type: AppAppBar)
Widget appBarWithBackButton(BuildContext context) {
  return _AppBarPreview(
    appBar: const AppAppBar(title: 'Details', leading: BackButton()),
  );
}

// ============================================================================
// Variant 4: With Actions
// ============================================================================

@widgetbook.UseCase(name: 'With Actions', type: AppAppBar)
Widget appBarWithActions(BuildContext context) {
  return _AppBarPreview(
    appBar: AppAppBar(
      title: 'Messages',
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.favorite), onPressed: () {}),
        IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ],
    ),
  );
}

// ============================================================================
// Variant 5: Centered Title
// ============================================================================

@widgetbook.UseCase(name: 'Centered Title', type: AppAppBar)
Widget centeredTitleAppBar(BuildContext context) {
  return _AppBarPreview(
    appBar: AppAppBar(
      title: 'Centered',
      centerTitle: true,
      actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})],
    ),
  );
}

// ============================================================================
// Variant 6: With Elevation
// ============================================================================

@widgetbook.UseCase(name: 'With Elevation', type: AppAppBar)
Widget appBarWithElevation(BuildContext context) {
  return _AppBarPreview(
    appBar: AppAppBar(
      title: 'Elevated',
      elevation: 4.0,
      actions: [
        IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
      ],
    ),
  );
}

// ============================================================================
// Variant 7: Custom Colors
// ============================================================================

@widgetbook.UseCase(name: 'Custom Colors', type: AppAppBar)
Widget customColorsAppBar(BuildContext context) {
  return _AppBarPreview(
    appBar: AppAppBar(
      title: 'Custom Colors',
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      actions: [IconButton(icon: const Icon(Icons.palette), onPressed: () {})],
    ),
  );
}

// ============================================================================
// Variant 8: Large Title (Collapsible)
// ============================================================================

@widgetbook.UseCase(name: 'Large Title', type: AppAppBar)
Widget largeTitleAppBar(BuildContext context) {
  return Scaffold(
    body: CustomScrollView(
      slivers: [
        AppAppBar.large(
          title: 'Large Title',
          pinned: true,
          expandedHeight: 128.0,
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text('Item ${index + 1}'),
              subtitle: Text('Scroll to see collapse effect'),
            ),
            childCount: 30,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Variant 9: Floating App Bar
// ============================================================================

@widgetbook.UseCase(name: 'Floating', type: AppAppBar)
Widget floatingAppBar(BuildContext context) {
  return Scaffold(
    body: CustomScrollView(
      slivers: [
        AppAppBar.large(
          title: 'Floating Bar',
          floating: true,
          snap: true,
          pinned: false,
          actions: [
            IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text('Item ${index + 1}'),
              subtitle: Text('Scroll down to hide, up to show'),
            ),
            childCount: 30,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
// Variant 10: With Tab Bar
// ============================================================================

@widgetbook.UseCase(name: 'With Tabs', type: AppAppBar)
Widget appBarWithTabs(BuildContext context) {
  return DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppAppBar(
        title: 'Tabs',
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
        bottom: const TabBar(
          tabs: [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          Center(child: Text('Content 1')),
          Center(child: Text('Content 2')),
          Center(child: Text('Content 3')),
        ],
      ),
    ),
  );
}

// ============================================================================
// Helper Widget - Preview Container for AppBar
// ============================================================================

class _AppBarPreview extends StatelessWidget {
  final AppAppBar appBar;

  const _AppBarPreview({required this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: const Center(child: Text('App Bar Preview')),
    );
  }
}
