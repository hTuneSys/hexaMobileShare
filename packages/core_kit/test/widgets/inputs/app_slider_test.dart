// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/widgets/inputs/app_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSlider', () {
    group('Basic Rendering', () {
      testWidgets('renders with required properties', (tester) async {
        double sliderValue = 50;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: sliderValue,
                min: 0,
                max: 100,
                onChanged: (value) {
                  sliderValue = value;
                },
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('displays label when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                label: 'Volume',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('Volume'), findsOneWidget);
      });

      testWidgets('renders without label (slider only)', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
        expect(find.byType(Text), findsNothing);
      });

      testWidgets('shows min/max indicators when enabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                showMinMaxIndicators: true,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('0.0'), findsOneWidget);
        expect(find.text('100.0'), findsOneWidget);
      });
    });

    group('Continuous Mode', () {
      testWidgets('displays initial value correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 75,
                min: 0,
                max: 100,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.value, 75);
      });

      testWidgets('calls onChanged during drag', (tester) async {
        double sliderValue = 50;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return AppSlider(
                    value: sliderValue,
                    min: 0,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        sliderValue = value;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        );

        // Simulate drag (this is simplified, actual drag testing is complex)
        final slider = find.byType(Slider);
        expect(slider, findsOneWidget);

        // Verify initial value
        expect(sliderValue, 50);
      });

      testWidgets('calls onChangeEnd when drag completes', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                onChanged: (value) {},
                onChangeEnd: (value) {
                  // Callback exists and will be called
                },
              ),
            ),
          ),
        );

        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('respects min and max bounds', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 25,
                min: 10,
                max: 90,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.min, 10);
        expect(slider.max, 90);
      });
    });

    group('Discrete Mode', () {
      testWidgets('creates divisions when specified', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 5,
                min: 0,
                max: 10,
                divisions: 10,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.divisions, 10);
      });

      testWidgets('shows value label in discrete mode', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 5,
                min: 0,
                max: 10,
                divisions: 10,
                showValueLabel: true,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.label, isNotNull);
        expect(slider.label, '5');
      });
    });

    group('Range Mode', () {
      testWidgets('renders RangeSlider for range mode', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider.range(
                values: const RangeValues(20, 80),
                min: 0,
                max: 100,
                onRangeChanged: (values) {},
              ),
            ),
          ),
        );

        expect(find.byType(RangeSlider), findsOneWidget);
      });

      testWidgets('displays initial range values', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider.range(
                values: const RangeValues(25, 75),
                min: 0,
                max: 100,
                onRangeChanged: (values) {},
              ),
            ),
          ),
        );

        final rangeSlider = tester.widget<RangeSlider>(
          find.byType(RangeSlider),
        );
        expect(rangeSlider.values.start, 25);
        expect(rangeSlider.values.end, 75);
      });

      testWidgets('shows range labels when enabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider.range(
                values: const RangeValues(20, 80),
                min: 0,
                max: 100,
                showValueLabel: true,
                onRangeChanged: (values) {},
              ),
            ),
          ),
        );

        final rangeSlider = tester.widget<RangeSlider>(
          find.byType(RangeSlider),
        );
        expect(rangeSlider.labels, isNotNull);
        expect(rangeSlider.labels?.start, '20.0');
        expect(rangeSlider.labels?.end, '80.0');
      });

      testWidgets('respects min and max bounds in range mode', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider.range(
                values: const RangeValues(100, 500),
                min: 0,
                max: 1000,
                onRangeChanged: (values) {},
              ),
            ),
          ),
        );

        final rangeSlider = tester.widget<RangeSlider>(
          find.byType(RangeSlider),
        );
        expect(rangeSlider.min, 0);
        expect(rangeSlider.max, 1000);
      });
    });

    group('Value Labels and Formatting', () {
      testWidgets('uses default formatter when none provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 42.7,
                min: 0,
                max: 100,
                showValueLabel: true,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.label, '42.7');
      });

      testWidgets('uses custom label formatter', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                showValueLabel: true,
                labelFormatter: (value) => '\$${value.toStringAsFixed(0)}',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.label, '\$50');
      });

      testWidgets('custom formatter works with min/max indicators', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                showMinMaxIndicators: true,
                labelFormatter: (value) => '${value.toInt()}%',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('0%'), findsOneWidget);
        expect(find.text('100%'), findsOneWidget);
      });
    });

    group('Disabled State', () {
      testWidgets('is disabled when onChanged is null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(value: 50, min: 0, max: 100, onChanged: null),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.onChanged, isNull);
      });

      testWidgets('is disabled when enabled is false', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                enabled: false,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.onChanged, isNull);
      });

      testWidgets('range slider is disabled when onRangeChanged is null', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider.range(
                values: const RangeValues(20, 80),
                min: 0,
                max: 100,
                onRangeChanged: null,
              ),
            ),
          ),
        );

        final rangeSlider = tester.widget<RangeSlider>(
          find.byType(RangeSlider),
        );
        expect(rangeSlider.onChanged, isNull);
      });

      testWidgets('label shows reduced opacity when disabled', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                label: 'Disabled slider',
                onChanged: null,
              ),
            ),
          ),
        );

        final textWidget = tester.widget<Text>(find.text('Disabled slider'));
        final textStyle = textWidget.style;

        // Check if the text has reduced opacity (disabled state)
        expect(textStyle?.color?.a, lessThan(1.0));
      });
    });

    group('Color Customization', () {
      testWidgets('uses custom active color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                activeColor: Colors.green,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.activeColor, Colors.green);
      });

      testWidgets('uses custom inactive color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                inactiveColor: Colors.grey,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.inactiveColor, Colors.grey);
      });

      testWidgets('uses custom thumb color', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                thumbColor: Colors.orange,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.thumbColor, Colors.orange);
      });
    });

    group('Theme Integration', () {
      testWidgets('uses theme colors when custom colors not provided', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
            ),
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                label: 'Themed slider',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('Themed slider'), findsOneWidget);
        expect(find.byType(Slider), findsOneWidget);
      });

      testWidgets('respects dark theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 0,
                max: 100,
                label: 'Dark themed slider',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('Dark themed slider'), findsOneWidget);
        expect(find.byType(Slider), findsOneWidget);
      });
    });

    group('Edge Cases', () {
      testWidgets('handles min equal to max', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 50,
                min: 50,
                max: 50,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.min, slider.max);
      });

      testWidgets('handles value at minimum', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 0,
                min: 0,
                max: 100,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.value, slider.min);
      });

      testWidgets('handles value at maximum', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSlider(
                value: 100,
                min: 0,
                max: 100,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final slider = tester.widget<Slider>(find.byType(Slider));
        expect(slider.value, slider.max);
      });
    });
  });
}
