// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/theme/app_shadows.dart';

/// Widgetbook stories for AppShadows
///
/// Demonstrates Material Design 3 elevation system with shadows and
/// surface tint overlays across all 6 elevation levels (0-5).

// ==================== Story 1: Interactive Playground ====================

@widgetbook.UseCase(name: 'Interactive Playground', type: AppShadows)
Widget interactivePlayground(BuildContext context) {
  // Knobs for all elevation properties
  final level = context.knobs.object.dropdown(
    label: 'Elevation Level',
    options: [0, 1, 2, 3, 4, 5],
    initialOption: 2,
    labelBuilder: (value) => 'Level $value (${AppShadows.levelName(value)})',
  );

  final enableTint = context.knobs.boolean(
    label: 'Enable Surface Tint',
    initialValue: true,
  );

  final width = context.knobs.double.slider(
    label: 'Container Width',
    initialValue: 200,
    min: 100,
    max: 400,
  );

  final height = context.knobs.double.slider(
    label: 'Container Height',
    initialValue: 150,
    min: 100,
    max: 300,
  );

  final borderRadius = context.knobs.double.slider(
    label: 'Border Radius',
    initialValue: 12,
    min: 0,
    max: 50,
  );

  final themeMode = context.knobs.object.dropdown(
    label: 'Component Theme',
    options: ['Light', 'Dark'],
    initialOption: 'Light',
  );

  final backgroundColor = context.knobs.colorOrNull(
    label: 'Background Color (null = surface)',
    initialValue: null,
  );

  // Apply theme mode
  return Theme(
    data: themeMode == 'Dark'
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true),
    child: Builder(
      builder: (context) {
        final decoration = enableTint
            ? AppShadows.decorationWithTint(
                context: context,
                level: level,
                backgroundColor: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
              )
            : BoxDecoration(
                color: backgroundColor ?? Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: AppShadows.forLevel(level),
              );

        return Center(
          child: Container(
            width: width,
            height: height,
            decoration: decoration,
            child: Center(
              child: Text(
                'Level $level\n${AppShadows.levelName(level).toUpperCase()}',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

// ==================== Story 2: Elevation Levels Showcase ====================

@widgetbook.UseCase(name: 'Elevation Levels Showcase', type: AppShadows)
Widget elevationLevelsShowcase(BuildContext context) {
  final level = context.knobs.object.dropdown(
    label: 'Elevation Level',
    options: [0, 1, 2, 3, 4, 5],
    initialOption: 2,
    labelBuilder: (value) => 'Level $value (${AppShadows.levelName(value)})',
  );

  final showTint = context.knobs.boolean(
    label: 'Show Surface Tint',
    initialValue: true,
  );

  final themeMode = context.knobs.object.dropdown(
    label: 'Component Theme',
    options: ['Light', 'Dark'],
    initialOption: 'Light',
  );

  final containerWidth = context.knobs.double.slider(
    label: 'Container Width',
    initialValue: 300,
    min: 200,
    max: 400,
  );

  final containerHeight = context.knobs.double.slider(
    label: 'Container Height',
    initialValue: 150,
    min: 100,
    max: 300,
  );

  return Theme(
    data: themeMode == 'Dark'
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true),
    child: Builder(
      builder: (context) {
        final decoration = showTint
            ? AppShadows.decorationWithTint(
                context: context,
                level: level,
                borderRadius: BorderRadius.circular(12),
              )
            : BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppShadows.forLevel(level),
              );

        return Center(
          child: Container(
            width: containerWidth,
            height: containerHeight,
            decoration: decoration,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Level $level',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppShadows.levelName(level).toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    showTint ? 'With Surface Tint' : 'Shadows Only',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

// ==================== Story 3: Light vs Dark Mode Comparison ====================

@widgetbook.UseCase(name: 'Light vs Dark Mode', type: AppShadows)
Widget lightVsDarkMode(BuildContext context) {
  final level = context.knobs.object.dropdown(
    label: 'Elevation Level',
    options: [0, 1, 2, 3, 4, 5],
    initialOption: 3,
    labelBuilder: (value) => 'Level $value (${AppShadows.levelName(value)})',
  );

  final showTint = context.knobs.boolean(
    label: 'Show Surface Tint',
    initialValue: true,
  );

  final themeMode = context.knobs.object.dropdown(
    label: 'Component Theme',
    options: ['Light', 'Dark'],
    initialOption: 'Light',
  );

  return Theme(
    data: themeMode == 'Dark'
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true),
    child: Builder(
      builder: (context) {
        final decoration = showTint
            ? AppShadows.decorationWithTint(
                context: context,
                level: level,
                borderRadius: BorderRadius.circular(16),
              )
            : BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppShadows.forLevel(level),
              );

        return Center(
          child: Container(
            width: 280,
            height: 200,
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.layers,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$themeMode Mode',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Level $level - ${AppShadows.levelName(level)}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

// ==================== Story 4: Common Component Elevations ====================

@widgetbook.UseCase(name: 'Common Components', type: AppShadows)
Widget commonComponents(BuildContext context) {
  final componentType = context.knobs.object.dropdown(
    label: 'Component Type',
    options: ['Card', 'FAB', 'Dialog', 'Navigation Drawer'],
    initialOption: 'Card',
  );

  final themeMode = context.knobs.object.dropdown(
    label: 'Component Theme',
    options: ['Light', 'Dark'],
    initialOption: 'Light',
  );

  // Map component types to recommended elevation levels
  final levelMap = {'Card': 1, 'FAB': 3, 'Dialog': 5, 'Navigation Drawer': 4};

  final level = levelMap[componentType]!;

  return Theme(
    data: themeMode == 'Dark'
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true),
    child: Builder(
      builder: (context) {
        final decoration = AppShadows.decorationWithTint(
          context: context,
          level: level,
          borderRadius: BorderRadius.circular(componentType == 'FAB' ? 28 : 12),
        );

        Widget content;
        switch (componentType) {
          case 'Card':
            content = Container(
              width: 300,
              height: 150,
              decoration: decoration,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card Title',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cards use Level 1 elevation (sm)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
            break;

          case 'FAB':
            content = Container(
              width: 56,
              height: 56,
              decoration: decoration.copyWith(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            );
            break;

          case 'Dialog':
            content = Container(
              width: 280,
              height: 200,
              decoration: decoration,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dialog',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Dialogs use Level 5 elevation (xxl)',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
            break;

          case 'Navigation Drawer':
            content = Container(
              width: 300,
              height: 400,
              decoration: decoration,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Navigation',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Drawers use Level 4 elevation (xl)',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
            break;

          default:
            content = const SizedBox();
        }

        return Center(child: content);
      },
    ),
  );
}

// ==================== Story 5: Shadow Variations ====================

@widgetbook.UseCase(name: 'Shadow Variations', type: AppShadows)
Widget shadowVariations(BuildContext context) {
  final shadowType = context.knobs.object.dropdown(
    label: 'Shadow Type',
    options: ['none', 'sm', 'md', 'lg', 'xl', 'xxl'],
    initialOption: 'md',
  );

  final enableTint = context.knobs.boolean(
    label: 'Enable Surface Tint',
    initialValue: false,
  );

  final backgroundColor = context.knobs.colorOrNull(
    label: 'Background Color',
    initialValue: null,
  );

  final themeMode = context.knobs.object.dropdown(
    label: 'Component Theme',
    options: ['Light', 'Dark'],
    initialOption: 'Light',
  );

  // Map shadow type name to level
  final levelMap = {'none': 0, 'sm': 1, 'md': 2, 'lg': 3, 'xl': 4, 'xxl': 5};

  final level = levelMap[shadowType]!;

  return Theme(
    data: themeMode == 'Dark'
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true),
    child: Builder(
      builder: (context) {
        final decoration = enableTint
            ? AppShadows.decorationWithTint(
                context: context,
                level: level,
                backgroundColor: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              )
            : BoxDecoration(
                color: backgroundColor ?? Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppShadows.forLevel(level),
              );

        return Center(
          child: Container(
            width: 250,
            height: 180,
            decoration: decoration,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    shadowType.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Level $level Shadow',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

// ==================== Story 6: Surface Tint Demonstration ====================

@widgetbook.UseCase(name: 'Surface Tint', type: AppShadows)
Widget surfaceTintDemo(BuildContext context) {
  final level = context.knobs.object.dropdown(
    label: 'Elevation Level',
    options: [0, 1, 2, 3, 4, 5],
    initialOption: 3,
    labelBuilder: (value) => 'Level $value',
  );

  final themeMode = context.knobs.object.dropdown(
    label: 'Component Theme',
    options: ['Light', 'Dark'],
    initialOption: 'Light',
  );

  final showTintInfo = context.knobs.boolean(
    label: 'Show Tint Info',
    initialValue: true,
  );

  return Theme(
    data: themeMode == 'Dark'
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true),
    child: Builder(
      builder: (context) {
        final tintColor = AppShadows.getSurfaceTint(context, level);
        final isDark = Theme.of(context).brightness == Brightness.dark;

        // Calculate tint opacity percentage
        final tintOpacity = isDark
            ? switch (level) {
                1 => 8,
                2 => 10,
                3 => 12,
                4 => 14,
                5 => 16,
                _ => 0,
              }
            : switch (level) {
                1 => 5,
                2 => 6,
                3 => 8,
                4 => 10,
                5 => 12,
                _ => 0,
              };

        return Center(
          child: Container(
            width: 300,
            height: 250,
            decoration: AppShadows.decorationWithTint(
              context: context,
              level: level,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: tintColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Surface Tint',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (showTintInfo) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Level $level: $tintOpacity% Opacity',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$themeMode Mode',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}

// ==================== Story 7: Elevation Animation Demo ====================

@widgetbook.UseCase(name: 'Elevation Animation', type: AppShadows)
Widget elevationAnimation(BuildContext context) {
  final startLevel = context.knobs.object.dropdown(
    label: 'Start Level',
    options: [0, 1, 2, 3, 4, 5],
    initialOption: 1,
    labelBuilder: (value) => 'Level $value',
  );

  final endLevel = context.knobs.object.dropdown(
    label: 'End Level',
    options: [0, 1, 2, 3, 4, 5],
    initialOption: 3,
    labelBuilder: (value) => 'Level $value',
  );

  final animationSpeed = context.knobs.double
      .slider(
        label: 'Animation Speed (ms)',
        initialValue: 1000,
        min: 200,
        max: 3000,
      )
      .toInt();

  final themeMode = context.knobs.object.dropdown(
    label: 'Component Theme',
    options: ['Light', 'Dark'],
    initialOption: 'Light',
  );

  return Theme(
    data: themeMode == 'Dark'
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true),
    child: Builder(
      builder: (context) {
        return Center(
          child: _AnimatedElevationCard(
            startLevel: startLevel,
            endLevel: endLevel,
            duration: Duration(milliseconds: animationSpeed),
          ),
        );
      },
    ),
  );
}

class _AnimatedElevationCard extends StatefulWidget {
  const _AnimatedElevationCard({
    required this.startLevel,
    required this.endLevel,
    required this.duration,
  });

  final int startLevel;
  final int endLevel;
  final Duration duration;

  @override
  State<_AnimatedElevationCard> createState() => _AnimatedElevationCardState();
}

class _AnimatedElevationCardState extends State<_AnimatedElevationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(_AnimatedElevationCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final shadows = AppShadows.lerpLevel(
          widget.startLevel,
          widget.endLevel,
          _animation.value,
        );

        // Calculate current level for display
        final currentLevel =
            widget.startLevel +
            ((widget.endLevel - widget.startLevel) * _animation.value).round();

        return Container(
          width: 250,
          height: 180,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: shadows,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.animation,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Animating...',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.startLevel} → ${widget.endLevel}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Current: ~$currentLevel',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ==================== Story 8: Real-World Examples ====================

@widgetbook.UseCase(name: 'Real-World Examples', type: AppShadows)
Widget realWorldExamples(BuildContext context) {
  final exampleType = context.knobs.object.dropdown(
    label: 'Example Type',
    options: ['Hover Card', 'Bottom Sheet', 'Menu', 'App Bar (Scrolled)'],
    initialOption: 'Hover Card',
  );

  final isElevated = context.knobs.boolean(
    label: 'Is Elevated',
    initialValue: true,
  );

  final themeMode = context.knobs.object.dropdown(
    label: 'Component Theme',
    options: ['Light', 'Dark'],
    initialOption: 'Light',
  );

  return Theme(
    data: themeMode == 'Dark'
        ? ThemeData.dark(useMaterial3: true)
        : ThemeData.light(useMaterial3: true),
    child: Builder(
      builder: (context) {
        Widget example;

        switch (exampleType) {
          case 'Hover Card':
            final level = isElevated ? 2 : 1;
            example = Container(
              width: 300,
              height: 180,
              decoration: AppShadows.decorationWithTint(
                context: context,
                level: level,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.photo,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        isElevated ? 'Hovered' : 'Normal',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    'Card elevation changes on hover',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Level: $level (${AppShadows.levelName(level)})',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            );
            break;

          case 'Bottom Sheet':
            final level = isElevated ? 5 : 0;
            example = Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: AppShadows.decorationWithTint(
                  context: context,
                  level: level,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isElevated ? 'Modal Sheet' : 'Persistent Sheet',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Level: $level (${AppShadows.levelName(level)})',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
            break;

          case 'Menu':
            final level = isElevated ? 3 : 1;
            example = Container(
              width: 200,
              decoration: AppShadows.decorationWithTint(
                context: context,
                level: level,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MenuItem(label: 'Copy', icon: Icons.copy),
                  _MenuItem(label: 'Paste', icon: Icons.paste),
                  _MenuItem(label: 'Delete', icon: Icons.delete),
                ],
              ),
            );
            break;

          case 'App Bar (Scrolled)':
            final level = isElevated ? 2 : 0;
            example = Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: 64,
                decoration: AppShadows.decorationWithTint(
                  context: context,
                  level: level,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.menu,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      isElevated ? 'Scrolled' : 'Top',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Level $level',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
            break;

          default:
            example = const SizedBox();
        }

        return Center(child: example);
      },
    ),
  );
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
