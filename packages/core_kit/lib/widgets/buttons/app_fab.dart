// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import '../../theme/app_radius.dart';
import '../../theme/app_typography.dart';

/// Floating Action Button following Material Design 3.
///
/// Variants:
/// - Default (56x56)
/// - Small (40x40)
/// - Large (96x96)
/// - Extended (48 height with label)
class AppFab extends StatelessWidget {
  /// Default FAB: 56x56
  const AppFab({
    required this.icon,
    this.iconWrapper,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.heroTag,
    this.shape,
    super.key,
  }) : _variant = _FabVariant.defaultFab,
       label = null,
       trailingIcon = null;

  /// Small FAB: 40x40
  const AppFab.small({
    required this.icon,
    this.iconWrapper,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.heroTag,
    this.shape,
    super.key,
  }) : _variant = _FabVariant.small,
       label = null,
       trailingIcon = null;

  /// Large FAB: 96x96
  const AppFab.large({
    required this.icon,
    this.iconWrapper,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.heroTag,
    this.shape,
    super.key,
  }) : _variant = _FabVariant.large,
       label = null,
       trailingIcon = null;

  /// Extended FAB with label (48dp height)
  const AppFab.extended({
    required this.icon,
    required this.label,
    this.trailingIcon,
    this.iconWrapper,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.heroTag,
    this.shape,
    super.key,
  }) : _variant = _FabVariant.extended;

  /// Icon to display.
  final IconData icon;

  /// Optional trailing icon for extended variant.
  final IconData? trailingIcon;

  /// Optional wrapper to decorate/animate the icon widget (e.g., rotation for loading).
  final Widget Function(Widget icon)? iconWrapper;

  /// Tap handler. Null disables the FAB.
  final VoidCallback? onPressed;

  /// Accessibility tooltip.
  final String? tooltip;

  /// Background color override.
  final Color? backgroundColor;

  /// Foreground (icon/label) color override.
  final Color? foregroundColor;

  /// Elevation override.
  final double? elevation;

  /// Hero tag for navigation transitions.
  final Object? heroTag;

  /// Custom shape override.
  final ShapeBorder? shape;

  /// Label for extended variant.
  final String? label;

  final _FabVariant _variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    // Derive MD3-compliant defaults from AppColorScheme/AppRadius/AppTypography
    final Color bg = backgroundColor ?? colors.primaryContainer;
    final Color fg = foregroundColor ?? colors.onPrimaryContainer;
    final WidgetStateProperty<double?> elevProp =
        WidgetStateProperty.resolveWith<double?>((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return (elevation ?? 12.0);
          }
          return (elevation ?? 6.0);
        });

    final ShapeBorder defaultShape = RoundedRectangleBorder(
      borderRadius: _variant == _FabVariant.extended
          ? AppRadius
                .xlRadius // 28dp for extended
          : AppRadius.lgRadius, // 16dp for regular
    );

    Widget childIcon = Icon(icon, size: _iconSizeFor(_variant));
    if (iconWrapper != null) {
      childIcon = iconWrapper!(childIcon);
    }

    Widget result;
    switch (_variant) {
      case _FabVariant.small:
        result = FloatingActionButton.small(
          heroTag: heroTag,
          onPressed: onPressed,
          tooltip: tooltip,
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: elevProp.resolve(const {}),
          shape: shape ?? defaultShape,
          child: childIcon,
        );
        break;
      case _FabVariant.large:
        result = FloatingActionButton.large(
          heroTag: heroTag,
          onPressed: onPressed,
          tooltip: tooltip,
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: elevProp.resolve(const {}),
          shape: shape ?? defaultShape,
          child: childIcon,
        );
        break;
      case _FabVariant.extended:
        // Compose label with optional trailing icon using MD3 spacing
        final Widget labelWidget = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label ?? '',
              style: AppTypography.textTheme().labelLarge?.copyWith(color: fg),
            ),
            if (trailingIcon != null) ...[
              const SizedBox(width: 8),
              Icon(trailingIcon, size: _iconSizeFor(_variant), color: fg),
            ],
          ],
        );

        result = FloatingActionButton.extended(
          heroTag: heroTag,
          onPressed: onPressed,
          tooltip: tooltip,
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: elevProp.resolve(const {}),
          shape: shape ?? defaultShape,
          label: labelWidget,
          icon: iconWrapper != null
              ? iconWrapper!(Icon(icon, size: _iconSizeFor(_variant)))
              : Icon(icon, size: _iconSizeFor(_variant)),
        );
        break;
      case _FabVariant.defaultFab:
        result = FloatingActionButton(
          heroTag: heroTag,
          onPressed: onPressed,
          tooltip: tooltip,
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: elevProp.resolve(const {}),
          shape: shape ?? defaultShape,
          child: childIcon,
        );
        break;
    }

    // Accessibility semantics wrapper and ensure min touch target
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: tooltip,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
        child: result,
      ),
    );
  }

  double _iconSizeFor(_FabVariant v) {
    switch (v) {
      case _FabVariant.large:
        return 36; // MD3 large icon size
      case _FabVariant.small:
        return 24; // MD3 small uses 24dp icon by spec requirement
      case _FabVariant.extended:
        return 24; // Extended uses 24dp icon
      case _FabVariant.defaultFab:
        return 24; // MD3 default uses 24dp icon size
    }
  }
}

