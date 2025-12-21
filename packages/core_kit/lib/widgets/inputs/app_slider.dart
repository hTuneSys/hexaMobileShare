// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A Material Design 3 slider widget that provides consistent value selection
/// experience across the application.
///
/// The [AppSlider] component supports:
/// - Continuous value selection (smooth sliding)
/// - Discrete value selection (snap to divisions)
/// - Range selection (min/max with two thumbs)
/// - Optional value labels
/// - Custom label formatters
/// - Material Design 3 theming
/// - Accessibility features
///
/// ## Basic Usage (Continuous)
///
/// ```dart
/// double value = 50;
///
/// AppSlider(
///   value: value,
///   min: 0,
///   max: 100,
///   label: 'Volume',
///   onChanged: (newValue) {
///     setState(() {
///       value = newValue;
///     });
///   },
/// )
/// ```
///
/// ## Discrete Slider with Divisions
///
/// ```dart
/// double rating = 3;
///
/// AppSlider(
///   value: rating,
///   min: 0,
///   max: 5,
///   divisions: 5,
///   label: 'Rating',
///   showValueLabel: true,
///   onChanged: (value) {
///     setState(() {
///       rating = value;
///     });
///   },
/// )
/// ```
///
/// ## Range Slider
///
/// ```dart
/// RangeValues priceRange = RangeValues(100, 500);
///
/// AppSlider.range(
///   values: priceRange,
///   min: 0,
///   max: 1000,
///   label: 'Price Range',
///   onChanged: (RangeValues values) {
///     setState(() {
///       priceRange = values;
///     });
///   },
/// )
/// ```
///
/// ## Custom Label Formatter
///
/// ```dart
/// AppSlider(
///   value: price,
///   min: 0,
///   max: 1000,
///   label: 'Price',
///   showValueLabel: true,
///   labelFormatter: (value) => '\$${value.toStringAsFixed(0)}',
///   onChanged: (value) => setState(() => price = value),
/// )
/// ```
///
/// ## Material Design 3 Specifications
///
/// - Track height: 4dp default
/// - Thumb size: 20dp diameter (24dp when pressed)
/// - Track width: Full width minus padding
/// - Division markers: 2dp circles on track
/// - Value label: Pill shape above thumb
/// - Minimum touch target: 48x48dp
///
/// ## Accessibility
///
/// - Semantic labels from [label] property
/// - Keyboard navigation (arrow keys adjust value)
/// - Value announcements to screen readers
/// - Disabled state properly announced
/// - Minimum touch target size
///
/// See also:
/// - [Material Design 3 Slider](https://m3.material.io/components/sliders/overview)
/// - [Slider] - Flutter's base slider widget
/// - [RangeSlider] - Flutter's base range slider widget
class AppSlider extends StatelessWidget {
  /// Creates a continuous or discrete slider.
  ///
  /// The [value], [min], [max], and [onChanged] parameters must not be null
  /// unless the slider is disabled.
  const AppSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.onChangeEnd,
    this.label,
    this.showValueLabel = false,
    this.labelFormatter,
    this.divisions,
    this.showMinMaxIndicators = false,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.enabled = true,
  }) : values = null,
       onRangeChanged = null,
       onRangeChangeEnd = null,
       _isRange = false;

  /// Creates a range slider with two thumbs for min/max selection.
  ///
  /// The [values], [min], [max], and [onRangeChanged] parameters must not
  /// be null unless the slider is disabled.
  const AppSlider.range({
    super.key,
    required this.values,
    required this.min,
    required this.max,
    required this.onRangeChanged,
    this.onRangeChangeEnd,
    this.label,
    this.showValueLabel = false,
    this.labelFormatter,
    this.divisions,
    this.showMinMaxIndicators = false,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.enabled = true,
  }) : value = null,
       onChanged = null,
       onChangeEnd = null,
       _isRange = true;

  /// The current value of the slider (for single-value mode).
  ///
  /// Must be between [min] and [max].
  final double? value;

  /// The current values of the range slider (for range mode).
  ///
  /// Both start and end must be between [min] and [max].
  final RangeValues? values;

  /// The minimum value the slider can have.
  final double min;

  /// The maximum value the slider can have.
  final double max;

  /// Called when the user is selecting a new value by dragging (single value).
  ///
  /// The slider passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the slider with the new
  /// value.
  final ValueChanged<double>? onChanged;

  /// Called when the user is selecting new values by dragging (range mode).
  final ValueChanged<RangeValues>? onRangeChanged;

  /// Called when the user is done selecting a new value (single value).
  ///
  /// This callback is called when the user stops dragging the slider.
  final ValueChanged<double>? onChangeEnd;

  /// Called when the user is done selecting new values (range mode).
  final ValueChanged<RangeValues>? onRangeChangeEnd;

  /// Optional text label displayed above the slider.
  ///
  /// Provides context for what the slider controls.
  final String? label;

  /// Whether to show the current value label above the thumb.
  ///
  /// When true, a label with the current value appears above the thumb
  /// during interaction or always (depending on Material behavior).
  ///
  /// Defaults to false.
  final bool showValueLabel;

  /// Optional function to format the value label text.
  ///
  /// If null, the value is displayed as is with [toStringAsFixed(0)].
  /// Use this to add currency symbols, percentages, or custom formatting.
  ///
  /// Example:
  /// ```dart
  /// labelFormatter: (value) => '\$${value.toStringAsFixed(2)}'
  /// ```
  final String Function(double)? labelFormatter;

  /// The number of discrete divisions for the slider.
  ///
  /// If null, the slider is continuous. If not null, the slider snaps
  /// to the nearest division point.
  ///
  /// Must be greater than 0 if provided.
  final int? divisions;

  /// Whether to show min/max value indicators below the slider.
  ///
  /// Displays the [min] and [max] values at the ends of the slider track.
  ///
  /// Defaults to false.
  final bool showMinMaxIndicators;

  /// The color to use for the active portion of the slider track.
  ///
  /// If null, uses the theme's primary color.
  final Color? activeColor;

  /// The color to use for the inactive portion of the slider track.
  ///
  /// If null, uses the theme's surface variant color.
  final Color? inactiveColor;

  /// The color to use for the slider thumb.
  ///
  /// If null, uses the theme's primary color.
  final Color? thumbColor;

  /// Whether the slider is enabled for interaction.
  ///
  /// When false, the slider is displayed with reduced opacity and does not
  /// respond to touch.
  ///
  /// Defaults to true.
  final bool enabled;

  /// Internal flag to track if this is a range slider.
  final bool _isRange;

  /// Whether this slider is currently enabled.
  ///
  /// A slider is considered enabled if [enabled] is true and the appropriate
  /// callback ([onChanged] or [onRangeChanged]) is not null.
  bool get _isEnabled =>
      enabled && (_isRange ? onRangeChanged != null : onChanged != null);

  /// Formats a value for display using the custom formatter or default.
  String _formatValue(double val) {
    if (labelFormatter != null) {
      return labelFormatter!(val);
    }
    return val.toStringAsFixed(divisions != null ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: _isEnabled
                  ? colorScheme.onSurface
                  : colorScheme.onSurface.withValues(alpha: 0.38),
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Slider
        if (_isRange)
          _buildRangeSlider(context, theme, colorScheme)
        else
          _buildSlider(context, theme, colorScheme),

        // Min/Max Indicators
        if (showMinMaxIndicators) ...[
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatValue(min),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _isEnabled
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onSurfaceVariant.withValues(alpha: 0.38),
                ),
              ),
              Text(
                _formatValue(max),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _isEnabled
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onSurfaceVariant.withValues(alpha: 0.38),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// Builds the single-value slider widget.
  Widget _buildSlider(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 4.0,
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
          valueIndicatorShape: const _ForceValueIndicatorShape(),
        ),
        child: Slider(
          value: value ?? min,
          min: min,
          max: max,
          divisions: divisions,
          label: showValueLabel ? _formatValue(value ?? min) : null,
          onChanged: _isEnabled ? onChanged : null,
          onChangeEnd: onChangeEnd,
          activeColor: activeColor ?? colorScheme.primary,
          inactiveColor: inactiveColor ?? colorScheme.surfaceContainerHighest,
          thumbColor: thumbColor ?? colorScheme.primary,
        ),
      ),
    );
  }

  /// Builds the range slider widget.
  Widget _buildRangeSlider(
    BuildContext context,
    ThemeData theme,
    ColorScheme colorScheme,
  ) {
    final rangeValues = values ?? RangeValues(min, max);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          trackHeight: 4.0,
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 24.0),
          rangeValueIndicatorShape: const _ForceRangeValueIndicatorShape(),
        ),
        child: RangeSlider(
          values: rangeValues,
          min: min,
          max: max,
          divisions: divisions,
          labels: showValueLabel
              ? RangeLabels(
                  _formatValue(rangeValues.start),
                  _formatValue(rangeValues.end),
                )
              : null,
          onChanged: _isEnabled ? onRangeChanged : null,
          onChangeEnd: onRangeChangeEnd,
          activeColor: activeColor ?? colorScheme.primary,
          inactiveColor: inactiveColor ?? colorScheme.surfaceContainerHighest,
        ),
      ),
    );
  }
}

