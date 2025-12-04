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

### 2. **State Management**

- Use appropriate state management for the use case
- Prefer immutability
- Document state flow in complex features

### 3. **Error Handling**

- Use typed exceptions (e.g., `AuthException`, `NetworkException`)
- Provide meaningful error messages
- Log errors appropriately (use `analytics_kit`)
- Handle edge cases gracefully

### 4. **Performance**

- Avoid rebuilding widgets unnecessarily
- Use `ListView.builder` for long lists
- Lazy-load data when appropriate
- Profile performance-critical code

### 5. **Accessibility**

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
