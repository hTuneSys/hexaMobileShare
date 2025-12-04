<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# SUMMARY.md

Welcome to the hexaMobileShare documentation hub. This file provides a high-level summary of the project and guides you to the right documentation based on your needs.

---

## 🎯 What is hexaMobileShare?

**hexaMobileShare** is a comprehensive **Flutter mobile kit monorepo** featuring production-ready UI widgets and utilities built with:

- ✨ **Flutter 3.x** for cross-platform mobile development
- 🎨 **Material Design 3** for beautiful, themeable widgets
- 📖 **Widgetbook** for interactive widget documentation
- 🔐 **Dart 3.x** for type safety and null safety
- ♿ **Accessibility-first** design
- 🚀 **Production-ready** and optimized

---

## 📚 Documentation Index

### 🚀 Getting Started

**New to hexaMobileShare? Start here:**

- [**GETTING_STARTED.md**](GETTING_STARTED.md) – Setup guide, prerequisites, and quick start
- [**FAQ.md**](FAQ.md) – Frequently asked questions

### 🏗️ Architecture & Design

**Understand how hexaMobileShare is built:**

- [**ARCHITECTURE.md**](ARCHITECTURE.md) – System architecture, widget design, and technology stack
- [**PROJECT_STRUCTURE.md**](PROJECT_STRUCTURE.md) – Directory structure and file organization
- [**CONFIGURATION.md**](CONFIGURATION.md) – Configuration files and settings

### 👨‍💻 Development

**For contributors and developers:**

- [**DEVELOPMENT_GUIDE.md**](DEVELOPMENT_GUIDE.md) – Comprehensive development workflow and best practices
- [**CONTRIBUTING.md**](CONTRIBUTING.md) – How to contribute (code, docs, issues)
- [**STYLE_GUIDE.md**](STYLE_GUIDE.md) – Code style and formatting conventions

### 🔀 Git Workflow

**Branching, commits, and pull requests:**

- [**BRANCH_STRATEGY.md**](BRANCH_STRATEGY.md) – Git branch naming and usage rules
- [**COMMIT_STRATEGY.md**](COMMIT_STRATEGY.md) – Commit message format and conventions
- [**PR_STRATEGY.md**](PR_STRATEGY.md) – Pull request guidelines and review process
- [**LABELLING_STRATEGY.md**](LABELLING_STRATEGY.md) – Issue and PR labeling system

### 🤝 Community

**Collaboration and communication:**

- [**CODE_OF_CONDUCT.md**](CODE_OF_CONDUCT.md) – Community behavior guidelines
- [**COMMUNITY.md**](COMMUNITY.md) – Community engagement and interaction
- [**SUPPORT.md**](SUPPORT.md) – How to get help
- [**CONTACT.md**](CONTACT.md) – Contact information

### 📋 Project Management

**Organizing work and tracking progress:**

- [**PROJECT_BOARD.md**](PROJECT_BOARD.md) – Project board structure and workflow

### 🔐 Security & Legal

**Security and licensing:**

- [**SECURITY.md**](SECURITY.md) – Security policy and vulnerability reporting
- [**LICENSE**](../LICENSE) – MIT License

### 🎨 Branding

**Visual identity and assets:**

- [**BRANDING.md**](BRANDING.md) – Logo usage and brand guidelines

---

## 🗺️ Quick Navigation

### I want to...

#### ...use the library in my project
1. Read [GETTING_STARTED.md](GETTING_STARTED.md)
2. Browse widgets in Widgetbook
3. Check [CONFIGURATION.md](CONFIGURATION.md) for integration

#### ...contribute code
1. Read [CONTRIBUTING.md](CONTRIBUTING.md)
2. Follow [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md)
3. Review [BRANCH_STRATEGY.md](BRANCH_STRATEGY.md) and [COMMIT_STRATEGY.md](COMMIT_STRATEGY.md)

#### ...understand the architecture
1. Read [ARCHITECTURE.md](ARCHITECTURE.md)
2. Explore [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)
3. Check [CONFIGURATION.md](CONFIGURATION.md)

