// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Placeholder stories for notifications_kit services
// TODO: Implement actual service stories once notification services are implemented

@widgetbook.UseCase(name: 'Local Notification Service', type: Placeholder)
Widget localNotificationServiceStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Local Notification Service Story')),
  );
}

@widgetbook.UseCase(name: 'Push Notification Service', type: Placeholder)
Widget pushNotificationServiceStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Push Notification Service Story')),
  );
}

@widgetbook.UseCase(name: 'Background Task Scheduler', type: Placeholder)
Widget backgroundTaskSchedulerStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Background Task Scheduler Story')),
  );
}
