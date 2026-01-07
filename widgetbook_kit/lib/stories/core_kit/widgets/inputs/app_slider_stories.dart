// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppSlider] component.
///
/// A Material Design 3 slider widget that provides consistent value selection
/// with support for continuous, discrete, and range modes.

/// Interactive Playground - explore all AppSlider properties with knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppSlider)
Widget appSliderPlayground(BuildContext context) {
  final mode = context.knobs.object.dropdown(
    label: 'Mode',
    options: const ['single', 'range'],
    labelBuilder: (value) => value,
  );

  final value = context.knobs.double.slider(
    label: 'Value',
    initialValue: 50,
    min: 0,
    max: 100,
  );

  final min = context.knobs.double.slider(
    label: 'Min',
    initialValue: 0,
    min: 0,
    max: 50,
  );

  final max = context.knobs.double.slider(
    label: 'Max',
    initialValue: 100,
    min: 50,
    max: 200,
  );

  final hasDivisions = context.knobs.boolean(
    label: 'Has Divisions',
    initialValue: false,
  );
  final divisions = hasDivisions
      ? context.knobs.int.slider(
          label: 'Divisions',
          initialValue: 10,
          min: 2,
          max: 20,
        )
      : null;

  final hasLabel = context.knobs.boolean(
    label: 'Has Label',
    initialValue: true,
  );
  final label = hasLabel
      ? context.knobs.string(label: 'Label Text', initialValue: 'Slider label')
      : null;

  final showValueLabel = context.knobs.boolean(
    label: 'Show Value Label',
    initialValue: false,
  );
  final showMinMaxIndicators = context.knobs.boolean(
    label: 'Show Min/Max Indicators',
    initialValue: false,
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  final hasCustomColors = context.knobs.boolean(
    label: 'Has Custom Colors',
    initialValue: false,
  );
  final activeColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Active Color',
          initialValue: Colors.green,
        )
      : null;

  final inactiveColor = hasCustomColors
      ? context.knobs.colorOrNull(label: 'Inactive Color')
      : null;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: mode == 'range'
          ? AppSlider.range(
              values: RangeValues(min + 20, max - 20),
              min: min,
              max: max,
              label: label,
              divisions: divisions,
              showValueLabel: showValueLabel,
              showMinMaxIndicators: showMinMaxIndicators,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              enabled: enabled,
              onRangeChanged: enabled ? (_) {} : null,
            )
          : AppSlider(
              value: value,
              min: min,
              max: max,
              label: label,
              divisions: divisions,
              showValueLabel: showValueLabel,
              showMinMaxIndicators: showMinMaxIndicators,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              enabled: enabled,
              onChanged: enabled ? (_) {} : null,
            ),
    ),
  );
}

/// Default - Basic continuous slider
@widgetbook.UseCase(name: 'Default', type: AppSlider)
Widget appSliderDefault(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSlider(
        value: 50,
        min: 0,
        max: 100,
        label: 'Volume',
        onChanged: (_) {},
      ),
    ),
  );
}

/// Discrete - Slider with divisions
@widgetbook.UseCase(name: 'Discrete', type: AppSlider)
Widget appSliderDiscrete(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSlider(
        value: 3,
        min: 0,
        max: 5,
        divisions: 5,
        label: 'Rating',
        showValueLabel: true,
        showMinMaxIndicators: true,
        onChanged: (_) {},
      ),
    ),
  );
}

/// Range - Range slider with two thumbs
@widgetbook.UseCase(name: 'Range', type: AppSlider)
Widget appSliderRange(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSlider.range(
        values: const RangeValues(100, 500),
        min: 0,
        max: 1000,
        divisions: 20,
        label: 'Price Range',
        showValueLabel: true,
        showMinMaxIndicators: true,
        labelFormatter: (value) => '\$${value.toInt()}',
        onRangeChanged: (_) {},
      ),
    ),
  );
}

/// With Value Label - Shows value during interaction
@widgetbook.UseCase(name: 'With Value Label', type: AppSlider)
Widget appSliderWithValueLabel(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSlider(
        value: 75,
        min: 0,
        max: 100,
        label: 'Brightness',
        showValueLabel: true,
        labelFormatter: (value) => '${value.toInt()}%',
        onChanged: (_) {},
      ),
    ),
  );
}

/// With Min/Max Indicators - Shows boundary values
@widgetbook.UseCase(name: 'With Min/Max Indicators', type: AppSlider)
Widget appSliderWithMinMaxIndicators(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSlider(
        value: 20,
        min: -10,
        max: 40,
        label: 'Temperature',
        showMinMaxIndicators: true,
        labelFormatter: (value) => '${value.toInt()}°C',
        onChanged: (_) {},
      ),
    ),
  );
}

/// Custom Formatter - Currency and percentage formatting
@widgetbook.UseCase(name: 'Custom Formatter', type: AppSlider)
Widget appSliderCustomFormatter(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSlider(
        value: 499.99,
        min: 0,
        max: 1000,
        label: 'Price',
        showValueLabel: true,
        showMinMaxIndicators: true,
        labelFormatter: (value) => '\$${value.toStringAsFixed(2)}',
        onChanged: (_) {},
      ),
    ),
  );
}

/// Disabled - Non-interactive state
@widgetbook.UseCase(name: 'Disabled', type: AppSlider)
Widget appSliderDisabled(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSlider(
        value: 50,
        min: 0,
        max: 100,
        label: 'Disabled slider',
        showMinMaxIndicators: true,
        onChanged: null,
      ),
    ),
  );
}

/// Custom Colors - Slider with custom colors
@widgetbook.UseCase(name: 'Custom Colors', type: AppSlider)
Widget appSliderCustomColors(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSlider(
        value: 60,
        min: 0,
        max: 100,
        label: 'Custom green slider',
        activeColor: Colors.green,
        thumbColor: Colors.green,
        showMinMaxIndicators: true,
        onChanged: (_) {},
      ),
    ),
  );
}

/// Volume Control - Real-world volume control example
@widgetbook.UseCase(name: 'Volume Control', type: AppSlider)
Widget appSliderVolumeControl(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.volume_up, size: 32),
          const SizedBox(height: 16),
          AppSlider(
            value: 50,
            min: 0,
            max: 100,
            label: 'Volume',
            showValueLabel: true,
            labelFormatter: (value) => '${value.toInt()}%',
            onChanged: (_) {},
          ),
        ],
      ),
    ),
  );
}
