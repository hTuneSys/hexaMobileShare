// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/feedback/app_bottom_sheet.dart';

// Story 1: Modal Action List - Demonstrates basic modal bottom sheet with action items
@widgetbook.UseCase(name: 'Modal Action List', type: AppBottomSheet)
Widget appBottomSheetActionList(BuildContext context) {
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
  final barrierColor = context.knobs.color(
    label: 'Barrier Color',
    initialValue: Colors.black54,
  );

  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          isDismissible: isDismissible,
          showDragHandle: showDragHandle,
          enableDrag: enableDrag,
          barrierColor: barrierColor,
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

// Story 2: Scrollable Content - Demonstrates bottom sheet with scrollable list
@widgetbook.UseCase(name: 'Scrollable Content', type: AppBottomSheet)
Widget appBottomSheetScrollable(BuildContext context) {
  final itemCount = context.knobs.int.slider(
    label: 'Item Count',
    initialValue: 20,
    min: 10,
    max: 50,
  );

  final useFullHeight = context.knobs.boolean(
    label: 'Use Full Height (vs Half)',
    initialValue: false,
  );

  final initialHeight = useFullHeight
      ? AppBottomSheetHeight.full
      : AppBottomSheetHeight.half;

  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          initialHeight: initialHeight,
          snapPoints: const [0.5, 0.9],
          builder: (context) => ListView.builder(
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text('Item ${index + 1}'),
              subtitle: Text('Subtitle for item ${index + 1}'),
            ),
          ),
        );
      },
      child: Text('Show $itemCount Items'),
    ),
  );
}

// Story 3: Form Input - Demonstrates bottom sheet with form fields and keyboard behavior
@widgetbook.UseCase(name: 'Form Input', type: AppBottomSheet)
Widget appBottomSheetForm(BuildContext context) {
  final useSafeArea = context.knobs.boolean(
    label: 'Use Safe Area',
    initialValue: true,
  );

  final showDragHandle = context.knobs.boolean(
    label: 'Show Drag Handle',
    initialValue: true,
  );

  return Center(
    child: ElevatedButton(
      onPressed: () {
        final nameController = TextEditingController();
        final emailController = TextEditingController();

        AppBottomSheet.show(
          context: context,
          initialHeight: AppBottomSheetHeight.auto,
          useSafeArea: useSafeArea,
          showDragHandle: showDragHandle,
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

// Story 4: Full Screen - Demonstrates nearly full-screen bottom sheet
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

// Story 5: Custom Height - Demonstrates custom initial heights and snap points
@widgetbook.UseCase(name: 'Custom Height', type: AppBottomSheet)
Widget appBottomSheetCustomHeight(BuildContext context) {
  final initialHeightIndex = context.knobs.int.slider(
    label: 'Initial Height',
    initialValue: 1,
    min: 0,
    max: 2,
  );

  final initialHeight = [
    AppBottomSheetHeight.auto,
    AppBottomSheetHeight.half,
    AppBottomSheetHeight.full,
  ][initialHeightIndex];

  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          initialHeight: initialHeight,
          snapPoints: const [0.3, 0.6, 0.95],
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Height: ${initialHeight.name}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
      child: Text('Show ${initialHeight.name} Height'),
    ),
  );
}

// Story 6: Persistent Sheet - Demonstrates persistent bottom sheet without backdrop
@widgetbook.UseCase(name: 'Persistent Sheet', type: AppBottomSheet)
Widget appBottomSheetPersistent(BuildContext context) {
  final showDragHandle = context.knobs.boolean(
    label: 'Show Drag Handle',
    initialValue: true,
  );

  return Center(
    child: ElevatedButton(
      onPressed: () {
        PersistentBottomSheetController? controller;
        controller = AppBottomSheet.showPersistent(
          context: context,
          initialHeight: AppBottomSheetHeight.auto,
          showDragHandle: showDragHandle,
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

// Story 7: Drag Handle Variants - Demonstrates drag handle configurations
@widgetbook.UseCase(name: 'Drag Handle Variants', type: AppBottomSheet)
Widget appBottomSheetDragHandle(BuildContext context) {
  final showDragHandle = context.knobs.boolean(
    label: 'Show Drag Handle',
    initialValue: true,
  );

  final enableDrag = context.knobs.boolean(
    label: 'Enable Drag',
    initialValue: true,
  );

  final isDismissible = context.knobs.boolean(
    label: 'Is Dismissible',
    initialValue: true,
  );

  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          showDragHandle: showDragHandle,
          enableDrag: enableDrag,
          isDismissible: isDismissible,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Drag Handle: ${showDragHandle ? 'Visible' : 'Hidden'}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Drag Enabled: ${enableDrag ? 'Yes' : 'No'}'),
                Text('Dismissible: ${isDismissible ? 'Yes' : 'No'}'),
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

// Story 8: Multiple Snap Points - Demonstrates multiple snap point configurations
@widgetbook.UseCase(name: 'Multiple Snap Points', type: AppBottomSheet)
Widget appBottomSheetSnapPoints(BuildContext context) {
  final snapPointCount = context.knobs.int.slider(
    label: 'Snap Point Count',
    initialValue: 4,
    min: 4,
    max: 5,
  );

  final snapPoints = snapPointCount == 4
      ? [0.2, 0.4, 0.6, 0.8]
      : [0.15, 0.35, 0.55, 0.75, 0.95];

  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppBottomSheet.show(
          context: context,
          snapPoints: snapPoints,
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
                Text('Snap points: ${snapPoints.join(', ')}'),
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
      child: Text('Show $snapPointCount Snap Points'),
    ),
  );
}
