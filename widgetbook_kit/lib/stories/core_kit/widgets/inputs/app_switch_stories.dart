// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/inputs/app_switch.dart';

// 1. Default Switch - Basic toggle
@widgetbook.UseCase(name: 'Default', type: AppSwitch)
Widget appSwitchDefault(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: AppSwitch(
      value: false,
      label: 'Toggle switch',
      onChanged: (value) {},
    ),
  );
}

// 2. States - All switch states
@widgetbook.UseCase(name: 'All States', type: AppSwitch)
Widget appSwitchStates(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'On (Active)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          AppSwitch(value: true, label: 'Switch is on', onChanged: (value) {}),
          const SizedBox(height: 16),
          const Text(
            'Off (Inactive)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          AppSwitch(
            value: false,
            label: 'Switch is off',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          const Text(
            'Disabled On',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const AppSwitch(
            value: true,
            label: 'Disabled (on state)',
            onChanged: null,
          ),
          const SizedBox(height: 16),
          const Text(
            'Disabled Off',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const AppSwitch(
            value: false,
            label: 'Disabled (off state)',
            onChanged: null,
          ),
        ],
      ),
    ),
  );
}

// 3. With Labels - Label variations
@widgetbook.UseCase(name: 'With Labels', type: AppSwitch)
Widget appSwitchLabels(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'No Label (Switch Only)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppSwitch(value: true, onChanged: (value) {}),
          const SizedBox(height: 24),
          const Text(
            'Short Label',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppSwitch(value: true, label: 'Wi-Fi', onChanged: (value) {}),
          const SizedBox(height: 24),
          const Text(
            'Long Label',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppSwitch(
            value: false,
            label: 'Automatically connect to available wireless networks',
            onChanged: (value) {},
          ),
          const SizedBox(height: 24),
          const Text(
            'With Subtitle (Additional Context)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppSwitch(
            value: true,
            label: 'Dark mode',
            subtitle: 'Use dark theme across the app for better visibility',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          AppSwitch(
            value: false,
            label: 'Push notifications',
            subtitle: 'Receive notifications about important updates',
            onChanged: (value) {},
          ),
        ],
      ),
    ),
  );
}

// 4. With Icons - Icon integration
@widgetbook.UseCase(name: 'With Icons', type: AppSwitch)
Widget appSwitchIcons(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Leading Icon + Switch',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          AppSwitch(
            value: true,
            icon: Icons.wifi,
            label: 'Wi-Fi',
            subtitle: 'Connect to wireless networks',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          AppSwitch(
            value: true,
            icon: Icons.bluetooth,
            label: 'Bluetooth',
            subtitle: 'Connect to nearby devices',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          AppSwitch(
            value: false,
            icon: Icons.airplanemode_active,
            label: 'Airplane mode',
            subtitle: 'Disable all wireless connections',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          AppSwitch(
            value: true,
            icon: Icons.notifications,
            label: 'Notifications',
            subtitle: 'Show notifications on lock screen',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          AppSwitch(
            value: false,
            icon: Icons.location_on,
            label: 'Location services',
            subtitle: 'Allow apps to use your location',
            onChanged: (value) {},
          ),
        ],
      ),
    ),
  );
}

// 5. Settings List - Realistic settings UI
@widgetbook.UseCase(name: 'Settings List', type: AppSwitch)
Widget appSwitchSettingsList(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Settings')),
    body: ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Network & Connectivity',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        AppSwitch(
          value: true,
          icon: Icons.wifi,
          label: 'Wi-Fi',
          subtitle: 'Connected to My Network',
          onChanged: (value) {},
        ),
        const Divider(height: 1),
        AppSwitch(
          value: true,
          icon: Icons.bluetooth,
          label: 'Bluetooth',
          onChanged: (value) {},
        ),
        const Divider(height: 1),
        AppSwitch(
          value: false,
          icon: Icons.airplanemode_active,
          label: 'Airplane mode',
          onChanged: (value) {},
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Notifications',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        AppSwitch(
          value: true,
          icon: Icons.notifications,
          label: 'Push notifications',
          subtitle: 'Show notifications on lock screen',
          onChanged: (value) {},
        ),
        const Divider(height: 1),
        AppSwitch(
          value: false,
          icon: Icons.vibration,
          label: 'Vibrate',
          onChanged: (value) {},
        ),
        const Divider(height: 1),
        const AppSwitch(
          value: false,
          icon: Icons.volume_off,
          label: 'Do not disturb',
          subtitle: 'Disabled by administrator',
          onChanged: null,
        ),
        const SizedBox(height: 24),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Privacy',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        AppSwitch(
          value: true,
          icon: Icons.location_on,
          label: 'Location services',
          subtitle: 'Allow apps to use your location',
          onChanged: (value) {},
        ),
        const Divider(height: 1),
        AppSwitch(
          value: false,
          icon: Icons.camera_alt,
          label: 'Camera access',
          onChanged: (value) {},
        ),
        const Divider(height: 1),
        AppSwitch(
          value: false,
          icon: Icons.mic,
          label: 'Microphone access',
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

// 6. Theme Variations - Light, dark, and custom colors
@widgetbook.UseCase(name: 'Theme Variations', type: AppSwitch)
Widget appSwitchThemeVariations(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Toggle theme in Widgetbook to see variations',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
          ),
          const SizedBox(height: 16),
          const Text(
            'Default Colors',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppSwitch(
            value: true,
            label: 'On (uses primary color)',
            onChanged: (value) {},
          ),
          const SizedBox(height: 8),
          AppSwitch(
            value: false,
            label: 'Off (uses surface color)',
            onChanged: (value) {},
          ),
          const SizedBox(height: 24),
          const Text(
            'Custom Brand Colors',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          AppSwitch(
            value: true,
            label: 'Green switch',
            activeColor: Colors.white,
            activeTrackColor: Colors.green,
            onChanged: (value) {},
          ),
          const SizedBox(height: 8),
          AppSwitch(
            value: true,
            label: 'Orange switch',
            activeColor: Colors.white,
            activeTrackColor: Colors.deepOrange,
            onChanged: (value) {},
          ),
          const SizedBox(height: 8),
          AppSwitch(
            value: true,
            label: 'Blue switch',
            activeColor: Colors.white,
            activeTrackColor: Colors.blue,
            onChanged: (value) {},
          ),
          const SizedBox(height: 24),
          const Text(
            'Contrast Demonstration',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: AppSwitch(
                  value: true,
                  label: 'On',
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppSwitch(
                  value: false,
                  label: 'Off',
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// 7. Real-World Examples
@widgetbook.UseCase(name: 'Real-World Examples', type: AppSwitch)
Widget appSwitchExamples(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Common Use Cases',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          AppSwitch(
            value: true,
            icon: Icons.dark_mode,
            label: 'Dark mode',
            subtitle: 'Reduces eye strain in low light',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          AppSwitch(
            value: false,
            icon: Icons.save_alt,
            label: 'Auto-save',
            subtitle: 'Automatically save changes',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          AppSwitch(
            value: true,
            icon: Icons.backup,
            label: 'Cloud backup',
            subtitle: 'Back up to cloud storage',
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          const AppSwitch(
            value: false,
            icon: Icons.analytics,
            label: 'Analytics',
            subtitle: 'Managed by organization policy',
            onChanged: null,
          ),
        ],
      ),
    ),
  );
}
