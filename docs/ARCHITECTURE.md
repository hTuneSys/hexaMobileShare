<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# 🏗️ hexaMobileShare Architecture

This document explains the architecture and design principles of the hexaMobileShare Flutter mobile kit monorepo.

---

## Overview

hexaMobileShare is a comprehensive Flutter mobile development kit built with modern mobile technologies. It provides a rich set of reusable packages and widgets for building cross-platform mobile applications with modular, scalable architecture.

---

## 🎯 Project Goals

- **Modularity**: Create highly reusable, composable Flutter packages
- **Type Safety**: Full Dart type safety with sound null safety
- **Accessibility**: Material Design 3 accessibility standards
- **Developer Experience**: Widgetbook integration for widget development and documentation
- **Cross-Platform**: Support iOS, Android, Web, and Desktop from single codebase
- **Production Ready**: Optimized for production use with proper package structure

---

## 🏛️ Technology Stack

### Core Technologies

- **Flutter 3.x**: Latest stable version with Material Design 3
- **Dart 3.x**: Sound null safety and modern language features
- **Melos**: Monorepo management and workspace tooling
- **Material Design 3**: Modern design system and theming

### Package Structure

- **analytics_kit**: Analytics, feature flags, and logging
- **auth_kit**: Authentication flows and session management
- **core_kit**: Core UI widgets and theme system
- **data_kit**: HTTP client, API handling, and data models
- **forms_kit**: Form validation and form widgets
- **localization_kit**: Multi-language support
- **media_kit**: Media playback and downloading
- **monetization_kit**: In-app purchases and subscriptions
- **navigation_kit**: Routing and deep linking
- **notifications_kit**: Push and local notifications
- **storage_kit**: Local storage and caching

### Development Tools

- **Widgetbook**: Widget development and documentation
  - Widget catalog with use cases
  - Theme switching and testing
  - Visual mobile kit monorepo
- **Melos**: Monorepo management
  - Bootstrap workspace
  - Version management
  - Script running across packages
- **Dart DevTools**: Profiling and debugging
- **Flutter Test**: Unit and widget testing

---

## 📦 Package Architecture

### Package Organization

The monorepo is organized into 11 specialized packages plus a widgetbook kit:

#### 1. **analytics_kit** (`packages/analytics_kit/`)
Analytics, tracking, feature flags, and logging:

- **Analytics**: Event tracking, screen tracking
- **Feature Flags**: A/B testing and feature toggles
- **Logger**: Application logging and debugging

#### 2. **auth_kit** (`packages/auth_kit/`)
Authentication and authorization:

- **Flows**: Login, registration, password reset, email verification
- **Models**: User, user profile, roles
- **Permissions**: Permission guards and role-based access
- **Services**: Auth service, session management, token storage
- **State**: Authentication state management

#### 3. **core_kit** (`packages/core_kit/`)
Core UI widgets and theme system:

- **Theme**: App color scheme, typography, spacing, shadows, radius
- **Icons**: Icon system and icon registry
- **Layout**: Scaffolds, containers, gap spacing, responsive padding
- **Typography**: Text styles, headings, body text, captions
- **Widgets**:
  - Buttons: Material buttons, FABs, icon buttons
  - Chips: Badges, tags, filter chips, input chips
  - Feedback: Dialogs, snackbars, toasts, loading states, error states
  - Inputs: Text fields, dropdowns, checkboxes, switches, sliders
  - Navigation**: App bars, bottom navigation, tabs, drawers
  - Surfaces: Cards, list tiles, section headers

#### 4. **data_kit** (`packages/data_kit/`)
HTTP client and data management:

- **HTTP**: API client, interceptors (auth, logging)
- **Models**: API result, API error, paginated response
- **Errors**: Error mapping, retry policies
- **Pagination**: Pagination controllers, paged list notifiers

#### 5. **forms_kit** (`packages/forms_kit/`)
Form management and validation:

- **Form**: Form controllers, form configuration, form state
- **Validators**: Email, password, phone, pattern, required validators
- **Widgets**: Form wrappers, field wrappers

#### 6. **localization_kit** (`packages/localization_kit/`)
Internationalization and localization:

- **Localization**: App localizations, delegates, loaders, keys

#### 7. **media_kit** (`packages/media_kit/`)
Media playback and download management:

- **Player**: Media player, audio/video adapters, controllers
- **Download**: Download manager, download tasks
- **Progress**: Progress tracking, user progress storage
- **Models**: Media items, media types

#### 8. **monetization_kit** (`packages/monetization_kit/`)
In-app purchases and subscriptions:

- **Purchase**: Purchase service, purchase validation
- **Entitlements**: Entitlement checker
- **Models**: Products, subscriptions

#### 9. **navigation_kit** (`packages/navigation_kit/`)
Routing and navigation:

- **Router**: Route configuration, route guards, route paths, deep linking
- **Shell**: App shells, drawer shells, tab shells
- **State**: Back button handling, route state

