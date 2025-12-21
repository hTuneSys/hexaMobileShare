// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/inputs/app_slider.dart';

// 1. Basic Continuous Slider - Simple value selection (Interactive)
@widgetbook.UseCase(name: 'Basic Continuous', type: AppSlider)
Widget appSliderBasicContinuous(BuildContext context) {
  return const _BasicContinuousDemo();
}

class _BasicContinuousDemo extends StatefulWidget {
  const _BasicContinuousDemo();

  @override
  State<_BasicContinuousDemo> createState() => _BasicContinuousDemoState();
}

class _BasicContinuousDemoState extends State<_BasicContinuousDemo> {
  double _value = 50;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Value: ${_value.toStringAsFixed(1)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          AppSlider(
            value: _value,
            min: 0,
            max: 100,
            label: 'Volume',
            showMinMaxIndicators: true,
            onChanged: (value) => setState(() => _value = value),
          ),
        ],
      ),
    );
  }
}

// 2. Discrete Slider - Snap to divisions (Interactive)
@widgetbook.UseCase(name: 'Discrete with Divisions', type: AppSlider)
Widget appSliderDiscrete(BuildContext context) {
  return const _DiscreteDemo();
}

class _DiscreteDemo extends StatefulWidget {
  const _DiscreteDemo();

  @override
  State<_DiscreteDemo> createState() => _DiscreteDemoState();
}

