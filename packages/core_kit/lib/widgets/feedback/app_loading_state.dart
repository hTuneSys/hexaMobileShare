// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Defines the visual variant of the loading indicator.
enum LoadingVariant {
  /// Circular progress indicator (indeterminate).
  circular,

  /// Linear progress bar (determinate with progress value).
  linear,

  /// Skeleton screen with shimmer animation.
  skeleton,

  /// Full-screen or local overlay with loading indicator.
  overlay,

  /// Small inline loading indicator for buttons/widgets.
  inline,
}

/// Defines the size of the loading indicator.
enum LoadingSize {
  /// Small size (16dp diameter for circular).
  small,

  /// Medium size (24dp diameter for circular).
  medium,

  /// Large size (48dp diameter for circular).
  large,
}

/// A widget that displays loading states with various visual indicators.
///
/// Provides visual feedback during async operations with spinners, progress
/// bars, and skeleton screens following Material Design 3 guidelines.
///
/// Example usage:
/// ```dart
/// // Circular spinner
/// AppLoadingState(
///   variant: LoadingVariant.circular,
///   size: LoadingSize.medium,
/// )
///
/// // Linear progress bar
/// AppLoadingState(
///   variant: LoadingVariant.linear,
///   progress: 0.65,
///   showPercentage: true,
/// )
///
/// // Loading overlay
/// AppLoadingState(
///   variant: LoadingVariant.overlay,
///   message: 'Loading data...',
/// )
/// ```
class AppLoadingState extends StatelessWidget {
  /// Creates an AppLoadingState widget.
  const AppLoadingState({
    this.variant = LoadingVariant.circular,
    this.size = LoadingSize.medium,
    this.progress,
    this.message,
    this.showPercentage = false,
    this.onCancel,
    this.color,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.overlayColor,
    this.semanticLabel,
    super.key,
  });

  /// The visual variant of the loading indicator.
  ///
  /// Defaults to [LoadingVariant.circular].
  final LoadingVariant variant;

  /// The size of the loading indicator.
  ///
  /// Only applies to [LoadingVariant.circular] and [LoadingVariant.inline].
  /// Defaults to [LoadingSize.medium].
  final LoadingSize size;

  /// The progress value for determinate loading (0.0 to 1.0).
  ///
  /// Only applies to [LoadingVariant.linear].
  /// If null, shows indeterminate progress.
  final double? progress;

  /// Optional loading message to display.
  ///
  /// Displayed below the loading indicator.
  final String? message;

  /// Whether to show progress percentage.
  ///
  /// Only applies when [progress] is not null.
  /// Defaults to false.
  final bool showPercentage;

  /// Callback when cancel button is pressed.
  ///
  /// If provided, a cancel button will be shown.
  final VoidCallback? onCancel;

  /// Custom color for the loading indicator.
  ///
  /// If null, uses [ColorScheme.primary].
  final Color? color;

  /// Base color for skeleton shimmer effect.
  ///
  /// If null, uses [ColorScheme.surfaceContainerHighest].
  final Color? shimmerBaseColor;

  /// Highlight color for skeleton shimmer effect.
  ///
  /// If null, uses [ColorScheme.surface].
  final Color? shimmerHighlightColor;

  /// Background color for overlay variant.
  ///
  /// If null, uses [ColorScheme.surface] with 80% opacity.
  final Color? overlayColor;

  /// Accessibility label for screen readers.
  ///
  /// If null, a default label will be generated based on the variant.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case LoadingVariant.circular:
        return _buildCircular(context);
      case LoadingVariant.linear:
        return _buildLinear(context);
      case LoadingVariant.skeleton:
        return _buildSkeleton(context);
      case LoadingVariant.overlay:
        return _buildOverlay(context);
      case LoadingVariant.inline:
        return _buildInline(context);
    }
  }

  Widget _buildCircular(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final indicatorColor = color ?? colorScheme.primary;
    final diameter = _getDiameter();
    final strokeWidth = _getStrokeWidth();

    return Semantics(
      label: semanticLabel ?? 'Loading',
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: diameter,
              height: diameter,
              child: CircularProgressIndicator(
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (onCancel != null) ...[
              const SizedBox(height: 16),
              OutlinedButton(onPressed: onCancel, child: const Text('Cancel')),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLinear(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final indicatorColor = color ?? colorScheme.primary;
    final trackColor = colorScheme.surfaceContainerHighest;

    return Semantics(
      label: semanticLabel ?? 'Loading progress',
      value: progress != null ? '${(progress! * 100).toInt()}%' : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 4,
            child: LinearProgressIndicator(
              value: progress,
              valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
              backgroundColor: trackColor,
            ),
          ),
          if (showPercentage && progress != null) ...[
            const SizedBox(height: 8),
            Text(
              '${(progress! * 100).toInt()}%',
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ],
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(
              message!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSkeleton(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final baseColor = shimmerBaseColor ?? colorScheme.surfaceContainerHighest;
    final highlightColor = shimmerHighlightColor ?? colorScheme.surface;

    return Semantics(
      label: semanticLabel ?? 'Loading content',
      child: _ShimmerEffect(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 200,
              height: 16,
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlay(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor =
        overlayColor ?? colorScheme.surface.withValues(alpha: 0.8);
    final indicatorColor = color ?? colorScheme.primary;

    return Semantics(
      label: semanticLabel ?? 'Loading overlay',
      child: Container(
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInline(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final indicatorColor = color ?? colorScheme.primary;

    return Semantics(
      label: semanticLabel ?? 'Loading',
      child: SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
        ),
      ),
    );
  }

  double _getDiameter() {
    switch (size) {
      case LoadingSize.small:
        return 16;
      case LoadingSize.medium:
        return 24;
      case LoadingSize.large:
        return 48;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case LoadingSize.small:
        return 2;
      case LoadingSize.medium:
        return 3;
      case LoadingSize.large:
        return 4;
    }
  }
}

/// A widget that applies a shimmer animation effect to its child.
class _ShimmerEffect extends StatefulWidget {
  const _ShimmerEffect({
    required this.child,
    required this.baseColor,
    required this.highlightColor,
  });

  final Widget child;
  final Color baseColor;
  final Color highlightColor;

  @override
  State<_ShimmerEffect> createState() => _ShimmerEffectState();
}

class _ShimmerEffectState extends State<_ShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
