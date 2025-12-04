<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

<div align="center">

# hexaMobileShare

**A comprehensive Flutter mobile kit monorepo with 11 modular packages and 200+ production-ready widgets**

[![CI Status](https://github.com/hTuneSys/hexaMobileShare/actions/workflows/ci.yml/badge.svg)](https://github.com/hTuneSys/hexaMobileShare/actions/workflows/ci.yml)
[![REUSE Compliance](https://api.reuse.software/badge/github.com/hTuneSys/hexaMobileShare)](https://api.reuse.software/info/github.com/hTuneSys/hexaMobileShare)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)

[**Documentation**](docs/SUMMARY.md) • [**Getting Started**](docs/GETTING_STARTED.md) • [**Contributing**](docs/CONTRIBUTING.md) • [**Widgetbook**](https://story.mobile.dev.hexatune.com)

</div>

---

## 🎯 What is hexaMobileShare?

**hexaMobileShare** is a production-ready Flutter mobile kit monorepo designed to accelerate cross-platform mobile app development. It provides 11 specialized kits with modular widgets, services, and utilities built with modern Flutter best practices.

### ✨ Key Features

- 📦 **11 Modular Kits** – Analytics, Auth, Core UI, Data, Forms, Localization, Media, Monetization, Navigation, Notifications, Storage
- 🎨 **Material Design 3** – Beautiful, themeable widgets following Material Design 3 guidelines
- 📖 **Widgetbook Integration** – Interactive component catalog with 218 story files ([Live Preview](https://story.mobile.dev.hexatune.com))
- 🔐 **Type-Safe** – Leveraging Dart's strong type system
- ♿ **Accessibility-First** – Built with screen readers and inclusive design in mind
- 🚀 **Production-Ready** – Tested, documented, and optimized for performance
- 🌍 **Internationalization** – Built-in i18n support with localization_kit
- 🧪 **Well-Tested** – Comprehensive unit and widget tests
- 📱 **Cross-Platform** – Works seamlessly on iOS, Android, Web, macOS, Linux, and Windows

---

## 📦 Package Structure

The monorepo contains 11 specialized kits organized for maximum modularity:

### Core Packages

| Package | Description | Key Features |
|---------|-------------|--------------|
| **[analytics_kit](packages/analytics_kit/)** | Analytics, logging, feature flags | Event tracking, screen analytics, logger, feature toggles |
| **[auth_kit](packages/auth_kit/)** | Authentication & authorization | OAuth, JWT, biometric auth, session management |
| **[core_kit](packages/core_kit/)** | Core UI widgets & theming | Buttons, layout, typography, Material Design 3 theme |
| **[data_kit](packages/data_kit/)** | HTTP client & API handling | REST client, pagination, error mapping, retry policies |
| **[forms_kit](packages/forms_kit/)** | Form management & validation | Form controllers, validators, custom form fields |
| **[localization_kit](packages/localization_kit/)** | Internationalization (i18n) | Multi-language support, translation management |
| **[media_kit](packages/media_kit/)** | Media handling | Audio/video players, image pickers, camera integration |
| **[monetization_kit](packages/monetization_kit/)** | In-app purchases & subscriptions | IAP handling, subscription management, payment flows |
| **[navigation_kit](packages/navigation_kit/)** | Routing & deep linking | Declarative routing, deep links, navigation guards |
| **[notifications_kit](packages/notifications_kit/)** | Push & local notifications | Firebase Cloud Messaging, local notifications, badges |
| **[storage_kit](packages/storage_kit/)** | Local storage & caching | Secure storage, key-value store, database abstraction |

### Development Tools

| Tool | Description |
|------|-------------|
| **[widgetbook_kit](widgetbook_kit/)** | Interactive component catalog with 218 stories ([Live Preview](https://story.mobile.dev.hexatune.com)) |

---

## 🚀 Quick Start

### Prerequisites

- **Flutter SDK** 3.x+ ([Install Flutter](https://docs.flutter.dev/get-started/install))
- **Dart SDK** 3.x+
- **Node.js** 18+ and **pnpm** 9+:
  ```bash
  npm install -g pnpm
  # Verify
  pnpm --version
  ```

### Installation (Development)

1. **Clone the repository**:
   ```bash
   git clone https://github.com/hTuneSys/hexaMobileShare.git
   cd hexaMobileShare
   ```

2. **Install dependencies** (installs Node.js dependencies and bootstraps all Flutter packages):
   ```bash
   pnpm install
   ```
   This will automatically:
   - Install Node.js dependencies (Husky, Commitlint)
   - Bootstrap all Flutter packages via Melos
   - Setup Git hooks for commit validation

3. **Run Widgetbook** (explore components interactively):
   ```bash
   pnpm storybook
   ```
   Opens at [http://localhost:8080](http://localhost:8080)
   
   **Live Preview:** [https://story.mobile.dev.hexatune.com](https://story.mobile.dev.hexatune.com)

### Installation (As a Dependency)

Add individual kits to your Flutter project:

```yaml
# pubspec.yaml
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

> **Note**: Packages will be published to pub.dev in the future for easier installation.

---

## 📚 Usage Examples

### Example 1: Using Core UI Components

```dart
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(height: 16), // From core_kit/layout
          ResponsivePadding( // From core_kit/layout
            child: Text('Welcome to hexaMobileShare!'),
          ),
        ],
      ),
    );
  }
}
```

### Example 2: Form Validation

```dart
import 'package:forms_kit/forms_kit.dart';

final formController = FormController(
  fields: {
    'email': FormFieldConfig(
      validators: [EmailValidator(), RequiredValidator()],
    ),
    'password': FormFieldConfig(
      validators: [PasswordValidator(minLength: 8), RequiredValidator()],
    ),
  },
);

// In your widget
AppForm(
  controller: formController,
  onSubmit: (values) {
    print('Form submitted: $values');
  },
  child: Column(
    children: [
      FormFieldWrapper(name: 'email'),
      FormFieldWrapper(name: 'password'),
    ],
  ),
);
```

### Example 3: API Data Fetching

```dart
import 'package:data_kit/data_kit.dart';

final apiClient = ApiClient(baseUrl: 'https://api.example.com');

// Fetch paginated data
final paginationController = PaginationController<User>(
  fetchPage: (page) async {
    final result = await apiClient.get('/users?page=$page');
    return PaginatedResponse.fromJson(result.data);
  },
);

// In your widget
PagedListView(
  controller: paginationController,
  itemBuilder: (context, user, index) => UserListItem(user: user),
);
```

---

## 🛠️ Development

### Common Commands

```bash
# Install dependencies and bootstrap all packages
pnpm install

# Run tests across all packages
pnpm test

# Run static analysis
pnpm analyze

# Format all Dart code
pnpm format

# Auto-fix formatting issues
pnpm format:fix

# Clean build artifacts
pnpm clean

# Run Widgetbook in Chrome (web)
pnpm storybook
# or
pnpm widgetbook:web

# Build Widgetbook for deployment
pnpm build-storybook
# or
pnpm widgetbook:build
```

### CI Quality Checks (Before Push)

Run the same checks that CI runs to catch issues early:

```bash
# Run all CI checks locally (recommended before push)
pnpm ci:local

# Or run checks individually:
pnpm ci:format   # Check code formatting
pnpm ci:analyze  # Run static analysis
pnpm ci:test     # Run all tests
```

**Note**: A pre-push Git hook automatically runs `pnpm ci:local` before every push. If any check fails, the push will be blocked. To fix formatting issues quickly, run `pnpm format:fix`.

### Package-Specific Development

```bash
# Navigate to a specific package and run Flutter commands
cd packages/core_kit
flutter test
flutter pub add provider

# Or use Melos directly for scoped operations
melos run core:analyze
melos exec --scope="auth_kit" -- flutter test
```

---

## 📖 Documentation

Comprehensive documentation is available in the [`docs/`](docs/) directory:

### Getting Started
- [**Getting Started Guide**](docs/GETTING_STARTED.md) – Setup, installation, quick start
- [**FAQ**](docs/FAQ.md) – Frequently asked questions

### Architecture & Design
- [**Architecture**](docs/ARCHITECTURE.md) – System design, widget architecture, technology stack
- [**Project Structure**](docs/PROJECT_STRUCTURE.md) – Directory organization, file layout
- [**Configuration**](docs/CONFIGURATION.md) – Configuration files and settings
- [**Widgetbook Deployment**](docs/WIDGETBOOK_DEPLOYMENT.md) – GitHub Pages deployment guide

### Development
- [**Development Guide**](docs/DEVELOPMENT_GUIDE.md) – Workflow, best practices, tooling
- [**Contributing Guide**](docs/CONTRIBUTING.md) – How to contribute code, docs, issues
- [**Style Guide**](docs/STYLE_GUIDE.md) – Code formatting, naming conventions

### Git Workflow
- [**Branch Strategy**](docs/BRANCH_STRATEGY.md) – Branch naming, Git flow
- [**Commit Strategy**](docs/COMMIT_STRATEGY.md) – Conventional Commits format
- [**PR Strategy**](docs/PR_STRATEGY.md) – Pull request guidelines, review process
- [**Labelling Strategy**](docs/LABELLING_STRATEGY.md) – Issue/PR labels

### Community & Support
- [**Code of Conduct**](docs/CODE_OF_CONDUCT.md) – Community behavior guidelines
- [**Support**](docs/SUPPORT.md) – How to get help
- [**Security**](docs/SECURITY.md) – Security policy, vulnerability reporting

### AI Agent Guidelines
- [**AGENTS.md**](AGENTS.md) – Guidelines for AI agents contributing to the project

---

## 🤝 Contributing

We welcome contributions from the community! Here's how to get started:

1. **Read the [Contributing Guide](docs/CONTRIBUTING.md)**
2. **Check out [open issues](https://github.com/hTuneSys/hexaMobileShare/issues)**
3. **Fork the repository** and create a feature branch:
   ```bash
   git checkout -b feat/my-new-feature
   ```
4. **Make your changes** following our [Style Guide](docs/STYLE_GUIDE.md)
5. **Write tests** and ensure they pass:
   ```bash
   pnpm test
   ```
6. **Commit using [Conventional Commits](docs/COMMIT_STRATEGY.md)**:
   ```bash
   git commit -m "feat(core-kit): add new button variant"
   ```
   (Husky will automatically validate your commit message format)
7. **Push and create a pull request** following our [PR Strategy](docs/PR_STRATEGY.md)

### Key Requirements

- ✅ All code and documentation must be in **English only** (see [AGENTS.md](AGENTS.md))
- ✅ Follow **Conventional Commits** format for commit messages
- ✅ Include **SPDX license headers** in all source files (REUSE compliance)
- ✅ Write **tests** for new features
- ✅ Update **documentation** and **Widgetbook stories** as needed
- ✅ Ensure **CI checks pass** before requesting review
  - Run `pnpm ci:local` to verify all checks locally
  - Pre-push hook automatically validates before push

---

## 🧪 Testing

Run tests across all packages:

```bash
# Run all tests
pnpm test

# Run tests with coverage (via Melos)
melos exec -- flutter test --coverage

# Run tests for a specific package
cd packages/auth_kit && flutter test
```

---

## 📊 Project Status

- ✅ **REUSE Compliant** – All 912 files have proper SPDX licensing
- ✅ **CI/CD Pipeline** – Automated testing, formatting, analysis, and builds
- ✅ **Widgetbook Integration** – 218 interactive component stories ([Live Preview](https://story.mobile.dev.hexatune.com))
- ✅ **Comprehensive Documentation** – 20+ documentation files
- 🚧 **Active Development** – New kits and features in progress

---

## 📜 License

This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.

All source files include SPDX headers for [REUSE](https://reuse.software/) compliance:

```dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT
```

---

## 🌐 Links & Resources

- **Documentation**: [docs/SUMMARY.md](docs/SUMMARY.md)
- **GitHub Repository**: [hTuneSys/hexaMobileShare](https://github.com/hTuneSys/hexaMobileShare)
- **Issues**: [Report bugs or request features](https://github.com/hTuneSys/hexaMobileShare/issues)
- **Discussions**: [GitHub Discussions](https://github.com/hTuneSys/hexaMobileShare/discussions)
- **Website**: [hexatune.com](https://hexatune.com)
- **Email**: [info@hexatune.com](mailto:info@hexatune.com)

### Flutter Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io)
- [Melos (Monorepo Management)](https://melos.invertase.dev)
- [Widgetbook](https://docs.widgetbook.io)

---

## 🙏 Acknowledgments

Built with ❤️ by **hexaTune LLC**

Special thanks to the Flutter community and all contributors who make this project possible.

---

<div align="center">

**[⬆ Back to Top](#hexamobileshare)**

</div>
