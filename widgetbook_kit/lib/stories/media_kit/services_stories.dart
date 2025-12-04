// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Placeholder stories for media_kit services
// TODO: Implement actual media service stories once MediaService, DownloadService, etc. are implemented

@widgetbook.UseCase(name: 'Media Service Example', type: Placeholder)
Widget mediaServiceStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Media Service Example Story')),
  );
}

@widgetbook.UseCase(name: 'Download Service Example', type: Placeholder)
Widget downloadServiceStory(BuildContext context) {
  return const Placeholder(
    child: Center(child: Text('Download Service Example Story')),
  );
}