enum _FabVariant { defaultFab, small, large, extended }

/// Internal helper to augment extended FAB with a trailing icon while
/// preserving Material behavior and ripple.
// Removed overlay helper; trailing icon is integrated into the extended label row for correct layout.

/// Animated switchable FAB to transition smoothly between extended and default.
///
/// This wrapper helps animate between an extended FAB (with label) and a
/// regular FAB using AnimatedSwitcher for a smooth cross-fade/size transition.
class AppFabSwitchable extends StatelessWidget {
  const AppFabSwitchable({
    required this.isExtended,
    required this.icon,
    this.label,
    this.trailingIcon,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.heroTag,
    this.shape,
    this.duration = const Duration(milliseconds: 200),
    super.key,
  });

  final bool isExtended;
  final IconData icon;
  final String? label;
  final IconData? trailingIcon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final Object? heroTag;
  final ShapeBorder? shape;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      child: isExtended
          ? AppFab.extended(
              key: const ValueKey('extended'),
              icon: icon,
              label: label ?? '',
              trailingIcon: trailingIcon,
              onPressed: onPressed,
              tooltip: tooltip,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              elevation: elevation,
              heroTag: heroTag,
              shape: shape,
            )
          : AppFab(
              key: const ValueKey('default'),
              icon: icon,
              onPressed: onPressed,
              tooltip: tooltip,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              elevation: elevation,
              heroTag: heroTag,
              shape: shape,
            ),
    );
  }
}

/// Helper widget to hide/show FAB based on scroll direction using AnimatedSlide.
class AppFabHideOnScroll extends StatefulWidget {
  const AppFabHideOnScroll({
    required this.scrollController,
    required this.fab,
    this.offset = const Offset(0, 1),
    this.duration = const Duration(milliseconds: 200),
    super.key,
  });

  final ScrollController scrollController;
  final Widget fab;
  final Offset offset;
  final Duration duration;

  @override
  State<AppFabHideOnScroll> createState() => _AppFabHideOnScrollState();
}

class _AppFabHideOnScrollState extends State<AppFabHideOnScroll> {
  double _last = 0;
  bool _hidden = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final current = widget.scrollController.position.pixels;
    final goingDown = current > _last;
    _last = current;
    if (goingDown && !_hidden) {
      setState(() => _hidden = true);
    } else if (!goingDown && _hidden) {
      setState(() => _hidden = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _hidden ? widget.offset : Offset.zero,
      duration: widget.duration,
      curve: Curves.easeInOut,
      child: widget.fab,
    );
  }
}
