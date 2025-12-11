// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 switch widget that provides consistent toggle switch
/// experience across the application.
///
/// The [AppSwitch] component supports:
/// - Standard on/off states
/// - Optional text labels and subtitles
/// - Optional leading icons
/// - Material Design 3 theming
/// - Custom color overrides
/// - Accessibility features
///
/// ## Basic Usage
///
/// ```dart
/// bool isEnabled = false;
///
/// AppSwitch(
///   value: isEnabled,
///   label: 'Enable notifications',
///   onChanged: (value) {
///     setState(() {
///       isEnabled = value;
///     });
///   },
/// )
/// ```
///
/// ## With Subtitle
///
/// Provide additional context with a subtitle:
///
/// ```dart
/// AppSwitch(
///   value: true,
///   label: 'Dark mode',
///   subtitle: 'Use dark theme across the app',
///   onChanged: (value) {
///     // Handle state change
///   },
/// )
/// ```
///
/// ## With Icon
///
/// Add a leading icon for visual context:
///
/// ```dart
/// AppSwitch(
///   value: false,
///   label: 'Bluetooth',
///   icon: Icons.bluetooth,
///   onChanged: (value) {
///     // Handle state change
///   },
/// )
/// ```
///
/// ## Custom Colors
///
/// Override default colors:
///
/// ```dart
/// AppSwitch(
///   value: true,
///   label: 'Custom switch',
///   activeColor: Colors.green,
///   activeTrackColor: Colors.green.withOpacity(0.5),
///   onChanged: (value) {},
/// )
/// ```
///
/// ## Material Design 3 Specifications
///
/// - Track size: 52x32dp (M3 standard)
/// - Thumb size: 16dp (off) → 24dp (on)
/// - Touch target: Minimum 48x48dp
/// - Animation: 200ms smooth transition
/// - Colors: Uses theme's [ColorScheme] tokens
///
/// ## Accessibility
///
/// - Minimum touch target of 48x48dp
/// - Semantic labels from [label] property
/// - State changes announced to screen readers ("On", "Off")
/// - Keyboard navigation support (Space/Enter to toggle)
/// - Disabled state announced to screen readers
///
/// See also:
/// - [Material Design 3 Switch](https://m3.material.io/components/switch/overview)
/// - [Switch] - Flutter's base switch widget
class AppSwitch extends StatelessWidget {
  /// Creates a Material Design 3 switch.
  ///
  /// The [value] and [onChanged] parameters must not be null unless
  /// the switch is disabled.
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.subtitle,
    this.icon,
    this.activeColor,
    this.inactiveColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.enabled = true,
  });

  /// The current value of the switch.
  ///
  /// When true, the switch is in the "on" position.
  /// When false, the switch is in the "off" position.
  final bool value;

  /// Called when the user toggles the switch.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If this callback is null, the switch will be displayed as disabled.
  final ValueChanged<bool>? onChanged;

  /// Optional text label displayed next to the switch.
  ///
  /// When null, only the switch is displayed.
  final String? label;

  /// Optional subtitle text displayed below the label.
  ///
  /// Provides additional context or description for the switch.
  /// Only displayed when [label] is also provided.
  final String? subtitle;

  /// Optional leading icon displayed before the label.
  ///
  /// Provides visual context for the switch purpose.
  final IconData? icon;

  /// The color to use when this switch is on.
  ///
  /// If null, uses the theme's primary color for the thumb.
  final Color? activeColor;

  /// The color to use when this switch is off.
  ///
  /// If null, uses the theme's outline color for the thumb.
  final Color? inactiveColor;

  /// The color to use for the track when this switch is on.
  ///
  /// If null, uses the theme's primary color.
  final Color? activeTrackColor;

  /// The color to use for the track when this switch is off.
  ///
  /// If null, uses the theme's surfaceContainerHighest color.
  final Color? inactiveTrackColor;

  /// Whether the switch is enabled for interaction.
  ///
  /// When false, the switch is displayed with reduced opacity and does not
  /// respond to touch.
  ///
  /// Defaults to true.
  final bool enabled;

  /// Whether this switch is currently enabled.
  ///
  /// A switch is considered enabled if [enabled] is true and [onChanged]
  /// is not null.
  bool get _isEnabled => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // If both label and subtitle are null, return just the switch
    if (label == null && subtitle == null) {
      return _buildSwitch(theme, colorScheme);
    }

    // If there's a label or subtitle, build the full layout
    return InkWell(
      onTap: _isEnabled
          ? () {
              onChanged?.call(!value);
            }
          : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Row(
          children: [
            // Leading icon (if provided)
            if (icon != null) ...[
              Icon(
                icon,
                size: 24,
                color: _isEnabled
                    ? colorScheme.onSurface
                    : colorScheme.onSurface.withValues(alpha: 0.38),
              ),
              const SizedBox(width: 16),
            ],
            // Label and subtitle
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: _isEnabled
                            ? colorScheme.onSurface
                            : colorScheme.onSurface.withValues(alpha: 0.38),
                      ),
                    ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: _isEnabled
                            ? colorScheme.onSurfaceVariant
                            : colorScheme.onSurfaceVariant.withValues(
                                alpha: 0.38,
                              ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Switch
            _buildSwitch(theme, colorScheme),
          ],
        ),
      ),
    );
  }

  /// Builds the switch widget with proper theming.
  Widget _buildSwitch(ThemeData theme, ColorScheme colorScheme) {
    return Switch(
      value: value,
      onChanged: _isEnabled ? onChanged : null,
      thumbColor: activeColor != null || inactiveColor != null
          ? WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.selected)) {
                return activeColor;
              }
              return inactiveColor;
            })
          : null,
      trackColor: activeTrackColor != null || inactiveTrackColor != null
          ? WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.selected)) {
                return activeTrackColor;
              }
              return inactiveTrackColor;
            })
          : null,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }
}
