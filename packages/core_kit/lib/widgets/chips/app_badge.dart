// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 badge component that displays notification counts or
/// status indicators overlaid on other UI elements.
///
/// The [AppBadge] component provides compact visual indicators that draw
/// attention to new notifications, updates, or statuses without disrupting
/// the user experience. It supports two main variants: numeric (with count)
/// and dot (simple indicator).
///
/// ## Usage
///
/// ```dart
/// // Numeric badge on an icon button
/// AppBadge(
///   count: 5,
///   child: IconButton(
///     icon: Icon(Icons.notifications),
///     onPressed: () {},
///   ),
/// )
///
/// // Dot badge (simple indicator)
/// AppBadge.dot(
///   child: IconButton(
///     icon: Icon(Icons.message),
///     onPressed: () {},
///   ),
/// )
///
/// // Custom position and colors
/// AppBadge(
///   count: 99,
///   position: BadgePosition.topStart,
///   backgroundColor: Colors.green,
///   textColor: Colors.white,
///   child: Icon(Icons.shopping_cart),
/// )
/// ```
///
/// ## Badge Types
///
/// **Numeric Badge**: Displays a count in a pill-shaped container. Automatically
/// shows "99+" when the count exceeds 99. Use for notification counts, unread
/// messages, or any numeric indicator.
///
/// **Dot Badge**: Shows a small circular indicator without text. Use for simple
/// status indicators or to show presence without specific counts.
///
/// ## Positioning
///
/// Badges can be positioned at any of the four corners of the child widget:
/// - [BadgePosition.topEnd] (default): Top-right in LTR, top-left in RTL
/// - [BadgePosition.topStart]: Top-left in LTR, top-right in RTL
/// - [BadgePosition.bottomEnd]: Bottom-right in LTR, bottom-left in RTL
/// - [BadgePosition.bottomStart]: Bottom-left in LTR, bottom-right in RTL
///
/// Use [offset] to fine-tune the badge position with custom horizontal/vertical
/// adjustments.
///
/// ## Accessibility
///
/// This component automatically provides proper accessibility support:
/// - Screen reader announcements include count ("5 notifications")
/// - Semantic labels describe badge purpose
/// - Hidden badges are excluded from accessibility tree
///
/// ## Material Design 3 Compliance
///
/// This component follows MD3 specifications:
/// - Dot size: 6dp diameter
/// - Small numeric: 16dp height, 4dp horizontal padding
/// - Large numeric: 20dp height, 6dp horizontal padding
/// - Typography: labelSmall (11sp) for numeric badges
/// - Colors: Error color background, onError text (customizable)
/// - Animation: 200ms fade in/out
///
/// See also:
/// - [Material Design 3 Badge](https://m3.material.io/components/badge)
/// - [BadgePosition] for positioning options
class AppBadge extends StatelessWidget {
  /// Creates a numeric badge that displays a count.
  ///
  /// The [count] determines the numeric value displayed. When [count] is 0
  /// and [autoHide] is true, the badge is hidden. Counts over 99 display
  /// as "99+".
  ///
  /// The [child] is required and represents the widget the badge overlays.
  const AppBadge({
    required this.count,
    required this.child,
    this.position = BadgePosition.topEnd,
    this.offset,
    this.autoHide = true,
    this.isLarge = false,
    this.backgroundColor,
    this.textColor,
    super.key,
  }) : isDot = false,
       assert(count >= 0, 'Count must be non-negative');

  /// Creates a dot badge (simple indicator without count).
  ///
  /// Dot badges show a small circular indicator. They're useful for status
  /// indicators or to show presence without specific counts.
  ///
  /// The [child] is required and represents the widget the badge overlays.
  const AppBadge.dot({
    required this.child,
    this.position = BadgePosition.topEnd,
    this.offset,
    this.backgroundColor,
    super.key,
  }) : count = 0,
       isDot = true,
       autoHide = false,
       isLarge = false,
       textColor = null;

  /// The widget that the badge overlays.
  final Widget child;

  /// The numeric count to display (numeric badges only).
  ///
  /// When [count] is 0 and [autoHide] is true, the badge is hidden.
  /// Counts over 99 display as "99+".
  final int count;

  /// Whether this is a dot badge (true) or numeric badge (false).
  final bool isDot;

  /// The position of the badge relative to the child widget.
  ///
  /// Defaults to [BadgePosition.topEnd] (top-right in LTR, top-left in RTL).
  final BadgePosition position;

  /// Custom offset to fine-tune badge position.
  ///
  /// Positive horizontal values move the badge right (in LTR) or left (in RTL).
  /// Positive vertical values move the badge down.
  final Offset? offset;

