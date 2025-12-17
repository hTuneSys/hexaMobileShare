// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:core_kit/theme/app_typography.dart';

/// A Material Design 3 list tile widget.
///
/// A single fixed-height row that typically contains text, icons, and optional
/// actions. List tiles provide a consistent layout with leading/trailing widgets
/// and up to three lines of text.
///
/// The tile automatically adjusts its height based on:
/// - One-line: 56dp (48dp if dense)
/// - Two-line: 72dp (64dp if dense)
/// - Three-line: 88dp (requires [isThreeLine] = true)
///
/// Example usage:
///
/// ```dart
/// // Basic list tile
/// AppListTile(
///   leading: Icon(Icons.person),
///   title: 'Profile',
///   onTap: () => _openProfile(),
/// )
///
/// // Two-line tile with subtitle
/// AppListTile(
///   leading: CircleAvatar(child: Icon(Icons.folder)),
///   title: 'Documents',
///   subtitle: '24 files',
///   trailing: Icon(Icons.chevron_right),
///   onTap: () => _openFolder(),
/// )
///
/// // Settings tile with switch
/// AppListTile(
///   leading: Icon(Icons.notifications),
///   title: 'Notifications',
///   subtitle: 'Enable push notifications',
///   trailing: Switch(value: _enabled, onChanged: _toggle),
/// )
/// ```
///
/// See also:
/// - [ListTile], the underlying Material widget
/// - Material Design 3 Lists: https://m3.material.io/components/lists
class AppListTile extends StatelessWidget {
  /// Creates a Material Design 3 list tile.
  ///
  /// The [title] parameter is required.
  const AppListTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.enabled = true,
    this.dense = false,
    this.isThreeLine = false,
    this.contentPadding,
    this.tileColor,
    this.selectedTileColor,
    this.shape,
    this.visualDensity,
    super.key,
  });

  /// The primary content of the list tile.
  ///
  /// Displayed using Material Design 3 [AppTypography.bodyLarge] style
  /// with [ColorScheme.onSurface] color (or [ColorScheme.onSecondaryContainer]
  /// when selected).
  final String title;

  /// Additional content displayed below the title.
  ///
  /// Displayed using Material Design 3 [AppTypography.bodyMedium] style
  /// with [ColorScheme.onSurfaceVariant] color.
  /// For three-line layout, set [isThreeLine] to true.
  final String? subtitle;

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] (24dp) or [CircleAvatar] (40dp).
  final Widget? leading;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon], [Text], or interactive widget like [Switch].
  final Widget? trailing;

  /// Called when the user taps this list tile.
  ///
  /// If null and [enabled] is true, the tile is still interactive but
  /// doesn't do anything when tapped.
  final VoidCallback? onTap;

  /// Called when the user long-presses on this list tile.
  final VoidCallback? onLongPress;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// Dense mode reduces the height:
  /// - One-line: 56dp → 48dp
  /// - Two-line: 72dp → 64dp
  ///
  /// Default is false.
  final bool dense;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If true, the tile height increases to 88dp to accommodate the subtitle.
  /// The subtitle should be limited to three lines of text.
  ///
  /// Default is false.
  final bool isThreeLine;

  /// Whether this list tile is currently selected.
  ///
  /// If true, the tile displays with [selectedTileColor] background and
  /// appropriate text color from the theme.
  ///
  /// Default is false.
  final bool selected;

  /// Whether this list tile is interactive.
  ///
  /// If false, the tile appears disabled with reduced opacity and
  /// [onTap] and [onLongPress] are ignored.
  ///
  /// Default is true.
  final bool enabled;

  /// The tile's internal padding.
  ///
  /// Default is EdgeInsets.symmetric(horizontal: 16.0).
  final EdgeInsetsGeometry? contentPadding;

  /// The tile's background color.
  ///
  /// If null, uses theme's surface color.
  final Color? tileColor;

  /// The tile's background color when [selected] is true.
  ///
  /// If null, uses theme's secondaryContainer color.
  final Color? selectedTileColor;

  /// The shape of the list tile's border.
  ///
  /// If null, no border is drawn.
  final ShapeBorder? shape;

  /// Defines how compact the tile's layout will be.
  ///
  /// This allows fine-tuning beyond the [dense] parameter.
  final VisualDensity? visualDensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = AppTypography.textTheme();

    // Build title with proper typography and color
    final titleWidget = Text(
      title,
      style: textTheme.bodyLarge?.copyWith(
        color: selected
            ? colorScheme.onSecondaryContainer
            : colorScheme.onSurface,
      ),
    );

    // Build subtitle with proper typography and color
    final subtitleWidget = subtitle != null
        ? Text(
            subtitle!,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          )
        : null;

    return ListTile(
      // Layout
      contentPadding:
          contentPadding ?? const EdgeInsets.symmetric(horizontal: 16.0),
      dense: dense,
      isThreeLine: isThreeLine,
      visualDensity: visualDensity,

      // Content
      leading: leading,
      title: titleWidget,
      subtitle: subtitleWidget,
      trailing: trailing,

      // Interaction
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      enabled: enabled,
      selected: selected,

      // Styling
      tileColor: tileColor,
      selectedTileColor: selectedTileColor ?? colorScheme.secondaryContainer,
      shape: shape,

      // Ensure minimum 48dp touch target for accessibility
      minVerticalPadding: dense ? 4.0 : 8.0,
    );
  }
}