class _DiscreteDemoState extends State<_DiscreteDemo> {
  double _rating = 3;
  double _quality = 5;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rating: ${_rating.toInt()}/5',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppSlider(
              value: _rating,
              min: 0,
              max: 5,
              divisions: 5,
              label: 'Rating',
              showValueLabel: true,
              showMinMaxIndicators: true,
              onChanged: (value) => setState(() => _rating = value),
            ),
            const SizedBox(height: 32),
            Text(
              'Quality Level: ${_quality.toInt()}/10',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppSlider(
              value: _quality,
              min: 0,
              max: 10,
              divisions: 10,
              label: 'Quality',
              showValueLabel: true,
              onChanged: (value) => setState(() => _quality = value),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. Range Slider - Min/Max selection (Interactive)
@widgetbook.UseCase(name: 'Range Slider', type: AppSlider)
Widget appSliderRange(BuildContext context) {
  return const _RangeSliderDemo();
}

class _RangeSliderDemo extends StatefulWidget {
  const _RangeSliderDemo();

  @override
  State<_RangeSliderDemo> createState() => _RangeSliderDemoState();
}

class _RangeSliderDemoState extends State<_RangeSliderDemo> {
  RangeValues _priceRange = const RangeValues(100, 500);
  RangeValues _ageRange = const RangeValues(18, 65);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price Range: \$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppSlider.range(
              values: _priceRange,
              min: 0,
              max: 1000,
              divisions: 20,
              label: 'Price Range',
              showValueLabel: true,
              showMinMaxIndicators: true,
              labelFormatter: (value) => '\$${value.toInt()}',
              onRangeChanged: (values) => setState(() => _priceRange = values),
            ),
            const SizedBox(height: 32),
            Text(
              'Age Range: ${_ageRange.start.toInt()} - ${_ageRange.end.toInt()} years',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppSlider.range(
              values: _ageRange,
              min: 0,
              max: 100,
              label: 'Age Range',
              showValueLabel: true,
              showMinMaxIndicators: true,
              onRangeChanged: (values) => setState(() => _ageRange = values),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. With Value Labels - Always visible labels (Interactive)
@widgetbook.UseCase(name: 'With Value Labels', type: AppSlider)
Widget appSliderValueLabels(BuildContext context) {
  return const _ValueLabelsDemo();
}

class _ValueLabelsDemo extends StatefulWidget {
  const _ValueLabelsDemo();

  @override
  State<_ValueLabelsDemo> createState() => _ValueLabelsDemoState();
}

class _ValueLabelsDemoState extends State<_ValueLabelsDemo> {
  double _brightness = 75;
  double _temperature = 22;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Drag the sliders to see value labels',
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
            ),
            const SizedBox(height: 24),
            AppSlider(
              value: _brightness,
              min: 0,
              max: 100,
              label: 'Brightness',
              showValueLabel: true,
              showMinMaxIndicators: true,
              labelFormatter: (value) => '${value.toInt()}%',
              onChanged: (value) => setState(() => _brightness = value),
            ),
            const SizedBox(height: 32),
            AppSlider(
              value: _temperature,
              min: 10,
              max: 35,
              label: 'Temperature',
              showValueLabel: true,
              divisions: 25,
              showMinMaxIndicators: true,
              labelFormatter: (value) => '${value.toInt()}°C',
              onChanged: (value) => setState(() => _temperature = value),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. Custom Formatter - Currency, percentage, custom formats (Interactive)
@widgetbook.UseCase(name: 'Custom Formatter', type: AppSlider)
Widget appSliderCustomFormatter(BuildContext context) {
  return const _CustomFormatterDemo();
}

class _CustomFormatterDemo extends StatefulWidget {
  const _CustomFormatterDemo();

  @override
  State<_CustomFormatterDemo> createState() => _CustomFormatterDemoState();
}

class _CustomFormatterDemoState extends State<_CustomFormatterDemo> {
  double _price = 499.99;
  double _discount = 25;
  double _distance = 5.5;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Currency: \$${_price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppSlider(
              value: _price,
              min: 0,
              max: 1000,
              label: 'Price',
              showValueLabel: true,
              showMinMaxIndicators: true,
              labelFormatter: (value) => '\$${value.toStringAsFixed(2)}',
              onChanged: (value) => setState(() => _price = value),
            ),
            const SizedBox(height: 32),
            Text(
              'Percentage: ${_discount.toInt()}%',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppSlider(
              value: _discount,
              min: 0,
              max: 100,
              divisions: 20,
              label: 'Discount',
              showValueLabel: true,
              showMinMaxIndicators: true,
              labelFormatter: (value) => '${value.toInt()}%',
              onChanged: (value) => setState(() => _discount = value),
            ),
            const SizedBox(height: 32),
            Text(
              'Distance: ${_distance.toStringAsFixed(1)} km',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppSlider(
              value: _distance,
              min: 0,
              max: 50,
              label: 'Search Radius',
              showValueLabel: true,
              showMinMaxIndicators: true,
              labelFormatter: (value) => '${value.toStringAsFixed(1)} km',
              onChanged: (value) => setState(() => _distance = value),
            ),
          ],
        ),
      ),
    );
  }
}

// 6. Disabled State - Non-interactive demonstration
@widgetbook.UseCase(name: 'Disabled State', type: AppSlider)
Widget appSliderDisabled(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Enabled Slider', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          AppSlider(
            value: 75,
            min: 0,
            max: 100,
            label: 'Enabled (interactive)',
            showMinMaxIndicators: true,
            onChanged: null, // Will be enabled in stateful version if needed
          ),
          SizedBox(height: 24),
          Text(
            'Disabled Slider (onChanged = null)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          AppSlider(
            value: 50,
            min: 0,
            max: 100,
            label: 'Disabled (non-interactive)',
            showMinMaxIndicators: true,
            onChanged: null,
          ),
          SizedBox(height: 24),
          Text(
            'Disabled via enabled property',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          AppSlider(
            value: 30,
            min: 0,
            max: 100,
            label: 'System managed (disabled)',
            enabled: false,
            showMinMaxIndicators: true,
            onChanged: _dummyCallback,
          ),
          SizedBox(height: 24),
          Text(
            'Disabled Range Slider',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          AppSlider.range(
            values: RangeValues(20, 80),
            min: 0,
            max: 100,
            label: 'Disabled range',
            showMinMaxIndicators: true,
            onRangeChanged: null,
          ),
        ],
      ),
    ),
  );
}

void _dummyCallback(double value) {
  // This won't be called when enabled = false
}

// 7. With Min/Max Indicators - Show bounds labels (Interactive)
@widgetbook.UseCase(name: 'With Min/Max Indicators', type: AppSlider)
Widget appSliderMinMaxIndicators(BuildContext context) {
  return const _MinMaxIndicatorsDemo();
}

class _MinMaxIndicatorsDemo extends StatefulWidget {
  const _MinMaxIndicatorsDemo();

  @override
  State<_MinMaxIndicatorsDemo> createState() => _MinMaxIndicatorsDemoState();
}

class _MinMaxIndicatorsDemoState extends State<_MinMaxIndicatorsDemo> {
  double _temperature1 = 20;
  double _temperature2 = 20;
  double _speed = 60;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Without Indicators',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppSlider(
              value: _temperature1,
              min: -10,
              max: 40,
              label: 'Temperature',
              onChanged: (value) => setState(() => _temperature1 = value),
            ),
            const SizedBox(height: 24),
            const Text(
              'With Indicators',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppSlider(
              value: _temperature2,
              min: -10,
              max: 40,
              label: 'Temperature',
              showMinMaxIndicators: true,
              labelFormatter: (value) => '${value.toInt()}°C',
              onChanged: (value) => setState(() => _temperature2 = value),
            ),
            const SizedBox(height: 32),
            const Text(
              'With Custom Formatted Indicators',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppSlider(
              value: _speed,
              min: 0,
              max: 120,
              divisions: 24,
              label: 'Speed',
              showMinMaxIndicators: true,
              showValueLabel: true,
              labelFormatter: (value) => '${value.toInt()} km/h',
              onChanged: (value) => setState(() => _speed = value),
            ),
          ],
        ),
      ),
    );
  }
}

