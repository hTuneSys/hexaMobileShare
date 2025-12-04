<!--
SPDX-FileCopyrightText: 2025 hexaTune LLC
SPDX-License-Identifier: MIT
-->

# STYLE_GUIDE.md

This style guide ensures consistency across the codebase by outlining formatting rules, naming conventions, and Dart/Flutter-specific practices used in the hexaMobileShare project.

---

Consistent style improves collaboration and makes onboarding easier. Stick to this guide for clean, professional code.

---

## 📝 Dart Style Guide

### General Formatting

Follow the [official Dart style guide](https://dart.dev/guides/language/effective-dart/style):

```bash
# Format all Dart files
melos run format

# Or format specific package
cd packages/core_kit
dart format .
```

### Key Formatting Rules

- **Indentation**: 2 spaces (enforced by `dart format`)
- **Line Length**: 80 characters max
- **Imports**: Organize imports in groups (dart, package, relative)
- **Trailing Commas**: Always use trailing commas for better diffs

```dart
// ✅ Good
Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Text('Hello'),
        Text('World'),
      ],
    ),
  );
}

// ❌ Bad - no trailing commas
Widget build(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Text('Hello'),
        Text('World')
      ]
    )
  );
}
```

---

## 🏷️ Naming Conventions

### Classes and Types

Use **UpperCamelCase** for class names and type definitions:

```dart
// ✅ Good
class UserProfile {}
class AppButton {}
abstract class AuthService {}
typedef ResponseCallback = void Function(String response);

// ❌ Bad
class userProfile {}
class app_button {}
```

### Variables and Parameters

Use **lowerCamelCase** for variables, parameters, and function names:

```dart
// ✅ Good
String userName = 'John';
final int itemCount = 5;
void saveUserData() {}

// ❌ Bad
String UserName = 'John';
final int item_count = 5;
void SaveUserData() {}
```

### Constants

Use **lowerCamelCase** for constants:

```dart
// ✅ Good
const double kDefaultPadding = 16.0;
const String kApiBaseUrl = 'https://api.example.com';

// Use 'k' prefix for private constants
const double _kInternalSpacing = 8.0;

// ❌ Bad
const double DEFAULT_PADDING = 16.0;
const String API_BASE_URL = 'https://api.example.com';
```

### Private Members

Prefix private members with underscore:

```dart
// ✅ Good
class MyWidget extends StatelessWidget {
  final String _privateField;
  
  void _privateMethod() {}
}

// ❌ Bad
class MyWidget extends StatelessWidget {
  final String privateField;  // Should be private
}
```

### Files

Use **snake_case** for file names:

```dart
// ✅ Good
app_button.dart
user_profile.dart
auth_service.dart

// ❌ Bad
AppButton.dart
userProfile.dart
AuthService.dart
```

---

## 📦 Package Structure

### Import Organization

Group imports in this order:

1. Dart SDK imports
2. Flutter imports
3. Package imports (alphabetically)
4. Relative imports

```dart
// ✅ Good
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:core_kit/core_kit.dart';
import 'package:data_kit/data_kit.dart';

import '../models/user.dart';
import 'auth_state.dart';

// ❌ Bad - mixed order
import 'package:core_kit/core_kit.dart';
import 'dart:async';
import '../models/user.dart';
import 'package:flutter/material.dart';
```

### Export Files

Each package should have a main export file:

```dart
// ✅ Good - packages/core_kit/lib/core_kit.dart
library core_kit;

// Theme
export 'theme/app_theme.dart';
export 'theme/app_color_scheme.dart';
export 'theme/app_typography.dart';

// Widgets
export 'widgets/buttons/app_button.dart';
export 'widgets/surfaces/app_card.dart';

// ❌ Bad - exporting everything
export 'package:core_kit/**/*.dart';
```

---

## 🎨 Widget Guidelines

### Stateless vs Stateful

Prefer `StatelessWidget` when possible:

```dart
// ✅ Good - no internal state
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.onPressed,
    super.key,
  });
  
  final String label;
  final VoidCallback? onPressed;
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

// Use StatefulWidget only when needed
class Counter extends StatefulWidget {
  const Counter({super.key});
  
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;
  
  @override
  Widget build(BuildContext context) {
    return Text('Count: $_count');
  }
}
```

### Constructor Conventions

- Always use `const` constructors when possible
- Use named parameters for clarity
- Include `super.key` for widget keys

```dart
// ✅ Good
class MyWidget extends StatelessWidget {
  const MyWidget({
    required this.title,
    this.subtitle,
    super.key,
  });
  
  final String title;
  final String? subtitle;
}

// ❌ Bad
class MyWidget extends StatelessWidget {
  MyWidget(this.title, this.subtitle);  // Positional params, no key
  
  String title;
  String? subtitle;
}
```

### BuildContext Usage

Use `context` parameter wisely:

```dart
// ✅ Good - accessing theme
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final colors = theme.colorScheme;
  
  return Container(
    color: colors.surface,
    child: Text(
      'Hello',
      style: theme.textTheme.titleMedium,
    ),
  );
}

// ❌ Bad - repeated context calls
Widget build(BuildContext context) {
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Text(
      'Hello',
      style: Theme.of(context).textTheme.titleMedium,
    ),
  );
}
```

---

## 🔒 Null Safety

### Use Sound Null Safety

- Mark nullable types with `?`
- Use `late` for deferred initialization
- Avoid `!` operator when possible

```dart
// ✅ Good
String? nullableString;
late String lateInitializedString;

String getUserName(User? user) {
  return user?.name ?? 'Guest';
}

// ❌ Bad
String nullableString;  // Missing ?
String getUserName(User user) {
  return user!.name;  // Avoid ! operator
}
```

### Non-nullable by Default

```dart
// ✅ Good
class User {
  const User({
    required this.id,
    required this.name,
    this.email,  // Nullable
  });
  
  final String id;    // Non-nullable
  final String name;  // Non-nullable
  final String? email;  // Explicitly nullable
}

// ❌ Bad
class User {
  String id;    // Should be final and required
  String name;
  String email;  // Should be nullable with ?
}
```

---

## 📐 Code Organization

### Class Member Order

1. Static constants
2. Instance fields
3. Constructors
4. Lifecycle methods (initState, build, dispose)
5. Public methods
6. Private methods

```dart
// ✅ Good
class MyWidget extends StatefulWidget {
  // 1. Static constants
  static const double kDefaultHeight = 48.0;
  
  // 2. Instance fields
  final String title;
  final VoidCallback? onTap;
  
  // 3. Constructor
  const MyWidget({
    required this.title,
    this.onTap,
    super.key,
  });
  
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  // 1. Instance fields
  late TextEditingController _controller;
  
  // 2. Lifecycle methods
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  // 3. Private methods
  void _handleTap() {
    widget.onTap?.call();
  }
}
```

---

## 💬 Comments and Documentation

### Dartdoc Comments

Use `///` for public APIs:

```dart
/// A Material Design button widget.
///
/// This button follows MD3 guidelines and supports
/// various visual variants.
class AppButton extends StatelessWidget {
  /// Creates an AppButton.
  ///
  /// The [label] must not be null.
  const AppButton({
    required this.label,
    this.variant = ButtonVariant.filled,
    this.onPressed,
    super.key,
  });
  
  /// The text displayed on the button.
  final String label;
  
  /// The visual variant of the button.
  ///
  /// Defaults to [ButtonVariant.filled].
  final ButtonVariant variant;
  
  /// Called when the button is tapped.
  final VoidCallback? onPressed;
}
```

### Inline Comments

Use `//` for implementation details:

```dart
// ✅ Good - explain why, not what
void calculateTotal() {
  // Apply discount before tax calculation to match business rules
  final discounted = price * (1 - discount);
  final total = discounted * (1 + taxRate);
}

// ❌ Bad - stating the obvious
void calculateTotal() {
  // Multiply price by discount
  final discounted = price * (1 - discount);
}
```

---

## 🧪 Testing Conventions

### Test File Naming

```dart
// Source file: packages/core_kit/lib/widgets/buttons/app_button.dart
// Test file: packages/core_kit/test/widgets/buttons/app_button_test.dart
```

### Test Structure

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders with label', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppButton(label: 'Click me'),
        ),
      );
      
      expect(find.text('Click me'), findsOneWidget);
    });
    
    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = false;
      
      await tester.pumpWidget(
        MaterialApp(
          home: AppButton(
            label: 'Click',
            onPressed: () => pressed = true,
          ),
        ),
      );
      
      await tester.tap(find.byType(AppButton));
      expect(pressed, isTrue);
    });
  });
}
```

---

## 🎯 Best Practices

### Use const Constructors

```dart
// ✅ Good
const padding = EdgeInsets.all(16.0);
const text = Text('Hello');

