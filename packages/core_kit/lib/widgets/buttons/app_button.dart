// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A customizable Material Design 3 button widget that provides a consistent
/// button experience across the application.
///
/// The [AppButton] component supports four visual variants (filled, outlined,
/// text, and elevated) and includes built-in support for loading states, icons,
/// and full-width layouts. All variants follow Material Design 3 guidelines
/// and automatically adapt to the app's theme.
///
/// ## Usage
///
/// ```dart
/// // Basic filled button
/// AppButton.filled(
///   label: 'Continue',
///   onPressed: () => print('Button pressed'),
/// )
///
/// // Button with icon
/// AppButton.filled(
///   label: 'Add to Cart',
///   icon: Icons.shopping_cart,
///   onPressed: () => print('Added to cart'),
/// )
///
/// // Loading state
/// AppButton.filled(
///   label: 'Processing',
///   isLoading: true,
///   onPressed: () {}, // Disabled during loading
/// )
///
/// // Full-width button
/// AppButton.filled(
///   label: 'Sign In',
///   fullWidth: true,
///   onPressed: () => print('Signing in'),
/// )
/// ```
///
/// ## When to Use Each Variant
///
/// **Filled Button** ([AppButton.filled]):
/// - Primary actions that require high emphasis
/// - Call-to-action buttons (e.g., "Sign In", "Submit", "Continue")
/// - Final step in a flow (e.g., "Complete Purchase")
///
/// **Outlined Button** ([AppButton.outlined]):
/// - Medium-emphasis actions
/// - Secondary actions that need less prominence than filled buttons
/// - Alternative options (e.g., "Cancel" alongside a filled "Submit")
///
/// **Text Button** ([AppButton.text]):
/// - Low-emphasis actions
/// - Tertiary actions or less important options
/// - Dialog actions (e.g., "Cancel", "Learn More")
/// - Inline actions that shouldn't dominate the interface
///
/// **Elevated Button** ([AppButton.elevated]):
/// - Actions that need to stand out from the background
/// - Use sparingly when visual separation is needed
/// - Best on surfaces with busy backgrounds or images
///
/// ## Accessibility
///
/// This component automatically provides proper accessibility support:
/// - Minimum touch target size of 48x48dp (enforced by Material buttons)
/// - Semantic labels for screen readers
/// - Proper disabled state announcements
/// - Loading state excludes from accessibility tree during processing
///
/// ## Material Design 3 Compliance
///
/// This component follows MD3 specifications:
/// - Button height: 40dp standard (48dp minimum touch target enforced)
/// - Horizontal padding: Follows MD3 guidelines per button type
/// - Typography: Uses theme's `labelLarge` text style
/// - Colors: Automatically uses theme's color scheme tokens
/// - Border radius: Follows Material Design 3 defaults
///
/// See also:
/// - [Material Design 3 Buttons](https://m3.material.io/components/buttons)
/// - [AppButtonVariant] for available button styles
class AppButton extends StatelessWidget {
  /// Creates a customizable button widget.
  ///
  /// The [label] parameter is required and specifies the text displayed on
  /// the button. The [variant] parameter defaults to [AppButtonVariant.filled].
  ///
  /// When [isLoading] is true, the button displays a loading indicator and
  /// the [onPressed] callback is disabled regardless of its value.
  ///
  /// Set [fullWidth] to true to make the button expand to fill its parent's
  /// width (useful for form layouts and mobile interfaces).
  const AppButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.filled,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  });

  /// Creates a filled button variant (high emphasis).
  ///
  /// Filled buttons have the highest visual impact and should be used for
  /// primary actions. They use the theme's primary color for the background.
  ///
  /// Example:
  /// ```dart
  /// AppButton.filled(
  ///   label: 'Submit Form',
  ///   onPressed: () => submitForm(),
  /// )
  /// ```
  const AppButton.filled({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.filled;

  /// Creates an outlined button variant (medium emphasis).
  ///
  /// Outlined buttons are medium-emphasis buttons that contain actions that
  /// are important but not primary. They pair well with filled buttons.
  ///
  /// Example:
  /// ```dart
  /// AppButton.outlined(
  ///   label: 'Cancel',
  ///   onPressed: () => Navigator.pop(context),
  /// )
  /// ```
  const AppButton.outlined({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.outlined;

  /// Creates a text button variant (low emphasis).
  ///
  /// Text buttons are low-emphasis buttons used for less important actions.
  /// They work well in dialogs and cards where button emphasis would be
  /// too strong.
  ///
  /// Example:
  /// ```dart
  /// AppButton.text(
  ///   label: 'Learn More',
  ///   onPressed: () => showInfoDialog(),
  /// )
  /// ```
  const AppButton.text({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.text;

  /// Creates an elevated button variant (elevated emphasis).
  ///
  /// Elevated buttons have a shadow to provide depth. Use them when you need
  /// the button to stand out from surfaces with patterns or images.
  ///
  /// Example:
  /// ```dart
  /// AppButton.elevated(
  ///   label: 'Get Started',
  ///   icon: Icons.arrow_forward,
  ///   onPressed: () => startOnboarding(),
  /// )
  /// ```
  const AppButton.elevated({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.elevated;

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
  /// When provided, the button will use the appropriate `.icon` constructor
  /// of the underlying Material button (e.g., [FilledButton.icon]).
  final IconData? icon;

  /// The visual style variant of the button.
  ///
  /// Defaults to [AppButtonVariant.filled]. See [AppButtonVariant] for
  /// available options and usage guidelines.
  final AppButtonVariant variant;

  /// Whether the button should expand to fill its parent's width.
  ///
  /// When true, the button is wrapped in a [SizedBox] with
  /// `width: double.infinity`. Useful for full-width form buttons.
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
    // Determine button content: loading indicator or label
    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : _buildButtonContent();

    // Build appropriate button variant
    final button = switch (variant) {
      AppButtonVariant.filled =>
        icon != null && !isLoading
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
        icon != null && !isLoading
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
        icon != null && !isLoading
            ? TextButton.icon(
                onPressed: isLoading ? null : onPressed,
                icon: Icon(icon),
                label: Text(label),
              )
            : TextButton(onPressed: isLoading ? null : onPressed, child: child),
      AppButtonVariant.elevated =>
        icon != null && !isLoading
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

    // Wrap with accessibility and layout
    final accessibleButton = Semantics(
      button: true,
      enabled: !isLoading && onPressed != null,
      label: isLoading ? '$label, loading' : label,
      excludeSemantics: isLoading,
      child: button,
    );

    // Apply full-width layout if requested
    if (fullWidth) {
      return SizedBox(width: double.infinity, child: accessibleButton);
    }

    return accessibleButton;
  }

  /// Builds the button's child content.
  ///
  /// Returns a [Text] widget with the button's label. This method exists
  /// to provide a consistent content builder for buttons without icons.
  Widget _buildButtonContent() {
    return Text(label);
  }
}

/// Visual style variants for [AppButton].
///
/// Each variant provides different visual emphasis and should be used
/// according to the action's importance in the interface hierarchy.
enum AppButtonVariant {
  /// Filled button with solid background color (high emphasis).
  ///
  /// Use for primary, high-emphasis actions like form submissions,
  /// confirmations, or the main call-to-action on a screen.
  filled,

  /// Outlined button with border, no background fill (medium emphasis).
  ///
  /// Use for secondary actions that are important but not primary,
  /// such as "Cancel" buttons or alternative options.
  outlined,

  /// Text-only button without background or border (low emphasis).
  ///
  /// Use for tertiary actions, less important options, or when
  /// button emphasis would overwhelm the interface (e.g., in dialogs).
  text,

  /// Elevated button with shadow for depth (elevated emphasis).
  ///
  /// Use when the button needs to stand out from busy backgrounds
  /// or patterned surfaces. Use sparingly for visual hierarchy.
  elevated,
}
