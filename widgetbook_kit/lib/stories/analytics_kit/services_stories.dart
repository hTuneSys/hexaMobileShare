// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Placeholder stories for analytics_kit services
// TODO: Implement actual service stories once analytics services are implemented

@widgetbook.UseCase(name: 'Analytics Service', type: Placeholder)
Widget analyticsServiceStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Analytics Service Story')),
  );
}

@widgetbook.UseCase(name: 'Feature Flag Client', type: Placeholder)
Widget featureFlagClientStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Feature Flag Client Story')),
  );
}

@widgetbook.UseCase(name: 'App Logger', type: Placeholder)
Widget appLoggerStory(BuildContext context) {
  return const Placeholder(child: Center(child: Text('App Logger Story')));
}
