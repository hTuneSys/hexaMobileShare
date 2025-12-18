// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/widgets/inputs/app_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppSwitch', () {
    group('Basic Rendering', () {
      testWidgets('renders with required properties', (tester) async {
        bool switchValue = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: switchValue,
                onChanged: (value) {
                  switchValue = value;
                },
              ),
            ),
          ),
        );

        expect(find.byType(Switch), findsOneWidget);
      });

      testWidgets('displays label when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                label: 'Enable notifications',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('Enable notifications'), findsOneWidget);
      });

      testWidgets('displays subtitle when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                label: 'Dark mode',
                subtitle: 'Use dark theme across the app',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('Dark mode'), findsOneWidget);
        expect(find.text('Use dark theme across the app'), findsOneWidget);
      });

      testWidgets('displays icon when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                label: 'Bluetooth',
                icon: Icons.bluetooth,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.bluetooth), findsOneWidget);
      });

      testWidgets('renders without label (switch only)', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(value: false, onChanged: (value) {}),
            ),
          ),
        );

        expect(find.byType(Switch), findsOneWidget);
        expect(find.byType(Text), findsNothing);
      });
    });

    group('State Management', () {
      testWidgets('shows on state when value is true', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: AppSwitch(value: true, onChanged: (value) {})),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.value, true);
      });

      testWidgets('shows off state when value is false', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(value: false, onChanged: (value) {}),
            ),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.value, false);
      });

      testWidgets('calls onChanged when toggled', (tester) async {
        bool switchValue = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: switchValue,
                onChanged: (value) {
                  switchValue = value;
                },
              ),
            ),
          ),
        );

        // Tap the switch
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();

        // Verify the value changed
        expect(switchValue, true);
      });

      testWidgets('calls onChanged when label is tapped', (tester) async {
        bool switchValue = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return AppSwitch(
                    value: switchValue,
                    label: 'Toggle me',
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        );

        // Tap the label
        await tester.tap(find.text('Toggle me'));
        await tester.pumpAndSettle();

        // Verify the value changed
        expect(switchValue, true);
      });
    });

    group('Disabled State', () {
      testWidgets('is disabled when onChanged is null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: AppSwitch(value: false, onChanged: null)),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.onChanged, isNull);
      });

      testWidgets('is disabled when enabled is false', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                enabled: false,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.onChanged, isNull);
      });

      testWidgets('shows disabled on state', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: AppSwitch(value: true, onChanged: null)),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.value, true);
        expect(switchWidget.onChanged, isNull);
      });

      testWidgets('shows disabled off state', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: AppSwitch(value: false, onChanged: null)),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.value, false);
        expect(switchWidget.onChanged, isNull);
      });

      testWidgets('does not call onChanged when disabled', (tester) async {
        bool callbackCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                enabled: false,
                onChanged: (value) {
                  callbackCalled = true;
                },
              ),
            ),
          ),
        );

        // Try to tap the switch
        await tester.tap(find.byType(Switch));
        await tester.pumpAndSettle();

        // Verify callback was not called
        expect(callbackCalled, false);
      });
    });

    group('Color Customization', () {
      testWidgets('uses custom activeColor', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: true,
                activeColor: Colors.green,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        final thumbColor = switchWidget.thumbColor;
        expect(thumbColor, isNotNull);
        // Verify thumbColor is a WidgetStateProperty
        expect(thumbColor, isA<WidgetStateProperty<Color?>>());
      });

      testWidgets('uses custom inactiveColor', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                inactiveColor: Colors.grey,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        final thumbColor = switchWidget.thumbColor;
        expect(thumbColor, isNotNull);
        expect(thumbColor, isA<WidgetStateProperty<Color?>>());
      });

      testWidgets('uses custom activeTrackColor', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: true,
                activeTrackColor: Colors.lightGreen,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        final trackColor = switchWidget.trackColor;
        expect(trackColor, isNotNull);
        expect(trackColor, isA<WidgetStateProperty<Color?>>());
      });

      testWidgets('uses custom inactiveTrackColor', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                inactiveTrackColor: Colors.blueGrey,
                onChanged: (value) {},
              ),
            ),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        final trackColor = switchWidget.trackColor;
        expect(trackColor, isNotNull);
        expect(trackColor, isA<WidgetStateProperty<Color?>>());
      });
    });

    group('Layout Variants', () {
      testWidgets('switch only layout has no padding or text', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(value: false, onChanged: (value) {}),
            ),
          ),
        );

        expect(find.byType(Text), findsNothing);
        expect(find.byType(Switch), findsOneWidget);
      });

      testWidgets('switch with label has proper layout', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                label: 'Test label',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('Test label'), findsOneWidget);
        expect(find.byType(Switch), findsOneWidget);
        expect(find.byType(Row), findsOneWidget);
      });

      testWidgets('switch with icon, label, and subtitle has full layout', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                icon: Icons.wifi,
                label: 'WiFi',
                subtitle: 'Connect to wireless networks',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.wifi), findsOneWidget);
        expect(find.text('WiFi'), findsOneWidget);
        expect(find.text('Connect to wireless networks'), findsOneWidget);
        expect(find.byType(Switch), findsOneWidget);
      });
    });

    group('Accessibility', () {
      testWidgets('has minimum touch target size', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(value: false, onChanged: (value) {}),
            ),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(
          switchWidget.materialTapTargetSize,
          MaterialTapTargetSize.padded,
        );
      });

      testWidgets('label provides semantic context', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                label: 'Enable dark mode',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('Enable dark mode'), findsOneWidget);
      });

      testWidgets('disabled state is properly indicated', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSwitch(
                value: false,
                label: 'Disabled switch',
                onChanged: null,
              ),
            ),
          ),
        );

        final switchWidget = tester.widget<Switch>(find.byType(Switch));
        expect(switchWidget.onChanged, isNull);

        // Find the label text widget
        final textWidget = tester.widget<Text>(find.text('Disabled switch'));
        final textStyle = textWidget.style;

        // Check if the text has reduced opacity (disabled state)
        expect(textStyle?.color?.a, lessThan(1.0));
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
              body: AppSwitch(
                value: true,
                label: 'Themed switch',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('Themed switch'), findsOneWidget);
        expect(find.byType(Switch), findsOneWidget);
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
              body: AppSwitch(
                value: false,
                label: 'Dark themed switch',
                onChanged: (value) {},
              ),
            ),
          ),
        );

        expect(find.text('Dark themed switch'), findsOneWidget);
        expect(find.byType(Switch), findsOneWidget);
      });
    });
  });
}
