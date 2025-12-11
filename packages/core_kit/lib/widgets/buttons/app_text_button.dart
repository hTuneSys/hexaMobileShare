// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';

/// A low-emphasis text button that displays text without a background or border.
///
/// [AppTextButton] is a convenient wrapper around [AppButton.text] that provides
/// a dedicated API for text-only buttons. Text buttons are the most subtle button
/// variant and should be used for tertiary actions, inline links, and less
/// important operations.
///
/// This component delegates all functionality to [AppButton.text], ensuring
/// consistent behavior while providing developers with an alternative,
/// component-specific naming convention.
///
/// ## When to Use AppTextButton
///
/// Text buttons have the lowest visual emphasis and are best suited for:
///
/// - **Tertiary Actions**: The least important actions in a set of options
/// - **Dialog Actions**: Dismissive actions like "Cancel", "Not now", "Skip"
/// - **Inline Actions**: Links within text such as "Learn more", "Show details"
/// - **Navigation Links**: In-app navigation that should look like text
/// - **Dense Layouts**: Where space is limited and visual weight must be minimal
///
/// ## Usage
///
/// ```dart
/// // Basic text button
/// AppTextButton(
///   label: 'Learn More',
///   onPressed: () => showInfoDialog(),
/// )
///
/// // Text button with icon
/// AppTextButton(
///   label: 'Add item',
///   icon: Icons.add,
///   onPressed: () => addItem(),
/// )
///
/// // In a dialog
/// AlertDialog(
///   actions: [
///     AppTextButton(
///       label: 'Not now',
///       onPressed: () => Navigator.pop(context),
///     ),
///     AppButton.filled(
///       label: 'Continue',
///       onPressed: () => continueAction(),
///     ),
///   ],
/// )
///
/// // As an inline link
/// Text.rich(
///   TextSpan(
///     text: 'By continuing, you agree to our terms. ',
///     children: [
///       WidgetSpan(
///         child: AppTextButton(
///           label: 'Learn more',
///           onPressed: () => showTerms(),
///         ),
///       ),
///     ],
///   ),
/// )
/// ```
///
/// ## Material Design 3 Compliance
///
/// This component follows Material Design 3 specifications for text buttons:
/// - **Height**: 40dp standard (48dp minimum touch target enforced)
/// - **Padding**: 12dp horizontal minimum
/// - **Typography**: Uses theme's `labelLarge` text style
/// - **Text Color**: `primary` (enabled), `onSurface` 38% opacity (disabled)
/// - **Background**: None (text-only)
/// - **Border**: None
/// - **State Layer**: 40dp ripple effect
/// - **Emphasis**: Lowest visual weight
///
/// ## Accessibility
///
/// Text buttons automatically provide proper accessibility support:
/// - Minimum touch target size of 48x48dp
/// - Semantic labels for screen readers
/// - Proper disabled state announcements
/// - Loading state excludes from accessibility tree
///
/// ## AppTextButton vs AppButton.text()
///
/// Both approaches are equivalent and produce identical results:
///
/// ```dart
/// // Using AppTextButton (component-specific API)
/// AppTextButton(label: 'Example', onPressed: () {})
///
/// // Using AppButton.text() (variant-based API)
/// AppButton.text(label: 'Example', onPressed: () {})
/// ```
///
/// Use whichever style you prefer. [AppTextButton] is provided as a convenience
/// for developers who prefer dedicated component names.
///
/// See also:
/// - [AppButton] for other button variants (filled, outlined, elevated)
/// - [Material Design 3 Buttons](https://m3.material.io/components/buttons)
class AppTextButton extends StatelessWidget {
  /// Creates a text button widget.
  ///
  /// The [label] parameter is required and specifies the text displayed on
  /// the button.
  ///
  /// When [isLoading] is true, the button displays a loading indicator and
  /// the [onPressed] callback is disabled.
  ///
  /// Set [fullWidth] to true to make the button expand to fill its parent's
  /// width.
  const AppTextButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  });

  /// The text displayed on the button.
  ///
  /// This text is required and will be displayed using the theme's
  /// `labelLarge` text style.
  final String label;

  /// Callback invoked when the button is pressed.
  ///
  /// If null, the button will be disabled. If [isLoading] is true,
  /// this callback will not be triggered even when the button is tapped.
  final VoidCallback? onPressed;

  /// Optional icon displayed before the label.
  ///
  /// When provided, the button will display the icon to the left of the
  /// label text.
  final IconData? icon;

  /// Whether the button should expand to fill its parent's width.
  ///
  /// When true, the button is wrapped in a [SizedBox] with
  /// `width: double.infinity`. Useful for full-width layouts.
  ///
  /// Defaults to false.
  final bool fullWidth;

  /// Whether the button is in a loading state.
  ///
  /// When true, displays a [CircularProgressIndicator] and disables
  /// the [onPressed] callback. The button remains disabled until
  /// [isLoading] is set to false.
  ///
  /// Defaults to false.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    // Delegate to AppButton.text() for consistent implementation
    return AppButton.text(
      label: label,
      onPressed: onPressed,
      icon: icon,
      fullWidth: fullWidth,
      isLoading: isLoading,
    );
  }
}