// ❌ Bad
final padding = EdgeInsets.all(16.0);
final text = Text('Hello');
```

### Prefer final over var

```dart
// ✅ Good
final String name = 'John';
final count = 5;

// ❌ Bad
var name = 'John';
var count = 5;
```

### Use Meaningful Names

```dart
// ✅ Good
final authenticatedUser = await authService.login(email, password);
final isEmailValid = EmailValidator.validate(email);

// ❌ Bad
final u = await authService.login(email, password);
final valid = EmailValidator.validate(email);
```

### Avoid Deep Nesting

```dart
// ✅ Good
Widget build(BuildContext context) {
  if (!isLoggedIn) {
    return LoginScreen();
  }
  
  if (!hasPermission) {
    return PermissionDeniedScreen();
  }
  
  return HomeScreen();
}

// ❌ Bad
Widget build(BuildContext context) {
  if (isLoggedIn) {
    if (hasPermission) {
      return HomeScreen();
    } else {
      return PermissionDeniedScreen();
    }
  } else {
    return LoginScreen();
  }
}
```

---

## 🚀 Performance Tips

### Use const Widgets

```dart
// ✅ Good - const widget won't rebuild
const SizedBox(height: 16.0)

// ❌ Bad
SizedBox(height: 16.0)
```

### Extract Widgets

```dart
// ✅ Good - reusable and testable
class _Header extends StatelessWidget {
  const _Header({required this.title});
  final String title;
  
  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}

// ❌ Bad - method instead of widget
Widget _buildHeader(String title) {
  return Text(title);
}
```

### Avoid Rebuilds

```dart
// ✅ Good - using ValueListenableBuilder
final ValueNotifier<int> counter = ValueNotifier(0);

ValueListenableBuilder<int>(
  valueListenable: counter,
  builder: (context, value, child) {
    return Text('$value');
  },
)

// ❌ Bad - entire widget rebuilds
setState(() => counter++);
```

---

## 📋 Linting

Use strict analysis options:

```yaml
# analysis_options.yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_literals_to_create_immutables
    - avoid_print
    - prefer_final_fields
    - unnecessary_this
```

Run analyzer:

```bash
melos run analyze
```

---

## ✅ Code Review Checklist

Before submitting PR:

- [ ] Code formatted with `dart format`
- [ ] No analyzer warnings
- [ ] All tests passing
- [ ] Dartdoc comments on public APIs
- [ ] Const constructors where applicable
- [ ] Null safety properly used
- [ ] Meaningful variable names
- [ ] No deep nesting (max 3 levels)
- [ ] Performance optimized (const, extract widgets)

---

This style guide ensures clean, maintainable, and performant Dart/Flutter code across the hexaMobileShare monorepo.
