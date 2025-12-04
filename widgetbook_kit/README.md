<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# Widgetbook Kit

**Interactive component catalog for hexaMobileShare with 218+ component stories**

The Widgetbook Kit is a comprehensive visual catalog showcasing all widgets, utilities, and services from the 11 modular packages in hexaMobileShare. It provides an interactive development environment for exploring, testing, and documenting components.

---

## 🔗 Live Preview

**Explore the live Widgetbook catalog:**

**[https://story.mobile.dev.hexatune.com](https://story.mobile.dev.hexatune.com)**

The live preview is automatically updated when changes are merged to the `develop` branch.

---

## 📖 What is Widgetbook?

Widgetbook is a Flutter package that creates an interactive catalog for widgets, similar to Storybook for React. It allows developers and designers to:

- 🎨 Browse all available components visually
- 🔍 Test components with interactive controls (knobs)
- 📱 Preview components in different screen sizes and orientations
- 🌙 Toggle between light and dark themes
- ♿ Test accessibility features
- 📚 View component documentation and usage examples

---

## 🗂️ Structure

The Widgetbook Kit contains **218+ story files** organized by package:

```
widgetbook_kit/
├── lib/
│   ├── app/                              # Widgetbook app configuration
│   │   ├── widgetbook_app.dart          # Main app entry point
│   │   └── widgetbook_app.directories.g.dart  # Auto-generated navigation
│   └── stories/                          # Component stories (1-to-1 with packages)
│       ├── analytics_kit/               # Analytics, logging, feature flags
│       ├── auth_kit/                    # Authentication & authorization
│       ├── core_kit/                    # Core UI widgets & theming
│       ├── data_kit/                    # HTTP client, API handling
│       ├── forms_kit/                   # Form management & validation
│       ├── localization_kit/            # Internationalization
│       ├── media_kit/                   # Media handling
│       ├── monetization_kit/            # In-app purchases
│       ├── navigation_kit/              # Routing & deep linking
│       ├── notifications_kit/           # Push & local notifications
│       └── storage_kit/                 # Local storage & caching
└── main.dart                            # App entry point
```

Each story file corresponds to a specific widget, service, or utility in the packages.

---

## 🚀 Running Locally

### Prerequisites

- Flutter SDK 3.x+
- Dart SDK 3.x+
- Node.js 18+ and pnpm (for monorepo scripts)

### Option 1: Using pnpm Scripts (Recommended)

From the **root** of the monorepo:

```bash
# Install dependencies and bootstrap packages
pnpm install

# Run Widgetbook in Chrome
pnpm storybook

# Or use the specific script
pnpm widgetbook:web
```

This will start Widgetbook at: **http://localhost:8080**

### Option 2: Using Flutter CLI

From the **widgetbook_kit** directory:

```bash
# Get dependencies
flutter pub get

# Run on Chrome (web)
flutter run -d chrome

# Run on macOS
flutter run -d macos

# Run on specific device
flutter devices
flutter run -d <device-id>
```

### Option 3: Using Melos

From the **root** of the monorepo:

```bash
# Bootstrap all packages
melos bootstrap

# Run Widgetbook
cd widgetbook_kit
flutter run -d chrome
```

---

## 🏗️ Building for Production

### Build Web Version

```bash
# From root (using pnpm)
pnpm build-storybook

# Or from widgetbook_kit directory
cd widgetbook_kit
flutter build web --release
```

The build output will be in: `widgetbook_kit/build/web`

### Build for Other Platforms

```bash
cd widgetbook_kit

# macOS
flutter build macos --release

# Linux
flutter build linux --release

# Windows
flutter build windows --release
```

---

## 🚀 Deployment

The Widgetbook is automatically deployed to GitHub Pages when changes are merged to `develop`.

### Automatic Deployment

**Trigger:** Merged PRs to `develop` that modify:
- `widgetbook_kit/**`
- `packages/**`
- `.github/workflows/widgetbook-deploy.yml`

**Live URL:** https://story.mobile.dev.hexatune.com

### Manual Deployment

Trigger deployment manually via GitHub Actions:

1. Go to: `Actions > Deploy Widgetbook to GitHub Pages`
2. Click **Run workflow**
3. Select branch: `develop`
4. Click **Run workflow**

For detailed deployment instructions, see: **[docs/WIDGETBOOK_DEPLOYMENT.md](../docs/WIDGETBOOK_DEPLOYMENT.md)**

---

## 📝 Adding New Stories

When creating a new widget or component in any package, add a corresponding story:

### 1. Create a Story File

```dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default',
  type: MyNewWidget,
)
Widget myNewWidgetUseCase(BuildContext context) {
  return MyNewWidget(
    title: context.knobs.string(
      label: 'Title',
      initialValue: 'Hello World',
    ),
    onTap: () {
      print('Widget tapped!');
    },
  );
}
```

### 2. Organize by Package

Place the story in the appropriate package directory:

```
lib/stories/<package_name>/<feature>/<widget>_stories.dart
```

### 3. Run Code Generation

```bash
# From root
pnpm bootstrap

# Or from widgetbook_kit
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Verify Story Appears

Run Widgetbook and verify the new story appears in the navigation:

```bash
pnpm storybook
```

---

## 🎨 Using Knobs

Knobs allow interactive control of widget properties in Widgetbook:

```dart
@widgetbook.UseCase(name: 'Interactive', type: MyButton)
Widget myButtonUseCase(BuildContext context) {
  return MyButton(
    label: context.knobs.string(
      label: 'Button Label',
      initialValue: 'Click Me',
    ),
    color: context.knobs.color(
      label: 'Background Color',
      initialValue: Colors.blue,
    ),
    enabled: context.knobs.boolean(
      label: 'Enabled',
      initialValue: true,
    ),
    size: context.knobs.list(
      label: 'Size',
      options: ['small', 'medium', 'large'],
      initialOption: 'medium',
    ),
  );
}
```

**Available Knobs:**
- `string()` – Text input
- `boolean()` – Toggle switch
- `number()` – Number input
- `color()` – Color picker
- `list()` – Dropdown selection
- `sliderKnob()` – Slider

---

## 🧪 Testing

Run tests for Widgetbook:

```bash
cd widgetbook_kit
flutter test
```

---

## 📚 Documentation

For more information, see:

- **[Widgetbook Deployment Guide](../docs/WIDGETBOOK_DEPLOYMENT.md)** – Deployment setup and troubleshooting
- **[Development Guide](../docs/DEVELOPMENT_GUIDE.md)** – Development workflow
- **[Project Structure](../docs/PROJECT_STRUCTURE.md)** – Repository organization
- **[Widgetbook Official Docs](https://docs.widgetbook.io)** – Widgetbook package documentation

---

## 🤝 Contributing

When contributing to hexaMobileShare:

1. **Add stories for new components** – Every new widget should have a corresponding Widgetbook story
2. **Update stories when APIs change** – Keep stories in sync with component updates
3. **Test stories locally** – Run `pnpm storybook` to verify stories render correctly
4. **Follow naming conventions** – Use `<widget_name>_stories.dart` format
5. **Include SPDX headers** – All story files must include licensing headers

See **[CONTRIBUTING.md](../docs/CONTRIBUTING.md)** for full contribution guidelines.

---

## 📜 License

This project is licensed under the **MIT License** – see the [LICENSE](../LICENSE) file for details.

```dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT
```

---

## 🔗 Links

- **Live Preview:** https://story.mobile.dev.hexatune.com
- **GitHub Repository:** [hTuneSys/hexaMobileShare](https://github.com/hTuneSys/hexaMobileShare)
- **Deployment Docs:** [docs/WIDGETBOOK_DEPLOYMENT.md](../docs/WIDGETBOOK_DEPLOYMENT.md)
- **Main Project README:** [README.md](../README.md)

---

Built with ❤️ by **hexaTune LLC**
