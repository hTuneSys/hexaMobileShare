// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Placeholder stories for navigation_kit router components
// TODO: Implement actual router stories once AppRouter, AppRouteConfig, etc. are implemented

@widgetbook.UseCase(name: 'App Router Configuration', type: Placeholder)
Widget appRouterStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('App Router Configuration Story')),
  );
}

@widgetbook.UseCase(name: 'Route Guards Example', type: Placeholder)
Widget routeGuardsStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Route Guards Example Story')),
  );
}

@widgetbook.UseCase(name: 'Deep Link Handler', type: Placeholder)
Widget deepLinkHandlerStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Deep Link Handler Story')),
  );
}
