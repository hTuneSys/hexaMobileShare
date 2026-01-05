// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_radius.dart';

/// A Material Design 3 navigation drawer component.
///
/// AppDrawer provides side navigation with menu items, sections,
/// and rich header content following MD3 specifications.
///
/// Features:
/// - User profile header with avatar, name, and email
/// - Menu items with icons, labels, and selection state
/// - Section dividers and headers for organization
/// - Badge support for notifications
/// - Expandable/collapsible sections
/// - Footer section for settings and sign out
/// - Smooth slide-in/slide-out animations
/// - RTL language support
/// - Safe area handling
///
/// Example:
/// ```dart
/// AppDrawer(
///   header: AppDrawerHeader(
///     avatar: CircleAvatar(child: Icon(Icons.person)),
///     name: 'John Doe',
///     email: 'john@example.com',
///   ),
///   destinations: [
///     AppDrawerDestination(
///       icon: Icons.home,
///       label: 'Home',
///     ),
///     AppDrawerDestination(
///       icon: Icons.settings,
///       label: 'Settings',
///     ),
///   ],
///   selectedIndex: 0,
///   onDestinationSelected: (index) {
///     // Handle navigation
///   },
/// )
/// ```
class AppDrawer extends StatefulWidget {
  /// Creates an AppDrawer.
  const AppDrawer({
    required this.destinations,
    this.header,
    this.sections,
    this.footer,
    this.selectedIndex = 0,
    this.onDestinationSelected,
    this.backgroundColor,
    this.elevation = 1.0,
    this.width = 360.0,
    super.key,
  });

  /// The list of destinations in the drawer.
  final List<AppDrawerDestination> destinations;

  /// Optional header content with user profile.
  final AppDrawerHeader? header;

  /// Optional sections to organize destinations.
  final List<AppDrawerSection>? sections;

  /// Optional footer content for actions like sign out.
  final Widget? footer;

  /// The index of the currently selected destination.
  final int selectedIndex;

  /// Called when a destination is selected.
  final ValueChanged<int>? onDestinationSelected;

  /// Background color of the drawer.
  final Color? backgroundColor;

  /// Elevation of the drawer surface.
  final double elevation;

  /// Width of the drawer.
  ///
  /// Default is 360dp for mobile as per MD3 specifications.
  final double width;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final Set<int> _expandedSections = {};

