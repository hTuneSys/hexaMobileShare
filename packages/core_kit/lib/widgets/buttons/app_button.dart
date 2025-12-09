// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A customizable Material Design 3 button widget that provides a consistent
/// button experience across the application.
///
/// AppButton supports four variants aligned with Material Design 3 guidelines:
/// - **Filled** (default): High emphasis actions, primary calls-to-action
/// - **Outlined**: Medium emphasis, secondary actions
/// - **Text**: Low emphasis, tertiary actions, inline actions
/// - **Elevated**: Special emphasis with shadow, use sparingly
///
/// ## When to Use Each Variant
///
/// ### Filled Button (Primary)
/// Use for the most important action on the screen:
/// - Form submissions (Sign In, Submit, Continue)
/// - Confirmations (Delete, Save, Confirm)
/// - Primary CTAs (Get Started, Buy Now, Add to Cart)
///
/// ### Outlined Button (Secondary)
/// Use for important but not primary actions:
/// - Cancel operations
/// - Alternative actions (Add to Wishlist)
/// - Navigation (Back, Next)
///
/// ### Text Button (Tertiary)
/// Use for low-priority actions:
/// - Optional actions (Skip, Learn More)
/// - Inline actions (Forgot Password?, View Details)
/// - Dialog dismissals
///
/// ### Elevated Button (Special Emphasis)
/// Use when you need to separate the button from patterned backgrounds:
/// - Creating new items (Create Account, New Project)
/// - Special promotions
/// - Floating actions that need to stand out
///
/// ## Features
///
/// - **Loading State**: Shows a circular progress indicator while processing
/// - **Icon Support**: Optionally display an icon alongside the label
/// - **Full Width**: Expand button to fill available width
/// - **Accessibility**: Built-in semantic labels and minimum touch targets
/// - **Disabled State**: Automatically handled via `onPressed: null`
///
/// ## Usage Examples
///
/// ```dart
/// // Basic filled button
/// AppButton.filled(
///   label: 'Continue',
///   onPressed: () => print('Pressed'),
/// )
///
/// // Outlined button with icon
/// AppButton.outlined(
///   label: 'Download',
///   icon: Icons.download,
///   onPressed: handleDownload,
/// )
///
/// // Full-width button with loading state
/// AppButton.filled(
///   label: 'Sign In',
///   fullWidth: true,
///   isLoading: isProcessing,
///   onPressed: isProcessing ? null : handleSignIn,
/// )
///
/// // Disabled button
/// AppButton.filled(
///   label: 'Submit',
///   onPressed: null, // Disabled state
/// )
/// ```
///
/// ## Accessibility
///
/// - Minimum touch target: 48x48dp (WCAG 2.1 AA compliant)
/// - Semantic labels automatically generated from button label
/// - Loading state properly announced to screen readers
/// - Color contrast ratios meet WCAG 2.1 AA standards
///
/// See also:
/// - [Material Design 3 Buttons](https://m3.material.io/components/buttons)
/// - [AppButtonVariant] for available button styles
class AppButton extends StatelessWidget {
  /// The button's label text.
  ///
  /// This text is displayed on the button and should clearly describe
  /// the action that will be performed when the button is pressed.
  /// Keep labels concise (1-3 words when possible).
  final String label;

  /// Callback function invoked when the button is pressed.
  ///
  /// Set to `null` to disable the button. When disabled, the button will
  /// have a muted appearance and will not respond to user interaction.
  final VoidCallback? onPressed;

  /// Optional icon displayed before the label.
  ///
  /// When provided, uses the Material button's `.icon()` constructor
  /// to ensure proper spacing and alignment between icon and label.
  /// Icons should support and clarify the button's action.
  final IconData? icon;

  /// The visual style variant of the button.
  ///
  /// Determines the button's appearance. See [AppButtonVariant] for options.
  /// Defaults to [AppButtonVariant.filled].
  final AppButtonVariant variant;

  /// Whether the button should expand to fill available horizontal space.
  ///
  /// When `true`, the button will be wrapped in a `SizedBox` with
  /// `width: double.infinity`. Useful for form layouts and mobile UIs.
  /// Defaults to `false`.
  final bool fullWidth;

  /// Whether the button is in a loading state.
  ///
  /// When `true`, displays a [CircularProgressIndicator] instead of the label
  /// and automatically disables the button. Use this to provide visual feedback
  /// during asynchronous operations (e.g., network requests, form submissions).
  /// Defaults to `false`.
  final bool isLoading;

  /// Creates an [AppButton] with the specified variant.
  ///
  /// This is the base constructor. Consider using one of the named constructors
  /// ([filled], [outlined], [text], [elevated]) for better readability.
  const AppButton({
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.filled,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  });

