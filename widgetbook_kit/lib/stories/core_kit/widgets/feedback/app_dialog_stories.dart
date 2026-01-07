// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Widgetbook stories for [AppDialog] component.
///
/// Demonstrates various configurations and use cases for the Material Design 3
/// dialog component, including basic alerts, confirmations, forms, and custom content.

@widgetbook.UseCase(name: 'Interactive Playground', type: AppDialog)
Widget appDialogPlayground(BuildContext context) {
  final title = context.knobs.stringOrNull(
    label: 'Title',
    initialValue: 'Dialog Title',
  );
  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: false,
  );
  final iconType = context.knobs.object.dropdown<IconData>(
    label: 'Icon',
    options: const [
      Icons.info_outline,
      Icons.warning_amber_outlined,
      Icons.error_outline,
      Icons.check_circle_outline,
    ],
    labelBuilder: (icon) {
      if (icon == Icons.info_outline) {
        return 'Info';
      }
      if (icon == Icons.warning_amber_outlined) {
        return 'Warning';
      }
      if (icon == Icons.error_outline) {
        return 'Error';
      }
      if (icon == Icons.check_circle_outline) {
        return 'Success';
      }
      return 'Info';
    },
  );
  final contentText = context.knobs.string(
    label: 'Content',
    initialValue: 'This is the dialog content.',
  );
  final isDismissible = context.knobs.boolean(
    label: 'Dismissible',
    initialValue: true,
  );
  final isFullScreen = context.knobs.boolean(
    label: 'Full Screen',
    initialValue: false,
  );
  final scrollable = context.knobs.boolean(
    label: 'Scrollable',
    initialValue: true,
  );
  final showPrimaryAction = context.knobs.boolean(
    label: 'Show Primary Action',
    initialValue: true,
  );
  final showSecondaryAction = context.knobs.boolean(
    label: 'Show Secondary Action',
    initialValue: true,
  );
  final showDestructiveAction = context.knobs.boolean(
    label: 'Show Destructive Action',
    initialValue: false,
  );

  final actions = <AppDialogAction>[];
  if (showSecondaryAction) {
    actions.add(
      AppDialogAction(
        label: 'Cancel',
        isSecondary: true,
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
      ),
    );
  }
  if (showDestructiveAction) {
    actions.add(
      AppDialogAction(
        label: 'Delete',
        isDestructive: true,
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
      ),
    );
  }
  if (showPrimaryAction) {
    actions.add(
      AppDialogAction(
        label: 'Confirm',
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
      ),
    );
  }

  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: title,
          icon: showIcon ? Icon(iconType) : null,
          content: contentText,
          actions: actions,
          isDismissible: isDismissible,
          isFullScreen: isFullScreen,
          scrollable: scrollable,
        );
      },
      child: const Text('Show Dialog'),
    ),
  );
}

@widgetbook.UseCase(name: 'Basic Alert', type: AppDialog)
Widget appDialogBasicAlert(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: 'Success',
          content: 'Your changes have been saved successfully.',
          actions: [
            AppDialogAction(
              label: 'OK',
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
          ],
        );
      },
      child: const Text('Show Basic Alert'),
    ),
  );
}

@widgetbook.UseCase(name: 'Confirmation Dialog', type: AppDialog)
Widget appDialogConfirmation(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show<bool>(
          context: context,
          title: 'Delete Item',
          content:
              'Are you sure you want to delete this item? This action cannot be undone.',
          actions: [
            AppDialogAction(
              label: 'Cancel',
              isSecondary: true,
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(false),
            ),
            AppDialogAction(
              label: 'Delete',
              isDestructive: true,
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(true),
            ),
          ],
        );
      },
      child: const Text('Show Confirmation Dialog'),
    ),
  );
}

