// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// Filled Button Stories

@widgetbook.UseCase(name: 'Default', type: AppButton)
Widget filledButtonDefault(BuildContext context) {
  return AppButton.filled(label: 'Continue', onPressed: () {});
}

@widgetbook.UseCase(name: 'With Icon', type: AppButton)
Widget filledButtonWithIcon(BuildContext context) {
  return AppButton.filled(
    label: 'Add to Cart',
    icon: Icons.shopping_cart,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Loading State', type: AppButton)
Widget filledButtonLoading(BuildContext context) {
  return AppButton.filled(
    label: 'Processing',
    onPressed: () {},
    isLoading: true,
  );
}

@widgetbook.UseCase(name: 'Disabled', type: AppButton)
Widget filledButtonDisabled(BuildContext context) {
  return const AppButton.filled(label: 'Submit', onPressed: null);
}

@widgetbook.UseCase(name: 'Full Width', type: AppButton)
Widget filledButtonFullWidth(BuildContext context) {
  return AppButton.filled(
    label: 'Sign In',
    icon: Icons.login,
    fullWidth: true,
    onPressed: () {},
  );
}

// Outlined Button Stories

@widgetbook.UseCase(name: 'Outlined Default', type: AppButton)
Widget outlinedButtonDefault(BuildContext context) {
  return AppButton.outlined(label: 'Cancel', onPressed: () {});
}

@widgetbook.UseCase(name: 'Outlined With Icon', type: AppButton)
Widget outlinedButtonWithIcon(BuildContext context) {
  return AppButton.outlined(
    label: 'Download',
    icon: Icons.download,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Outlined Loading', type: AppButton)
Widget outlinedButtonLoading(BuildContext context) {
  return AppButton.outlined(label: 'Saving', isLoading: true, onPressed: () {});
}

@widgetbook.UseCase(name: 'Outlined Disabled', type: AppButton)
Widget outlinedButtonDisabled(BuildContext context) {
  return const AppButton.outlined(label: 'Edit', onPressed: null);
}

@widgetbook.UseCase(name: 'Outlined Full Width', type: AppButton)
Widget outlinedButtonFullWidth(BuildContext context) {
  return AppButton.outlined(
    label: 'Register',
    fullWidth: true,
    onPressed: () {},
  );
}

// Text Button Stories

@widgetbook.UseCase(name: 'Text Default', type: AppButton)
Widget textButtonDefault(BuildContext context) {
  return AppButton.text(label: 'Skip', onPressed: () {});
}

@widgetbook.UseCase(name: 'Text With Icon', type: AppButton)
Widget textButtonWithIcon(BuildContext context) {
  return AppButton.text(
    label: 'Learn More',
    icon: Icons.arrow_forward,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Text Loading', type: AppButton)
Widget textButtonLoading(BuildContext context) {
  return AppButton.text(label: 'Loading', isLoading: true, onPressed: () {});
}

@widgetbook.UseCase(name: 'Text Disabled', type: AppButton)
Widget textButtonDisabled(BuildContext context) {
  return const AppButton.text(label: 'Forgot Password', onPressed: null);
}

// Elevated Button Stories

@widgetbook.UseCase(name: 'Elevated Default', type: AppButton)
Widget elevatedButtonDefault(BuildContext context) {
  return AppButton.elevated(label: 'Get Started', onPressed: () {});
}

@widgetbook.UseCase(name: 'Elevated With Icon', type: AppButton)
Widget elevatedButtonWithIcon(BuildContext context) {
  return AppButton.elevated(
    label: 'Upload File',
    icon: Icons.upload,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Elevated Loading', type: AppButton)
Widget elevatedButtonLoading(BuildContext context) {
  return AppButton.elevated(
    label: 'Uploading',
    isLoading: true,
    onPressed: () {},
  );
}

@widgetbook.UseCase(name: 'Elevated Disabled', type: AppButton)
Widget elevatedButtonDisabled(BuildContext context) {
  return const AppButton.elevated(label: 'Confirm', onPressed: null);
}

@widgetbook.UseCase(name: 'Elevated Full Width', type: AppButton)
Widget elevatedButtonFullWidth(BuildContext context) {
  return AppButton.elevated(
    label: 'Create Account',
    icon: Icons.person_add,
    fullWidth: true,
    onPressed: () {},
  );
}

// Real-world Use Cases

@widgetbook.UseCase(name: 'Login Form Submit', type: AppButton)
Widget loginFormSubmit(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
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
  );
}

@widgetbook.UseCase(name: 'Dialog Actions', type: AppButton)
Widget dialogActions(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      AppButton.text(label: 'Cancel', onPressed: () {}),
      const SizedBox(width: 8),
      AppButton.filled(label: 'Delete', onPressed: () {}),
    ],
  );
}

@widgetbook.UseCase(name: 'E-commerce Add to Cart', type: AppButton)
Widget ecommerceAddToCart(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
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
  );
}

@widgetbook.UseCase(name: 'Loading Processing Payment', type: AppButton)
Widget loadingProcessingPayment(BuildContext context) {
  return AppButton.filled(
    label: 'Processing Payment',
    fullWidth: true,
    isLoading: true,
    onPressed: () {},
  );
}

// Comprehensive Interactive Stories

@widgetbook.UseCase(name: 'All Variants Comparison', type: AppButton)
Widget allVariantsComparison(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'All Button Variants',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      const Text('Filled (High Emphasis)'),
      const SizedBox(height: 8),
      AppButton.filled(label: 'Continue', onPressed: () {}),
      const SizedBox(height: 16),
      const Text('Outlined (Medium Emphasis)'),
      const SizedBox(height: 8),
      AppButton.outlined(label: 'Continue', onPressed: () {}),
      const SizedBox(height: 16),
      const Text('Text (Low Emphasis)'),
      const SizedBox(height: 8),
      AppButton.text(label: 'Continue', onPressed: () {}),
      const SizedBox(height: 16),
      const Text('Elevated (Special Emphasis)'),
      const SizedBox(height: 8),
      AppButton.elevated(label: 'Continue', onPressed: () {}),
    ],
  );
}

@widgetbook.UseCase(name: 'All Variants with Icons', type: AppButton)
Widget allVariantsWithIcons(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppButton.filled(
        label: 'Add to Cart',
        icon: Icons.shopping_cart,
        onPressed: () {},
      ),
      const SizedBox(height: 12),
      AppButton.outlined(
        label: 'Add to Cart',
        icon: Icons.shopping_cart,
        onPressed: () {},
      ),
      const SizedBox(height: 12),
      AppButton.text(
        label: 'Add to Cart',
        icon: Icons.shopping_cart,
        onPressed: () {},
      ),
      const SizedBox(height: 12),
      AppButton.elevated(
        label: 'Add to Cart',
        icon: Icons.shopping_cart,
        onPressed: () {},
      ),
    ],
  );
}

