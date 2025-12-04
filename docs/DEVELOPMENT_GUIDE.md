<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# DEVELOPMENT_GUIDE.md

This guide helps developers understand how to work with the hexaMobileShare Flutter mobile kit monorepo. It explains the development workflow, tools, best practices, and internal structure.

---

## 🎯 Overview

hexaMobileShare is a modern Flutter monorepo built with:
- **Flutter 3.x** with Material Design 3
- **Dart 3.x** for type safety and null safety
- **Widgetbook** for widget development
- **Melos** for monorepo management
- **Material Design 3** theming system

---

## 🚀 Quick Start

### Prerequisites

Ensure you have installed:
- **Node.js** 18+ (LTS recommended)
  - Download from [nodejs.org](https://nodejs.org/)
  - Verify: `node --version`

- **pnpm** 9+
  ```bash
  npm install -g pnpm
  # Verify
  pnpm --version
  ```

- **Flutter** 3.x+ (stable channel recommended)
  - Download from [flutter.dev](https://flutter.dev/docs/get-started/install)
  - Verify: `flutter --version`

- **Dart** 3.x+ (comes with Flutter)
  - Verify: `dart --version`

- **Git** for version control
  ```bash
  git --version
  ```

### Installation

```bash
# Clone the repository
git clone https://github.com/hTuneSys/hexaMobileShare.git
cd hexaMobileShare

# Install dependencies (bootstraps all Flutter packages)
pnpm install

# Run Widgetbook
pnpm storybook
```

---

## 📁 Project Structure

```
hexaMobileShare/
├── packages/                  # 11 modular kits
│   ├── analytics_kit/        # Analytics, logging, feature flags
│   │   ├── lib/              # Library source code
│   │   ├── test/             # Unit tests
│   │   ├── pubspec.yaml      # Package dependencies
│   │   └── README.md         # Kit documentation
│   ├── auth_kit/             # Authentication & authorization
│   ├── core_kit/             # Core UI widgets & theming
│   ├── data_kit/             # HTTP client, API handling
│   ├── forms_kit/            # Form management & validation
│   ├── localization_kit/     # Internationalization
│   ├── media_kit/            # Audio/video players
│   ├── monetization_kit/     # In-app purchases
│   ├── navigation_kit/       # Routing, deep linking
│   ├── notifications_kit/    # Push & local notifications
│   └── storage_kit/          # Local storage, caching
├── widgetbook_kit/           # Widgetbook catalog app
│   ├── lib/
│   │   ├── app/              # App configuration
│   │   └── stories/          # Widget stories (218 files)
│   ├── android/              # Android platform
│   ├── ios/                  # iOS platform
│   ├── web/                  # Web platform
│   └── pubspec.yaml
├── docs/                     # Documentation
├── melos.yaml                # Monorepo configuration
└── package.json              # Node.js dev dependencies
```

---

## 🧱 Development Workflow

### 1. Widget Development

#### Create Widget Structure

```bash
# Navigate to a kit
cd packages/core_kit/lib

# Create widget file
mkdir -p buttons
touch buttons/custom_button.dart
```

#### Write Widget

```dart
// packages/core_kit/lib/buttons/custom_button.dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool disabled;

  const CustomButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: _getButtonStyle(theme),
      child: Text(label),
    );
  }

  ButtonStyle _getButtonStyle(ThemeData theme) {
    final backgroundColor = switch (variant) {
      ButtonVariant.primary => theme.colorScheme.primary,
      ButtonVariant.secondary => theme.colorScheme.secondary,
      ButtonVariant.accent => theme.colorScheme.tertiary,
    };

    final padding = switch (size) {
      ButtonSize.small => const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ButtonSize.medium => const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ButtonSize.large => const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    };

    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: padding,
    );
  }
}

enum ButtonVariant { primary, secondary, accent }
enum ButtonSize { small, medium, large }
```

#### Write Widgetbook Story

```dart
// widgetbook_kit/lib/stories/core_kit/buttons/custom_button_stories.dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:core_kit/buttons/custom_button.dart';

@UseCase(name: 'Primary', type: CustomButton)
Widget customButtonPrimary(BuildContext context) {
  return CustomButton(
    label: 'Primary Button',
    variant: ButtonVariant.primary,
    onPressed: () {},
  );
}

@UseCase(name: 'Secondary', type: CustomButton)
Widget customButtonSecondary(BuildContext context) {
  return CustomButton(
    label: 'Secondary Button',
    variant: ButtonVariant.secondary,
    onPressed: () {},
  );
}

@UseCase(name: 'Disabled', type: CustomButton)
Widget customButtonDisabled(BuildContext context) {
  return const CustomButton(
    label: 'Disabled Button',
    disabled: true,
  );
}
```

#### Export Widget

```dart
// packages/core_kit/lib/core_kit.dart
library core_kit;

export 'buttons/custom_button.dart';
// ... other exports
```

### 2. View in Widgetbook

```bash
# Start Widgetbook dev server
pnpm storybook

# Open http://localhost:8080
```

Navigate to `Core Kit > Buttons > CustomButton` to see your widget.

### 3. Test Widget

```bash
# Run all CI checks (recommended)
pnpm ci:local

# Or run checks individually:
pnpm ci:format   # Check formatting
pnpm ci:analyze  # Static analysis
pnpm ci:test     # Run tests

# Auto-fix formatting issues
pnpm format:fix
```

---

## 🎨 Styling Guidelines

### Material Design 3 Theming

Use Material Design 3's theming system for consistent styling:

```dart
// Access theme colors
final theme = Theme.of(context);
final primaryColor = theme.colorScheme.primary;
final backgroundColor = theme.colorScheme.background;

// Use semantic colors
Container(
  color: theme.colorScheme.surface,
  child: Text(
    'Hello',
    style: theme.textTheme.bodyLarge,
  ),
)
```

### Widget Styling Best Practices

```dart
// ✅ Good - Use theme colors
Container(
  color: Theme.of(context).colorScheme.primary,
)

// ❌ Bad - Hardcoded colors
Container(
  color: Colors.blue,  // Won't adapt to theme
)

// ✅ Good - Responsive sizing
Padding(
  padding: const EdgeInsets.all(16),
  child: Text(
    'Content',
    style: Theme.of(context).textTheme.bodyMedium,
  ),
)
```

### Theme Support

Widgets automatically support light/dark themes through MaterialApp:

```dart
MaterialApp(
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
  themeMode: ThemeMode.system,  // or ThemeMode.light, ThemeMode.dark
);
```
```

---

## 🧪 Flutter State Management

### StatelessWidget vs StatefulWidget

```dart
// Use StatelessWidget for widgets without internal state
class MyStatelessWidget extends StatelessWidget {
  final String title;
  
  const MyStatelessWidget({Key? key, required this.title}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

// Use StatefulWidget for widgets with internal state
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _counter = 0;
  
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $_counter'),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

### Widget Props (Constructor Parameters)

```dart
class MyWidget extends StatelessWidget {
  // Required parameter
  final String name;
  
  // Optional parameter with default value
  final ButtonVariant variant;
  
  // Optional nullable parameter
  final String? subtitle;
  
  // Callback function
  final VoidCallback? onPressed;

  const MyWidget({
    Key? key,
    required this.name,
    this.variant = ButtonVariant.primary,
    this.subtitle,
    this.onPressed,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name),
        if (subtitle != null) Text(subtitle!),
        if (onPressed != null)
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Click'),
          ),
      ],
    );
  }
}
```

---

## 🧪 Testing

### Unit Tests with Flutter Test

```dart
// packages/core_kit/test/buttons/custom_button_test.dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/buttons/custom_button.dart';

void main() {
  group('CustomButton', () {
    testWidgets('renders with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              label: 'Click me',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Click me'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              label: 'Click',
              onPressed: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Click'));
      await tester.pump();

      expect(wasTapped, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (WidgetTester tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomButton(
              label: 'Click',
              disabled: true,
              onPressed: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Click'));
      await tester.pump();

      expect(wasTapped, isFalse);
    });
  });
}
```

Run tests:

```bash
# Run all tests
pnpm test

# Run tests for specific kit
cd packages/core_kit
flutter test
```

### Accessibility Testing

Use Widgetbook to test accessibility:

1. Open Widgetbook
2. Navigate to your widget story
3. Check semantic labels and contrast
4. Test keyboard navigation
5. Use screen reader to verify behavior

---

## 🔀 Branching & PRs

Follow the naming rules defined in [BRANCH_STRATEGY](BRANCH_STRATEGY.md) and [PR_STRATEGY](PR_STRATEGY.md).

### Allowed Branch Prefixes

- `feat/` – New features or widgets
- `fix/` – Bug fixes
- `refactor/` – Code refactoring
- `test/` – Tests
- `docs/` – Documentation
- `ci/` – CI/CD changes
- `style/` – Code formatting
- `perf/` – Performance improvements
- `chore/` – Maintenance

### Create a Feature Branch

```bash
git checkout develop
git pull origin develop
git checkout -b feat/new-widget
```

### Open a PR

Follow the [PR template](../.github/PULL_REQUEST_TEMPLATE.md):

1. Write descriptive title: `feat(MyButton): add new button widget`
2. Fill out PR description
3. Check all items in the checklist
4. Request review

---

## 🧱 Commit Conventions

Use the supported types from [COMMIT_STRATEGY](COMMIT_STRATEGY.md):

```bash
feat(MyButton): add new button widget
fix(Modal): resolve focus trap issue
docs(README): update installation guide
test(Button): add accessibility tests
refactor(Card): simplify props structure
style: format code with prettier
chore(deps): update dependencies
```

Use semantic and meaningful commits. PRs with vague commits will be rejected.

---

## 🧱 CI/CD Pipeline

### Remote CI (GitHub Actions)

CI runs automatically on Pull Requests to `develop` branch:

- **Code formatting**: `dart format --set-exit-if-changed`
- **Static analysis**: `melos run analyze` (all packages)
- **Tests**: `melos run test` (all packages)
- **Dependency review**: Check for vulnerable dependencies
- **REUSE compliance**: Verify SPDX headers

**Triggers**:
- Pull Requests to `develop` branch
- Changes to `packages/**`, `widgetbook_kit/**`, `.github/workflows/ci.yml`, or `package.json`
- Manual workflow dispatch

See [`.github/workflows/ci.yml`](../.github/workflows/ci.yml) for full configuration.

### Local CI Checks (Before Push)

**Run the same checks locally to catch issues before pushing:**

```bash
# 🎯 RECOMMENDED: Run all CI checks at once
pnpm ci:local

# Or run checks individually:
pnpm ci:format   # Format check (fails if code needs formatting)
pnpm ci:analyze  # Static analysis (all packages)
pnpm ci:test     # Unit & widget tests (all packages)

# If format check fails, auto-fix with:
pnpm format:fix
```

### Pre-Push Hook (Automatic)

A Git hook (`.husky/pre-push`) **automatically** runs before every `git push`:

```bash
git push origin feat/my-feature
```

**What it does:**
1. ✅ Checks Dart formatting (`pnpm ci:format`)
2. ✅ Runs static analysis (`pnpm ci:analyze`)
3. ✅ Runs all tests (`pnpm ci:test`)
4. ❌ **Blocks push if any check fails**

**Output example:**

```
🔍 Running CI checks before push...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📝 [1/3] Checking Dart formatting...
✅ Format check passed

🔬 [2/3] Running static analysis...
✅ Static analysis passed

🧪 [3/3] Running tests...
✅ Tests passed

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✨ All CI checks passed! Proceeding with push...
```

**If a check fails:**

```bash
❌ Format check failed!
💡 Run 'pnpm format:fix' to auto-fix formatting issues
```

### CI Workflow Comparison

| Check | Local (`pnpm ci:local`) | Pre-Push Hook | Remote CI (GitHub) |
|-------|-------------------------|---------------|--------------------|
| **Format** | ✅ | ✅ | ✅ |
| **Analyze** | ✅ | ✅ | ✅ |
| **Tests** | ✅ | ✅ | ✅ |
| **Dependency Review** | ❌ | ❌ | ✅ (PR only) |
| **Coverage Upload** | ❌ | ❌ | ✅ (Codecov) |
| **When runs** | Manual | Every `git push` | Every PR |

### Bypass Pre-Push Hook (Not Recommended)

In emergency situations only:

```bash
# Skip pre-push hook (NOT RECOMMENDED - CI will still fail)
git push --no-verify
```

⚠️ **Warning**: Bypassing the hook means CI will likely fail on GitHub, delaying your PR review.

### CI Best Practices

1. **Run `pnpm ci:local` before committing** - Catch issues early
2. **Don't bypass pre-push hook** - It saves you from failed CI
3. **Fix issues incrementally** - Don't accumulate formatting/analysis issues
4. **Keep tests fast** - Slow tests discourage running them
5. **Monitor CI feedback** - Address CI failures promptly

---

## 🛡️ Branch Protection

Branches like `main`, `release/*`, and `develop` are protected:

- Require PR review
- Require status checks to pass
- Require conventional commit titles
- No direct pushes allowed

---

## 📚 Documentation & Contributions

### Widget Documentation

- Write Widgetbook stories with `tags: ['autodocs']`
- Add JSDoc comments to Dart interfaces
- Include usage examples in stories
- Document all props and events

### Update Documentation Files

When modifying features, update relevant `.md` files in `docs/`:

- [ARCHITECTURE](ARCHITECTURE.md) – System design
- [CONFIGURATION](CONFIGURATION.md) – Config changes
- [PROJECT_STRUCTURE](PROJECT_STRUCTURE.md) – Directory changes

Follow the guide in [CONTRIBUTING](CONTRIBUTING.md).

---

## 🧠 Helpful Resources

### Internal Docs

- [GETTING_STARTED](GETTING_STARTED.md) – Initial setup and quick commands
- [ARCHITECTURE](ARCHITECTURE.md) – System design and modules
- [CONFIGURATION](CONFIGURATION.md) – Configuration details
- [CONTRIBUTING](CONTRIBUTING.md) – Contribution guidelines
- [PROJECT_STRUCTURE](PROJECT_STRUCTURE.md) – Directory structure
- [CONTACT](CONTACT.md), [SUPPORT](SUPPORT.md) – Communication channels
- [LABELLING_STRATEGY](LABELLING_STRATEGY.md) – Tag issues/PRs correctly
- [BRANCH_STRATEGY](BRANCH_STRATEGY.md) – Branch naming conventions
- [COMMIT_STRATEGY](COMMIT_STRATEGY.md) – Commit message conventions

### External Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io)
- [Widgetbook Documentation](https://docs.widgetbook.io)
- [Melos Documentation](https://melos.invertase.dev)

---

## 🎯 Best Practices

### Widget Design

1. **Single Responsibility**: Each widget should do one thing well
2. **Composability**: Build complex UIs from simple widgets
3. **Type Safety**: Always define Dart interfaces
4. **Accessibility**: ARIA attributes, keyboard navigation, focus management
5. **Documentation**: Write clear stories and prop descriptions

### Code Quality

1. **Format on Save**: Enable Dart formatting in your IDE
2. **Analyze**: Run `pnpm analyze` before committing
3. **Test Accessibility**: Use Widgetbook to verify accessibility
4. **Keep it Simple**: Avoid over-engineering
5. **Follow Conventions**: Use established patterns in the codebase

### Performance

1. **Use const Constructors**: Mark widgets as const when possible
2. **Minimize Re-builds**: Use StatelessWidget when state isn't needed
3. **Lazy Load**: Use ListView.builder for long lists
4. **Optimize Builds**: Profile with Flutter DevTools

---

## 🐛 Debugging

### Flutter DevTools

Use Flutter DevTools for debugging:

```bash
# Run app in debug mode
flutter run

# DevTools will be available at the URL shown in console
```

### Widgetbook Debugging

- Use `debugPrint()` in widget code
- Check Flutter console for errors
- Use Widgetbook's knobs to test different props

### Analyzer Errors

```bash
# Check for errors
pnpm analyze

# Format code
pnpm format
```

---

## 📦 Building & Publishing

### Build Widgetbook

```bash
# Build static Widgetbook web app
pnpm build-storybook

# Output in widgetbook_kit/build/web/
```

### Publish to pub.dev

```bash
# Navigate to kit
cd packages/core_kit

# Dry run
flutter pub publish --dry-run

# Publish
flutter pub publish
```

---

## 🎨 Code Style

### Dart

- Follow official Dart style guide
- Use type annotations for public APIs
- Avoid dynamic types
- Use type inference for local variables

### Flutter

- Use const constructors when possible
- Prefer StatelessWidget over StatefulWidget when no state is needed
- Keep widget build methods under 100 lines
- Extract complex logic to separate methods or classes

### Formatting

- Use `dart format` (configured)
- 80 character line width
- Trailing commas for better formatting

---

## 🚦 Quality Gates

Before merging PR:

- ✅ All tests pass
- ✅ Static analysis passes (no warnings)
- ✅ Code is formatted
- ✅ REUSE compliance check passes
- ✅ Widgetbook builds successfully
- ✅ No accessibility violations
- ✅ PR approved by maintainer

---

Welcome to the hexaMobileShare dev team! Let's build amazing widgets together! 🚀
