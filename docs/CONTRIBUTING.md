<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# Contributing to hexaMobileShare

Thank you for your interest in contributing to **hexaMobileShare**!  
This document outlines how to get involved, contribute code or ideas, and follow our development process.

---

## 📚 Before You Start

Please review the following core documents:

- [Getting Started](GETTING_STARTED.md) – Setup guide for new developers
- [Architecture](ARCHITECTURE.md) – Widget library architecture and design
- [Development Guide](DEVELOPMENT_GUIDE.md) – Detailed development workflow
- [Project Structure](PROJECT_STRUCTURE.md) – Repository organization
- [Branch Strategy](BRANCH_STRATEGY.md) – Git branching guidelines
- [FAQ](FAQ.md) – Frequently asked questions

---

## 🧩 Contribution Types

### 1. Code Contributions
- **New Widgets**: Add new UI widgets to the library
- **Widget Enhancements**: Improve existing widgets
- **Bug Fixes**: Fix issues in existing widgets
- **Type Definitions**: Improve Dart types
- **Accessibility**: Enhance ARIA support and keyboard navigation
- **Performance**: Optimize widget rendering and bundle size

### 2. Widgetbook Stories
- Add stories for existing widgets
- Improve widget documentation
- Add interactive examples
- Create accessibility test cases

### 3. Documentation
- Fix typos and improve clarity
- Add code examples
- Write guides and tutorials
- Update API documentation

### 4. Testing
- Write unit tests with Flutter Test framework
- Write widget tests for UI components
- Improve test coverage
- Test on multiple platforms (Android, iOS, Web)

### 5. Issues & Feedback
- Report bugs with reproductions
- Propose new features
- Suggest improvements
- Answer questions in discussions

---

## 🚀 Getting Started

### 1. Fork and Clone

```bash
# Fork the repository on GitHub
# Then clone your fork
git clone https://github.com/YOUR_USERNAME/hexaMobileShare.git
cd hexaMobileShare
```

### 2. Install Dependencies

```bash
pnpm install
```

This will automatically:
- Install Node.js dependencies (Husky, Commitlint)
- Bootstrap all Flutter packages via Melos
- Setup Git hooks for commit validation

### 3. Start Development

```bash
# Start Widgetbook for widget development
pnpm storybook

# Or run a specific package
cd packages/core_kit
flutter run -d chrome
```

---

## 🔀 Branch Strategy

Follow our [Branching Guide](BRANCH_STRATEGY.md):

### Branch Naming

Always branch from `develop` and use one of these prefixes:

- `feat/` – New features or widgets
- `fix/` – Bug fixes
- `refactor/` – Code refactoring
- `test/` – Adding or updating tests
- `docs/` – Documentation changes
- `style/` – Code style/formatting changes
- `perf/` – Performance improvements
- `chore/` – Maintenance tasks
- `ci/` – CI/CD changes
- `build/` – Build system changes

### Examples

```bash
git checkout develop
git pull origin develop
git checkout -b feat/new-button-widget
git checkout -b fix/modal-close-bug
git checkout -b docs/update-getting-started
```

### Important Rules

- **Never** branch from `main`
- **Never** push directly to `main` or `develop`
- Always create a PR for your changes
- Keep branches focused on a single feature/fix

---

## ✏️ Commit & PR Formatting

