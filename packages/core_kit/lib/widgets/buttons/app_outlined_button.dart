// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:core_kit/widgets/buttons/app_button.dart';

/// A convenience wrapper that delegates to AppButton.outlined().
/// Use for secondary actions requiring an outlined style.
class AppOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool fullWidth;
  final bool isLoading;

  const AppOutlinedButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton.outlined(
      label: label,
      onPressed: onPressed,
      icon: icon,
      fullWidth: fullWidth,
      isLoading: isLoading,
    );
  }
}
