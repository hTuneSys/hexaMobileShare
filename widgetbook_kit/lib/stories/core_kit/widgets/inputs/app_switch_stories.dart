// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/inputs/app_switch.dart';

// 1. Default Switch - Basic toggle (Interactive)
@widgetbook.UseCase(name: 'Default', type: AppSwitch)
Widget appSwitchDefault(BuildContext context) {
  return const _DefaultSwitchDemo();
}

class _DefaultSwitchDemo extends StatefulWidget {
  const _DefaultSwitchDemo();

  @override
  State<_DefaultSwitchDemo> createState() => _DefaultSwitchDemoState();
}

class _DefaultSwitchDemoState extends State<_DefaultSwitchDemo> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(
        value: _value,
        label: 'Toggle switch',
        onChanged: (value) => setState(() => _value = value),
      ),
    );
  }
}

// 2. States - All switch states (Static - for comparison)
@widgetbook.UseCase(name: 'All States', type: AppSwitch)
Widget appSwitchStates(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('On (Active)', style: TextStyle(fontWeight: FontWeight.bold)),
          AppSwitch(value: true, label: 'Switch is on', onChanged: null),
          SizedBox(height: 16),
          Text('Off (Inactive)', style: TextStyle(fontWeight: FontWeight.bold)),
          AppSwitch(value: false, label: 'Switch is off', onChanged: null),
          SizedBox(height: 16),
          Text('Disabled On', style: TextStyle(fontWeight: FontWeight.bold)),
          AppSwitch(value: true, label: 'Disabled (on state)', onChanged: null),
          SizedBox(height: 16),
          Text('Disabled Off', style: TextStyle(fontWeight: FontWeight.bold)),
          AppSwitch(
            value: false,
            label: 'Disabled (off state)',
            onChanged: null,
          ),
        ],
      ),
    ),
  );
}

// 3. With Labels - Label variations (Interactive)
@widgetbook.UseCase(name: 'With Labels', type: AppSwitch)
Widget appSwitchLabels(BuildContext context) {
  return const _LabelsDemo();
}

class _LabelsDemo extends StatefulWidget {
  const _LabelsDemo();

  @override
  State<_LabelsDemo> createState() => _LabelsDemoState();
}

class _LabelsDemoState extends State<_LabelsDemo> {
  bool _noLabel = true;
  bool _shortLabel = true;
  bool _longLabel = false;
  bool _darkMode = true;
  bool _notifications = false;