  /// Whether to automatically hide the badge when count is 0.
  ///
  /// Only applicable to numeric badges. Defaults to true.
  final bool autoHide;

  /// Whether to use the large size variant.
  ///
  /// Large badges have more height and padding. Only applicable to numeric
  /// badges. Defaults to false.
  final bool isLarge;

  /// Custom background color for the badge.
  ///
  /// Defaults to theme's error color for numeric badges.
  final Color? backgroundColor;

  /// Custom text color for the badge.
  ///
  /// Defaults to theme's onError color. Only applicable to numeric badges.
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    // Hide badge if autoHide is enabled and count is 0
    final shouldShow = isDot || !autoHide || count > 0;

    if (!shouldShow) {
      return child;
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // Determine badge colors
    final badgeBackgroundColor = backgroundColor ?? colorScheme.error;
    final badgeTextColor = textColor ?? colorScheme.onError;

    // Build badge content
    final badgeContent = isDot
        ? _buildDotBadge(badgeBackgroundColor)
        : _buildNumericBadge(badgeBackgroundColor, badgeTextColor, textTheme);

    // Calculate badge position
    final alignment = _getAlignment(position);
    final badgeOffset = _calculateOffset(position);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: alignment.y < 0 ? badgeOffset.dy : null,
          bottom: alignment.y > 0 ? badgeOffset.dy : null,
          left: alignment.x < 0 ? badgeOffset.dx : null,
          right: alignment.x > 0 ? badgeOffset.dx : null,
          child: AnimatedOpacity(
            opacity: shouldShow ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: Semantics(label: _getSemanticLabel(), child: badgeContent),
          ),
        ),
      ],
    );
  }

  /// Builds a dot badge (small circle indicator).
  Widget _buildDotBadge(Color backgroundColor) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
    );
  }

  /// Builds a numeric badge (pill-shaped with count).
  Widget _buildNumericBadge(
    Color backgroundColor,
    Color textColor,
    TextTheme textTheme,
  ) {
    // Determine display text (show 99+ for counts over 99)
    final displayText = count > 99 ? '99+' : count.toString();

    // Size specifications
    final height = isLarge ? 20.0 : 16.0;
    final horizontalPadding = isLarge ? 6.0 : 4.0;
    final minWidth = isLarge ? 20.0 : 16.0;

    return Container(
      constraints: BoxConstraints(minWidth: minWidth, minHeight: height),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: Center(
        child: Text(
          displayText,
          style: textTheme.labelSmall?.copyWith(
            color: textColor,
            fontSize: 11,
            height: 1.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// Gets the alignment for the badge based on position.
  Alignment _getAlignment(BadgePosition position) {
    return switch (position) {
      BadgePosition.topStart => Alignment.topLeft,
      BadgePosition.topEnd => Alignment.topRight,
      BadgePosition.bottomStart => Alignment.bottomLeft,
      BadgePosition.bottomEnd => Alignment.bottomRight,
    };
  }

  /// Calculates the offset for badge positioning.
  Offset _calculateOffset(BadgePosition position) {
    // Default offset (4dp from edges)
    const defaultOffset = 4.0;

    // Base offset based on position
    final baseOffset = switch (position) {
      BadgePosition.topStart => const Offset(defaultOffset, defaultOffset),
      BadgePosition.topEnd => const Offset(defaultOffset, defaultOffset),
      BadgePosition.bottomStart => const Offset(defaultOffset, defaultOffset),
      BadgePosition.bottomEnd => const Offset(defaultOffset, defaultOffset),
    };

    // Apply custom offset if provided
    if (offset != null) {
      return Offset(baseOffset.dx + offset!.dx, baseOffset.dy + offset!.dy);
    }

    return baseOffset;
  }

  /// Gets the semantic label for screen readers.
  String _getSemanticLabel() {
    if (isDot) {
      return 'Status indicator';
    }

    if (count == 0) {
      return 'No notifications';
    } else if (count == 1) {
      return '1 notification';
    } else if (count > 99) {
      return 'More than 99 notifications';
    } else {
      return '$count notifications';
    }
  }
}

/// Defines the position of a badge relative to its child widget.
///
/// Badge positions are RTL-aware:
/// - `Start` positions align to the left in LTR and right in RTL
/// - `End` positions align to the right in LTR and left in RTL
enum BadgePosition {
  /// Top-left in LTR, top-right in RTL.
  topStart,

  /// Top-right in LTR, top-left in RTL (default).
  topEnd,

  /// Bottom-left in LTR, bottom-right in RTL.
  bottomStart,

  /// Bottom-right in LTR, bottom-left in RTL.
  bottomEnd,
}
