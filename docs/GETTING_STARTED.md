<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# 🚀 Getting Started with hexaMobileShare

Welcome to the hexaMobileShare mobile kit monorepo! This guide will help you set up your development environment, understand the project structure, and start building or using widgets.

---

## 📋 What is hexaMobileShare?

hexaMobileShare is a comprehensive **Flutter mobile kit monorepo** featuring:

- 🎨 **Modular architecture** across 11 specialized kits
- 🌈 **Material Design 3** styling system
- 📖 **Widgetbook** for widget development and documentation
- ✨ **Dart 3.x** for type safety and null safety
- ♿ **Accessibility-first** design
- 🎯 **Production-ready** widgets and utilities

---

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed:

### Required

- **Node.js** 18+ (LTS recommended)
  - Download from [nodejs.org](https://nodejs.org/)
  - Verify: `node --version`

- **pnpm** 9+
  ```bash
  npm install -g pnpm
  # Verify
  pnpm --version
  ```

- **Flutter SDK** 3.x+
  - Download from [flutter.dev](https://flutter.dev/docs/get-started/install)
  - Verify: `flutter --version`

- **Dart SDK** 3.x+ (comes with Flutter)
  - Verify: `dart --version`

- **Git** for version control
  ```bash
  git --version
  ```

### Recommended

- **VS Code** with extensions:
  - Flutter for VS Code
  - Dart for VS Code
  - Material Design Icons IntelliSense
  - Better Comments

---

## 📦 Installation

### For Contributors (Development)

1. **Clone the repository**:
   ```bash
   git clone https://github.com/hTuneSys/hexaMobileShare.git
   cd hexaMobileShare
   ```

2. **Install dependencies** (one-time setup):
   ```bash
   pnpm install
   ```
   
   This command will automatically:
   - ✅ Install Node.js development dependencies (Husky, Commitlint)
   - ✅ Install Melos globally (`dart pub global activate melos`)
   - ✅ Run `melos bootstrap` to install all Flutter package dependencies
   - ✅ Setup Git hooks for commit message validation
   
   **Note**: This is a one-time setup. Melos will be installed globally and available for all future commands.

3. **Run Widgetbook** (recommended for widget development):
   ```bash
   pnpm storybook
   ```
   
   Opens at [http://localhost:8080](http://localhost:8080)

### For Consumers (Using the Library)

Add individual kits to your Flutter project's `pubspec.yaml`:

```yaml
dependencies:
  core_kit:
    git:
      url: https://github.com/hTuneSys/hexaMobileShare.git
      path: packages/core_kit
  auth_kit:
    git:
      url: https://github.com/hTuneSys/hexaMobileShare.git
      path: packages/auth_kit
```

Then run:
```bash
flutter pub get
```

> **Note**: Packages will be published to pub.dev in the future for easier installation.

---

## 🚦 Quick Start

### Option 1: Explore with Widgetbook (Recommended)

Widgetbook provides an interactive environment to browse and test all widgets:

```bash
cd hexaMobileShare
pnpm install
pnpm storybook
```

Browse widgets by kit in your browser at [http://localhost:8080](http://localhost:8080):
- **analytics_kit** → Analytics events, feature flags, logging
- **auth_kit** → Authentication flows, permissions, session management
- **core_kit** → Buttons, inputs, layout, typography, theme
- **data_kit** → API client, pagination, error handling
- **forms_kit** → Form controllers, validators, custom fields
- **localization_kit** → i18n support, translations
- **media_kit** → Audio/video players, media handling
- **monetization_kit** → In-app purchases, subscriptions
- **navigation_kit** → Routing, deep linking, navigation guards
- **notifications_kit** → Push notifications, local notifications
- **storage_kit** → Local storage, caching, secure storage

### Option 2: Build Your First Flutter Widget

1. **Navigate to a kit and create a new widget**:
   ```bash
   cd packages/core_kit/lib
   mkdir -p buttons
   touch buttons/custom_button.dart
   ```

2. **Write the widget**:
   ```dart
   // packages/core_kit/lib/buttons/custom_button.dart
   import 'package:flutter/material.dart';
   
   class CustomButton extends StatelessWidget {
     final String label;
     final VoidCallback? onPressed;
     final ButtonVariant variant;
     
     const CustomButton({
       Key? key,
       required this.label,
       this.onPressed,
       this.variant = ButtonVariant.primary,
     }) : super(key: key);
     
     @override
     Widget build(BuildContext context) {
       return ElevatedButton(
         onPressed: onPressed,
         child: Text(label),
       );
     }
   }
   
   enum ButtonVariant { primary, secondary, accent }
   ```

3. **Create a Widgetbook story**:
   ```dart
   // widgetbook_kit/lib/stories/core_kit/buttons/custom_button_stories.dart
   import 'package:flutter/material.dart';
   import 'package:widgetbook_annotation/widgetbook_annotation.dart';
   import 'package:core_kit/buttons/custom_button.dart';
   
   @UseCase(name: 'Default', type: CustomButton)
   Widget customButtonDefault(BuildContext context) {
     return CustomButton(
       label: 'Click me',
       onPressed: () {},
     );
   }
   ```

4. **View in Widgetbook**:
   ```bash
   pnpm storybook
   ```
   
   Navigate to: `Core Kit > Buttons > CustomButton`

### Option 3: Use Kits in Your Flutter App

Add the kit to your `pubspec.yaml`:

```yaml
dependencies:
  core_kit:
    git:
      url: https://github.com/hTuneSys/hexaMobileShare.git
      path: packages/core_kit
```

Then use it in your app:

```dart
import 'package:flutter/material.dart';
import 'package:core_kit/core_kit.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Column(
        children: [
          Gap(height: 16),
          ResponsivePadding(
            child: Text('Welcome to hexaMobileShare!'),
          ),
        ],
      ),
    );
  }
}
```

---

## 📂 Project Structure

```
hexaMobileShare/
├── packages/                  # 11 modular kits
│   ├── analytics_kit/        # Analytics, logging, feature flags
│   ├── auth_kit/             # Authentication & authorization
│   ├── core_kit/             # Core UI widgets & theming
│   ├── data_kit/             # HTTP client, API handling
│   ├── forms_kit/            # Form management & validation
│   ├── localization_kit/     # Internationalization (i18n)
│   ├── media_kit/            # Audio/video players, media
│   ├── monetization_kit/     # In-app purchases, subscriptions
│   ├── navigation_kit/       # Routing, deep linking
│   ├── notifications_kit/    # Push & local notifications
│   └── storage_kit/          # Local storage, caching
├── widgetbook_kit/           # Widgetbook catalog app
├── docs/                     # Documentation
├── melos.yaml                # Monorepo configuration
└── package.json              # Node.js dev dependencies
```

---

## 🎨 Kit Overview

Each kit provides specialized functionality:

- **analytics_kit** → Analytics events, feature flags, logging
- **auth_kit** → Authentication flows, permissions, session management
- **core_kit** → Buttons, inputs, layout, typography, theme
- **data_kit** → API client, pagination, error handling
- **forms_kit** → Form controllers, validators, custom fields
- **localization_kit** → i18n support, translations
- **media_kit** → Audio/video players, media handling
- **monetization_kit** → In-app purchases, subscriptions
- **navigation_kit** → Routing, deep linking, navigation guards
- **notifications_kit** → Push notifications, local notifications
- **storage_kit** → Local storage, caching, secure storage

---

## ⚙️ Development Commands

### Essential Commands

| Command | Description |
|---------|-------------|
| `pnpm install` | Install dependencies & bootstrap packages |
| `pnpm storybook` | Start Widgetbook dev server |
| `pnpm build-storybook` | Build static Widgetbook |
| `pnpm test` | Run tests across all kits |
| `pnpm analyze` | Run static analysis |
| `pnpm format` | Format all Dart code |
| `pnpm bootstrap` | Bootstrap all packages (melos) |

### Typical Development Flow

```bash
# 1. Start Widgetbook
pnpm storybook

# 2. Make changes to widgets
# (Widgetbook will hot-reload)

# 3. Run analysis
pnpm analyze

# 4. Format code
pnpm format

# 5. Run tests
pnpm test
```

---

## 🧪 Testing Your Setup

### 1. Verify Widgetbook Works

```bash
pnpm storybook
```

Expected: Widgetbook opens at `http://localhost:8080` showing the widget catalog.

### 2. Check Flutter Analysis

```bash
pnpm analyze
```

Expected: No analyzer warnings or errors.

### 3. Verify Tests Run

```bash
pnpm test
```

Expected: All tests pass successfully.

### 4. Test Theme Switching

1. Open Widgetbook
2. Look for theme switcher in toolbar
3. Toggle between light and dark themes
4. Widgets should adapt automatically

---

## 🎨 Styling & Theming

### Material Design 3 Themes

The kits use Material Design 3 with customizable themes. Each kit can adapt to your app's theme configuration.

### Apply Theme in Your App

```dart
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}
```

### Theme Switching in Widgetbook

Widgetbook includes a theme switcher in the toolbar. Use it to preview widgets in both light and dark themes.

---

## 📚 Next Steps

### For Contributors

1. Read [CONTRIBUTING.md](CONTRIBUTING.md) – Contribution guidelines
2. Review [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md) – Detailed development workflow
3. Check [ARCHITECTURE.md](ARCHITECTURE.md) – Understand the architecture
4. Explore [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) – Directory organization

### For Widget Users

1. Browse Widgetbook to explore widgets
2. Check widget props in Widgetbook's "Controls" tab
3. Copy code examples from stories
4. Read [CONFIGURATION.md](CONFIGURATION.md) for integration setup

### Learn More

- [Flutter Documentation](https://docs.flutter.dev)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io)
- [Widgetbook Docs](https://docs.widgetbook.io)

---

## 🐛 Troubleshooting

### pnpm install fails

```bash
# Clear cache and reinstall
pnpm store prune
rm -rf node_modules
pnpm install
```

### Widgetbook doesn't start

```bash
# Check Node version (must be 18+)
node --version

# Check Flutter installation
flutter doctor

# Restart Widgetbook
pnpm storybook
```

### Flutter analyzer errors

```bash
# Clean and get dependencies
flutter clean
pnpm bootstrap

# Re-run analysis
pnpm analyze
```

### Styles not loading

Ensure Material Design 3 is configured correctly in your theme:

```dart
// Verify MaterialApp uses Material Design 3
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    // ... your theme configuration
  ),
)
```

---

## 🙋 Getting Help

### Documentation

- [FAQ.md](FAQ.md) – Frequently asked questions
- [SUPPORT.md](SUPPORT.md) – Support channels
- [CONTACT.md](CONTACT.md) – Contact information

### Community

- **GitHub Discussions**: [Ask questions](https://github.com/hTuneSys/hexaMobileShare/discussions)
- **Issues**: [Report bugs](https://github.com/hTuneSys/hexaMobileShare/issues)
- **Email**: [info@hexatune.com](mailto:info@hexatune.com)

---

## ✅ Checklist

Before you start developing:

- [ ] Node.js 18+ installed
- [ ] pnpm 9+ installed  
- [ ] Flutter SDK 3.x+ installed
- [ ] Dart SDK 3.x+ installed
- [ ] Repository cloned
- [ ] Dependencies installed (`pnpm install`)
- [ ] Widgetbook running (`pnpm storybook`)
- [ ] Analysis passing (`pnpm analyze`)
- [ ] Read [CONTRIBUTING.md](CONTRIBUTING.md)
- [ ] Read [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md)

---

You're now ready to explore and build with hexaMobileShare! 🎉

Happy coding! 🚀