@widgetbook.UseCase(name: 'Scrolling Content', type: AppDialog)
Widget appDialogScrolling(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: 'Terms of Service',
          content: '''
Please read these terms of service carefully before using our application.

1. Acceptance of Terms
By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement.

2. Use License
Permission is granted to temporarily download one copy of the materials on our application for personal, non-commercial transitory viewing only.

3. Disclaimer
The materials on our application are provided on an 'as is' basis. We make no warranties, expressed or implied.

4. Limitations
In no event shall our company or its suppliers be liable for any damages arising out of the use or inability to use the materials on our application.

5. Accuracy of Materials
The materials appearing on our application could include technical, typographical, or photographic errors.

6. Links
We have not reviewed all of the sites linked to our application and are not responsible for the contents of any such linked site.

7. Modifications
We may revise these terms of service for its application at any time without notice.

8. Governing Law
These terms and conditions are governed by and construed in accordance with the laws.
''',
          actions: [
            AppDialogAction(
              label: 'Decline',
              isSecondary: true,
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(false),
            ),
            AppDialogAction(
              label: 'Accept',
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(true),
            ),
          ],
          scrollable: true,
        );
      },
      child: const Text('Show Terms of Service'),
    ),
  );
}

@widgetbook.UseCase(name: 'Form Dialog', type: AppDialog)
Widget appDialogForm(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: 'Add New Item',
          contentBuilder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Item Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: ['Work', 'Personal', 'Other']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) {},
              ),
            ],
          ),
          actions: [
            AppDialogAction(
              label: 'Cancel',
              isSecondary: true,
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
            AppDialogAction(
              label: 'Add',
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(true),
            ),
          ],
          scrollable: true,
        );
      },
      child: const Text('Show Form Dialog'),
    ),
  );
}

@widgetbook.UseCase(name: 'Custom Content', type: AppDialog)
Widget appDialogCustomContent(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: 'Choose Your Plan',
          contentBuilder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PlanCard(
                title: 'Basic',
                price: 'Free',
                features: ['5 Projects', '1 GB Storage', 'Basic Support'],
                isSelected: true,
              ),
              const SizedBox(height: 16),
              _PlanCard(
                title: 'Pro',
                price: '\$9.99/mo',
                features: [
                  'Unlimited Projects',
                  '100 GB Storage',
                  'Priority Support',
                ],
                isSelected: false,
              ),
            ],
          ),
          actions: [
            AppDialogAction(
              label: 'Cancel',
              isSecondary: true,
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
            AppDialogAction(
              label: 'Continue',
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(true),
            ),
          ],
          scrollable: true,
        );
      },
      child: const Text('Show Plan Selection'),
    ),
  );
}

@widgetbook.UseCase(name: 'Full Screen', type: AppDialog)
Widget appDialogFullScreen(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: 'Edit Profile',
          isFullScreen: true,
          contentBuilder: (context) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                ),
                const SizedBox(height: 24),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ),
          actions: [
            AppDialogAction(
              label: 'Cancel',
              isSecondary: true,
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            ),
            AppDialogAction(
              label: 'Save',
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(true),
            ),
          ],
        );
      },
      child: const Text('Show Full Screen Dialog'),
    ),
  );
}

@widgetbook.UseCase(name: 'With Icon', type: AppDialog)
Widget appDialogWithIcon(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: 'Warning',
          icon: const Icon(Icons.warning_amber_outlined),
          content:
              'This action will permanently delete all your data. Please make sure you have backed up your information.',
          actions: [
            AppDialogAction(
              label: 'Cancel',
              isSecondary: true,
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(false),
            ),
            AppDialogAction(
              label: 'I Understand',
              isDestructive: true,
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop(true),
            ),
          ],
        );
      },
      child: const Text('Show Warning Dialog'),
    ),
  );
}

@widgetbook.UseCase(name: 'Multi Action', type: AppDialog)
Widget appDialogMultiAction(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show<String>(
          context: context,
          title: 'Unsaved Changes',
          icon: const Icon(Icons.edit_note),
          content:
              'You have unsaved changes. What would you like to do with them?',
          actions: [
            AppDialogAction(
              label: 'Discard',
              isDestructive: true,
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop('discard'),
            ),
            AppDialogAction(
              label: 'Cancel',
              isSecondary: true,
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop('cancel'),
            ),
            AppDialogAction(
              label: 'Save',
              onPressed: () =>
                  Navigator.of(context, rootNavigator: true).pop('save'),
            ),
          ],
        );
      },
      child: const Text('Show Multi-Action Dialog'),
    ),
  );
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.features,
    required this.isSelected,
  });

  final String title;
  final String price;
  final List<String> features;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: isSelected
            ? colorScheme.primaryContainer.withValues(alpha: 0.1)
            : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: colorScheme.primary, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...features.map(
            (feature) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    feature,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