@widgetbook.UseCase(name: 'States Comparison', type: AppButton)
Widget statesComparison(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Enabled State'),
      const SizedBox(height: 8),
      AppButton.filled(label: 'Enabled', onPressed: () {}),
      const SizedBox(height: 16),
      const Text('Disabled State'),
      const SizedBox(height: 8),
      const AppButton.filled(label: 'Disabled', onPressed: null),
      const SizedBox(height: 16),
      const Text('Loading State'),
      const SizedBox(height: 8),
      AppButton.filled(label: 'Loading', isLoading: true, onPressed: () {}),
    ],
  );
}

@widgetbook.UseCase(name: 'Long Text Handling', type: AppButton)
Widget longTextHandling(BuildContext context) {
  return SizedBox(
    width: 300,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Normal Width Container (300px)'),
        const SizedBox(height: 8),
        AppButton.filled(
          label: 'This is a very long button label that might wrap or overflow',
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        AppButton.outlined(
          label: 'Another extremely long label to test text overflow behavior',
          icon: Icons.info,
          onPressed: () {},
        ),
        const SizedBox(height: 16),
        AppButton.filled(
          label: 'Very long text with full width enabled to see how it behaves',
          fullWidth: true,
          onPressed: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(name: 'Interactive Playground', type: AppButton)
Widget interactivePlayground(BuildContext context) {
  final label = context.knobs.string(
    label: 'Button Label',
    initialValue: 'Click Me',
  );

  final variantIndex = context.knobs.list(
    label: 'Variant',
    options: ['Filled', 'Outlined', 'Text', 'Elevated'],
    labelBuilder: (value) => value,
  );

  final iconOptions = [
    'None',
    'Check',
    'Add',
    'Remove',
    'ShoppingCart',
    'Download',
    'Upload',
    'Login',
    'Logout',
  ];

  final selectedIcon = context.knobs.list(
    label: 'Icon',
    options: iconOptions,
    labelBuilder: (value) => value,
  );

  IconData? icon;
  switch (selectedIcon) {
    case 'Check':
      icon = Icons.check;
    case 'Add':
      icon = Icons.add;
    case 'Remove':
      icon = Icons.remove;
    case 'ShoppingCart':
      icon = Icons.shopping_cart;
    case 'Download':
      icon = Icons.download;
    case 'Upload':
      icon = Icons.upload;
    case 'Login':
      icon = Icons.login;
    case 'Logout':
      icon = Icons.logout;
    default:
      icon = null;
  }

  final fullWidth = context.knobs.boolean(
    label: 'Full Width',
    initialValue: false,
  );

  final isLoading = context.knobs.boolean(
    label: 'Loading State',
    initialValue: false,
  );

  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  final VoidCallback? onPressed = enabled ? () {} : null;

  switch (variantIndex) {
    case 'Outlined':
      return AppButton.outlined(
        label: label,
        icon: icon,
        fullWidth: fullWidth,
        isLoading: isLoading,
        onPressed: onPressed,
      );
    case 'Text':
      return AppButton.text(
        label: label,
        icon: icon,
        fullWidth: fullWidth,
        isLoading: isLoading,
        onPressed: onPressed,
      );
    case 'Elevated':
      return AppButton.elevated(
        label: label,
        icon: icon,
        fullWidth: fullWidth,
        isLoading: isLoading,
        onPressed: onPressed,
      );
    default:
      return AppButton.filled(
        label: label,
        icon: icon,
        fullWidth: fullWidth,
        isLoading: isLoading,
        onPressed: onPressed,
      );
  }
}