#### ...report a bug or request a feature
1. Check [FAQ.md](FAQ.md) first
2. Use [GitHub Issues](https://github.com/hTuneSys/hexaMobileShare/issues)
3. Follow issue templates in `.github/ISSUE_TEMPLATE/`

#### ...get help
1. Check [FAQ.md](FAQ.md)
2. Read [SUPPORT.md](SUPPORT.md)
3. Use [GitHub Discussions](https://github.com/hTuneSys/hexaMobileShare/discussions)
4. Contact via [CONTACT.md](CONTACT.md)

---

## 📦 Mobile Kit Structure

The monorepo contains 11 specialized kits organized in `packages/`:

### 1. **analytics_kit**
Analytics, logging, and feature flags:
- Event tracking
- Analytics providers integration
- Feature flag management
- Logging utilities

### 2. **auth_kit**
Authentication and authorization:
- Login/signup flows
- OAuth integrations
- Session management
- Permission handling

### 3. **core_kit**
Core UI widgets and theming:
- Buttons, inputs, layout widgets
- Typography components
- Material Design 3 theming
- Common UI patterns

### 4. **data_kit**
HTTP client and API handling:
- REST API client
- Pagination controllers
- Error handling
- Request/response interceptors

### 5. **forms_kit**
Form management and validation:
- Form controllers
- Field validators
- Custom form widgets
- Form state management

### 6. **localization_kit**
Internationalization (i18n):
- Translation management
- Locale switching
- RTL support
- Language detection

### 7. **media_kit**
Audio/video and media handling:
- Audio players
- Video players
- Media file handling
- Camera/gallery integration

### 8. **monetization_kit**
In-app purchases and subscriptions:
- Payment processing
- Subscription management
- Purchase validation
- Revenue analytics

### 9. **navigation_kit**
Routing and navigation:
- Navigation controllers
- Deep linking
- Route guards
- Navigation animations

### 10. **notifications_kit**
Push and local notifications:
- Push notification handling
- Local notifications
- Notification scheduling
- Notification actions

### 11. **storage_kit**
Local storage and caching:
- Key-value storage
- Secure storage
- Cache management
- File storage

See [ARCHITECTURE.md](ARCHITECTURE.md) and [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) for complete details.

---

## 🛠️ Technology Stack

- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **UI Design**: Material Design 3
- **Widget Catalog**: Widgetbook
- **Testing**: Flutter Test + Widget Testing
- **Build System**: Flutter Build System
- **Monorepo Manager**: Melos (wrapped by pnpm)

---

## 🎓 Learning Path

### For Widget Users

1. [GETTING_STARTED.md](GETTING_STARTED.md) – Setup and installation
2. Browse Widgetbook – Explore widgets
3. [CONFIGURATION.md](CONFIGURATION.md) – Integration setup
4. [FAQ.md](FAQ.md) – Common questions

### For Contributors

1. [GETTING_STARTED.md](GETTING_STARTED.md) – Environment setup
2. [ARCHITECTURE.md](ARCHITECTURE.md) – Understand the design
3. [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md) – Development workflow
4. [CONTRIBUTING.md](CONTRIBUTING.md) – Contribution process
5. [BRANCH_STRATEGY.md](BRANCH_STRATEGY.md) + [COMMIT_STRATEGY.md](COMMIT_STRATEGY.md) – Git workflow

### For Maintainers

1. All contributor documentation above
2. [PR_STRATEGY.md](PR_STRATEGY.md) – PR review process
3. [LABELLING_STRATEGY.md](LABELLING_STRATEGY.md) – Issue management
4. [PROJECT_BOARD.md](PROJECT_BOARD.md) – Project organization
5. [SECURITY.md](SECURITY.md) – Security policy

---

## 📊 Documentation Breakdown

### Strategy & Process (How we work)

- [BRANCH_STRATEGY.md](BRANCH_STRATEGY.md)
- [COMMIT_STRATEGY.md](COMMIT_STRATEGY.md)
- [PR_STRATEGY.md](PR_STRATEGY.md)
- [LABELLING_STRATEGY.md](LABELLING_STRATEGY.md)

### Technical Docs (How it works)

- [ARCHITECTURE.md](ARCHITECTURE.md)
- [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)
- [CONFIGURATION.md](CONFIGURATION.md)
- [STYLE_GUIDE.md](STYLE_GUIDE.md)

### Guides (How to do things)

- [GETTING_STARTED.md](GETTING_STARTED.md)
- [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md)
- [CONTRIBUTING.md](CONTRIBUTING.md)

### Community & Support (How to engage)

- [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
- [COMMUNITY.md](COMMUNITY.md)
- [SUPPORT.md](SUPPORT.md)
- [CONTACT.md](CONTACT.md)
- [FAQ.md](FAQ.md)

### Governance (Policies)

- [SECURITY.md](SECURITY.md)
- [LICENSE](../LICENSE)

### Project Management

- [PROJECT_BOARD.md](PROJECT_BOARD.md)
- [BRANDING.md](BRANDING.md)

---

## 🌐 External Links

- **Website**: [hexatune.com](https://hexatune.com)
- **GitHub**: [github.com/hTuneSys/hexaMobileShare](https://github.com/hTuneSys/hexaMobileShare)
- **Issues**: [GitHub Issues](https://github.com/hTuneSys/hexaMobileShare/issues)
- **Discussions**: [GitHub Discussions](https://github.com/hTuneSys/hexaMobileShare/discussions)
- **License**: [MIT](https://opensource.org/license/mit/)

---

## 🔄 Keeping Documentation Updated

When making changes to the project:

1. **New Features**: Update [ARCHITECTURE.md](ARCHITECTURE.md) and [CHANGELOG.md](../CHANGELOG.md)
2. **Configuration Changes**: Update [CONFIGURATION.md](CONFIGURATION.md)
3. **Directory Changes**: Update [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)
4. **Process Changes**: Update strategy docs ([BRANCH_STRATEGY.md](BRANCH_STRATEGY.md), etc.)
5. **New Widgets**: Add to widget list in [ARCHITECTURE.md](ARCHITECTURE.md)

---

## 📞 Get Involved

- 💬 **Discussions**: [GitHub Discussions](https://github.com/hTuneSys/hexaMobileShare/discussions)
- 🐛 **Issues**: [Report bugs or request features](https://github.com/hTuneSys/hexaMobileShare/issues)
- 🤝 **Contribute**: Read [CONTRIBUTING.md](CONTRIBUTING.md)
- 📧 **Email**: [info@hexatune.com](mailto:info@hexatune.com)

---

## ✅ Documentation Checklist

Before starting work:

- [ ] Read [GETTING_STARTED.md](GETTING_STARTED.md)
- [ ] Review [CONTRIBUTING.md](CONTRIBUTING.md)
- [ ] Understand [BRANCH_STRATEGY.md](BRANCH_STRATEGY.md)
- [ ] Follow [COMMIT_STRATEGY.md](COMMIT_STRATEGY.md)
- [ ] Check [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)

---

This summary helps you navigate the documentation efficiently and understand the project structure. For specific topics, jump to the relevant document using the links above.

---

**Built by [hexaTune LLC](https://hexatune.com)**  
**License**: [MIT](../LICENSE)  
**GitHub**: [hTuneSys/hexaMobileShare](https://github.com/hTuneSys/hexaMobileShare)
