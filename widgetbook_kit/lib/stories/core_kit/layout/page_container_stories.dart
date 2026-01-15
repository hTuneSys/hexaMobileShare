// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Widgetbook stories for [PageContainer] component.
///
/// A layout widget that wraps page content with consistent padding
/// and max-width constraints for better readability on large screens.

// ============================================================================
// Interactive Playground - MUST BE FIRST
// ============================================================================

@widgetbook.UseCase(name: 'Interactive Playground', type: PageContainer)
Widget pageContainerPlayground(BuildContext context) {
  final maxWidth = context.knobs.double.slider(
    label: 'Max Width',
    initialValue: 1200,
    min: 400,
    max: 1600,
  );
  final enableMaxWidth = context.knobs.boolean(
    label: 'Enable Max Width',
    initialValue: true,
  );
  final horizontalPadding = context.knobs.double.slider(
    label: 'Horizontal Padding',
    initialValue: 16,
    min: 0,
    max: 64,
  );
  final center = context.knobs.boolean(
    label: 'Center Content',
    initialValue: true,
  );
  final useSafeArea = context.knobs.boolean(
    label: 'Use SafeArea',
    initialValue: true,
  );
  final safeAreaTop = context.knobs.boolean(
    label: 'SafeArea Top',
    initialValue: true,
  );
  final safeAreaBottom = context.knobs.boolean(
    label: 'SafeArea Bottom',
    initialValue: true,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Interactive Playground')),
    body: PageContainer(
      maxWidth: enableMaxWidth ? maxWidth : null,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      center: center,
      useSafeArea: useSafeArea,
      safeAreaTop: safeAreaTop,
      safeAreaBottom: safeAreaBottom,
      child: AppCard(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'PageContainer Content',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This content is wrapped in a PageContainer with responsive '
              'padding and max-width constraints. Resize the window to see '
              'the responsive behavior.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Current max-width: ${enableMaxWidth ? '${maxWidth.toStringAsFixed(0)}dp' : 'None'}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 2: Default Container
// ============================================================================

@widgetbook.UseCase(name: 'Default Container', type: PageContainer)
Widget defaultContainer(BuildContext context) {
  final showMultipleCards = context.knobs.boolean(
    label: 'Show Multiple Cards',
    initialValue: false,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Default Container')),
    body: PageContainer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.md),
            AppCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Default PageContainer',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Uses default max-width (1200dp) and responsive padding. '
                    'Content is centered on wide screens.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            if (showMultipleCards) ...[
              const SizedBox(height: AppSpacing.md),
              AppCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(
                  'Additional content card',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              AppCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(
                  'Another content card',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 3: Responsive Behavior Demo
// ============================================================================

@widgetbook.UseCase(name: 'Responsive Behavior', type: PageContainer)
Widget responsiveBehavior(BuildContext context) {
  final showBreakpointInfo = context.knobs.boolean(
    label: 'Show Breakpoint Info',
    initialValue: true,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Responsive Behavior')),
    body: PageContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          String breakpoint;
          String padding;
          Color indicatorColor;

          if (width < 600) {
            breakpoint = 'Mobile';
            padding = '16dp';
            indicatorColor = Colors.green;
          } else if (width < 840) {
            breakpoint = 'Tablet';
            padding = '24dp';
            indicatorColor = Colors.orange;
          } else {
            breakpoint = 'Desktop';
            padding = '32dp';
            indicatorColor = Colors.blue;
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.md),
                if (showBreakpointInfo)
                  AppCard(
                    color: indicatorColor.withValues(alpha: 0.1),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: indicatorColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              'Current Breakpoint: $breakpoint',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: indicatorColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Screen Width: ${width.toStringAsFixed(0)}dp',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'Horizontal Padding: $padding',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: AppSpacing.md),
                AppCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Responsive Padding Demo',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Resize the window to see how padding changes at '
                        'different breakpoints:\n\n'
                        '• Mobile (< 600dp): 16dp padding\n'
                        '• Tablet (600-840dp): 24dp padding\n'
                        '• Desktop (> 840dp): 32dp padding',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          );
        },
      ),
    ),
  );
}

// ============================================================================
// Variant 4: Max-Width Demonstration
// ============================================================================

@widgetbook.UseCase(name: 'Max-Width Demonstration', type: PageContainer)
Widget maxWidthDemo(BuildContext context) {
  final maxWidth = context.knobs.double.slider(
    label: 'Max Width',
    initialValue: 800,
    min: 400,
    max: 1400,
  );
  final showWidthIndicator = context.knobs.boolean(
    label: 'Show Width Indicator',
    initialValue: true,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Max-Width Demo')),
    body: Stack(
      children: [
        PageContainer(
          maxWidth: maxWidth,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.md),
                AppCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Max-Width: ${maxWidth.toStringAsFixed(0)}dp',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Content is constrained to a maximum width and '
                        'centered on wide screens. This improves readability '
                        'by keeping line lengths optimal.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Sed do eiusmod tempor incididunt ut labore et dolore '
                    'magna aliqua. Ut enim ad minim veniam, quis nostrud '
                    'exercitation ullamco laboris.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ),
          ),
        ),
        if (showWidthIndicator)
          Positioned(
            bottom: AppSpacing.md,
            right: AppSpacing.md,
            child: AppCard(
              color: Theme.of(context).colorScheme.primaryContainer,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Text(
                'Max: ${maxWidth.toStringAsFixed(0)}dp',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

// ============================================================================
// Variant 5: Custom Padding
// ============================================================================

@widgetbook.UseCase(name: 'Custom Padding', type: PageContainer)
Widget customPadding(BuildContext context) {
  final horizontalPadding = context.knobs.double.slider(
    label: 'Horizontal Padding',
    initialValue: 24,
    min: 0,
    max: 64,
  );
  final verticalPadding = context.knobs.double.slider(
    label: 'Vertical Padding',
    initialValue: 16,
    min: 0,
    max: 64,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Custom Padding')),
    body: Container(
      // Background color to visualize the padding area
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: PageContainer(
        maxWidth: null, // Disable max-width to see padding effect clearly
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Custom Padding Override',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'When you provide custom padding, it overrides the '
                    'responsive padding behavior. The gray area around this '
                    'card shows the padding applied by PageContainer.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Current padding:\n'
                    '• Horizontal: ${horizontalPadding.toStringAsFixed(0)}dp\n'
                    '• Vertical: ${verticalPadding.toStringAsFixed(0)}dp',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text(
                'This second card also respects the same padding. '
                'Adjust the sliders to see how padding affects content positioning.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 6: Fluid Container (No Max-Width)
// ============================================================================

@widgetbook.UseCase(name: 'Fluid Container', type: PageContainer)
Widget fluidContainer(BuildContext context) {
  final showComparison = context.knobs.boolean(
    label: 'Show Side-by-Side Comparison',
    initialValue: true,
  );

  if (showComparison) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fluid vs Constrained')),
      body: Row(
        children: [
          // Fluid side
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: PageContainer.fluid(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    AppCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fluid',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            'No max-width, expands to fill space.',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(width: 1),
          // Constrained side
          Expanded(
            child: PageContainer.narrow(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.md),
                  AppCard(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Narrow',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Max-width 800dp, centered.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  return Scaffold(
    appBar: AppBar(title: const Text('Fluid Container')),
    body: PageContainer.fluid(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.md),
            AppCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fluid Container',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'PageContainer.fluid() creates a container without '
                    'max-width constraints. Content expands to fill the '
                    'available width with only responsive padding applied.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 7: Form Layout
// ============================================================================

@widgetbook.UseCase(name: 'Form Layout', type: PageContainer)
Widget formLayout(BuildContext context) {
  final useNarrowWidth = context.knobs.boolean(
    label: 'Use Narrow Width (800dp)',
    initialValue: true,
  );
  final useSafeArea = context.knobs.boolean(
    label: 'Use SafeArea',
    initialValue: true,
  );

  final container = useNarrowWidth
      ? PageContainer.narrow(
          useSafeArea: useSafeArea,
          child: _buildFormContent(context),
        )
      : PageContainer(
          useSafeArea: useSafeArea,
          child: _buildFormContent(context),
        );

  return Scaffold(
    appBar: AppBar(title: const Text('Form Layout')),
    body: container,
  );
}

Widget _buildFormContent(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.md),
        AppCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Account',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              const AppTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
              ),
              const SizedBox(height: AppSpacing.md),
              const AppTextField(
                label: 'Email',
                hint: 'Enter your email address',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.md),
              const AppTextField(
                label: 'Password',
                hint: 'Enter your password',
                obscureText: true,
              ),
              const SizedBox(height: AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                child: AppButton.filled(
                  label: 'Create Account',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    ),
  );
}

// ============================================================================
// Variant 8: Settings Screen
// ============================================================================

@widgetbook.UseCase(name: 'Settings Screen', type: PageContainer)
Widget settingsScreen(BuildContext context) {
  final centerContent = context.knobs.boolean(
    label: 'Center Content',
    initialValue: true,
  );
  final maxWidth = context.knobs.double.slider(
    label: 'Max Width',
    initialValue: 600,
    min: 400,
    max: 1000,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: PageContainer(
      maxWidth: maxWidth,
      center: centerContent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.md),
            _SettingsSection(
              title: 'Account',
              children: [
                _SettingsTile(
                  icon: Icons.person,
                  title: 'Profile',
                  subtitle: 'View and edit your profile',
                ),
                _SettingsTile(
                  icon: Icons.security,
                  title: 'Security',
                  subtitle: 'Password and authentication',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _SettingsSection(
              title: 'Preferences',
              children: [
                _SettingsTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: 'Manage notification settings',
                ),
                _SettingsTile(
                  icon: Icons.palette,
                  title: 'Appearance',
                  subtitle: 'Theme and display options',
                ),
                _SettingsTile(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: 'English',
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    ),
  );
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        AppCard(
          padding: EdgeInsets.zero,
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      leading: Icon(icon),
      title: title,
      subtitle: subtitle,
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