All commits and pull requests must follow [Conventional Commits](https://www.conventionalcommits.org/):

### Allowed Commit Types

- `feat`: New feature or widget
- `fix`: Bug fix
- `refactor`: Code refactoring
- `test`: Add or update tests
- `docs`: Documentation changes
- `style`: Code formatting (no functional changes)
- `perf`: Performance improvements
- `chore`: Maintenance tasks
- `ci`: CI/CD changes
- `build`: Build system changes
- `release`: Release preparation
- `hotfix`: Critical bug fix

### Commit Message Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Examples

```bash
# Widget changes
feat(Button): add loading state prop
fix(Modal): resolve focus trap issue
refactor(Card): simplify prop structure

# Documentation
docs(README): update installation instructions
docs(Button): add usage examples to story

# Tests
test(Button): add accessibility tests
test(Modal): add keyboard navigation tests

# Chores
chore(deps): update dependencies
chore(storybook): upgrade to v8
```

### PR Titles

PR titles must follow the same format:

```
feat(Button): add loading state support
fix(Modal): resolve keyboard navigation bug
docs: update contribution guidelines
```

---

## 🧪 Development Workflow

### 1. Create a Widget

```bash
# Create widget file
touch src/widgets/core/buttons/NewButton.dart

# Create story file
touch src/widgets/core/buttons/NewButton.stories.dart
```

### 2. Write the Widget

```dart
// packages/core_kit/lib/src/widgets/buttons/new_button.dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary }

class NewButton extends StatelessWidget {
  final String label;
  final ButtonVariant variant;
  final VoidCallback? onPressed;

  const NewButton({
    super.key,
    required this.label,
    this.variant = ButtonVariant.primary,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == ButtonVariant.primary;
    
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary 
            ? Theme.of(context).colorScheme.primary 
            : Theme.of(context).colorScheme.secondary,
      ),
      child: Text(label),
    );
  }
}
```

### 3. Write the Story

```dart
// widgetbook_kit/lib/stories/core_kit/buttons/new_button.dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:core_kit/core_kit.dart';

@UseCase(name: 'Primary', type: NewButton)
Widget primaryButton(BuildContext context) {
  return NewButton(
    label: 'Click me',
    variant: ButtonVariant.primary,
    onPressed: () {},
  );
}

@UseCase(name: 'Secondary', type: NewButton)
Widget secondaryButton(BuildContext context) {
  return NewButton(
    label: 'Click me',
    variant: ButtonVariant.secondary,
    onPressed: () {},
  );
}
```

### 4. Test in Widgetbook

```bash
pnpm storybook
# Open http://localhost:8080 (or the port shown)
```

### 5. Export the Widget

```dart
// packages/core_kit/lib/core_kit.dart
export 'src/widgets/buttons/new_button.dart';
```

### 6. Analyze Code

```bash
pnpm analyze
```

### 7. Format Code

```bash
pnpm format
```

### 8. Commit Changes

```bash
git add .
git commit -m "feat(NewButton): add new button widget"
git push origin feat/new-button-widget
```

---

## 🧪 Testing Guidelines

### Unit Tests

Write tests using Flutter Test framework:

```dart
// packages/core_kit/test/widgets/buttons/new_button_test.dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('NewButton', () {
    testWidgets('renders with label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewButton(
              label: 'Click me',
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text('Click me'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      var pressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NewButton(
              label: 'Click me',
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(NewButton));
      expect(pressed, isTrue);
    });
  });
}
```

Run tests:

```bash
pnpm test
```

### Accessibility

Use Widgetbook's a11y addon:
- Check the "Accessibility" tab in Widgetbook
- Fix any violations
- Ensure keyboard navigation works
- Test with screen readers

---

## 📋 PR Checklist

Before submitting a PR, ensure:

- [ ] Code follows the [Style Guide](STYLE_GUIDE.md)
- [ ] Widget has proper Dart types
- [ ] Widgetbook story is created
- [ ] Widget is exported in package's main library file
- [ ] Tests are written (if applicable)
- [ ] Accessibility is tested
- [ ] Code is formatted (`pnpm format`)
- [ ] Analysis passes (`pnpm analyze`)
- [ ] Commit messages follow conventional format
- [ ] PR title follows conventional format
- [ ] Documentation is updated (if needed)

---

## 🏷 Label System

Labels are automatically assigned based on:
- PR title type (`feat`, `fix`, `docs`, etc.)
- Changed files (widget category)

Refer to [Labelling Strategy](LABELLING_STRATEGY.md) for details.

---

## 🔁 CI/CD & Releases

### Automated Checks

All PRs must pass:
- Code formatting (`dart format`)
- Static analysis (`flutter analyze`)
- Tests (`flutter test`)
- Build verification

### Release Process

1. PRs are merged into `develop`
2. `develop` is tested and validated
3. `develop` is merged to `main`
4. Semantic versioning is automated
5. Packages are published to pub.dev

---

## 🎨 Widget Design Guidelines

### Props Interface

Always define clear parameter types:

```dart
class MyWidget extends StatelessWidget {
  // Required parameters
  final String label;
  
  // Optional parameters with defaults
  final ButtonVariant variant;
  final Size size;
  final bool disabled;
  
  // Event handlers
  final VoidCallback? onPressed;

  const MyWidget({
    super.key,
    required this.label,
    this.variant = ButtonVariant.primary,
    this.size = Size.medium,
    this.disabled = false,
    this.onPressed,
  });
}
```

### Material Design 3 Styling

Use Material Design 3 theming:

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,
  ),
  child: Text(label),
)
```

### State Management

Use Flutter state management patterns:

```dart
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int _count = 0;

  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Count: $_count');
  }
}
```

### Accessibility

- Use Semantics widget for screen readers
- Ensure sufficient color contrast
- Provide keyboard navigation support
- Test with accessibility tools

```dart
Semantics(
  label: ariaLabel,
  button: true,
  enabled: !disabled,
  child: ElevatedButton(
    onPressed: disabled ? null : onPressed,
    child: Text(label),
  ),
)
```

---

## 🙋 Support & Communication

### Questions

- Use [GitHub Discussions](https://github.com/hTuneSys/hexaMobileShare/discussions)
- Check the [FAQ](FAQ.md)
- Review existing issues

### Issues

- Bug reports: Use the [Bug Report Template](../.github/ISSUE_TEMPLATE/bug-report.md)
- Feature requests: Use the [Feature Request Template](../.github/ISSUE_TEMPLATE/feature-request.md)

### Contact

- Email: [info@hexatune.com](mailto:info@hexatune.com)
- Follow our [Code of Conduct](CODE_OF_CONDUCT.md)

---

## 🎯 Priority Areas

We especially welcome contributions in:

1. **Accessibility improvements** – WCAG compliance, semantic labels
2. **Widget tests** – Unit and widget tests
3. **Documentation** – Examples, guides, API docs
4. **New widgets** – Filling gaps in widget coverage
5. **Type safety** – Improving Dart type definitions
6. **Performance** – Rendering optimization, package size reduction

---

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io)
- [Widgetbook Documentation](https://docs.widgetbook.io)
- [Conventional Commits](https://www.conventionalcommits.org/)

---

We're excited to build hexaMobileShare with your help! 🚀

Thank you for contributing!
