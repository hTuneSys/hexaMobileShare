// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A customizable Material Design 3 button widget.
/// Supports multiple variants: filled, outlined, text, and elevated.
class AppButton extends StatelessWidget {
  /// The button's label text
  final String label;

  /// Callback when the button is pressed
  final VoidCallback? onPressed;

  /// Optional leading icon
  final IconData? icon;

  /// Button variant style
  final AppButtonVariant variant;

  /// Whether the button should take full width
  final bool fullWidth;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Creates an AppButton
  const AppButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.filled,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  });

  /// Creates a filled button (default)
  const AppButton.filled({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.filled;

  /// Creates an outlined button
  const AppButton.outlined({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.outlined;

  /// Creates a text button
  const AppButton.text({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.text;

  /// Creates an elevated button
  const AppButton.elevated({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.elevated;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : _buildButtonContent();

    final button = switch (variant) {
      AppButtonVariant.filled =>
        icon != null
            ? FilledButton.icon(
                onPressed: isLoading ? null : onPressed,
                icon: Icon(icon),
                label: Text(label),
              )
            : FilledButton(
                onPressed: isLoading ? null : onPressed,
                child: child,
              ),
      AppButtonVariant.outlined =>
        icon != null
            ? OutlinedButton.icon(
                onPressed: isLoading ? null : onPressed,
                icon: Icon(icon),
                label: Text(label),
              )
            : OutlinedButton(
                onPressed: isLoading ? null : onPressed,
                child: child,
              ),
      AppButtonVariant.text =>
        icon != null
            ? TextButton.icon(
                onPressed: isLoading ? null : onPressed,
                icon: Icon(icon),
                label: Text(label),
              )
            : TextButton(onPressed: isLoading ? null : onPressed, child: child),
      AppButtonVariant.elevated =>
        icon != null
            ? ElevatedButton.icon(
                onPressed: isLoading ? null : onPressed,
                icon: Icon(icon),
                label: Text(label),
              )
            : ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                child: child,
              ),
    };

    if (fullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  Widget _buildButtonContent() {
    if (icon != null) {
      return Text(label);
    }
    return Text(label);
  }
}

/// Button variant styles
enum AppButtonVariant {
  /// Filled button with background color
  filled,

  /// Outlined button with border
  outlined,

  /// Text-only button without background
  text,

  /// Elevated button with shadow
  elevated,
}
