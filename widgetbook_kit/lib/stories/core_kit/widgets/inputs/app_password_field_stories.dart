// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Basic password field with visibility toggle
@widgetbook.UseCase(name: 'Basic', type: AppPasswordField)
Widget basicPasswordField(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: AppPasswordField(label: 'Password', hint: 'Enter your password'),
  );
}

/// Password field with strength indicator
@widgetbook.UseCase(name: 'With Strength Indicator', type: AppPasswordField)
Widget passwordFieldWithStrength(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: AppPasswordField(
      label: 'Create Password',
      hint: 'Choose a strong password',
      showStrengthIndicator: true,
      helperText:
          'Use at least 8 characters with mixed case, numbers, and symbols',
    ),
  );
}

/// Password confirmation field pair with dynamic matching validation
@widgetbook.UseCase(name: 'Password Confirmation', type: AppPasswordField)
Widget passwordConfirmationFields(BuildContext context) {
  return const _PasswordConfirmationExample();
}

class _PasswordConfirmationExample extends StatefulWidget {
  const _PasswordConfirmationExample();

  @override
  State<_PasswordConfirmationExample> createState() =>
      _PasswordConfirmationExampleState();
}

class _PasswordConfirmationExampleState
    extends State<_PasswordConfirmationExample> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  String? _confirmError;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validateConfirmation);
    _confirmController.addListener(_validateConfirmation);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _validateConfirmation() {
    setState(() {
      if (_confirmController.text.isEmpty) {
        _confirmError = null;
      } else if (_passwordController.text != _confirmController.text) {
        _confirmError = 'Passwords do not match';
      } else {
        _confirmError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Confirmation',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          AppPasswordField(
            controller: _passwordController,
            label: 'New Password',
            hint: 'Enter new password',
            showStrengthIndicator: true,
            helperText: 'Choose a strong password',
          ),
          const SizedBox(height: 16),
          AppPasswordField(
            controller: _confirmController,
            label: 'Confirm Password',
            hint: 'Re-enter your password',
            errorText: _confirmError,
          ),
          if (_confirmError == null && _confirmController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 12.0),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Passwords match',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Password field with dynamic validation errors
@widgetbook.UseCase(name: 'With Validation Error', type: AppPasswordField)
Widget passwordFieldWithError(BuildContext context) {
  return const _ValidationErrorExample();
}

class _ValidationErrorExample extends StatefulWidget {
  const _ValidationErrorExample();

  @override
  State<_ValidationErrorExample> createState() =>
      _ValidationErrorExampleState();
}

class _ValidationErrorExampleState extends State<_ValidationErrorExample> {
  final _controller = TextEditingController();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validatePassword() {
    setState(() {
      final password = _controller.text;

      if (password.isEmpty) {
        _errorText = null;
      } else if (password.length < 8) {
        _errorText = 'Password must be at least 8 characters';
      } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
        _errorText = 'Password must contain at least one uppercase letter';
      } else if (!RegExp(r'[a-z]').hasMatch(password)) {
        _errorText = 'Password must contain at least one lowercase letter';
      } else if (!RegExp(r'[0-9]').hasMatch(password)) {
        _errorText = 'Password must contain at least one number';
      } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
        _errorText = 'Password must contain at least one special character';
      } else {
        _errorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dynamic Validation',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Type a password to see validation errors change dynamically',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          AppPasswordField(
            controller: _controller,
            label: 'Password',
            hint: 'Enter your password',
            errorText: _errorText,
            showStrengthIndicator: true,
          ),
          const SizedBox(height: 16),
          _buildValidationChecklist(context),
        ],
      ),
    );
  }

  Widget _buildValidationChecklist(BuildContext context) {
    final password = _controller.text;
    final hasMinLength = password.length >= 8;
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Requirements:',
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildCheckItem(context, 'At least 8 characters', hasMinLength),
          _buildCheckItem(context, 'One uppercase letter', hasUppercase),
          _buildCheckItem(context, 'One lowercase letter', hasLowercase),
          _buildCheckItem(context, 'One number', hasNumber),
          _buildCheckItem(context, 'One special character', hasSpecialChar),
        ],
      ),
    );
  }

  Widget _buildCheckItem(BuildContext context, String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.circle_outlined,
            size: 16,
            color: isValid
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isValid
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              decoration: isValid ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    );
  }
}

/// Disabled password field
@widgetbook.UseCase(name: 'Disabled', type: AppPasswordField)
Widget disabledPasswordField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppPasswordField(
      label: 'Password',
      hint: 'Enter your password',
      enabled: false,
      controller: TextEditingController(text: 'disabled_password'),
    ),
  );
}

/// Password field with copy prevention
@widgetbook.UseCase(name: 'With Copy Prevention', type: AppPasswordField)
Widget passwordFieldWithCopyPrevention(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppPasswordField(
          label: 'Secure Password',
          hint: 'Copy/paste disabled',
          preventCopyPaste: true,
          helperText: 'Copy and paste operations are disabled for security',
        ),
      ],
    ),
  );
}

/// Login form password field variant
@widgetbook.UseCase(name: 'Login Form Variant', type: AppPasswordField)
Widget loginFormPasswordField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Sign In', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 24),
        const AppTextField(
          label: 'Email',
          hint: 'your@email.com',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        const AppPasswordField(
          label: 'Password',
          hint: 'Enter your password',
          showLockIcon: true,
          textInputAction: TextInputAction.done,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: const Text('Forgot Password?'),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
          child: const Text('Sign In'),
        ),
      ],
    ),
  );
}

/// Registration form password field with requirements
@widgetbook.UseCase(name: 'Registration Form Variant', type: AppPasswordField)
Widget registrationFormPasswordField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Create Account',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        const AppTextField(
          label: 'Full Name',
          hint: 'John Doe',
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 16),
        const AppTextField(
          label: 'Email',
          hint: 'your@email.com',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        const AppPasswordField(
          label: 'Password',
          hint: 'Create a strong password',
          showStrengthIndicator: true,
          showLockIcon: true,
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Password Requirements:',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              _buildRequirement(context, 'At least 8 characters'),
              _buildRequirement(context, 'Mix of uppercase & lowercase'),
              _buildRequirement(context, 'At least one number'),
              _buildRequirement(context, 'At least one special character'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const AppPasswordField(
          label: 'Confirm Password',
          hint: 'Re-enter your password',
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
          child: const Text('Create Account'),
        ),
      ],
    ),
  );
}

Widget _buildRequirement(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 2.0),
    child: Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 16,
          color: Theme.of(context).colorScheme.outline,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    ),
  );
}
