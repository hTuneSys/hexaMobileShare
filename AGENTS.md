<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# AI Agent Guidelines for hexaMobileShare

This document provides critical information for AI agents working on the hexaMobileShare project. It ensures consistent, high-quality contributions aligned with project standards.

---

## 📌 Table of Contents

- [Project Overview](#project-overview)
- [Language Requirements](#language-requirements)
- [Project Architecture](#project-architecture)
- [Development Standards](#development-standards)
- [Contribution Workflow](#contribution-workflow)
- [Quality Assurance](#quality-assurance)

---

## Project Overview

**hexaMobileShare** is a Flutter-based mobile kit monorepo designed as a comprehensive collection of reusable widgets, utilities, and services for building cross-platform mobile applications.

- **Organization**: hexaTune LLC
- **License**: MIT
- **Technology Stack**: Flutter 3.x, Dart 3.x, Melos (monorepo management), Material Design 3
- **Primary Goal**: Provide modular, well-documented, and tested mobile development kits

---

## Language Requirements

### 1. **ENGLISH ONLY FOR PROJECT FILES**

**⚠️ ABSOLUTE REQUIREMENT:** All code, comments, documentation, commit messages, PR titles, branch names, and any text within project files **MUST BE IN ENGLISH ONLY**.

This includes but is not limited to:
- ✅ Dart code and comments
- ✅ Documentation files (README.md, docs/*, CHANGELOG.md)
- ✅ Git commit messages
- ✅ Pull request titles and descriptions
- ✅ Branch names
- ✅ Issue titles and descriptions
- ✅ Configuration files (pubspec.yaml, melos.yaml, etc.)
- ✅ Test descriptions and assertions
- ✅ Variable, function, and class names
- ✅ String literals in code (unless specifically for localization purposes)

**Note:** Communication between developers and AI agents can be in any language, but all content written to project files must be in English.

### 2. **Why English Only?**

- **Global Collaboration**: Enables developers worldwide to contribute and understand the codebase
- **Consistency**: Ensures uniform documentation and code readability
- **Tooling Compatibility**: Most development tools, linters, and CI/CD systems expect English
- **Professionalism**: Industry-standard practice for open-source and commercial projects

---

## Project Architecture

### Monorepo Structure

```
hexaMobileShare/
├── packages/                  # 11 modular kits
│   ├── analytics_kit/        # Analytics, logging, feature flags
│   ├── auth_kit/             # Authentication & authorization
│   ├── core_kit/             # Core UI widgets & theming (Material Design 3)
│   ├── data_kit/             # HTTP client, API handling, pagination
│   ├── forms_kit/            # Form management & validation
│   ├── localization_kit/     # Internationalization (i18n)
│   ├── media_kit/            # Audio/video players, media handling
│   ├── monetization_kit/     # In-app purchases, subscriptions
│   ├── navigation_kit/       # Routing, deep linking
│   ├── notifications_kit/    # Push & local notifications
│   └── storage_kit/          # Local storage, caching
├── widgetbook_kit/           # Widgetbook catalog app (218 story files)
└── docs/                     # Comprehensive project documentation
```

### Package Organization

Each kit follows a standard structure:
```
<kit_name>/
├── lib/
│   └── <kit_name>.dart      # Public API entry point
├── test/
│   └── <kit_name>_test.dart
├── pubspec.yaml             # Dependencies
├── CHANGELOG.md             # Version history
└── README.md                # Kit documentation
```

### Widgetbook Structure

```
widgetbook_kit/
├── lib/
│   ├── app/                 # Widgetbook app configuration
│   └── stories/             # 218 story files (1-to-1 mapping with package entities)
│       ├── analytics_kit/
│       ├── auth_kit/
│       ├── core_kit/
│       └── ...
└── test/
```

### Widgetbook Story Requirements

**IMPORTANT**: Every Widgetbook story file must follow these strict requirements:

1. **Required Number of Variants**
   - Each component story **MUST** have between **5-10 variants** (use cases)
   - This ensures comprehensive coverage of component states and configurations
   - Include common use cases, edge cases, and different visual states

2. **Single Component Per Variant**
   - Each variant (use case) must display **only one component instance**
   - Do NOT show multiple instances, variations, or examples in a single variant
   - Each variant should represent a specific state or configuration of the component

3. **Interactive Playground Variant (MANDATORY)**
   - Every story file **MUST** include an "Interactive Playground" variant
   - This variant must be the **first variant** in the story
   - This variant must display **only ONE component instance**
   - This variant must expose **ALL component props as knobs**
   - Every single property of the component must be adjustable via knobs
   - Users should be able to modify any property in real-time and see instant visual feedback
   - Use appropriate knob types:
     - `context.knobs.boolean()` for boolean props
     - `context.knobs.string()` for string props
     - `context.knobs.number()` for numeric props
     - `context.knobs.list()` for enum/option props
     - `context.knobs.colorOrNull()` for color props (returns nullable Color)
   - **CRITICAL**: Do NOT show multiple component instances in Interactive Playground
   - **CRITICAL**: ALL component properties must have corresponding knobs

**Example Story Structure**:
```dart
@WidgetbookUseCase(name: 'Interactive Playground', type: MyButton)
Widget interactivePlayground(BuildContext context) {
  return MyButton(
    label: context.knobs.string(label: 'Label', initialValue: 'Click Me'),
    isEnabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
    variant: context.knobs.list(
      label: 'Variant',
      options: ['primary', 'secondary', 'outlined'],
      initialOption: 'primary',
    ),
    size: context.knobs.number(label: 'Size', initialValue: 48).toDouble(),
    onPressed: () {},
  );
}

@WidgetbookUseCase(name: 'Primary Button', type: MyButton)
Widget primaryButton(BuildContext context) {
  return MyButton(
    label: 'Primary',
    variant: 'primary',
    onPressed: () {},
  );
}

@WidgetbookUseCase(name: 'Disabled State', type: MyButton)
Widget disabledState(BuildContext context) {
  return MyButton(
    label: 'Disabled',
    isEnabled: false,
    onPressed: () {},
  );
}
```

**Key Points**:
- Each variant shows ONE component in a specific state
- Interactive Playground allows real-time exploration of all props
- Other variants demonstrate specific use cases or states
- Keep variants focused and purposeful

---

## Development Standards

### 1. **Code Style**

- Follow **official Dart style guide** (https://dart.dev/guides/language/effective-dart/style)
- Use `dart format .` before committing
- Run `flutter analyze` and resolve all warnings
- Maximum line length: 80 characters
- Use trailing commas for better formatting

### 2. **Naming Conventions**

- **Files**: `snake_case.dart` (e.g., `auth_service.dart`)
- **Classes**: `UpperCamelCase` (e.g., `AuthService`)
- **Variables/Functions**: `lowerCamelCase` (e.g., `getUserProfile()`)
- **Constants**: `lowerCamelCase` (e.g., `defaultTimeout`)
- **Private members**: Prefix with `_` (e.g., `_privateMethod()`)

### 3. **Documentation**

- Use **Dartdoc comments** (`///`) for public APIs
- Include code examples in documentation where helpful
- Keep README.md files up-to-date for each kit
- Document complex logic with inline comments

### 4. **Testing**

- Write unit tests for all business logic
- Use widget tests for UI components
- Aim for meaningful test coverage (focus on critical paths)
- Name tests clearly: `test('description of what is being tested', () { ... })`

### 5. **Dependencies**

- Minimize external dependencies
- Use well-maintained, popular packages
- Document why each dependency is needed
- Keep dependencies up-to-date via Dependabot

### 6. **Licensing (REUSE Compliance)**

Every source file **MUST** include SPDX headers:

```dart
// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT
```

For Markdown/YAML files:
```markdown
<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->
```

Run `reuse lint` before committing to ensure compliance.

---

## Contribution Workflow

### 1. **Branch Strategy**

- **Main branches**: `main` (stable), `develop` (active development)
- **Feature branches**: `feat/<description>` (e.g., `feat/add-dark-mode`)
- **Bugfix branches**: `fix/<description>` (e.g., `fix/auth-token-refresh`)
- **Hotfix branches**: `hotfix/<description>` (e.g., `hotfix/critical-crash`)

See [docs/BRANCH_STRATEGY.md](docs/BRANCH_STRATEGY.md) for details.

### 2. **Commit Messages**

Follow **Conventional Commits** format:

```
<type>(<scope>): <subject>

<body> (optional)

<footer> (optional)
```

**Allowed types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`, `perf`, `build`, `release`, `hotfix`

**Examples**:
```
feat(auth-kit): add biometric authentication support
fix(core-kit): resolve button ripple effect on dark theme
docs(getting-started): update installation instructions
test(data-kit): add pagination controller tests
```

See [docs/COMMIT_STRATEGY.md](docs/COMMIT_STRATEGY.md) for details.

### 3. **Pull Requests**

- Use the PR template (`.github/PULL_REQUEST_TEMPLATE.md`)
- Title must follow Conventional Commits format
- Link related issues (e.g., `Closes #42`)
- Request reviews from team members
- Ensure CI checks pass before merging
- Keep PRs focused (single feature/fix per PR)

See [docs/PR_STRATEGY.md](docs/PR_STRATEGY.md) for details.

### 4. **pnpm Commands**

```bash
# Bootstrap all packages (install dependencies)
pnpm bootstrap

# Run tests across all packages
pnpm test

# Run static analysis
pnpm analyze

# Format all Dart code
pnpm format

# Start Widgetbook
pnpm storybook

# Build Widgetbook
pnpm build-storybook
```

---

## Quality Assurance

### 1. **Pre-Commit Checks**

The following checks run automatically via Git hooks:

- **REUSE compliance**: Ensures all files have proper licensing
- **Commit message format**: Validates Conventional Commits format

### 2. **CI Pipeline**

On every push/PR, GitHub Actions runs:

- ✅ Code formatting check (`dart format --set-exit-if-changed`)
- ✅ Static analysis (`flutter analyze`)
- ✅ Unit & widget tests (`flutter test`)
- ✅ REUSE compliance check
- ✅ Widgetbook build (web)

See `.github/workflows/ci.yml` for full pipeline.

### 3. **Code Review Checklist**

Before approving a PR, verify:

- [ ] Code is in **English only** (no other languages)
- [ ] SPDX headers are present
- [ ] Code is formatted (`dart format`)
- [ ] No analyzer warnings
- [ ] Tests pass locally and in CI
- [ ] Documentation is updated (README, Dartdoc)
- [ ] Commit messages follow Conventional Commits
- [ ] PR description is clear and complete

---

## Key Project Files

### Configuration Files

- **`melos.yaml`**: Monorepo configuration
- **`pubspec.yaml`**: Package dependencies (per kit)
- **`analysis_options.yaml`**: Dart analyzer settings (per kit)
- **`.github/workflows/`**: CI/CD pipelines
- **`.husky/`**: Git hooks for pre-commit checks
- **`REUSE.toml`**: REUSE compliance configuration

### Documentation

- **`README.md`**: Project overview and quick start
- **`docs/ARCHITECTURE.md`**: Detailed architecture guide
- **`docs/DEVELOPMENT_GUIDE.md`**: Setup and development workflow
- **`docs/STYLE_GUIDE.md`**: Dart/Flutter coding standards
- **`docs/GETTING_STARTED.md`**: Step-by-step getting started guide
- **`docs/CONTRIBUTING.md`**: How to contribute

---

## Common Patterns & Best Practices

### 1. **Widget Development**

- Use `const` constructors wherever possible for performance
- Prefer `StatelessWidget` over `StatefulWidget` when state isn't needed
- Extract complex widgets into separate files
- Follow Material Design 3 guidelines for UI consistency

### 2. **Material Design 3 - STRICT REQUIREMENTS**

**⚠️ ABSOLUTE REQUIREMENT:** All UI components MUST strictly follow Material Design 3 guidelines. Custom styling outside of Material Design 3 is **PROHIBITED**.

**DO NOT use:**
- ❌ Custom CSS (Flutter doesn't use CSS)
- ❌ Custom colors outside of Material Design 3 ColorScheme
- ❌ Custom fonts outside of Material Design 3 Typography
- ❌ Custom styling that contradicts Material Design 3 specifications
- ❌ Arbitrary padding, margin, or spacing values
- ❌ Custom elevation values outside Material Design 3 standards
- ❌ Custom border radius values outside Material Design 3 standards

**MUST use:**
- ✅ Material Design 3 ColorScheme (`Theme.of(context).colorScheme`)
- ✅ Material Design 3 TextTheme (`Theme.of(context).textTheme`)
- ✅ Material Design 3 component variants (filled, outlined, text, etc.)
- ✅ Material Design 3 spacing system (`AppSpacing` from core_kit)
- ✅ Material Design 3 radius system (`AppRadius` from core_kit)
- ✅ Material Design 3 elevation system (0, 1, 2, 3, 4, 6, 8, 12, 16, 24)
- ✅ Material Design 3 motion and animation guidelines

**Example - Correct Usage:**
```dart
// ✅ CORRECT - Using Material Design 3 ColorScheme
Container(
  color: Theme.of(context).colorScheme.primaryContainer,
  child: Text(
    'Hello',
    style: Theme.of(context).textTheme.bodyLarge,
  ),
)

// ✅ CORRECT - Using core_kit spacing
Padding(
  padding: EdgeInsets.all(AppSpacing.md),
  child: child,
)
```

**Example - Incorrect Usage:**
```dart
// ❌ WRONG - Custom colors
Container(
  color: Color(0xFF123456), // Custom hex color
  child: child,
)

// ❌ WRONG - Custom font sizes
Text(
  'Hello',
  style: TextStyle(fontSize: 17.5), // Arbitrary font size
)

// ❌ WRONG - Arbitrary spacing
Padding(
  padding: EdgeInsets.all(13.5), // Non-standard spacing
  child: child,
)
```

**Rationale:**
- Ensures visual consistency across the entire application
- Maintains accessibility standards (contrast, font scaling, etc.)
- Enables automatic theme switching (light/dark mode)
- Reduces maintenance burden
- Follows industry best practices
- Improves developer experience with predictable components

**Resources:**
- Material Design 3: https://m3.material.io
- Flutter Material 3: https://docs.flutter.dev/ui/design/material
- hexaMobileShare core_kit: Use components from `core_kit` package

### 3. **State Management**

- Use appropriate state management for the use case
- Prefer immutability
- Document state flow in complex features

### 4. **Error Handling**

- Use typed exceptions (e.g., `AuthException`, `NetworkException`)
- Provide meaningful error messages
- Log errors appropriately (use `analytics_kit`)
- Handle edge cases gracefully

### 5. **Performance**

- Avoid rebuilding widgets unnecessarily
- Use `ListView.builder` for long lists
- Lazy-load data when appropriate
- Profile performance-critical code

### 6. **Accessibility**

- Use semantic labels for screen readers
- Ensure sufficient color contrast
- Test with accessibility tools

---

## Troubleshooting

### Common Issues

1. **REUSE lint fails**
   - Ensure all files have SPDX headers
   - Check `REUSE.toml` for ignored file patterns
   - Run `reuse download --all` to fetch missing licenses

2. **Melos command not found**
   - Run `dart pub global activate melos`
   - Ensure `~/.pub-cache/bin` is in your PATH

3. **CI pipeline fails**
   - Check GitHub Actions logs for specific errors
   - Reproduce locally with `melos run test`, `flutter analyze`
   - Ensure all dependencies are up-to-date

4. **Commit hook blocks commit**
   - Fix REUSE compliance issues
   - Ensure commit message follows Conventional Commits
   - Run `git commit --no-verify` to bypass (not recommended)

---

## Additional Resources

- **Flutter Documentation**: https://docs.flutter.dev
- **Dart Language Guide**: https://dart.dev/guides
- **Material Design 3**: https://m3.material.io
- **Melos**: https://melos.invertase.dev
- **Widgetbook**: https://docs.widgetbook.io
- **REUSE Software**: https://reuse.software

---

## Contact

For questions or support:
- **Organization**: hexaTune LLC
- **Email**: info@hexatune.com
- **GitHub**: https://github.com/hTuneSys/hexaMobileShare

---

**Remember**: All project files must be in **ENGLISH ONLY**. This is a fundamental requirement for maintaining code quality and enabling global collaboration.
