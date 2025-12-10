// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// 1. Interactive Playground - All Variants with Different States
@widgetbook.UseCase(name: 'Interactive Playground', type: AppButton)
Widget appButtonPlayground(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Filled Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppButton.filled(label: 'Default', onPressed: () {}),
          const SizedBox(height: 8),
          AppButton.filled(
            label: 'With Icon',
            icon: Icons.add,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          const AppButton.filled(label: 'Disabled', onPressed: null),
          const SizedBox(height: 8),
          AppButton.filled(label: 'Loading', isLoading: true, onPressed: () {}),
          const SizedBox(height: 8),
          AppButton.filled(
            label: 'Full Width',
            fullWidth: true,
            onPressed: () {},
          ),
          const Divider(height: 32),
          const Text(
            'Outlined Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppButton.outlined(label: 'Default', onPressed: () {}),
          const SizedBox(height: 8),
          AppButton.outlined(
            label: 'With Icon',
            icon: Icons.download,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          const AppButton.outlined(label: 'Disabled', onPressed: null),
          const SizedBox(height: 8),
          AppButton.outlined(
            label: 'Loading',
            isLoading: true,
            onPressed: () {},
          ),
          const Divider(height: 32),
          const Text(
            'Text Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppButton.text(label: 'Default', onPressed: () {}),
          const SizedBox(height: 8),
          AppButton.text(
            label: 'With Icon',
            icon: Icons.arrow_forward,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          const AppButton.text(label: 'Disabled', onPressed: null),
          const SizedBox(height: 8),
          AppButton.text(label: 'Loading', isLoading: true, onPressed: () {}),
          const Divider(height: 32),
          const Text(
            'Elevated Variants',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppButton.elevated(label: 'Default', onPressed: () {}),
          const SizedBox(height: 8),
          AppButton.elevated(
            label: 'With Icon',
            icon: Icons.upload,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          const AppButton.elevated(label: 'Disabled', onPressed: null),
          const SizedBox(height: 8),
          AppButton.elevated(
            label: 'Loading',
            isLoading: true,
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}

// 2. All Variants Side-by-Side
@widgetbook.UseCase(name: 'All Variants', type: AppButton)
Widget appButtonAllVariants(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Filled', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppButton.filled(label: 'Filled Button', onPressed: () {}),
        const SizedBox(height: 16),
        const Text('Outlined', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppButton.outlined(label: 'Outlined Button', onPressed: () {}),
        const SizedBox(height: 16),
        const Text('Text', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppButton.text(label: 'Text Button', onPressed: () {}),
        const SizedBox(height: 16),
        const Text('Elevated', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppButton.elevated(label: 'Elevated Button', onPressed: () {}),
      ],
    ),
  );
}

// 3. With Icons - Demonstrate icon combinations
@widgetbook.UseCase(name: 'With Icons', type: AppButton)
Widget appButtonWithIcons(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All button variants support icons',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        AppButton.filled(label: 'Add Item', icon: Icons.add, onPressed: () {}),
        const SizedBox(height: 8),
        AppButton.outlined(
          label: 'Download',
          icon: Icons.download,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        AppButton.text(
          label: 'Learn More',
          icon: Icons.arrow_forward,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        AppButton.elevated(
          label: 'Upload',
          icon: Icons.upload,
          onPressed: () {},
        ),
      ],
    ),
  );
}

// 4. States - Interactive state demonstration
@widgetbook.UseCase(name: 'States', type: AppButton)
Widget appButtonStates(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enabled', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppButton.filled(label: 'Enabled', onPressed: () {}),
        const SizedBox(height: 16),
        const Text('Disabled', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const AppButton.filled(label: 'Disabled', onPressed: null),
        const SizedBox(height: 16),
        const Text('Loading', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppButton.filled(
          label: 'Processing',
          isLoading: true,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        const Text(
          'Icon + Loading (Bug Fix Demo)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          'When both icon and loading are true, loading indicator should show instead of icon',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 8),
        AppButton.filled(
          label: 'Uploading',
          icon: Icons.cloud_upload,
          isLoading: true,
          onPressed: () {},
        ),
      ],
    ),
  );
}

// 5. Sizes - Layout variations
@widgetbook.UseCase(name: 'Sizes', type: AppButton)
Widget appButtonSizes(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Normal Width',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AppButton.filled(label: 'Normal', fullWidth: false, onPressed: () {}),
        const SizedBox(height: 16),
        const Text('Full Width', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        AppButton.filled(
          label: 'Full Width',
          fullWidth: true,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        const Text(
          'Full Width with Icon',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AppButton.filled(
          label: 'Sign In',
          icon: Icons.login,
          fullWidth: true,
          onPressed: () {},
        ),
      ],
    ),
  );
}

// 6. Theme Variations - Light & dark mode
@widgetbook.UseCase(name: 'Theme Variations', type: AppButton)
Widget appButtonThemeVariations(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Toggle theme in Widgetbook settings (top toolbar) to see light/dark mode variations',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        AppButton.filled(label: 'Filled', onPressed: () {}),
        const SizedBox(height: 8),
        AppButton.outlined(label: 'Outlined', onPressed: () {}),
        const SizedBox(height: 8),
        AppButton.text(label: 'Text', onPressed: () {}),
        const SizedBox(height: 8),
        AppButton.elevated(label: 'Elevated', onPressed: () {}),
      ],
    ),
  );
}

// 7. Edge Cases
@widgetbook.UseCase(name: 'Edge Cases', type: AppButton)
Widget appButtonEdgeCases(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Very Long Label',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 200,
          child: AppButton.filled(
            label: 'This is a very long button label that might wrap',
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Empty Label',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AppButton.filled(label: '', onPressed: () {}),
        const SizedBox(height: 16),
        const Text(
          'All Properties Combined',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        AppButton.filled(
          label: 'Complete',
          icon: Icons.check_circle,
          fullWidth: true,
          isLoading: false,
          onPressed: () {},
        ),
      ],
    ),
  );
}

// Real-world Examples

@widgetbook.UseCase(name: 'Login Form Example', type: AppButton)
Widget loginFormExample(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Typical login form layout',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        AppButton.filled(
          label: 'Sign In',
          icon: Icons.login,
          fullWidth: true,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        AppButton.text(
          label: 'Forgot Password?',
          fullWidth: true,
          onPressed: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Dialog Actions Example', type: AppButton)
Widget dialogActionsExample(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Typical dialog action buttons',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AppButton.text(label: 'Cancel', onPressed: () {}),
            const SizedBox(width: 8),
            AppButton.filled(label: 'Confirm', onPressed: () {}),
          ],
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'E-commerce Example', type: AppButton)
Widget ecommerceExample(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'E-commerce product actions',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        AppButton.filled(
          label: 'Add to Cart',
          icon: Icons.shopping_cart,
          fullWidth: true,
          onPressed: () {},
        ),
        const SizedBox(height: 8),
        AppButton.outlined(
          label: 'Add to Wishlist',
          icon: Icons.favorite_border,
          fullWidth: true,
          onPressed: () {},
        ),
      ],
    ),
  );
}
