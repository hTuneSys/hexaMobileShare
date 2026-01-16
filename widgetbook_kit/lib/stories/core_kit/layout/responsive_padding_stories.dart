// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [ResponsivePadding] layout widget.
///
/// A layout widget that automatically adjusts padding based on screen size
/// breakpoints (mobile, tablet, desktop).

/// Interactive Playground - explore all ResponsivePadding properties with knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: ResponsivePadding)
Widget responsivePaddingPlayground(BuildContext context) {
  final paddingType = context.knobs.object.dropdown(
    label: 'Padding Type',
    options: const ['all', 'symmetric', 'horizontal', 'vertical', 'custom'],
    labelBuilder: (value) => value,
  );

  final mobilePadding = context.knobs.double.slider(
    label: 'Mobile Padding',
    initialValue: AppSpacing.sm,
    min: 0,
    max: 48,
  );

  final tabletPadding = context.knobs.double.slider(
    label: 'Tablet Padding',
    initialValue: AppSpacing.md,
    min: 0,
    max: 64,
  );

  final desktopPadding = context.knobs.double.slider(
    label: 'Desktop Padding',
    initialValue: AppSpacing.lg,
    min: 0,
    max: 96,
  );

  final mobileBreakpoint = context.knobs.double.slider(
    label: 'Mobile Breakpoint',
    initialValue: 600,
    min: 300,
    max: 800,
  );

  final tabletBreakpoint = context.knobs.double.slider(
    label: 'Tablet Breakpoint',
    initialValue: 1024,
    min: 600,
    max: 1400,
  );

  final showBreakpointInfo = context.knobs.boolean(
    label: 'Show Breakpoint Info',
    initialValue: true,
  );

  Widget buildContent(BuildContext ctx) {
    final width = MediaQuery.sizeOf(ctx).width;
    String deviceType;
    if (width < mobileBreakpoint) {
      deviceType = 'Mobile';
    } else if (width < tabletBreakpoint) {
      deviceType = 'Tablet';
    } else {
      deviceType = 'Desktop';
    }

    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Responsive Content',
            style: Theme.of(ctx).textTheme.titleMedium,
          ),
          if (showBreakpointInfo) ...[
            const Gap.sm(),
            Text('Width: ${width.toStringAsFixed(0)}dp'),
            Text('Device: $deviceType'),
            Text('Padding Type: $paddingType'),
          ],
        ],
      ),
    );
  }

  Widget child = Builder(builder: buildContent);

  switch (paddingType) {
    case 'all':
      return ResponsivePadding.all(
        mobile: mobilePadding,
        tablet: tabletPadding,
        desktop: desktopPadding,
        mobileBreakpoint: mobileBreakpoint,
        tabletBreakpoint: tabletBreakpoint,
        child: child,
      );
    case 'symmetric':
      return ResponsivePadding.symmetric(
        mobileHorizontal: mobilePadding,
        mobileVertical: mobilePadding / 2,
        tabletHorizontal: tabletPadding,
        tabletVertical: tabletPadding / 2,
        desktopHorizontal: desktopPadding,
        desktopVertical: desktopPadding / 2,
        mobileBreakpoint: mobileBreakpoint,
        tabletBreakpoint: tabletBreakpoint,
        child: child,
      );
    case 'horizontal':
      return ResponsivePadding.horizontal(
        mobile: mobilePadding,
        tablet: tabletPadding,
        desktop: desktopPadding,
        mobileBreakpoint: mobileBreakpoint,
        tabletBreakpoint: tabletBreakpoint,
        child: child,
      );
    case 'vertical':
      return ResponsivePadding.vertical(
        mobile: mobilePadding,
        tablet: tabletPadding,
        desktop: desktopPadding,
        mobileBreakpoint: mobileBreakpoint,
        tabletBreakpoint: tabletBreakpoint,
        child: child,
      );
    default:
      return ResponsivePadding(
        mobilePadding: EdgeInsets.all(mobilePadding),
        tabletPadding: EdgeInsets.all(tabletPadding),
        desktopPadding: EdgeInsets.all(desktopPadding),
        mobileBreakpoint: mobileBreakpoint,
        tabletBreakpoint: tabletBreakpoint,
        child: child,
      );
  }
}

/// Default - Basic usage with default breakpoints
@widgetbook.UseCase(name: 'Default', type: ResponsivePadding)
Widget responsivePaddingDefault(BuildContext context) {
  final mobilePadding = context.knobs.double.slider(
    label: 'Mobile Padding',
    initialValue: AppSpacing.sm,
    min: 0,
    max: 32,
  );

  final tabletPadding = context.knobs.double.slider(
    label: 'Tablet Padding',
    initialValue: AppSpacing.md,
    min: 0,
    max: 48,
  );

  final desktopPadding = context.knobs.double.slider(
    label: 'Desktop Padding',
    initialValue: AppSpacing.lg,
    min: 0,
    max: 64,
  );

  return ResponsivePadding.all(
    mobile: mobilePadding,
    tablet: tabletPadding,
    desktop: desktopPadding,
    child: Builder(
      builder: (ctx) {
        final width = MediaQuery.sizeOf(ctx).width;
        String deviceType;
        double currentPadding;

        if (width < ResponsiveBreakpoints.mobile) {
          deviceType = 'Mobile';
          currentPadding = mobilePadding;
        } else if (width < ResponsiveBreakpoints.tablet) {
          deviceType = 'Tablet';
          currentPadding = tabletPadding;
        } else {
          deviceType = 'Desktop';
          currentPadding = desktopPadding;
        }

        return AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Content with responsive padding',
                style: Theme.of(ctx).textTheme.bodyLarge,
              ),
              const Gap.sm(),
              Text(
                'Device: $deviceType | Padding: ${currentPadding.toStringAsFixed(0)}dp',
                style: Theme.of(ctx).textTheme.bodySmall,
              ),
            ],
          ),
        );
      },
    ),
  );
}

