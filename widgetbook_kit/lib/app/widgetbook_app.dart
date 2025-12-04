// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'widgetbook_app.directories.g.dart';

@widgetbook.App()
class HexaWidgetbookApp extends StatelessWidget {
  const HexaWidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData(brightness: Brightness.light, useMaterial3: true),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData(brightness: Brightness.dark, useMaterial3: true),
            ),
          ],
        ),
      ],
    );
  }
}
