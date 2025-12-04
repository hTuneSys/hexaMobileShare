// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Placeholder stories for navigation_kit shell components
// TODO: Implement actual shell stories once AppShell, AppTabShell, AppDrawerShell are implemented

@widgetbook.UseCase(name: 'App Shell Basic', type: Placeholder)
Widget appShellStory(BuildContext context) {
  return const Placeholder(child: Center(child: Text('App Shell Basic Story')));
}

@widgetbook.UseCase(name: 'App Tab Shell', type: Placeholder)
Widget appTabShellStory(BuildContext context) {
  return const Placeholder(child: Center(child: Text('App Tab Shell Story')));
}

@widgetbook.UseCase(name: 'App Drawer Shell', type: Placeholder)
Widget appDrawerShellStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('App Drawer Shell Story')),
  );
}
