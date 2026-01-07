// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppSwitch] component.
///
/// A Material Design 3 switch widget that provides consistent toggle switch
/// experience with support for labels, subtitles, icons, and custom theming.

/// Interactive Playground - explore all AppSwitch properties with knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppSwitch)
Widget appSwitchPlayground(BuildContext context) {
  final value = context.knobs.boolean(label: 'Value', initialValue: true);
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final hasLabel = context.knobs.boolean(
    label: 'Has Label',
    initialValue: true,
  );
  final hasSubtitle = context.knobs.boolean(
    label: 'Has Subtitle',
    initialValue: false,
  );
  final hasIcon = context.knobs.boolean(label: 'Has Icon', initialValue: false);
  final hasCustomColors = context.knobs.boolean(
    label: 'Has Custom Colors',
    initialValue: false,
  );

  final label = hasLabel
      ? context.knobs.string(
          label: 'Label Text',
          initialValue: 'Enable notifications',
        )
      : null;

  final subtitle = hasSubtitle
      ? context.knobs.string(
          label: 'Subtitle Text',
          initialValue: 'Receive push notifications',
        )
      : null;

  final icon = hasIcon
      ? IconData(
          context.knobs.int.slider(
            label: 'Icon Code',
            initialValue: Icons.notifications.codePoint,
            min: Icons.abc.codePoint,
            max: Icons.zoom_out.codePoint,
          ),
          fontFamily: 'MaterialIcons',
        )
      : null;

  final activeColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Active Color',
          initialValue: Colors.white,
        )
      : null;

  final activeTrackColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Active Track Color',
          initialValue: Colors.green,
        )
      : null;

  final inactiveColor = hasCustomColors
      ? context.knobs.colorOrNull(label: 'Inactive Color')
      : null;

  final inactiveTrackColor = hasCustomColors
      ? context.knobs.colorOrNull(label: 'Inactive Track Color')
      : null;

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(
        value: value,
        label: label,
        subtitle: subtitle,
        icon: icon,
        activeColor: activeColor,
        inactiveColor: inactiveColor,
        activeTrackColor: activeTrackColor,
        inactiveTrackColor: inactiveTrackColor,
        enabled: enabled,
        onChanged: enabled ? (_) {} : null,
      ),
    ),
  );
}

/// Default - Basic switch with label
@widgetbook.UseCase(name: 'Default', type: AppSwitch)
Widget appSwitchDefault(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(
        value: true,
        label: 'Enable notifications',
        onChanged: (_) {},
      ),
    ),
  );
}

/// With Subtitle - Switch with label and subtitle
@widgetbook.UseCase(name: 'With Subtitle', type: AppSwitch)
Widget appSwitchWithSubtitle(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(
        value: true,
        label: 'Dark mode',
        subtitle: 'Use dark theme across the app',
        onChanged: (_) {},
      ),
    ),
  );
}

/// With Icon - Switch with leading icon
@widgetbook.UseCase(name: 'With Icon', type: AppSwitch)
Widget appSwitchWithIcon(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(
        value: true,
        icon: Icons.bluetooth,
        label: 'Bluetooth',
        subtitle: 'Connect to nearby devices',
        onChanged: (_) {},
      ),
    ),
  );
}

/// Without Label - Switch only (no label)
@widgetbook.UseCase(name: 'Without Label', type: AppSwitch)
Widget appSwitchWithoutLabel(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(value: false, onChanged: (_) {}),
    ),
  );
}

/// Disabled On - Disabled switch in on state
@widgetbook.UseCase(name: 'Disabled On', type: AppSwitch)
Widget appSwitchDisabledOn(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(
        value: true,
        label: 'Disabled switch (on)',
        onChanged: null,
      ),
    ),
  );
}

/// Disabled Off - Disabled switch in off state
@widgetbook.UseCase(name: 'Disabled Off', type: AppSwitch)
Widget appSwitchDisabledOff(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(
        value: false,
        label: 'Disabled switch (off)',
        enabled: false,
        onChanged: (_) {},
      ),
    ),
  );
}

/// Custom Colors - Switch with custom colors
@widgetbook.UseCase(name: 'Custom Colors', type: AppSwitch)
Widget appSwitchCustomColors(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(
        value: true,
        label: 'Custom green switch',
        activeColor: Colors.white,
        activeTrackColor: Colors.green,
        onChanged: (_) {},
      ),
    ),
  );
}

/// Long Label - Switch with long label text
@widgetbook.UseCase(name: 'Long Label', type: AppSwitch)
Widget appSwitchLongLabel(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(
        value: false,
        label: 'Automatically connect to available wireless networks',
        subtitle:
            'This is a very long subtitle that demonstrates how the '
            'component handles multi-line text with proper wrapping',
        onChanged: (_) {},
      ),
    ),
  );
}

/// Settings Item - Switch styled as settings item
@widgetbook.UseCase(name: 'Settings Item', type: AppSwitch)
Widget appSwitchSettingsItem(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSwitch(
        value: true,
        icon: Icons.wifi,
        label: 'Wi-Fi',
        subtitle: 'Connected to My Network',
        onChanged: (_) {},
      ),
    ),
  );
}
