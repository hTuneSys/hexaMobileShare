// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// 1. Default Text Button - Interactive playground
@widgetbook.UseCase(name: 'Default', type: AppTextButton)
Widget appTextButtonDefault(BuildContext context) {
  return Center(
    child: AppTextButton(label: 'Text Button', onPressed: () {}),
  );
}

// 2. With Icon - Icon + text combinations
@widgetbook.UseCase(name: 'With Icon', type: AppTextButton)
Widget appTextButtonWithIcon(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Text buttons with various icons',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        AppTextButton(label: 'Add Item', icon: Icons.add, onPressed: () {}),
        const SizedBox(height: 8),
        AppTextButton(
          label: 'Learn More',
          icon: Icons.arrow_forward,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        AppTextButton(
          label: 'Show Details',
          icon: Icons.info_outline,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        AppTextButton(
          label: 'See All',
          icon: Icons.arrow_forward_ios,
          onPressed: () {},
        ),
      ],
    ),
  );
}

// 3. States - All button states
@widgetbook.UseCase(name: 'States', type: AppTextButton)
Widget appTextButtonStates(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enabled', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppTextButton(label: 'Enabled', onPressed: () {}),
        const SizedBox(height: 16),
        const Text('Disabled', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const AppTextButton(label: 'Disabled', onPressed: null),
        const SizedBox(height: 16),
        const Text('Loading', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppTextButton(label: 'Processing', isLoading: true, onPressed: () {}),
        const SizedBox(height: 16),
        const Text(
          'Hover (Desktop)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'Hover over the button to see the subtle highlight effect',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 8),
        AppTextButton(label: 'Hover Me', onPressed: () {}),
      ],
    ),
  );
}

// 4. Inline Usage - Within text paragraphs
@widgetbook.UseCase(name: 'Inline Usage', type: AppTextButton)
Widget appTextButtonInlineUsage(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Text buttons work well inline within paragraphs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 16),
            children: [
              const TextSpan(
                text: 'By continuing, you agree to our terms and conditions. ',
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: AppTextButton(label: 'Learn more', onPressed: () {}),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 16),
            children: [
              const TextSpan(text: 'Your order has been confirmed. '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: AppTextButton(label: 'View details', onPressed: () {}),
              ),
              const TextSpan(text: ' or '),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: AppTextButton(label: 'track shipment', onPressed: () {}),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Minimal Visual Impact',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Notice how text buttons maintain minimal visual weight, '
          'blending seamlessly with surrounding text while remaining '
          'clearly interactive.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    ),
  );
}

// 5. Button Hierarchy - Visual comparison
@widgetbook.UseCase(name: 'Button Hierarchy', type: AppTextButton)
Widget appTextButtonHierarchy(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Visual Weight Comparison',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Notice the decreasing visual emphasis from filled to text',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 24),
        const Text(
          'High Emphasis (Primary Actions)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AppButton.filled(label: 'Filled Button', onPressed: () {}),
        const SizedBox(height: 24),
        const Text(
          'Medium Emphasis (Secondary Actions)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AppButton.outlined(label: 'Outlined Button', onPressed: () {}),
        const SizedBox(height: 24),
        const Text(
          'Low Emphasis (Tertiary Actions)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AppTextButton(label: 'Text Button', onPressed: () {}),
        const Divider(height: 48),
        const Text(
          'Common Pattern: Dialog Actions',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppTextButton(label: 'Cancel', onPressed: () {}),
            const SizedBox(width: 8),
            AppButton.filled(label: 'Confirm', onPressed: () {}),
          ],
        ),
      ],
    ),
  );
}

// 6. Theme Variations - Light and dark modes
@widgetbook.UseCase(name: 'Theme Variations', type: AppTextButton)
Widget appTextButtonThemeVariations(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Toggle theme in Widgetbook settings (top toolbar) to see variations',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 24),
        const Text('Enabled', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppTextButton(label: 'Text Button', onPressed: () {}),
        const SizedBox(height: 16),
        const Text('Disabled', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const AppTextButton(label: 'Disabled', onPressed: null),
        const SizedBox(height: 16),
        const Text('With Icon', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppTextButton(
          label: 'Learn More',
          icon: Icons.arrow_forward,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        const Text('Loading', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppTextButton(label: 'Processing', isLoading: true, onPressed: () {}),
        const Divider(height: 32),
        const Text(
          'Color Contrast',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Text buttons use the primary color in light mode and adjust '
          'automatically for dark mode. Disabled buttons use onSurface '
          'color at 38% opacity.',
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}

// 7. Common Use Cases - Real-world examples
@widgetbook.UseCase(name: 'Common Use Cases', type: AppTextButton)
Widget appTextButtonUseCases(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '1. Dialog Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Delete this item?'),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppTextButton(label: 'Cancel', onPressed: () {}),
                    const SizedBox(width: 8),
                    AppTextButton(label: 'Not now', onPressed: () {}),
                    const SizedBox(width: 8),
                    AppButton.filled(label: 'Delete', onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '2. Navigation Links',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Popular Items'),
                const SizedBox(height: 8),
                const Text('Item 1'),
                const Text('Item 2'),
                const Text('Item 3'),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppTextButton(
                    label: 'See all',
                    icon: Icons.arrow_forward,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '3. Inline Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Shipping Address'),
                    AppTextButton(label: 'Change', onPressed: () {}),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('123 Main St, City, State 12345'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '4. Toolbar/Menu Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Document.pdf'),
                Row(
                  children: [
                    AppTextButton(label: 'Share', onPressed: () {}),
                    AppTextButton(label: 'Download', onPressed: () {}),
                    AppTextButton(label: 'Delete', onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '5. Skip Actions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Enable Notifications?'),
                const SizedBox(height: 8),
                const Text(
                  'Get notified about important updates',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 16),
                AppButton.filled(label: 'Enable', onPressed: () {}),
                const SizedBox(height: 8),
                Center(
                  child: AppTextButton(label: 'Skip for now', onPressed: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