/// A custom value indicator shape that forces the label to follow the thumb
/// without being clamped by screen boundaries.
class _ForceValueIndicatorShape extends SliderComponentShape {
  const _ForceValueIndicatorShape();

  @override
  Size getPreferredSize(
    bool isEnabled,
    bool isDiscrete, {
    TextPainter? labelPainter,
  }) {
    if (labelPainter != null) {
      labelPainter.layout();
      return Size(labelPainter.width + 24, 48);
    }
    return const Size(48, 48);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final double scale = activationAnimation.value;
    if (scale == 0.0) return;

    // Shift vertically to be above the thumb
    // Standard Material 3 spacing
    final Offset labelCenter = center - const Offset(0, 44);

    canvas.save();
    canvas.translate(labelCenter.dx, labelCenter.dy);
    canvas.scale(scale, scale);

    final Paint paint = Paint()..color = sliderTheme.valueIndicatorColor!;

    // Calculate dynamic width based on text
    labelPainter.layout();
    final double textWidth = labelPainter.width;
    final double bubbleWidth = textWidth + 24.0; // 12px padding on each side
    final double bubbleHeight = 32.0;

    // Draw bubble shape (inverted tear drop)
    final Path path = Path();

    // Main bubble body
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset.zero,
          width: bubbleWidth,
          height: bubbleHeight,
        ),
        const Radius.circular(16),
      ),
    );

    // Little triangle pointing down
    path.moveTo(-6, bubbleHeight / 2);
    path.lineTo(0, (bubbleHeight / 2) + 6);
    path.lineTo(6, bubbleHeight / 2);
    path.close();

    canvas.drawPath(path, paint);

    // Draw text
    labelPainter.paint(
      canvas,
      Offset(-textWidth / 2, -labelPainter.height / 2),
    );

    canvas.restore();
  }
}