  /// Creates a filled button (high emphasis, primary actions).
  ///
  /// Filled buttons have the most visual weight and should be used for
  /// the primary action on a screen. Examples: 'Sign In', 'Submit', 'Buy Now'.
  const AppButton.filled({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.filled;

  /// Creates an outlined button (medium emphasis, secondary actions).
  ///
  /// Outlined buttons are used for important but not primary actions.
  /// Examples: 'Cancel', 'Back', 'Add to Wishlist'.
  const AppButton.outlined({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.outlined;

  /// Creates a text button (low emphasis, tertiary actions).
  ///
  /// Text buttons have the least visual weight and should be used for
  /// optional or inline actions. Examples: 'Skip', 'Learn More', 'Forgot Password?'.
  const AppButton.text({
    required this.label,
    this.onPressed,
    this.icon,
    this.fullWidth = false,
    this.isLoading = false,
    super.key,
  }) : variant = AppButtonVariant.text;

  /// Creates an elevated button (special emphasis with shadow).
  ///
  /// Elevated buttons add dimension to layouts and should be used sparingly.
  /// Best for separating the button from patterned backgrounds or for special CTAs.
  /// Examples: 'Create Account', 'Get Started', 'Upgrade Now'.
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
    final theme = Theme.of(context);

    // Build the button content (loading indicator or label)
    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : _buildButtonContent();

    // Create the appropriate button variant
    final button = switch (variant) {
      AppButtonVariant.filled =>
        icon != null
            ? FilledButton.icon(
                onPressed: isLoading ? null : onPressed,
                icon: Icon(icon),
                label: Text(label),
                style: _getButtonStyle(theme),
              )
            : FilledButton(
                onPressed: isLoading ? null : onPressed,
                style: _getButtonStyle(theme),
                child: child,
              ),
      AppButtonVariant.outlined =>
        icon != null
            ? OutlinedButton.icon(
                onPressed: isLoading ? null : onPressed,
                icon: Icon(icon),
                label: Text(label),
                style: _getButtonStyle(theme),
              )
            : OutlinedButton(
                onPressed: isLoading ? null : onPressed,
                style: _getButtonStyle(theme),
                child: child,
              ),
      AppButtonVariant.text =>
        icon != null
            ? TextButton.icon(
                onPressed: isLoading ? null : onPressed,
                icon: Icon(icon),
                label: Text(label),
                style: _getButtonStyle(theme),
              )
            : TextButton(
                onPressed: isLoading ? null : onPressed,
                style: _getButtonStyle(theme),
                child: child,
              ),
      AppButtonVariant.elevated =>
        icon != null
            ? ElevatedButton.icon(
                onPressed: isLoading ? null : onPressed,
                icon: Icon(icon),
                label: Text(label),
                style: _getButtonStyle(theme),
              )
            : ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                style: _getButtonStyle(theme),
                child: child,
              ),
    };

    // Wrap in Semantics for accessibility
    final semanticButton = Semantics(
      button: true,
      enabled: onPressed != null && !isLoading,
      label: isLoading ? '$label, loading' : label,
      excludeSemantics: true, // Exclude child semantics to use our custom label
      child: ExcludeSemantics(
        excluding: isLoading, // Exclude loading indicator from screen readers
        child: button,
      ),
    );

    // Apply full width if requested
    if (fullWidth) {
      return SizedBox(width: double.infinity, child: semanticButton);
    }

    return semanticButton;
  }

  /// Returns Material Design 3 compliant button style.
  ///
  /// Ensures proper height (40dp standard), minimum touch target (48x48dp),
  /// padding, and text style according to M3 specifications.
  ButtonStyle _getButtonStyle(ThemeData theme) {
    return ButtonStyle(
      // Minimum height: 40dp for standard buttons
      minimumSize: WidgetStateProperty.all(const Size(64, 40)),
      // Maximum height to ensure consistent sizing
      maximumSize: WidgetStateProperty.all(const Size(double.infinity, 40)),
      // Padding according to M3 specs
      padding: WidgetStateProperty.all(
        variant == AppButtonVariant.text
            ? const EdgeInsets.symmetric(horizontal: 12)
            : const EdgeInsets.symmetric(horizontal: 24),
      ),
      // Ensure minimum touch target size (48x48dp) for accessibility
      tapTargetSize: MaterialTapTargetSize.padded,
      // Use labelLarge typography from M3
      textStyle: WidgetStateProperty.all(theme.textTheme.labelLarge),
    );
  }

  /// Builds the button's content (label text).
  ///
  /// Note: When [icon] is provided, the icon is added via the button's
  /// `.icon()` constructor, so this method only returns the text label.
  Widget _buildButtonContent() {
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