#### 10. **notifications_kit** (`packages/notifications_kit/`)
Push and local notifications:

- **Push**: Push notification service, token management
- **Local**: Local notification service, notification channels
- **Background**: Background tasks, task scheduling

#### 11. **storage_kit** (`packages/storage_kit/`)
Local storage and caching:

- **Cache**: Local cache, Hive cache, cache keys
- **Key-Value**: Key-value store, SharedPreferences store
- **Settings**: Settings storage

#### 12. **widgetbook_kit** (Development Tool)
Widgetbook for widget development and documentation:

- **Stories**: Individual story files for each package entity (1-to-1 mapping)
- **App**: Widgetbook application configuration
- Provides live preview and documentation for all widgets

### Package Design Principles

1. **Single Responsibility**: Each package focuses on one domain
2. **Minimal Dependencies**: Packages have minimal cross-dependencies
3. **Type Safety**: Full Dart null safety and strong typing
4. **Platform Agnostic**: Core logic separated from platform-specific code
5. **Testable**: Easy to unit test in isolation
6. **Well Documented**: Comprehensive Widgetbook stories

---

## 🎨 Theme Architecture

### Material Design 3

The project uses Material Design 3 (Material You) theming:

```dart
// core_kit/lib/theme/app_theme.dart
ThemeData buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: AppColorScheme.light,
    typography: AppTypography.typography,
    // ...
  );
}
```

### Theme System Widgets

- **AppColorScheme**: MD3 color schemes (light/dark)
- **AppTypography**: Type scale following MD3 guidelines
- **AppSpacing**: Consistent spacing system (4dp grid)
- **AppRadius**: Border radius constants
- **AppShadows**: Elevation shadow system

### Widget Theming Pattern

Widgets use theme extensions and context:

```dart
// Using theme
final colors = Theme.of(context).colorScheme;
final textTheme = Theme.of(context).textTheme;
final spacing = AppSpacing.md;

// Custom theme data
return Container(
  padding: EdgeInsets.all(spacing),
  decoration: BoxDecoration(
    color: colors.surface,
    borderRadius: BorderRadius.circular(AppRadius.md),
  ),
  child: Text(
    'Hello',
    style: textTheme.titleMedium,
  ),
);
```

---

## 📚 Widgetbook Integration

### Purpose

Widgetbook serves as:
- **Development Environment**: Isolated widget development
- **Documentation**: Live widget documentation
- **Testing**: Visual testing and interaction testing
- **Showcase**: Demo application for the widget library

### Structure

```dart
// widgetbook_kit/lib/stories/{kit_name}/{path}/{file}_stories.dart
// Each package entity has a corresponding story file (1-to-1 mapping)

// Example: widgetbook_kit/lib/stories/core_kit/widgets/buttons/app_button_stories.dart
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

@widgetbook.UseCase(
  name: 'Primary',
  type: AppButton,
)
Widget appButtonPrimary(BuildContext context) {
  return AppButton(
    label: 'Primary Button',
    variant: ButtonVariant.primary,
    onPressed: () {},
  );
}
```

### Theme Support

Widgetbook includes theme switching for light/dark mode testing.

---

## 📤 Package Distribution

### Pub.dev Publishing

Packages are individually published to pub.dev:

```yaml
# pubspec.yaml for each package
name: analytics_kit
version: 1.0.0
publish_to: 'https://pub.dev'
```

### Usage in Consumer Projects

```yaml
# pubspec.yaml
dependencies:
  analytics_kit: ^1.0.0
  auth_kit: ^1.0.0
  core_kit: ^1.0.0
```

```dart
// Import packages
import 'package:core_kit/core_kit.dart';
import 'package:auth_kit/auth_kit.dart';

// Use widgets
AppButton(label: 'Click me', onPressed: () {});
```

---

## 🔄 Development Workflow

1. **Package Development**: Build packages with Melos workspace
2. **Type Safety**: Dart analyzer ensures type safety
3. **Testing**: Flutter test for unit and widget tests
4. **Documentation**: Write Widgetbook stories for visual documentation
5. **Version Management**: Melos version command for synchronized versioning
6. **Publishing**: Publish packages to pub.dev

---

## 🧩 Module System

- **Dart Packages**: Modern Dart package system
- **Minimal Dependencies**: Each package has minimal external dependencies
- **Melos Workspace**: Unified monorepo management
- **Pub Package Manager**: Standard Dart/Flutter package distribution

---

## 🔐 Type System

Full Dart type safety with:
- Sound null safety enabled
- Strong mode type checking
- Widget type definitions
- Generic widget support
- Extension types for theme data

---

## 📬 Questions?

Contact the team at **[info@hexatune.com](mailto:info@hexatune.com)** or open an issue.

---

Built by [hexaTune LLC](https://hexatune.com) · GitHub: [hTuneSys/hexaMobileShare](https://github.com/hTuneSys/hexaMobileShare) · License: [MIT](https://opensource.org/license/mit/)
