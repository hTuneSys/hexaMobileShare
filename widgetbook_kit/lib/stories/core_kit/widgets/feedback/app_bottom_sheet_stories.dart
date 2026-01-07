// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/feedback/app_bottom_sheet.dart';

/// Widgetbook stories for [AppBottomSheet] component.
///
/// Demonstrates various configurations and use cases for the Material Design 3
/// bottom sheet component, including modal, persistent, scrollable, and form variants.

@widgetbook.UseCase(name: 'Interactive Playground', type: AppBottomSheet)
Widget appBottomSheetPlayground(BuildContext context) {
  final isDismissible = context.knobs.boolean(
    label: 'Is Dismissible',
    initialValue: true,
  );
  final showDragHandle = context.knobs.boolean(
    label: 'Show Drag Handle',
    initialValue: true,
  );
  final enableDrag = context.knobs.boolean(
    label: 'Enable Drag',
    initialValue: true,
  );
  final useSafeArea = context.knobs.boolean(
    label: 'Use Safe Area',
    initialValue: true,
  );
  final initialHeight = context.knobs.object.dropdown<AppBottomSheetHeight>(
    label: 'Initial Height',
    options: const [
      AppBottomSheetHeight.auto,
      AppBottomSheetHeight.half,
      AppBottomSheetHeight.full,
    ],
    labelBuilder: (height) {
      switch (height) {
        case AppBottomSheetHeight.auto:
          return 'Auto';
        case AppBottomSheetHeight.half:
          return 'Half';
        case AppBottomSheetHeight.full:
          return 'Full';
      }
    },
  );
  final itemCount = context.knobs.int.slider(
    label: 'Item Count',
    initialValue: 5,
    min: 3,
    max: 10,
  );

  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          isDismissible: isDismissible,
          showDragHandle: showDragHandle,
          enableDrag: enableDrag,
          useSafeArea: useSafeArea,
          initialHeight: initialHeight,
          builder: (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Interactive Bottom Sheet',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...List.generate(
                  itemCount,
                  (index) => ListTile(
                    leading: Icon(Icons.star, color: Colors.amber[700]),
                    title: Text('Item ${index + 1}'),
                    onTap: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const Text('Show Bottom Sheet'),
    ),
  );
}

@widgetbook.UseCase(name: 'Modal Action List', type: AppBottomSheet)
Widget appBottomSheetActionList(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          initialHeight: AppBottomSheetHeight.auto,
          builder: (context) => Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.share),
                  title: const Text('Share'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Delete'),
                  iconColor: Colors.red,
                  textColor: Colors.red,
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.close),
                  title: const Text('Cancel'),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
      child: const Text('Show Action Sheet'),
    ),
  );
}

@widgetbook.UseCase(name: 'Scrollable Content', type: AppBottomSheet)
Widget appBottomSheetScrollable(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          initialHeight: AppBottomSheetHeight.half,
          snapPoints: const [0.5, 0.9],
          builder: (context) => ListView.builder(
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text('Item ${index + 1}'),
              subtitle: Text('Subtitle for item ${index + 1}'),
            ),
          ),
        );
      },
      child: const Text('Show Scrollable List'),
    ),
  );
}

@widgetbook.UseCase(name: 'Form Input', type: AppBottomSheet)
Widget appBottomSheetForm(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        final nameController = TextEditingController();
        final emailController = TextEditingController();

        AppBottomSheet.show(
          context: context,
          initialHeight: AppBottomSheetHeight.auto,
          useSafeArea: true,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Quick Comment',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        );
      },
      child: const Text('Show Form'),
    ),
  );
}

@widgetbook.UseCase(name: 'Full Screen', type: AppBottomSheet)
Widget appBottomSheetFullScreen(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          initialHeight: AppBottomSheetHeight.full,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: List.generate(
                      20,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Card(
                          child: ListTile(
                            leading: const Icon(Icons.article),
                            title: Text('Article ${index + 1}'),
                            subtitle: Text(
                              'This is a detailed description for article ${index + 1}',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const Text('Show Full Screen'),
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Height', type: AppBottomSheet)
Widget appBottomSheetCustomHeight(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          initialHeight: AppBottomSheetHeight.half,
          snapPoints: const [0.3, 0.6, 0.95],
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Custom Height Sheet',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Snap points: 0.3, 0.6, 0.95'),
                const SizedBox(height: 16),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: List.generate(
                      15,
                      (index) => ListTile(
                        leading: const Icon(Icons.label, color: Colors.blue),
                        title: Text('Item ${index + 1}'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const Text('Show Custom Height'),
    ),
  );
}

@widgetbook.UseCase(name: 'Persistent Sheet', type: AppBottomSheet)
Widget appBottomSheetPersistent(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        PersistentBottomSheetController? controller;
        controller = AppBottomSheet.showPersistent(
          context: context,
          initialHeight: AppBottomSheetHeight.auto,
          builder: (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Persistent Bottom Sheet',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('This sheet has no backdrop and stays visible'),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => controller?.close(),
                  child: const Text('Close Sheet'),
                ),
              ],
            ),
          ),
        );
      },
      child: const Text('Show Persistent Sheet'),
    ),
  );
}

@widgetbook.UseCase(name: 'Drag Handle Variants', type: AppBottomSheet)
Widget appBottomSheetDragHandle(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          showDragHandle: true,
          enableDrag: true,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Drag Handle Enabled',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Try dragging the sheet up or down'),
                const SizedBox(height: 16),
                const Divider(),
                ...List.generate(
                  5,
                  (index) => ListTile(
                    leading: const Icon(Icons.drag_indicator),
                    title: Text('Item ${index + 1}'),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  label: const Text('Close Sheet'),
                ),
              ],
            ),
          ),
        );
      },
      child: const Text('Show Sheet'),
    ),
  );
}

@widgetbook.UseCase(name: 'Multiple Snap Points', type: AppBottomSheet)
Widget appBottomSheetSnapPoints(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          snapPoints: const [0.2, 0.4, 0.6, 0.8],
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Multiple Snap Points',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Snap points: 0.2, 0.4, 0.6, 0.8'),
                const SizedBox(height: 16),
                const Text(
                  'Try dragging the sheet to see it snap to different heights!',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: List.generate(
                      30,
                      (index) => ListTile(
                        leading: CircleAvatar(child: Text('${index + 1}')),
                        title: Text('Scrollable Item ${index + 1}'),
                        subtitle: const Text('Drag sheet up/down to snap'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: const Text('Show Multiple Snap Points'),
    ),
  );
}
