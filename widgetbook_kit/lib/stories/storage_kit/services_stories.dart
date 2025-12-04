// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Placeholder stories for storage_kit services
// TODO: Implement actual service stories once storage services are implemented

@widgetbook.UseCase(name: 'Key-Value Store Service', type: Placeholder)
Widget keyValueStoreServiceStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Key-Value Store Service Story')),
  );
}

@widgetbook.UseCase(name: 'Shared Preferences Store', type: Placeholder)
Widget sharedPreferencesStoreStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Shared Preferences Store Story')),
  );
}

@widgetbook.UseCase(name: 'Settings Store Service', type: Placeholder)
Widget settingsStoreServiceStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Settings Store Service Story')),
  );
}