  @override
  Widget build(BuildContext context) {
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
            AppSwitch(
              value: _noLabel,
              onChanged: (value) => setState(() => _noLabel = value),
            ),
            const SizedBox(height: 24),
            const Text(
              'Short Label',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppSwitch(
              value: _shortLabel,
              label: 'Wi-Fi',
              onChanged: (value) => setState(() => _shortLabel = value),
            ),
            const SizedBox(height: 24),
            const Text(
              'Long Label',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppSwitch(
              value: _longLabel,
              label: 'Automatically connect to available wireless networks',
              onChanged: (value) => setState(() => _longLabel = value),
            ),
            const SizedBox(height: 24),
            const Text(
              'With Subtitle (Additional Context)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppSwitch(
              value: _darkMode,
              label: 'Dark mode',
              subtitle: 'Use dark theme across the app for better visibility',
              onChanged: (value) => setState(() => _darkMode = value),
            ),
            const SizedBox(height: 16),
            AppSwitch(
              value: _notifications,
              label: 'Push notifications',
              subtitle: 'Receive notifications about important updates',
              onChanged: (value) => setState(() => _notifications = value),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. With Icons - Icon integration (Interactive)
@widgetbook.UseCase(name: 'With Icons', type: AppSwitch)
Widget appSwitchIcons(BuildContext context) {
  return const _IconsDemo();
}

class _IconsDemo extends StatefulWidget {
  const _IconsDemo();

  @override
  State<_IconsDemo> createState() => _IconsDemoState();
}

class _IconsDemoState extends State<_IconsDemo> {
  bool _wifi = true;
  bool _bluetooth = true;
  bool _airplane = false;
  bool _notifications = true;
  bool _location = false;

  @override
  Widget build(BuildContext context) {
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
              value: _wifi,
              icon: Icons.wifi,
              label: 'Wi-Fi',
              subtitle: 'Connect to wireless networks',
              onChanged: (value) => setState(() => _wifi = value),
            ),
            const SizedBox(height: 16),
            AppSwitch(
              value: _bluetooth,
              icon: Icons.bluetooth,
              label: 'Bluetooth',
              subtitle: 'Connect to nearby devices',
              onChanged: (value) => setState(() => _bluetooth = value),
            ),
            const SizedBox(height: 16),
            AppSwitch(
              value: _airplane,
              icon: Icons.airplanemode_active,
              label: 'Airplane mode',
              subtitle: 'Disable all wireless connections',
              onChanged: (value) => setState(() => _airplane = value),
            ),
            const SizedBox(height: 16),
            AppSwitch(
              value: _notifications,
              icon: Icons.notifications,
              label: 'Notifications',
              subtitle: 'Show notifications on lock screen',
              onChanged: (value) => setState(() => _notifications = value),
            ),
            const SizedBox(height: 16),
            AppSwitch(
              value: _location,
              icon: Icons.location_on,
              label: 'Location services',
              subtitle: 'Allow apps to use your location',
              onChanged: (value) => setState(() => _location = value),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. Settings List - Realistic settings UI (Interactive - Critical!)
@widgetbook.UseCase(name: 'Settings List', type: AppSwitch)
Widget appSwitchSettingsList(BuildContext context) {
  return const _SettingsListDemo();
}

class _SettingsListDemo extends StatefulWidget {
  const _SettingsListDemo();

  @override
  State<_SettingsListDemo> createState() => _SettingsListDemoState();
}

class _SettingsListDemoState extends State<_SettingsListDemo> {
  // Network & Connectivity
  bool _wifi = true;
  bool _bluetooth = true;
  bool _airplane = false;

  // Notifications
  bool _pushNotifications = true;
  bool _vibrate = false;

  // Privacy
  bool _location = true;
  bool _camera = false;
  bool _microphone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Network & Connectivity Section
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
            value: _wifi,
            icon: Icons.wifi,
            label: 'Wi-Fi',
            subtitle: 'Connected to My Network',
            onChanged: (value) => setState(() => _wifi = value),
          ),
          const Divider(height: 1),
          AppSwitch(
            value: _bluetooth,
            icon: Icons.bluetooth,
            label: 'Bluetooth',
            onChanged: (value) => setState(() => _bluetooth = value),
          ),
          const Divider(height: 1),
          AppSwitch(
            value: _airplane,
            icon: Icons.airplanemode_active,
            label: 'Airplane mode',
            onChanged: (value) => setState(() => _airplane = value),
          ),
          const SizedBox(height: 24),

          // Notifications Section
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
            value: _pushNotifications,
            icon: Icons.notifications,
            label: 'Push notifications',
            subtitle: 'Show notifications on lock screen',
            onChanged: (value) => setState(() => _pushNotifications = value),
          ),
          const Divider(height: 1),
          AppSwitch(
            value: _vibrate,
            icon: Icons.vibration,
            label: 'Vibrate',
            onChanged: (value) => setState(() => _vibrate = value),
          ),
          const Divider(height: 1),
          // Do not disturb - Disabled
          const AppSwitch(
            value: false,
            icon: Icons.volume_off,
            label: 'Do not disturb',
            subtitle: 'Disabled by administrator',
            onChanged: null,
          ),
          const SizedBox(height: 24),

          // Privacy Section
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
            value: _location,
            icon: Icons.location_on,
            label: 'Location services',
            subtitle: 'Allow apps to use your location',
            onChanged: (value) => setState(() => _location = value),
          ),
          const Divider(height: 1),
          AppSwitch(
            value: _camera,
            icon: Icons.camera_alt,
            label: 'Camera access',
            onChanged: (value) => setState(() => _camera = value),
          ),
          const Divider(height: 1),
          AppSwitch(
            value: _microphone,
            icon: Icons.mic,
            label: 'Microphone access',
            onChanged: (value) => setState(() => _microphone = value),
          ),
        ],
      ),
    );
  }
}