// 8. Real-World Examples - Common use cases (Interactive)
@widgetbook.UseCase(name: 'Real-World Examples', type: AppSlider)
Widget appSliderRealWorld(BuildContext context) {
  return const _RealWorldDemo();
}

class _RealWorldDemo extends StatefulWidget {
  const _RealWorldDemo();

  @override
  State<_RealWorldDemo> createState() => _RealWorldDemoState();
}

class _RealWorldDemoState extends State<_RealWorldDemo> {
  double _volume = 50;
  double _brightness = 75;
  RangeValues _priceFilter = const RangeValues(0, 500);
  double _fontScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Common Use Cases',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            // Volume Control
            const Icon(Icons.volume_up, size: 32),
            const SizedBox(height: 8),
            AppSlider(
              value: _volume,
              min: 0,
              max: 100,
              label: 'Volume',
              showValueLabel: true,
              labelFormatter: (value) => '${value.toInt()}%',
              onChanged: (value) => setState(() => _volume = value),
            ),
            const SizedBox(height: 32),
            // Brightness Control
            const Icon(Icons.brightness_6, size: 32),
            const SizedBox(height: 8),
            AppSlider(
              value: _brightness,
              min: 0,
              max: 100,
              label: 'Screen Brightness',
              showValueLabel: true,
              labelFormatter: (value) => '${value.toInt()}%',
              onChanged: (value) => setState(() => _brightness = value),
            ),
            const SizedBox(height: 32),
            // Price Range Filter
            const Icon(Icons.filter_list, size: 32),
            const SizedBox(height: 8),
            Text(
              'Price: \$${_priceFilter.start.toInt()} - \$${_priceFilter.end.toInt()}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AppSlider.range(
              values: _priceFilter,
              min: 0,
              max: 1000,
              divisions: 20,
              label: 'Price Filter',
              showValueLabel: true,
              showMinMaxIndicators: true,
              labelFormatter: (value) => '\$${value.toInt()}',
              onRangeChanged: (values) => setState(() => _priceFilter = values),
            ),
            const SizedBox(height: 32),
            // Font Size
            const Icon(Icons.text_fields, size: 32),
            const SizedBox(height: 8),
            AppSlider(
              value: _fontScale,
              min: 0.5,
              max: 2.0,
              divisions: 15,
              label: 'Font Scale',
              showValueLabel: true,
              labelFormatter: (value) => '${value.toStringAsFixed(1)}x',
              showMinMaxIndicators: true,
              onChanged: (value) => setState(() => _fontScale = value),
            ),
            const SizedBox(height: 16),
            Text(
              'Preview text at ${_fontScale.toStringAsFixed(1)}x scale',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontSize: 16 * _fontScale),
            ),
          ],
        ),
      ),
    );
  }
}