/// Breakpoint Demo - Shows current breakpoint and applied padding
@widgetbook.UseCase(name: 'Breakpoint Demo', type: ResponsivePadding)
Widget responsivePaddingBreakpointDemo(BuildContext context) {
  final mobilePadding = context.knobs.double.slider(
    label: 'Mobile Padding',
    initialValue: 8,
    min: 0,
    max: 32,
  );

  final tabletPadding = context.knobs.double.slider(
    label: 'Tablet Padding',
    initialValue: 16,
    min: 0,
    max: 48,
  );

  final desktopPadding = context.knobs.double.slider(
    label: 'Desktop Padding',
    initialValue: 24,
    min: 0,
    max: 64,
  );

  return ResponsivePadding.all(
    mobile: mobilePadding,
    tablet: tabletPadding,
    desktop: desktopPadding,
    child: Builder(
      builder: (ctx) {
        final width = MediaQuery.sizeOf(ctx).width;
        String deviceType;
        double currentPadding;

        if (width < ResponsiveBreakpoints.mobile) {
          deviceType = 'MOBILE';
          currentPadding = mobilePadding;
        } else if (width < ResponsiveBreakpoints.tablet) {
          deviceType = 'TABLET';
          currentPadding = tabletPadding;
        } else {
          deviceType = 'DESKTOP';
          currentPadding = desktopPadding;
        }

        return AppCard.outlined(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                deviceType == 'MOBILE'
                    ? Icons.phone_android
                    : deviceType == 'TABLET'
                    ? Icons.tablet_android
                    : Icons.desktop_windows,
                size: 48,
                color: Theme.of(ctx).colorScheme.primary,
              ),
              const Gap.md(),
              Text(
                deviceType,
                style: Theme.of(ctx).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap.sm(),
              Text(
                'Width: ${width.toStringAsFixed(0)}dp',
                style: Theme.of(ctx).textTheme.bodyMedium,
              ),
              Text(
                'Padding: ${currentPadding.toStringAsFixed(0)}dp',
                style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(ctx).colorScheme.secondary,
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

/// All Padding Types - Demonstrates all, symmetric, horizontal, vertical
@widgetbook.UseCase(name: 'All Padding Types', type: ResponsivePadding)
Widget responsivePaddingAllTypes(BuildContext context) {
  final paddingType = context.knobs.object.dropdown(
    label: 'Padding Type',
    options: const ['All', 'Symmetric', 'Horizontal', 'Vertical'],
    labelBuilder: (value) => value,
  );

  final paddingValue = context.knobs.double.slider(
    label: 'Padding Value',
    initialValue: 16,
    min: 0,
    max: 48,
  );

  Widget content = AppCard(
    child: Text(
      'Padding Type: $paddingType\nValue: ${paddingValue.toStringAsFixed(0)}dp',
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  );

  switch (paddingType) {
    case 'All':
      return ResponsivePadding.all(
        mobile: paddingValue,
        tablet: paddingValue,
        desktop: paddingValue,
        child: content,
      );
    case 'Symmetric':
      return ResponsivePadding.symmetric(
        mobileHorizontal: paddingValue,
        mobileVertical: paddingValue / 2,
        tabletHorizontal: paddingValue,
        tabletVertical: paddingValue / 2,
        desktopHorizontal: paddingValue,
        desktopVertical: paddingValue / 2,
        child: content,
      );
    case 'Horizontal':
      return ResponsivePadding.horizontal(
        mobile: paddingValue,
        tablet: paddingValue,
        desktop: paddingValue,
        child: content,
      );
    case 'Vertical':
      return ResponsivePadding.vertical(
        mobile: paddingValue,
        tablet: paddingValue,
        desktop: paddingValue,
        child: content,
      );
    default:
      return ResponsivePadding.all(
        mobile: paddingValue,
        tablet: paddingValue,
        desktop: paddingValue,
        child: content,
      );
  }
}

/// Custom Breakpoints - Custom mobile/tablet threshold values
@widgetbook.UseCase(name: 'Custom Breakpoints', type: ResponsivePadding)
Widget responsivePaddingCustomBreakpoints(BuildContext context) {
  final mobileBreakpoint = context.knobs.double.slider(
    label: 'Mobile Breakpoint',
    initialValue: 480,
    min: 300,
    max: 800,
  );

  final tabletBreakpoint = context.knobs.double.slider(
    label: 'Tablet Breakpoint',
    initialValue: 900,
    min: 600,
    max: 1400,
  );

  final mobilePadding = context.knobs.double.slider(
    label: 'Mobile Padding',
    initialValue: AppSpacing.xs,
    min: 0,
    max: 32,
  );

  final tabletPadding = context.knobs.double.slider(
    label: 'Tablet Padding',
    initialValue: AppSpacing.md,
    min: 0,
    max: 48,
  );

  final desktopPadding = context.knobs.double.slider(
    label: 'Desktop Padding',
    initialValue: AppSpacing.xl,
    min: 0,
    max: 64,
  );

  return ResponsivePadding.all(
    mobile: mobilePadding,
    tablet: tabletPadding,
    desktop: desktopPadding,
    mobileBreakpoint: mobileBreakpoint,
    tabletBreakpoint: tabletBreakpoint,
    child: Builder(
      builder: (ctx) {
        final width = MediaQuery.sizeOf(ctx).width;
        String deviceType;
        double currentPadding;

        if (width < mobileBreakpoint) {
          deviceType = 'Mobile (< ${mobileBreakpoint.toInt()}dp)';
          currentPadding = mobilePadding;
        } else if (width < tabletBreakpoint) {
          deviceType = 'Tablet (< ${tabletBreakpoint.toInt()}dp)';
          currentPadding = tabletPadding;
        } else {
          deviceType = 'Desktop (>= ${tabletBreakpoint.toInt()}dp)';
          currentPadding = desktopPadding;
        }

        return AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Custom Breakpoints',
                style: Theme.of(ctx).textTheme.titleMedium,
              ),
              const Gap.sm(),
              Text('Current Width: ${width.toStringAsFixed(0)}dp'),
              Text(deviceType),
              Text('Padding: ${currentPadding.toStringAsFixed(0)}dp'),
            ],
          ),
        );
      },
    ),
  );
}

/// Page Edge Padding - Real-world page edge padding example
@widgetbook.UseCase(name: 'Page Edge Padding', type: ResponsivePadding)
Widget responsivePaddingPageEdge(BuildContext context) {
  final useLargePadding = context.knobs.boolean(
    label: 'Use Large Padding',
    initialValue: false,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Page Edge Padding')),
    body: ResponsivePadding.horizontal(
      mobile: useLargePadding ? AppSpacing.md : AppSpacing.sm,
      tablet: useLargePadding ? AppSpacing.xl : AppSpacing.lg,
      desktop: useLargePadding ? AppSpacing.xxxl : AppSpacing.xl,
      child: ListView(
        children: [
          const Gap.md(),
          AppCard(
            child: Text(
              'Page Content',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Gap.md(),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'This content has responsive horizontal padding.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Gap.sm(),
                Text(
                  'Resize the window to see the padding adjust.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// Card Content Padding - Card content padding real-world example
@widgetbook.UseCase(name: 'Card Content Padding', type: ResponsivePadding)
Widget responsivePaddingCardContent(BuildContext context) {
  final showBorder = context.knobs.boolean(
    label: 'Show Border',
    initialValue: true,
  );

  return Center(
    child: Container(
      decoration: showBorder
          ? BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            )
          : null,
      child: ResponsivePadding.all(
        mobile: AppSpacing.sm,
        tablet: AppSpacing.md,
        desktop: AppSpacing.lg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Card Title', style: Theme.of(context).textTheme.titleLarge),
            const Gap.sm(),
            Text(
              'This card has responsive padding that adjusts based on screen '
              'size. On mobile, the padding is smaller to maximize content '
              'area. On desktop, larger padding provides visual breathing room.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Gap.md(),
            AppButton.filled(label: 'Action', onPressed: () {}),
          ],
        ),
      ),
    ),
  );
}

/// Responsive Form - Form with responsive spacing
@widgetbook.UseCase(name: 'Responsive Form', type: ResponsivePadding)
Widget responsivePaddingForm(BuildContext context) {
  final useVerticalPadding = context.knobs.boolean(
    label: 'Use Vertical Padding',
    initialValue: true,
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Responsive Form')),
    body: ResponsivePadding.symmetric(
      mobileHorizontal: AppSpacing.md,
      mobileVertical: useVerticalPadding ? AppSpacing.sm : 0,
      tabletHorizontal: AppSpacing.xl,
      tabletVertical: useVerticalPadding ? AppSpacing.md : 0,
      desktopHorizontal: AppSpacing.xxxl,
      desktopVertical: useVerticalPadding ? AppSpacing.lg : 0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap.lg(),
            Text(
              'Create Account',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap.lg(),
            const AppTextField(
              label: 'Full Name',
              hint: 'Enter your full name',
            ),
            const Gap.md(),
            const AppTextField(label: 'Email', hint: 'Enter your email'),
            const Gap.md(),
            const AppPasswordField(
              label: 'Password',
              hint: 'Enter your password',
            ),
            const Gap.lg(),
            AppButton.filled(
              label: 'Create Account',
              fullWidth: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
