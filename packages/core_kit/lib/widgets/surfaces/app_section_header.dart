// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

import '../../theme/app_spacing.dart';

/// Defines the position of the divider relative to the section header.
enum DividerPosition {
  /// No divider is shown.
  none,

  /// Divider is shown above the section header.
  above,

  /// Divider is shown below the section header.
  below,

  /// Dividers are shown both above and below the section header.
  both,
}

/// A Material Design 3 section header widget for organizing content.
///
/// [AppSectionHeader] is a visual divider that organizes content into logical
/// groups by displaying a title and optional actions. It's commonly used in
/// settings screens, forms, lists, and anywhere content needs to be categorized.
///
/// Section headers improve scannability and help users quickly find what they're
/// looking for. They provide semantic structure for screen readers.
///
/// The widget follows M3 specifications:
/// - Minimum height: 48dp (with single-line title)
/// - Padding: 16dp horizontal, 8dp vertical (default)
/// - Title: titleSmall (14sp, 500 weight)
/// - Subtitle: bodySmall (12sp, regular weight)
///
/// Example:
/// ```dart
/// AppSectionHeader(
///   title: 'Account Settings',
/// )
///
/// AppSectionHeader(
///   title: 'Privacy',
///   subtitle: 'Manage your privacy and security settings',
///   trailing: TextButton(
///     onPressed: () {},
///     child: Text('Edit'),
///   ),
/// )
///
/// // For sticky headers in scrollable content:
/// CustomScrollView(
///   slivers: [
///     SliverPersistentHeader(
///       pinned: true,
///       delegate: SectionHeaderDelegate(
///         child: AppSectionHeader(
///           title: 'Pinned Section',
///           backgroundColor: Theme.of(context).colorScheme.surface,
///         ),
///       ),
///     ),
///   ],
/// )
/// ```
class AppSectionHeader extends StatelessWidget {
  /// Creates a section header with the given [title].
  ///
  /// The [title] is the main text displayed in the section header.
  const AppSectionHeader({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.padding,
    this.showDivider = false,
    this.dividerPosition = DividerPosition.below,
    this.dividerIndent,
    this.dividerEndIndent,
    this.backgroundColor,
    this.textStyle,
    this.subtitleStyle,
    this.isUpperCase = false,
    this.minHeight = 48.0,
    super.key,
  });

  /// The main title text of the section header.
  ///
  /// This is required and will be displayed prominently.
  final String title;

  /// An optional subtitle or description below the title.
  ///
  /// Use this to provide additional context about the section.
  final String? subtitle;

  /// An optional widget to display before the title.
  ///
  /// Typically an [Icon] widget.
  final Widget? leading;

  /// An optional widget to display after the title.
  ///
  /// Typically a [TextButton] or [IconButton] for section-level actions.
  final Widget? trailing;

  /// Custom padding for the section header.
  ///
  /// If null, defaults to horizontal 16dp and vertical 8dp padding.
  final EdgeInsetsGeometry? padding;

  /// Whether to show a divider.
  ///
  /// Defaults to false. When true, a divider is shown at the position
  /// specified by [dividerPosition].
  final bool showDivider;

  /// The position of the divider relative to the section header content.
  ///
  /// Only applies when [showDivider] is true.
  /// Defaults to [DividerPosition.below].
  final DividerPosition dividerPosition;

  /// The amount of empty space to the leading edge of the divider.
  ///
  /// If null, the divider extends to the edge of its parent.
  final double? dividerIndent;

  /// The amount of empty space to the trailing edge of the divider.
  ///
  /// If null, the divider extends to the edge of its parent.
  final double? dividerEndIndent;

  /// The background color of the section header.
  ///
  /// If null, the header has a transparent background.
  /// Set this to an opaque color when using as a sticky header.
  final Color? backgroundColor;

  /// Custom text style for the title.
  ///
  /// If null, uses [TextTheme.titleSmall] with [ColorScheme.onSurfaceVariant].
  final TextStyle? textStyle;

  /// Custom text style for the subtitle.
  ///
  /// If null, uses [TextTheme.bodySmall] with [ColorScheme.onSurfaceVariant]
  /// at 60% opacity.
  final TextStyle? subtitleStyle;

  /// Whether to display the title in uppercase.
  ///
  /// Defaults to false. M3 section headers often use uppercase styling.
  final bool isUpperCase;

  /// The minimum height of the section header.
  ///
  /// Defaults to 48dp as per Material Design 3 specifications.
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Build title text
    final displayTitle = isUpperCase ? title.toUpperCase() : title;

    final effectiveTitleStyle =
        textStyle ??
        theme.textTheme.titleSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w500,
        );

    final effectiveSubtitleStyle =
        subtitleStyle ??
        theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant.withAlpha(153), // 60% opacity
        );

    final effectivePadding =
        padding ??
        const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        );

    // Build the content row with minimum height
    Widget content = ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Padding(
        padding: effectivePadding,
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppSpacing.sm),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(displayTitle, style: effectiveTitleStyle),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppSpacing.xs / 2),
                    Text(subtitle!, style: effectiveSubtitleStyle),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );

    // Apply background color if specified
    if (backgroundColor != null) {
      content = ColoredBox(color: backgroundColor!, child: content);
    }

    // Build with dividers if needed
    if (showDivider && dividerPosition != DividerPosition.none) {
      final divider = Divider(
        height: 1,
        thickness: 1,
        color: colorScheme.outlineVariant,
        indent: dividerIndent,
        endIndent: dividerEndIndent,
      );

      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dividerPosition == DividerPosition.above ||
              dividerPosition == DividerPosition.both)
            divider,
          content,
          if (dividerPosition == DividerPosition.below ||
              dividerPosition == DividerPosition.both)
            divider,
        ],
      );
    }

    // Wrap with semantics for accessibility
    return Semantics(
      header: true,
      label: subtitle != null ? '$displayTitle, $subtitle' : displayTitle,
      child: content,
    );
  }
}

/// A [SliverPersistentHeaderDelegate] for creating sticky section headers.
///
/// Use this delegate with [SliverPersistentHeader] to create section headers
/// that stick to the top of the viewport when scrolling.
///
/// Example:
/// ```dart
/// CustomScrollView(
///   slivers: [
///     SliverPersistentHeader(
///       pinned: true,
///       delegate: SectionHeaderDelegate(
///         child: AppSectionHeader(
///           title: 'Pinned Section',
///           backgroundColor: Theme.of(context).colorScheme.surface,
///         ),
///       ),
///     ),
///     SliverList(
///       delegate: SliverChildListDelegate([
///         // List items...
///       ]),
///     ),
///   ],
/// )
/// ```
class SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  /// Creates a section header delegate.
  ///
  /// The [child] is typically an [AppSectionHeader] widget.
  /// The [height] defaults to 48dp as per Material Design 3 specifications.
  const SectionHeaderDelegate({required this.child, this.height = 48.0});

  /// The widget to display as the section header.
  final Widget child;

  /// The height of the section header.
  ///
  /// Defaults to 48dp.
  final double height;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SectionHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}
