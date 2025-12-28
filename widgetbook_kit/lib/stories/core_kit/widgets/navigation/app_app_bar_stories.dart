// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// 1. Basic App Bar - Default app bar with title and back button
@widgetbook.UseCase(name: 'Basic App Bar', type: AppAppBar)
Widget basicAppBar(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'My App');
  final showBackButton = context.knobs.boolean(
    label: 'Show Back Button',
    initialValue: false,
  );
  final elevation = context.knobs.double.slider(
    label: 'Elevation',
    initialValue: 0.0,
    min: 0.0,
    max: 8.0,
  );

  return Scaffold(
    appBar: AppAppBar(
      title: title,
      leading: showBackButton ? const BackButton() : null,
      elevation: elevation,
    ),
    body: const Center(child: Text('Basic app bar example')),
  );
}

// 2. Action Icons - App bar with action icon buttons
@widgetbook.UseCase(name: 'Action Icons', type: AppAppBar)
Widget actionIcons(BuildContext context) {
  final title = context.knobs.string(label: 'Title', initialValue: 'Actions');
  final numberOfActions = context.knobs.double
      .slider(label: 'Number of Actions', initialValue: 2.0, min: 1.0, max: 4.0)
      .toInt();

  final actionIcons = [
    Icons.search,
    Icons.favorite,
    Icons.more_vert,
    Icons.share,
  ];

  return Scaffold(
    appBar: AppAppBar(
      title: title,
      actions: List.generate(
        numberOfActions,
        (index) => IconButton(
          icon: Icon(actionIcons[index]),
          onPressed: () {},
          tooltip: 'Action ${index + 1}',
        ),
      ),
    ),
    body: const Center(child: Text('App bar with action icons')),
  );
}

// 3. Large Title (Collapsible) - App bar with large title that collapses on scroll
@widgetbook.UseCase(name: 'Large Title (Collapsible)', type: AppAppBar)
Widget largeTitleCollapsible(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Large Title',
  );
  final expandedHeight = context.knobs.double.slider(
    label: 'Expanded Height',
    initialValue: 128.0,
    min: 100.0,
    max: 200.0,
  );
  final pinned = context.knobs.boolean(label: 'Pinned', initialValue: true);
  final floating = context.knobs.boolean(
    label: 'Floating',
    initialValue: false,
  );
  final snap = context.knobs.boolean(label: 'Snap', initialValue: false);

  return Scaffold(
    body: CustomScrollView(
      slivers: [
        AppAppBar.large(
          title: title,
          expandedHeight: expandedHeight,
          pinned: pinned,
          floating: floating,
          snap: snap,
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => ListTile(
              title: Text('Item ${index + 1}'),
              subtitle: Text('Scroll to see the app bar collapse'),
            ),
            childCount: 30,
          ),
        ),
      ],
    ),
  );
}

// 4. Center-Aligned Title - App bar with centered title
@widgetbook.UseCase(name: 'Center-Aligned Title', type: AppAppBar)
Widget centerAlignedTitle(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Centered Title',
  );
  final centerTitle = context.knobs.boolean(
    label: 'Center Title',
    initialValue: true,
  );
  final backgroundColor = context.knobs.colorOrNull(
    label: 'Background Color',
    initialValue: Colors.blue,
  );

  return Scaffold(
    appBar: AppAppBar(
      title: title,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      foregroundColor: Colors.white,
    ),
    body: const Center(child: Text('Center-aligned app bar example')),
  );
}

// 5. With Search Field - App bar with integrated search field
@widgetbook.UseCase(name: 'With Search Field', type: AppAppBar)
Widget withSearchField(BuildContext context) {
  final searchHint = context.knobs.string(
    label: 'Search Hint',
    initialValue: 'Search...',
  );
  final showSearch = context.knobs.boolean(
    label: 'Show Search',
    initialValue: true,
  );

  return Scaffold(
    appBar: AppAppBar(
      title: showSearch
          ? TextField(
              decoration: InputDecoration(
                hintText: searchHint,
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
            )
          : 'Search Example',
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      actions: [
        if (!showSearch)
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
      ],
    ),
    body: ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.article),
        title: Text('Search Result ${index + 1}'),
        subtitle: Text('Description for item ${index + 1}'),
      ),
    ),
  );
}

// 6. With Tabs - App bar with TabBar at the bottom
@widgetbook.UseCase(name: 'With Tabs', type: AppAppBar)
Widget withTabs(BuildContext context) {
  final numberOfTabs = context.knobs.double
      .slider(label: 'Number of Tabs', initialValue: 3.0, min: 2.0, max: 5.0)
      .toInt();

  final tabLabels = ['Home', 'Explore', 'Profile', 'Settings', 'More'];

  return DefaultTabController(
    length: numberOfTabs,
    child: Scaffold(
      appBar: AppAppBar(
        title: 'Tabs Example',
        bottom: TabBar(
          tabs: List.generate(
            numberOfTabs,
            (index) => Tab(text: tabLabels[index]),
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: TabBarView(
        children: List.generate(
          numberOfTabs,
          (index) => Center(
            child: Text(
              'Tab ${index + 1}: ${tabLabels[index]}',
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    ),
  );
}

// 7. Transparent App Bar - App bar with transparent background
@widgetbook.UseCase(name: 'Transparent App Bar', type: AppAppBar)
Widget transparentAppBar(BuildContext context) {
  final backgroundOpacity = context.knobs.double.slider(
    label: 'Background Opacity',
    initialValue: 0.0,
    min: 0.0,
    max: 1.0,
  );
  final foregroundColor = context.knobs.colorOrNull(
    label: 'Foreground Color',
    initialValue: Colors.white,
  );

  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppAppBar(
      title: 'Transparent',
      backgroundColor: Colors.black.withValues(alpha: backgroundOpacity),
      foregroundColor: foregroundColor,
      elevation: 0,
      actions: [IconButton(icon: const Icon(Icons.settings), onPressed: () {})],
    ),
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple, Colors.blue, Colors.pink],
        ),
      ),
      child: const Center(
        child: Text(
          'Content Behind App Bar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

// 8. Custom Colors - App bar with custom colors
@widgetbook.UseCase(name: 'Custom Colors', type: AppAppBar)
Widget customColors(BuildContext context) {
  final title = context.knobs.string(
    label: 'Title',
    initialValue: 'Custom Colors',
  );
  final backgroundColor = context.knobs.colorOrNull(
    label: 'Background Color',
    initialValue: Colors.blue,
  );
  final foregroundColor = context.knobs.colorOrNull(
    label: 'Foreground Color',
    initialValue: Colors.white,
  );
  final elevation = context.knobs.double.slider(
    label: 'Elevation',
    initialValue: 4.0,
    min: 0.0,
    max: 16.0,
  );

  return Scaffold(
    appBar: AppAppBar(
      title: title,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      actions: [
        IconButton(icon: const Icon(Icons.palette), onPressed: () {}),
        IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
      ],
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Custom colored app bar', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
            ),
            child: const Text('Matching Button'),
          ),
        ],
      ),
    ),
  );
}