// 6. Theme Variations - Light, dark, and custom colors (Interactive)
@widgetbook.UseCase(name: 'Theme Variations', type: AppSwitch)
Widget appSwitchThemeVariations(BuildContext context) {
  return const _ThemeVariationsDemo();
}

class _ThemeVariationsDemo extends StatefulWidget {
  const _ThemeVariationsDemo();

  @override
  State<_ThemeVariationsDemo> createState() => _ThemeVariationsDemoState();
}

class _ThemeVariationsDemoState extends State<_ThemeVariationsDemo> {
  bool _defaultOn = true;
  bool _defaultOff = false;
  bool _greenSwitch = true;
  bool _orangeSwitch = true;
  bool _blueSwitch = true;

  @override
  Widget build(BuildContext context) {
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
              value: _defaultOn,
              label: 'On (uses primary color)',
              onChanged: (value) => setState(() => _defaultOn = value),
            ),
            const SizedBox(height: 8),
            AppSwitch(
              value: _defaultOff,
              label: 'Off (uses surface color)',
              onChanged: (value) => setState(() => _defaultOff = value),
            ),
            const SizedBox(height: 24),
            const Text(
              'Custom Brand Colors',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AppSwitch(
              value: _greenSwitch,
              label: 'Green switch',
              activeColor: Colors.white,
              activeTrackColor: Colors.green,
              onChanged: (value) => setState(() => _greenSwitch = value),
            ),
            const SizedBox(height: 8),
            AppSwitch(
              value: _orangeSwitch,
              label: 'Orange switch',
              activeColor: Colors.white,
              activeTrackColor: Colors.deepOrange,
              onChanged: (value) => setState(() => _orangeSwitch = value),
            ),
            const SizedBox(height: 8),
            AppSwitch(
              value: _blueSwitch,
              label: 'Blue switch',
              activeColor: Colors.white,
              activeTrackColor: Colors.blue,
              onChanged: (value) => setState(() => _blueSwitch = value),
            ),
          ],
        ),
      ),
    );
  }
}

// 7. Real-World Examples (Interactive)
@widgetbook.UseCase(name: 'Real-World Examples', type: AppSwitch)
Widget appSwitchExamples(BuildContext context) {
  return const _RealWorldDemo();
}

class _RealWorldDemo extends StatefulWidget {
  const _RealWorldDemo();

  @override
  State<_RealWorldDemo> createState() => _RealWorldDemoState();
}

class _RealWorldDemoState extends State<_RealWorldDemo> {
  bool _darkMode = true;
  bool _autoSave = false;
  bool _cloudBackup = true;

  @override
  Widget build(BuildContext context) {
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
              value: _darkMode,
              icon: Icons.dark_mode,
              label: 'Dark mode',
              subtitle: 'Reduces eye strain in low light',
              onChanged: (value) => setState(() => _darkMode = value),
            ),
            const SizedBox(height: 16),
            AppSwitch(
              value: _autoSave,
              icon: Icons.save_alt,
              label: 'Auto-save',
              subtitle: 'Automatically save changes',
              onChanged: (value) => setState(() => _autoSave = value),
            ),
            const SizedBox(height: 16),
            AppSwitch(
              value: _cloudBackup,
              icon: Icons.backup,
              label: 'Cloud backup',
              subtitle: 'Back up to cloud storage',
              onChanged: (value) => setState(() => _cloudBackup = value),
            ),
            const SizedBox(height: 16),
            // Analytics - Disabled (managed by organization)
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
}
