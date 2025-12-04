<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# 📁 Project Structure: hexaMobileShare

This document outlines the organization of the hexaMobileShare Flutter mobile kit monorepo repository.

---

## 🏗️ Repository Overview

hexaMobileShare is a **monorepo** containing:
- 11 Flutter mobile kits in `packages/`
- Widgetbook catalog app in `widgetbook_kit/`
- Documentation in `docs/`
- GitHub configurations in `.github/`
- License and legal files

---

## 📂 Root Directory

```
hexaMobileShare/
├── .github/              # GitHub configuration
│   ├── ISSUE_TEMPLATE/   # Issue templates
│   ├── workflows/        # GitHub Actions CI/CD
│   ├── CODEOWNERS        # Code ownership
│   ├── CODE_OF_CONDUCT.md
│   ├── PULL_REQUEST_TEMPLATE.md
│   └── SECURITY.md
├── .husky/               # Git hooks
├── docs/                 # Documentation files
├── packages/             # 11 mobile kits (analytics, auth, core, data, forms, localization, media, monetization, navigation, notifications, storage)
├── widgetbook_kit/       # Widgetbook catalog app
├── LICENSES/             # License files
├── .gitignore
├── .releaserc.yml        # Semantic release config
├── AGENTS.md             # AI agent guidelines
├── CHANGELOG.md
├── LICENSE
├── melos.yaml            # Melos monorepo config
├── package.json          # pnpm scripts
├── README.md
└── REUSE.toml            # License compliance
```

---

## 📦 Packages Directory (`packages/`)

The monorepo contains 11 modular kits, each as an independent Flutter package:

```
packages/
├── analytics_kit/        # Analytics, logging, feature flags
├── auth_kit/             # Authentication & authorization
├── core_kit/             # Core UI widgets & theming (Material Design 3)
├── data_kit/             # HTTP client, API handling, pagination
├── forms_kit/            # Form management & validation
├── localization_kit/     # Internationalization (i18n)
├── media_kit/            # Audio/video players, media handling
├── monetization_kit/     # In-app purchases, subscriptions
├── navigation_kit/       # Routing, deep linking
├── notifications_kit/    # Push & local notifications
└── storage_kit/          # Local storage, caching
```

Each kit follows this structure:

```
<kit_name>/
├── lib/
│   ├── <kit_name>.dart           # Public API entry point
│   └── src/                      # Implementation files
│       ├── models/
│       ├── services/
│       ├── widgets/
│       └── utils/
├── test/
│   └── <kit_name>_test.dart
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── CHANGELOG.md
├── LICENSE
├── pubspec.yaml
└── README.md
```

---

## 📚 Widgetbook Directory (`widgetbook_kit/`)

The Widgetbook catalog app for showcasing and developing widgets:

```
widgetbook_kit/
├── android/              # Android platform files
├── ios/                  # iOS platform files
├── lib/
│   ├── app/              # Widgetbook app configuration
│   │   ├── widgetbook_app.dart
│   │   └── widgetbook_app.directories.g.dart (generated)
│   ├── stories/          # 218 story files (1-to-1 with package entities)
│   │   ├── analytics_kit/
│   │   ├── auth_kit/
│   │   ├── core_kit/
│   │   ├── data_kit/
│   │   ├── forms_kit/
│   │   ├── localization_kit/
│   │   ├── media_kit/
│   │   ├── monetization_kit/
│   │   ├── navigation_kit/
│   │   ├── notifications_kit/
│   │   └── storage_kit/
│   └── main.dart         # App entry point
├── linux/                # Linux platform files
├── macos/                # macOS platform files
├── test/
│   └── widget_test.dart
├── web/                  # Web platform files
├── windows/              # Windows platform files
├── .gitignore
├── .metadata
├── analysis_options.yaml
├── pubspec.lock
├── pubspec.yaml
└── README.md
```

---

## 📄 Documentation Directory (`docs/`)

```
docs/
├── ARCHITECTURE.md         # System architecture and design
├── BRANCH_STRATEGY.md      # Git branching guidelines
├── BRANDING.md             # Brand guidelines
├── CNAME                   # GitHub Pages custom domain
├── CODE_OF_CONDUCT.md      # Community behavior rules
├── COMMIT_STRATEGY.md      # Commit message conventions
├── COMMUNITY.md            # Community guidelines
├── CONFIGURATION.md        # Configuration guide
├── CONTACT.md              # Contact information
├── CONTRIBUTING.md         # Contribution guidelines
├── DEVELOPMENT_GUIDE.md    # Development workflow
├── FAQ.md                  # Frequently asked questions
├── GETTING_STARTED.md      # Setup and quick start
├── LABELLING_STRATEGY.md   # Issue/PR labeling
├── PR_STRATEGY.md          # Pull request guidelines
├── PROJECT_BOARD.md        # Project management
├── PROJECT_STRUCTURE.md    # This file
├── SECURITY.md             # Security policy
├── STYLE_GUIDE.md          # Code style guidelines
├── SUMMARY.md              # Documentation overview
└── SUPPORT.md              # Support information
```