/// A custom value indicator shape for RangeSlider that forces the label to follow,
/// matching the single slider implementation.
class _ForceRangeValueIndicatorShape extends RangeSliderValueIndicatorShape {
  const _ForceRangeValueIndicatorShape();

  @override
  Size getPreferredSize(
    bool isEnabled,
    bool isDiscrete, {
    required TextPainter labelPainter,
    required double textScaleFactor,
  }) {
    labelPainter.layout();
    return Size(labelPainter.width + 24, 48);
  }

  @override
  double getHorizontalShift({
    RenderBox? parentBox,
    Offset? center,
    TextPainter? labelPainter,
    Animation<double>? activationAnimation,
    double? scale,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    // Return 0 to prevent any automatic horizontal shifting/clamping
    return 0;
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isOnTop = false,
    required TextPainter labelPainter,
    double value = 0.0,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    TextDirection textDirection = TextDirection.ltr,
    Thumb thumb = Thumb.start,
    bool? isPressed,
    Size? sizeWithOverflow,
    double? textScaleFactor,
  }) {
    final Canvas canvas = context.canvas;
    final double scale = activationAnimation.value;
    if (scale == 0.0) return;

    final Offset labelCenter = center - const Offset(0, 44);

    canvas.save();
    canvas.translate(labelCenter.dx, labelCenter.dy);
    canvas.scale(scale, scale);

    final Paint paint = Paint()..color = sliderTheme.valueIndicatorColor!;

    // Calculate dynamic width
    labelPainter.layout();
    final double textWidth = labelPainter.width;
    final double bubbleWidth = textWidth + 24.0;
    final double bubbleHeight = 32.0;

    final Path path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset.zero,
          width: bubbleWidth,
          height: bubbleHeight,
        ),
        const Radius.circular(16),
      ),
    );
    path.moveTo(-6, bubbleHeight / 2);
    path.lineTo(0, (bubbleHeight / 2) + 6);
    path.lineTo(6, bubbleHeight / 2);
    path.close();

    canvas.drawPath(path, paint);

    labelPainter.paint(
      canvas,
      Offset(-textWidth / 2, -labelPainter.height / 2),
    );

    canvas.restore();
  }
}
