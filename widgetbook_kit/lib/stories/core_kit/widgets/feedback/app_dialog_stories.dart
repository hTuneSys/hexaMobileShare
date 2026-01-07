// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Interactive Playground - All features combined with full knob control
@widgetbook.UseCase(name: 'Interactive Playground', type: AppDialog)
Widget interactivePlayground(BuildContext context) {
  final title = context.knobs.object.dropdown(
    label: 'Title',
    options: [
      'Dialog Title',
      'Confirm Action',
      'Warning',
      'Success',
      'Error',
      'Information',
    ],
    initialOption: 'Dialog Title',
  );

  final hasIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: false,
  );

  final iconType = context.knobs.object.dropdown(
    label: 'Icon Type',
    options: ['Info', 'Warning', 'Error', 'Success'],
    initialOption: 'Info',
  );

  final contentType = context.knobs.object.dropdown(
    label: 'Content Type',
    options: ['Text', 'Long Text', 'Custom'],
    initialOption: 'Text',
  );

  final textContent = context.knobs.object.dropdown(
    label: 'Content Text',
    options: [
      'This is the dialog content.',
      'Are you sure you want to continue?',
      'This action cannot be undone.',
      'Your changes have been saved successfully.',
      'An error occurred. Please try again.',
    ],
    initialOption: 'This is the dialog content.',
  );

  final actionCount = context.knobs.object.dropdown(
    label: 'Number of Actions',
    options: ['1', '2', '3'],
    initialOption: '2',
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

  final showBarrier = context.knobs.boolean(
    label: 'Custom Barrier Color',
    initialValue: false,
  );

  Widget? icon;
  if (hasIcon) {
    icon = Icon(
      iconType == 'Info'
          ? Icons.info_outline
          : iconType == 'Warning'
          ? Icons.warning_amber_outlined
          : iconType == 'Error'
          ? Icons.error_outline
          : Icons.check_circle_outline,
    );
  }

  String? content;
  Widget Function(BuildContext)? contentBuilder;

  if (contentType == 'Long Text') {
    content = '''$textContent

This is a longer text that demonstrates scrolling behavior in the dialog. When content exceeds the maximum height, it becomes scrollable automatically.

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''';
  } else if (contentType == 'Custom') {
    contentBuilder = (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(textContent),
        const SizedBox(height: 16),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Enter your name',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  } else {
    content = textContent;
  }

  final numActions = int.parse(actionCount);
  final actions = <AppDialogAction>[];

  if (numActions >= 1) {
    actions.add(
      AppDialogAction(
        label: 'Cancel',
        isSecondary: true,
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
        },
      ),
    );
  }
  if (numActions >= 2) {
    actions.add(
      AppDialogAction(
        label: 'Confirm',
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop(true);
        },
      ),
    );
  }
  if (numActions >= 3) {
    actions.add(
      AppDialogAction(
        label: 'Delete',
        isDestructive: true,
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop(true);
        },
      ),
    );
  }

  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: title,
          icon: icon,
          content: content,
          contentBuilder: contentBuilder,
          actions: actions,
          isDismissible: isDismissible,
          isFullScreen: isFullScreen,
          scrollable: scrollable,
          barrierColor: showBarrier ? Colors.blue.withValues(alpha: 0.3) : null,
        );
      },
      child: const Text('Show Dialog'),
    ),
  );
}

/// Basic alert dialog with title, message, and OK button
@widgetbook.UseCase(name: 'Basic Alert', type: AppDialog)
Widget basicAlert(BuildContext context) {
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
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
      child: const Text('Show Basic Alert'),
    ),
  );
}

/// Confirmation dialog with Cancel and Confirm actions
@widgetbook.UseCase(name: 'Confirmation Dialog', type: AppDialog)
Widget confirmationDialog(BuildContext context) {
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
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(false);
              },
            ),
            AppDialogAction(
              label: 'Delete',
              isDestructive: true,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
            ),
          ],
        );
      },
      child: const Text('Show Confirmation Dialog'),
    ),
  );
}