---

## ⚙️ Configuration Files

### Root Level

- **`.gitignore`** – Git ignore patterns
- **`.releaserc.yml`** – Semantic release configuration
- **`AGENTS.md`** – AI agent guidelines (CRITICAL: English-only requirement)
- **`CHANGELOG.md`** – Project changelog
- **`LICENSE`** – MIT license
- **`melos.yaml`** – Melos monorepo configuration
- **`package.json`** – pnpm scripts (wraps melos commands)
- **`README.md`** – Project overview
- **`REUSE.toml`** – License compliance metadata

### Package Level (each kit in `packages/`)

**Package Configuration:**
- **`pubspec.yaml`** – Package dependencies and metadata
- **`analysis_options.yaml`** – Dart analyzer settings
- **`.metadata`** – Flutter metadata
- **`CHANGELOG.md`** – Package version history
- **`LICENSE`** – MIT license
- **`README.md`** – Package documentation

---

## 🔧 Build Artifacts

### Generated Directories (Not in Git)

```
# Root level
.dart_tool/               # Dart/Flutter tool cache

# Each package
packages/<kit_name>/
└── .dart_tool/           # Package-specific cache

# Widgetbook
widgetbook_kit/
├── .dart_tool/           # Dart tool cache
├── build/                # Build output
│   ├── web/              # Web build
│   ├── android/          # Android APK/AAB
│   └── ios/              # iOS IPA
└── .flutter-plugins      # Flutter plugin registry
```

---

## 📦 Package Exports

Each kit exports its public API from its main library file:

```dart
// packages/core_kit/lib/core_kit.dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

library core_kit;

// Widgets
export 'src/widgets/buttons/primary_button.dart';
export 'src/widgets/cards/info_card.dart';
export 'src/widgets/dialogs/confirm_dialog.dart';

// Models
export 'src/models/theme_config.dart';

// Services
export 'src/services/theme_service.dart';
```

Usage in other packages or apps:

```dart
import 'package:core_kit/core_kit.dart';
import 'package:auth_kit/auth_kit.dart';
import 'package:data_kit/data_kit.dart';

// Use exported widgets/services
PrimaryButton(
  label: 'Login',
  onPressed: () => AuthService.login(),
)
```

---

## 🎯 Key Directories Explained

### `packages/`
Contains 11 independent Flutter kits. Each kit is a self-contained package with its own pubspec.yaml, documentation, and tests.

### `widgetbook_kit/`
Widgetbook catalog app for widget development and documentation. Contains 218 story files mapping 1-to-1 with package entities.

### `docs/`
Comprehensive project documentation covering architecture, development workflows, and contribution guidelines.

### `.github/`
GitHub-specific configurations including CI/CD workflows, issue templates, and community files.

### `.husky/`
Git hooks for pre-commit validation (REUSE compliance, commit message format).

---

## 📝 File Naming Conventions

- **Dart files**: snake_case (e.g., `primary_button.dart`, `auth_service.dart`)
- **Classes**: UpperCamelCase (e.g., `PrimaryButton`, `AuthService`)
- **Story files**: Widget name + story description (e.g., `primary_button.dart` in `widgetbook_kit/lib/stories/`)
- **Test files**: Widget/class name + `_test.dart` (e.g., `primary_button_test.dart`)
- **Config files**: Standard names (e.g., `pubspec.yaml`, `melos.yaml`, `analysis_options.yaml`)
- **Documentation**: SCREAMING_SNAKE_CASE for markdown (e.g., `GETTING_STARTED.md`, `ARCHITECTURE.md`)

---

## 🚀 Build & Deployment

### Development
```bash
# Bootstrap all packages (install dependencies)
pnpm install

# Run Widgetbook for widget development
pnpm storybook

# Run tests across all packages
pnpm test

# Analyze code
pnpm analyze

# Format code
pnpm format
```

### Production
```bash
# Build Widgetbook for web deployment
pnpm build-storybook

# Build individual packages (from package directory)
cd packages/core_kit
flutter build web
```

### Distribution
- **pub.dev**: Each kit published independently
- **Widgetbook**: Deployed from `widgetbook_kit/build/web/` directory

---

For more details on development workflow, see [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md).