  void _toggleSection(int index) {
    setState(() {
      if (_expandedSections.contains(index)) {
        _expandedSections.remove(index);
      } else {
        _expandedSections.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: widget.width,
      child: Drawer(
        backgroundColor: widget.backgroundColor ?? colorScheme.surface,
        elevation: widget.elevation,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              if (widget.header != null) widget.header!,

              // Menu items and sections
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    if (widget.sections != null && widget.sections!.isNotEmpty)
                      ..._buildSections()
                    else
                      ..._buildDestinations(widget.destinations, 0),
                  ],
                ),
              ),

              // Footer
              if (widget.footer != null)
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: widget.footer!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSections() {
    final List<Widget> items = [];

    for (
      int sectionIndex = 0;
      sectionIndex < widget.sections!.length;
      sectionIndex++
    ) {
      final section = widget.sections![sectionIndex];

      // Section header
      if (section.title != null) {
        items.add(
          _AppDrawerSectionHeader(
            title: section.title!,
            isExpanded: section.isExpandable
                ? _expandedSections.contains(sectionIndex)
                : null,
            onTap: section.isExpandable
                ? () => _toggleSection(sectionIndex)
                : null,
          ),
        );
      }

      // Section destinations
      if (!section.isExpandable || _expandedSections.contains(sectionIndex)) {
        items.addAll(
          _buildDestinations(section.destinations, section.startIndex),
        );
      }

      // Divider after section
      if (section.hasDivider && sectionIndex < widget.sections!.length - 1) {
        items.add(
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Divider(
              height: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        );
      }
    }

    return items;
  }

  List<Widget> _buildDestinations(
    List<AppDrawerDestination> destinations,
    int startIndex,
  ) {
    return destinations.asMap().entries.map((entry) {
      final index = startIndex + entry.key;
      final destination = entry.value;
      final isSelected = index == widget.selectedIndex;

      return _AppDrawerDestinationTile(
        destination: destination,
        isSelected: isSelected,
        onTap: destination.enabled
            ? () => widget.onDestinationSelected?.call(index)
            : null,
      );
    }).toList();
  }
}

/// Configuration for a drawer header with user profile.
class AppDrawerHeader extends StatelessWidget {
  /// Creates an AppDrawerHeader.
  const AppDrawerHeader({
    this.avatar,
    this.name,
    this.email,
    this.backgroundImage,
    this.backgroundColor,
    this.decoration,
    this.onTap,
    this.height = 160.0,
    super.key,
  });

  /// User avatar widget (typically a CircleAvatar).
  final Widget? avatar;

  /// User's display name.
  final String? name;

  /// User's email address.
  final String? email;

  /// Background image for the header.
  final ImageProvider? backgroundImage;

  /// Background color for the header.
  final Color? backgroundColor;

  /// Custom decoration for the header.
  final Decoration? decoration;

  /// Called when the header is tapped.
  final VoidCallback? onTap;

  /// Height of the header.
  ///
  /// Default is 160dp as per MD3 specifications.
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: height,
          decoration:
              decoration ??
              BoxDecoration(
                color: backgroundColor ?? colorScheme.primaryContainer,
                image: backgroundImage != null
                    ? DecorationImage(
                        image: backgroundImage!,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (avatar != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: avatar!,
                ),
              if (name != null)
                Text(
                  name!,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              if (email != null)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Text(
                    email!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer.withValues(
                        alpha: 0.8,
                      ),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single destination in the drawer menu.
class AppDrawerDestination {
  /// Creates an AppDrawerDestination.
  const AppDrawerDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badge,
    this.badgeLabel,
    this.enabled = true,
  });

  /// Icon displayed for this destination.
  final IconData icon;

  /// Icon displayed when this destination is selected.
  final IconData? selectedIcon;

  /// Label text for this destination.
  final String label;

  /// Whether to show a badge on this destination.
  final bool? badge;

  /// Optional label for the badge.
  final String? badgeLabel;

  /// Whether this destination is enabled.
  final bool enabled;
}

/// A section in the drawer that groups related destinations.
class AppDrawerSection {
  /// Creates an AppDrawerSection.
  const AppDrawerSection({
    required this.destinations,
    required this.startIndex,
    this.title,
    this.hasDivider = true,
    this.isExpandable = false,
  });

  /// Title of the section.
  final String? title;

  /// List of destinations in this section.
  final List<AppDrawerDestination> destinations;

  /// Starting index for destinations in this section.
  final int startIndex;

  /// Whether to show a divider after this section.
  final bool hasDivider;

  /// Whether this section can be expanded/collapsed.
  final bool isExpandable;
}

/// Internal widget for rendering a drawer destination tile.
class _AppDrawerDestinationTile extends StatelessWidget {
  const _AppDrawerDestinationTile({
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final AppDrawerDestination destination;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor = isSelected
        ? colorScheme.secondaryContainer
        : Colors.transparent;

    final foregroundColor = isSelected
        ? colorScheme.onSecondaryContainer
        : colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs / 2,
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: AppRadius.xlRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.xlRadius,
          child: Container(
            height: 56.0,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Icon(
                  isSelected && destination.selectedIcon != null
                      ? destination.selectedIcon
                      : destination.icon,
                  color: foregroundColor,
                  size: 24.0,
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    destination.label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: foregroundColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (destination.badge == true)
                  Container(
                    margin: const EdgeInsets.only(left: AppSpacing.sm),
                    padding: destination.badgeLabel != null
                        ? EdgeInsets.symmetric(
                            horizontal: _getBadgeHorizontalPadding(
                              destination.badgeLabel!,
                            ),
                            vertical: AppSpacing.xs / 2,
                          )
                        : null,
                    decoration: BoxDecoration(
                      color: colorScheme.error,
                      borderRadius: destination.badgeLabel != null
                          ? AppRadius.fullRadius
                          : null,
                      shape: destination.badgeLabel != null
                          ? BoxShape.rectangle
                          : BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: _getBadgeMinWidth(destination.badgeLabel),
                      minHeight: _getBadgeMinHeight(destination.badgeLabel),
                    ),
                    child: destination.badgeLabel != null
                        ? Center(
                            child: Text(
                              destination.badgeLabel!,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onError,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : null,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Returns the minimum width for a badge based on its label.
  ///
  /// MD3 Specifications:
  /// - No label (dot): 8dp
  /// - Single digit (1-9): 16dp
  /// - Two+ digits (10+): 20dp minimum (will expand with content)
  double _getBadgeMinWidth(String? label) {
    if (label == null) return 8.0; // Dot badge
    if (label.length == 1) return 16.0; // Single digit
    return 20.0; // Two or more digits
  }

  /// Returns the minimum height for a badge based on its label.
  ///
  /// MD3 Specifications:
  /// - No label (dot): 8dp
  /// - Single digit (1-9): 16dp
  /// - Two+ digits (10+): 20dp
  double _getBadgeMinHeight(String? label) {
    if (label == null) return 8.0; // Dot badge
    if (label.length == 1) return 16.0; // Single digit
    return 20.0; // Two or more digits
  }

  /// Returns the horizontal padding for a badge based on its label length.
  ///
  /// MD3 Specifications:
  /// - Single digit: 0dp (circular shape)
  /// - Two+ digits: 4dp (pill shape)
  double _getBadgeHorizontalPadding(String label) {
    if (label.length == 1) return 0.0; // Circular
    return 4.0; // Pill shape
  }
}

/// Internal widget for rendering a section header.
class _AppDrawerSectionHeader extends StatelessWidget {
  const _AppDrawerSectionHeader({
    required this.title,
    this.isExpanded,
    this.onTap,
  });

  final String title;
  final bool? isExpanded;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48.0,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isExpanded != null)
              Icon(
                isExpanded! ? Icons.expand_less : Icons.expand_more,
                color: colorScheme.onSurfaceVariant,
                size: 24.0,
              ),
          ],
        ),
      ),
    );
  }
}
