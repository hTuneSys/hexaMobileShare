<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# CONFIGURATION.md

This document explains how configuration is managed across the hexaMobileShare project, including development environment setup, build configuration, and runtime parameters.

---

## 📦 Package Configuration

### pubspec.yaml (Kit Level)

Each kit has its own `pubspec.yaml` configuration:

```yaml
name: core_kit
description: Core UI widgets and theming for hexaMobileShare
version: 0.0.1
publish_to: none

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: '>=3.0.0'

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true
```

**Key Fields:**
- `name`: Package identifier
- `version`: Semantic version
- `publish_to`: Set to `none` for private packages, or `pub.dev` for public
- `environment`: Dart and Flutter SDK constraints
- `dependencies`: Package dependencies
- `dev_dependencies`: Development-only dependencies

---

## 🎨 Material Design 3 Configuration

### Theme Configuration

Material Design 3 themes are configured in Flutter apps using `ThemeData`:

```dart
import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
  // Customize component themes
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    ),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  ),
);
```

### Applying Themes

```dart
MaterialApp(
  title: 'My App',
  theme: lightTheme,
  darkTheme: darkTheme,
  themeMode: ThemeMode.system,  // Follow system preference
  home: MyHomePage(),
);
```

---

## ⚙️ Melos Configuration

### melos.yaml

Monorepo configuration located at root:

```yaml
name: hexaMobileShare
repository: https://github.com/hTuneSys/hexaMobileShare

packages:
  - packages/**
  - widgetbook_kit

command:
  version:
    linkToCommits: true
    workspaceChangelog: true

  bootstrap:
    environment:
      sdk: '>=3.0.0 <4.0.0'
      flutter: '>=3.0.0'

scripts:
  analyze:
    description: Run Flutter analyzer for all packages
    run: flutter analyze
    exec:
      concurrency: 1

  format:
    description: Format all Dart code
    run: dart format .
    exec:
      concurrency: 1

  test:
    description: Run tests for all packages
    run: flutter test
    exec:
      concurrency: 1
      failFast: true

  clean:
    description: Clean all packages
    run: flutter clean
    exec:
      concurrency: 1
```

**Key Sections:**
- `packages`: Locations of packages in monorepo
- `scripts`: Reusable commands across packages
- `bootstrap`: Dependency installation settings
- `version`: Versioning and changelog configuration

---

## 📖 Widgetbook Configuration

### widgetbook_kit/lib/app/widgetbook_app.dart

```dart
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData.light(useMaterial3: true),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData.dark(useMaterial3: true),
            ),
          ],
        ),
        DeviceFrameAddon(
          devices: [
            Devices.ios.iPhone13,
            Devices.android.samsungGalaxyS20,
          ],
        ),
        LocalizationAddon(
          locales: [
            Locale('en', 'US'),
            Locale('tr', 'TR'),
          ],
        ),
      ],
      integrations: [
        WidgetbookCloudIntegration(),
      ],
    );
  }
}
```

**Features:**
- **Theme Addon**: Switch between light/dark themes
- **Device Frame Addon**: Preview on different devices
- **Localization Addon**: Test different locales
- **Cloud Integration**: Optional Widgetbook Cloud integration

---

## 🎯 Environment Setup

### Development

```bash
# Install dependencies
pnpm install

# Bootstrap all Flutter packages
pnpm bootstrap

# Start Widgetbook
pnpm storybook
```

### Build

```bash
# Build Widgetbook web app
pnpm build-storybook

# Output in widgetbook_kit/build/web/
```

### Quality Checks

```bash
# Static analysis
pnpm analyze

# Format code
pnpm format

# Run tests
pnpm test
```

---

## 📋 Scripts Reference

From root `package.json`:

| Script | Command | Description |
|--------|---------|-------------|
| `install` | `pnpm install` | Install Node.js deps + bootstrap packages |
| `bootstrap` | `melos bootstrap` | Install Flutter package dependencies |
| `analyze` | `melos run analyze` | Run static analysis |
| `format` | `melos run format` | Format all Dart code |
| `test` | `melos run test` | Run all tests |
| `storybook` | `pnpm widgetbook:web` | Start Widgetbook dev server |
| `build-storybook` | `pnpm widgetbook:build` | Build Widgetbook static site |

---

## 🔧 Tool Configurations

### analysis_options.yaml

Each kit has an `analysis_options.yaml` for Dart analyzer:

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_literals_to_create_immutables
    - avoid_print
    - prefer_final_fields
    - prefer_final_locals
    - sort_constructors_first
    - sort_unnamed_constructors_first
    - always_declare_return_types
    - avoid_empty_else
    - avoid_relative_lib_imports
    - prefer_single_quotes
    - require_trailing_commas

analyzer:
  exclude:
    - '**/*.g.dart'
    - '**/*.freezed.dart'
  strong-mode:
    implicit-casts: false
    implicit-dynamic: false
```

### VS Code Settings

`.vscode/settings.json` (recommended):

```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true,
    "source.organizeImports": true
  },
  "[dart]": {
    "editor.formatOnSave": true,
    "editor.formatOnType": true,
    "editor.rulers": [80],
    "editor.selectionHighlight": false,
    "editor.suggest.snippetsPreventQuickSuggestions": false,
    "editor.suggestSelection": "first",
    "editor.tabCompletion": "onlySnippets",
    "editor.wordBasedSuggestions": false
  },
  "dart.lineLength": 80,
  "dart.enableSdkFormatter": true
}
```

---

## 🌐 Runtime Configuration

### Using Kits in Your App

Add kits to your app's `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # hexaMobileShare kits
  core_kit:
    git:
      url: https://github.com/hTuneSys/hexaMobileShare.git
      path: packages/core_kit
  
  auth_kit:
    git:
      url: https://github.com/hTuneSys/hexaMobileShare.git
      path: packages/auth_kit
```

Then import in your Dart code:

```dart
import 'package:core_kit/core_kit.dart';
import 'package:auth_kit/auth_kit.dart';
```

### Theme Configuration

Configure Material Design 3 theme globally:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}
```

---

## 📦 Publishing Configuration

### Publishing to pub.dev

Each kit can be published independently:

```bash
# Navigate to kit
cd packages/core_kit

# Dry run
flutter pub publish --dry-run

# Publish
flutter pub publish
```

### Version Management

Use Melos for versioning:

```bash
# Version packages
melos version

# Create changelog
melos version --changelog
```

---

## 🔒 Git Configuration

`.gitignore` excludes:

```
# Flutter
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
build/
.pub-cache/
.pub/

# IDE
.idea/
.vscode/
*.iml

# Environment
.env
.env.local
```

---

## 🔐 REUSE Configuration

`REUSE.toml` for license compliance:

```toml
version = 1
SPDX-PackageName = "hexaMobileShare"
SPDX-PackageSupplier = "hexaTune LLC"
SPDX-PackageDownloadLocation = "https://github.com/hTuneSys/hexaMobileShare"

[[annotations]]
path = [
  ".github/**",
  "**.dart_tool/**",
  "**/build/**",
  "**.pub-cache/**"
]
precedence = "aggregate"
SPDX-FileCopyrightText = "2025 hexaTune LLC"
SPDX-License-Identifier = "MIT"
```

---

## 📝 Notes

- All packages use Dart 3.x with null safety enabled
- Flutter analyzer strict mode enforces best practices
- Widgetbook is configured for component development and documentation
- Material Design 3 is used across all UI kits
- Melos manages monorepo operations efficiently
- REUSE compliance ensures proper licensing

---

This guide helps contributors safely configure and run the project in various environments.