/// Dialog with scrollable long content
@widgetbook.UseCase(name: 'Scrolling Content', type: AppDialog)
Widget scrollingContent(BuildContext context) {
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
The materials on our application are provided on an 'as is' basis. We make no warranties, expressed or implied, and hereby disclaim and negate all other warranties including, without limitation, implied warranties or conditions of merchantability, fitness for a particular purpose, or non-infringement of intellectual property or other violation of rights.

4. Limitations
In no event shall our company or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on our application.

5. Accuracy of Materials
The materials appearing on our application could include technical, typographical, or photographic errors. We do not warrant that any of the materials on its website are accurate, complete or current.

6. Links
We have not reviewed all of the sites linked to our application and are not responsible for the contents of any such linked site.

7. Modifications
We may revise these terms of service for its application at any time without notice. By using this application you are agreeing to be bound by the then current version of these terms of service.

8. Governing Law
These terms and conditions are governed by and construed in accordance with the laws and you irrevocably submit to the exclusive jurisdiction of the courts in that location.
''',
          actions: [
            AppDialogAction(
              label: 'Decline',
              isSecondary: true,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(false);
              },
            ),
            AppDialogAction(
              label: 'Accept',
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
            ),
          ],
          scrollable: true,
        );
      },
      child: const Text('Show Terms of Service'),
    ),
  );
}

/// Dialog with form inputs
@widgetbook.UseCase(name: 'Form Dialog', type: AppDialog)
Widget formDialog(BuildContext context) {
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
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            AppDialogAction(
              label: 'Add',
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
            ),
          ],
          scrollable: true,
        );
      },
      child: const Text('Show Form Dialog'),
    ),
  );
}

/// Dialog with custom content layout
@widgetbook.UseCase(name: 'Custom Content', type: AppDialog)
Widget customContent(BuildContext context) {
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
              const SizedBox(height: 16),
              _PlanCard(
                title: 'Enterprise',
                price: 'Custom',
                features: [
                  'Everything in Pro',
                  'Custom Storage',
                  'Dedicated Support',
                ],
                isSelected: false,
              ),
            ],
          ),
          actions: [
            AppDialogAction(
              label: 'Cancel',
              isSecondary: true,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            AppDialogAction(
              label: 'Continue',
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
            ),
          ],
          scrollable: true,
        );
      },
      child: const Text('Show Plan Selection'),
    ),
  );
}

/// Full-screen dialog variant for mobile devices
@widgetbook.UseCase(name: 'Full Screen', type: AppDialog)
Widget fullScreen(BuildContext context) {
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
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                  items: ['United States', 'United Kingdom', 'Canada', 'Other']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: [
            AppDialogAction(
              label: 'Cancel',
              isSecondary: true,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            AppDialogAction(
              label: 'Save',
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
            ),
          ],
        );
      },
      child: const Text('Show Full Screen Dialog'),
    ),
  );
}

/// Dialog with icon/illustration
@widgetbook.UseCase(name: 'With Icon', type: AppDialog)
Widget withIcon(BuildContext context) {
  return Center(
    child: ElevatedButton(
      onPressed: () {
        AppDialog.show(
          context: context,
          title: 'Warning',
          icon: const Icon(Icons.warning_amber_outlined),
          content:
              'This action will permanently delete all your data. Please make sure you have backed up your information before proceeding.',
          actions: [
            AppDialogAction(
              label: 'Cancel',
              isSecondary: true,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(false);
              },
            ),
            AppDialogAction(
              label: 'I Understand',
              isDestructive: true,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop(true);
              },
            ),
          ],
        );
      },
      child: const Text('Show Warning Dialog'),
    ),
  );
}

/// Dialog with three action buttons
@widgetbook.UseCase(name: 'Multi Action', type: AppDialog)
Widget multiAction(BuildContext context) {
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
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('discard');
              },
            ),
            AppDialogAction(
              label: 'Cancel',
              isSecondary: true,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('cancel');
              },
            ),
            AppDialogAction(
              label: 'Save',
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('save');
              },
            ),
          ],
        );
      },
      child: const Text('Show Multi-Action Dialog'),
    ),
  );
}

/// Helper widget for plan card in custom content example
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
