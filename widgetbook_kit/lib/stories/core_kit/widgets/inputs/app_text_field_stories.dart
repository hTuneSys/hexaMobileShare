// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Widgetbook stories for [AppTextField] component.
///
/// Demonstrates various configurations and use cases for the Material Design 3
/// text field component, including basic fields, validation states, specialized
/// input types, and interactive features.

@widgetbook.UseCase(name: 'Basic', type: AppTextField)
Widget buildAppTextFieldBasicUseCase(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            label: 'Full Name',
            hint: 'Enter your full name',
            helperText: 'Your first and last name',
            onChanged: (value) => debugPrint('Name: $value'),
          ),
          const SizedBox(height: 24),
          AppTextField(
            label: 'Bio',
            hint: 'Tell us about yourself',
            helperText: 'Optional',
            textCapitalization: TextCapitalization.sentences,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Validation Error', type: AppTextField)
Widget buildAppTextFieldErrorUseCase(BuildContext context) {
  final emailController = TextEditingController(text: 'invalid-email');
  final passwordController = TextEditingController(text: '123');

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            controller: emailController,
            label: 'Email',
            hint: 'example@email.com',
            errorText: 'Please enter a valid email address',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          AppTextField(
            controller: passwordController,
            label: 'Password',
            hint: 'Enter password',
            errorText: 'Password must be at least 8 characters',
            obscureText: true,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Multiline (Text Area)', type: AppTextField)
Widget buildAppTextFieldMultilineUseCase(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField.multiline(
            label: 'Description',
            hint: 'Enter a detailed description...',
            helperText: 'Maximum 500 characters',
            maxLength: 500,
            maxLines: 5,
            minLines: 3,
          ),
          const SizedBox(height: 24),
          AppTextField.multiline(
            label: 'Comments',
            hint: 'Share your thoughts',
            maxLines: 8,
            minLines: 4,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Icons', type: AppTextField)
Widget buildAppTextFieldWithIconsUseCase(BuildContext context) {
  final searchController = TextEditingController();
  final passwordController = TextEditingController();

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            controller: searchController,
            label: 'Search',
            hint: 'Search for items...',
            prefixIcon: Icons.search,
            suffixIcon: Icons.clear,
            onSuffixIconTap: () {
              searchController.clear();
              debugPrint('Search cleared');
            },
          ),
          const SizedBox(height: 24),
          AppTextField(
            controller: passwordController,
            label: 'Password',
            hint: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            suffixIcon: Icons.visibility_off,
            obscureText: true,
            onSuffixIconTap: () {
              debugPrint('Toggle password visibility');
            },
          ),
          const SizedBox(height: 24),
          AppTextField(
            label: 'Email',
            hint: 'your.email@example.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'States (Disabled & Read-only)', type: AppTextField)
Widget buildAppTextFieldStatesUseCase(BuildContext context) {
  final disabledController = TextEditingController(text: 'Disabled content');
  final readOnlyController = TextEditingController(
    text: 'Read-only content that can be selected',
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppTextField(
            label: 'Enabled Field',
            hint: 'You can type here',
            helperText: 'This field is enabled',
          ),
          const SizedBox(height: 24),
          AppTextField(
            controller: disabledController,
            label: 'Disabled Field',
            hint: 'Cannot type here',
            helperText: 'This field is disabled',
            enabled: false,
          ),
          const SizedBox(height: 24),
          AppTextField(
            controller: readOnlyController,
            label: 'Read-only Field',
            hint: 'Can select but not edit',
            helperText: 'This field is read-only',
            readOnly: true,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Numeric Input with Formatter', type: AppTextField)
Widget buildAppTextFieldNumericUseCase(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField.numeric(
            label: 'Age',
            hint: 'Enter your age',
            maxLength: 3,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 24),
          AppTextField.phone(
            label: 'Phone Number',
            hint: '(123) 456-7890',
            prefixIcon: Icons.phone_outlined,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
              _PhoneNumberFormatter(),
            ],
          ),
          const SizedBox(height: 24),
          AppTextField.numeric(
            label: 'Quantity',
            hint: '0',
            prefixIcon: Icons.shopping_cart_outlined,
            helperText: 'Enter quantity to purchase',
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Email & URL Input', type: AppTextField)
Widget buildAppTextFieldEmailUrlUseCase(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField.email(
            label: 'Email Address',
            hint: 'your.email@example.com',
            prefixIcon: Icons.email_outlined,
            helperText: 'We will never share your email',
          ),
          const SizedBox(height: 24),
          AppTextField.url(
            label: 'Website',
            hint: 'https://example.com',
            prefixIcon: Icons.link,
            helperText: 'Enter your website URL',
          ),
          const SizedBox(height: 24),
          AppTextField.email(
            label: 'Confirm Email',
            hint: 'Re-enter your email',
            prefixIcon: Icons.email_outlined,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Search Field Variant', type: AppTextField)
Widget buildAppTextFieldSearchUseCase(BuildContext context) {
  final searchController = TextEditingController();

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTextField(
            controller: searchController,
            hint: 'Search products...',
            prefixIcon: Icons.search,
            suffixIcon: Icons.clear,
            onSuffixIconTap: () {
              searchController.clear();
            },
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              debugPrint('Search submitted: $value');
            },
          ),
          const SizedBox(height: 24),
          AppTextField(
            hint: 'Search locations...',
            prefixIcon: Icons.location_on_outlined,
            suffixIcon: Icons.my_location,
            textInputAction: TextInputAction.search,
            onSuffixIconTap: () {
              debugPrint('Use current location');
            },
          ),
          const SizedBox(height: 24),
          AppTextField(
            hint: 'Search users...',
            prefixIcon: Icons.person_search,
            textInputAction: TextInputAction.search,
          ),
        ],
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Character Counter & Max Length', type: AppTextField)
Widget buildAppTextFieldCharacterCounterUseCase(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppTextField(
            label: 'Username',
            hint: 'Choose a username',
            helperText: 'Must be between 3-20 characters',
            maxLength: 20,
          ),
          const SizedBox(height: 24),
          AppTextField.multiline(
            label: 'Tweet',
            hint: 'What\'s happening?',
            maxLength: 280,
            maxLines: 4,
            minLines: 2,
          ),
          const SizedBox(height: 24),
          const AppTextField(
            label: 'Bio',
            hint: 'Tell us about yourself',
            maxLength: 150,
            showCharacterCounter: true,
          ),
        ],
      ),
    ),
  );
}

/// Custom phone number formatter
class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    if (text.isEmpty) {
      return newValue;
    }

    final buffer = StringBuffer();
    for (int i = 0; i < text.length && i < 10; i++) {
      if (i == 0) {
        buffer.write('(');
      }
      buffer.write(text[i]);
      if (i == 2) {
        buffer.write(') ');
      } else if (i == 5) {
        buffer.write('-');
      }
    }

    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
