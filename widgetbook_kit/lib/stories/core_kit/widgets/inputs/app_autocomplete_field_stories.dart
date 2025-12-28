// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/widgets/inputs/app_autocomplete_field.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Widgetbook stories for [AppAutocompleteField] component.
///
/// Demonstrates various configurations and use cases for the Material Design 3
/// autocomplete field component, including static suggestions, async API
/// integration, custom rendering, and interactive features.

// ============================================================================
// Story 1: Basic Autocomplete - Static list of suggestions
// ============================================================================

/// Basic autocomplete with static fruit suggestions.
@widgetbook.UseCase(name: 'Basic', type: AppAutocompleteField)
Widget basicAutocomplete(BuildContext context) {
  return const _BasicAutocompleteDemo();
}

class _BasicAutocompleteDemo extends StatefulWidget {
  const _BasicAutocompleteDemo();

  @override
  State<_BasicAutocompleteDemo> createState() => _BasicAutocompleteDemoState();
}

class _BasicAutocompleteDemoState extends State<_BasicAutocompleteDemo> {
  String? _selectedFruit;

  final List<String> _fruits = [
    'Apple',
    'Apricot',
    'Avocado',
    'Banana',
    'Blackberry',
    'Blueberry',
    'Cherry',
    'Coconut',
    'Date',
    'Dragon Fruit',
    'Elderberry',
    'Fig',
    'Grape',
    'Grapefruit',
    'Guava',
    'Kiwi',
    'Lemon',
    'Lime',
    'Mango',
    'Orange',
    'Papaya',
    'Peach',
    'Pear',
    'Pineapple',
    'Plum',
    'Raspberry',
    'Strawberry',
    'Watermelon',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Autocomplete',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Type to filter fruits from a static list',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            AppAutocompleteField<String>(
              suggestions: _fruits,
              label: 'Select Fruit',
              hint: 'Type to search...',
              helperText: 'Start typing to see suggestions',
              prefixIcon: Icons.search,
              onSelected: (value) {
                setState(() {
                  _selectedFruit = value;
                });
                debugPrint('Selected: $value');
              },
              onChanged: (value) {
                debugPrint('Text changed: $value');
              },
            ),
            const SizedBox(height: 24),
            if (_selectedFruit != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Fruit:',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _selectedFruit!,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Story 2: Async Autocomplete - Simulated API call
// ============================================================================

/// Autocomplete with async suggestion loading (simulated API).
@widgetbook.UseCase(name: 'Async API', type: AppAutocompleteField)
Widget asyncAutocomplete(BuildContext context) {
  return const _AsyncAutocompleteDemo();
}

class _AsyncAutocompleteDemo extends StatefulWidget {
  const _AsyncAutocompleteDemo();

  @override
  State<_AsyncAutocompleteDemo> createState() => _AsyncAutocompleteDemoState();
}

class _AsyncAutocompleteDemoState extends State<_AsyncAutocompleteDemo> {
  String? _selectedUser;

  // Simulated user database
  final List<String> _users = [
    'Alice Johnson',
    'Bob Smith',
    'Carol Williams',
    'David Brown',
    'Emma Davis',
    'Frank Miller',
    'Grace Wilson',
    'Henry Moore',
    'Isabella Taylor',
    'Jack Anderson',
  ];

  Future<List<String>> _fetchUsers(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Filter users based on query
    return _users
        .where((user) => user.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Async Autocomplete',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Simulated API call with 500ms delay',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            AppAutocompleteField<String>(
              onSuggestionsFetchRequested: _fetchUsers,
              label: 'Search Users',
              hint: 'Type a name...',
              helperText: 'Loading indicator appears during fetch',
              prefixIcon: Icons.person_search,
              debounceDelay: const Duration(milliseconds: 300),
              onSelected: (value) {
                setState(() {
                  _selectedUser = value;
                });
                debugPrint('Selected user: $value');
              },
            ),
            const SizedBox(height: 24),
            if (_selectedUser != null)
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Selected: $_selectedUser',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Story 3: Custom Item Rendering - Rich suggestion cards
// ============================================================================

/// Autocomplete with custom item builder showing rich user cards.
@widgetbook.UseCase(name: 'Custom Items', type: AppAutocompleteField)
Widget customItemAutocomplete(BuildContext context) {
  return const _CustomItemAutocompleteDemo();
}

class _User {
  final String name;
  final String email;
  final String role;
  final IconData icon;

  const _User({
    required this.name,
    required this.email,
    required this.role,
    required this.icon,
  });
}

class _CustomItemAutocompleteDemo extends StatefulWidget {
  const _CustomItemAutocompleteDemo();

  @override
  State<_CustomItemAutocompleteDemo> createState() =>
      _CustomItemAutocompleteDemoState();
}

class _CustomItemAutocompleteDemoState
    extends State<_CustomItemAutocompleteDemo> {
  _User? _selectedUser;

  final List<_User> _users = const [
    _User(
      name: 'Alice Johnson',
      email: 'alice@example.com',
      role: 'Product Manager',
      icon: Icons.business_center,
    ),
    _User(
      name: 'Bob Smith',
      email: 'bob@example.com',
      role: 'Software Engineer',
      icon: Icons.code,
    ),
    _User(
      name: 'Carol Williams',
      email: 'carol@example.com',
      role: 'UX Designer',
      icon: Icons.palette,
    ),
    _User(
      name: 'David Brown',
      email: 'david@example.com',
      role: 'DevOps Engineer',
      icon: Icons.cloud,
    ),
    _User(
      name: 'Emma Davis',
      email: 'emma@example.com',
      role: 'Data Scientist',
      icon: Icons.analytics,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Item Rendering',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Rich user cards with icons, names, and roles',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            AppAutocompleteField<_User>(
              suggestions: _users,
              displayStringForOption: (user) => user.name,
              customItemBuilder: (context, user, isHighlighted) {
                return Container(
                  color: isHighlighted
                      ? Theme.of(context).colorScheme.surfaceContainerHighest
                      : null,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        child: Icon(
                          user.icon,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              user.role,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              label: 'Select Team Member',
              hint: 'Search by name...',
              prefixIcon: Icons.people,
              onSelected: (user) {
                setState(() {
                  _selectedUser = user;
                });
                debugPrint('Selected: ${user.name} - ${user.role}');
              },
            ),
            const SizedBox(height: 24),
            if (_selectedUser != null)
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    child: Icon(
                      _selectedUser!.icon,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(_selectedUser!.name),
                  subtitle: Text(_selectedUser!.role),
                  trailing: Text(_selectedUser!.email),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Story 4: Email Autocomplete - Real-world example
// ============================================================================

/// Email autocomplete with domain suggestions.
@widgetbook.UseCase(name: 'Email Autocomplete', type: AppAutocompleteField)
Widget emailAutocomplete(BuildContext context) {
  return const _EmailAutocompleteDemo();
}

class _EmailAutocompleteDemo extends StatefulWidget {
  const _EmailAutocompleteDemo();

  @override
  State<_EmailAutocompleteDemo> createState() => _EmailAutocompleteDemoState();
}

class _EmailAutocompleteDemoState extends State<_EmailAutocompleteDemo> {
  final TextEditingController _controller = TextEditingController();
  String? _email;

  final List<String> _emailDomains = [
    '@gmail.com',
    '@yahoo.com',
    '@outlook.com',
    '@hotmail.com',
    '@icloud.com',
    '@protonmail.com',
    '@aol.com',
  ];

  List<String> _getEmailSuggestions(String input) {
    if (input.isEmpty || input.contains('@')) {
      return [];
    }

    return _emailDomains.map((domain) => input + domain).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Autocomplete',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Suggests common email domains as you type',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            AppAutocompleteField<String>(
              controller: _controller,
              suggestions: _getEmailSuggestions(_controller.text),
              label: 'Email Address',
              hint: 'Enter your email',
              helperText: 'Domain suggestions will appear',
              prefixIcon: Icons.email,
              allowFreeText: true,
              filterStrategy: FilterStrategy.startsWith,
              onChanged: (value) {
                setState(() {
                  // Update suggestions based on input
                });
              },
              onSelected: (value) {
                setState(() {
                  _email = value;
                });
                debugPrint('Email: $value');
              },
            ),
            const SizedBox(height: 24),
            if (_email != null)
              Card(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Theme.of(
                          context,
                        ).colorScheme.onTertiaryContainer,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _email!,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onTertiaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Story 5: Free Text Input - Allow non-suggestion values
// ============================================================================

/// Autocomplete that allows free text input not in suggestions.
@widgetbook.UseCase(name: 'Free Text', type: AppAutocompleteField)
Widget freeTextAutocomplete(BuildContext context) {
  return const _FreeTextAutocompleteDemo();
}

class _FreeTextAutocompleteDemo extends StatefulWidget {
  const _FreeTextAutocompleteDemo();

  @override
  State<_FreeTextAutocompleteDemo> createState() =>
      _FreeTextAutocompleteDemoState();
}

class _FreeTextAutocompleteDemoState extends State<_FreeTextAutocompleteDemo> {
  final List<String> _tags = [];

  final List<String> _existingTags = [
    'Flutter',
    'Dart',
    'Mobile',
    'Web',
    'Desktop',
    'iOS',
    'Android',
    'Material Design',
    'UI/UX',
    'Development',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Free Text Input',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Type existing tags or create new ones',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            AppAutocompleteField<String>(
              suggestions: _existingTags,
              label: 'Add Tags',
              hint: 'Type or select a tag...',
              helperText: 'You can create new tags or select existing ones',
              prefixIcon: Icons.label,
              allowFreeText: true,
              onChanged: (value) {
                if (value.isNotEmpty && !_tags.contains(value)) {
                  setState(() {
                    _tags.add(value);
                  });
                }
              },
              onSelected: (value) {
                if (!_tags.contains(value)) {
                  setState(() {
                    _tags.add(value);
                  });
                }
                debugPrint('Tag added: $value');
              },
            ),
            const SizedBox(height: 24),
            if (_tags.isNotEmpty) ...[
              Text(
                'Added Tags:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _tags.map((tag) {
                  final isExisting = _existingTags.contains(tag);
                  return Chip(
                    label: Text(tag),
                    backgroundColor: isExisting
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Theme.of(context).colorScheme.tertiaryContainer,
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _tags.remove(tag);
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Story 6: Loading State - Shows loading indicator
// ============================================================================

/// Autocomplete with prominent loading state.
@widgetbook.UseCase(name: 'Loading State', type: AppAutocompleteField)
Widget loadingStateAutocomplete(BuildContext context) {
  return const _LoadingStateAutocompleteDemo();
}

class _LoadingStateAutocompleteDemo extends StatelessWidget {
  const _LoadingStateAutocompleteDemo();

  Future<List<String>> _slowFetch(String query) async {
    // Simulate slow API
    await Future.delayed(const Duration(seconds: 2));
    return [
      'Result for "$query" 1',
      'Result for "$query" 2',
      'Result for "$query" 3',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Loading State',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '2-second delay to showcase loading indicator',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            AppAutocompleteField<String>(
              onSuggestionsFetchRequested: _slowFetch,
              label: 'Search (Slow)',
              hint: 'Type to trigger 2s loading...',
              helperText: 'Notice the loading spinner in suffix and dropdown',
              prefixIcon: Icons.hourglass_empty,
              loadingText: 'Fetching results...',
              debounceDelay: const Duration(milliseconds: 500),
              onSelected: (value) {
                debugPrint('Selected: $value');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Story 7: Empty State - No results found
// ============================================================================

/// Autocomplete showing empty state when no matches found.
@widgetbook.UseCase(name: 'Empty State', type: AppAutocompleteField)
Widget emptyStateAutocomplete(BuildContext context) {
  return const _EmptyStateAutocompleteDemo();
}

class _EmptyStateAutocompleteDemo extends StatelessWidget {
  const _EmptyStateAutocompleteDemo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Empty State',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Try typing "xyz" to see the empty state',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            AppAutocompleteField<String>(
              suggestions: const [
                'Apple',
                'Banana',
                'Cherry',
                'Date',
                'Elderberry',
              ],
              label: 'Search Fruits',
              hint: 'Type something that doesn\'t exist...',
              helperText: 'Empty state appears when no matches found',
              prefixIcon: Icons.search_off,
              emptyStateText: '🔍 No fruits found matching your search',
              onSelected: (value) {
                debugPrint('Selected: $value');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Story 8: Filter Strategies - Compare different filtering methods
// ============================================================================

/// Compare different filtering strategies (startsWith, contains, fuzzy).
@widgetbook.UseCase(name: 'Filter Strategies', type: AppAutocompleteField)
Widget filterStrategiesAutocomplete(BuildContext context) {
  return const _FilterStrategiesAutocompleteDemo();
}

class _FilterStrategiesAutocompleteDemo extends StatefulWidget {
  const _FilterStrategiesAutocompleteDemo();

  @override
  State<_FilterStrategiesAutocompleteDemo> createState() =>
      _FilterStrategiesAutocompleteDemoState();
}

class _FilterStrategiesAutocompleteDemoState
    extends State<_FilterStrategiesAutocompleteDemo> {
  FilterStrategy _strategy = FilterStrategy.startsWith;

  final List<String> _languages = [
    'JavaScript',
    'TypeScript',
    'Java',
    'Python',
    'C++',
    'C#',
    'Ruby',
    'Go',
    'Rust',
    'Swift',
    'Kotlin',
    'Dart',
    'PHP',
    'Scala',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter Strategies',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Try typing "script" with different strategies',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            SegmentedButton<FilterStrategy>(
              segments: const [
                ButtonSegment(
                  value: FilterStrategy.startsWith,
                  label: Text('Starts With'),
                ),
                ButtonSegment(
                  value: FilterStrategy.contains,
                  label: Text('Contains'),
                ),
                ButtonSegment(
                  value: FilterStrategy.fuzzy,
                  label: Text('Fuzzy'),
                ),
              ],
              selected: {_strategy},
              onSelectionChanged: (Set<FilterStrategy> newSelection) {
                setState(() {
                  _strategy = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 24),
            AppAutocompleteField<String>(
              key: ValueKey(_strategy),
              suggestions: _languages,
              filterStrategy: _strategy,
              label: 'Programming Language',
              hint: 'Try typing "script"...',
              helperText: _getStrategyDescription(_strategy),
              prefixIcon: Icons.code,
              onSelected: (value) {
                debugPrint('Selected: $value');
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getStrategyDescription(FilterStrategy strategy) {
    switch (strategy) {
      case FilterStrategy.startsWith:
        return 'Matches items starting with your input';
      case FilterStrategy.contains:
        return 'Matches items containing your input anywhere';
      case FilterStrategy.fuzzy:
        return 'Flexible matching with characters in sequence';
    }
  }
}

// ============================================================================
// Story 9: Interactive Playground - Full customization with knobs
// ============================================================================

/// Interactive playground to customize all autocomplete properties.
@widgetbook.UseCase(name: 'Interactive Playground', type: AppAutocompleteField)
Widget interactivePlayground(BuildContext context) {
  // Text customization
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Select Item',
  );
  final hint = context.knobs.string(
    label: 'Hint',
    initialValue: 'Type to search...',
  );
  final helperText = context.knobs.string(
    label: 'Helper Text',
    initialValue: 'Start typing to see suggestions',
  );

  // Behavior toggles
  final allowFreeText = context.knobs.boolean(
    label: 'Allow Free Text',
    initialValue: true,
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final highlightMatching = context.knobs.boolean(
    label: 'Highlight Matching',
    initialValue: true,
  );

  // Filter strategy
  final filterStrategy = context.knobs.object.dropdown(
    label: 'Filter Strategy',
    options: [
      FilterStrategy.startsWith,
      FilterStrategy.contains,
      FilterStrategy.fuzzy,
    ],
    labelBuilder: (strategy) {
      switch (strategy) {
        case FilterStrategy.startsWith:
          return 'Starts With';
        case FilterStrategy.contains:
          return 'Contains';
        case FilterStrategy.fuzzy:
          return 'Fuzzy';
      }
    },
  );

  // Debounce delay
  final debounceMs = context.knobs.double.slider(
    label: 'Debounce Delay (ms)',
    initialValue: 300,
    min: 0,
    max: 1000,
  );

  // Max suggestions
  final maxSuggestions = context.knobs.int.slider(
    label: 'Max Suggestions',
    initialValue: 10,
    min: 3,
    max: 20,
  );

  final suggestions = [
    'Apple',
    'Apricot',
    'Avocado',
    'Banana',
    'Blackberry',
    'Blueberry',
    'Cherry',
    'Coconut',
    'Date',
    'Dragon Fruit',
    'Elderberry',
    'Fig',
    'Grape',
    'Grapefruit',
    'Guava',
    'Kiwi',
    'Lemon',
    'Lime',
    'Mango',
    'Orange',
    'Papaya',
    'Peach',
    'Pear',
    'Pineapple',
    'Plum',
    'Raspberry',
    'Strawberry',
    'Watermelon',
  ];

  return Scaffold(
    body: Center(
      child: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppAutocompleteField<String>(
            suggestions: suggestions,
            label: label,
            hint: hint,
            helperText: helperText,
            prefixIcon: Icons.search,
            allowFreeText: allowFreeText,
            enabled: enabled,
            highlightMatching: highlightMatching,
            filterStrategy: filterStrategy,
            debounceDelay: Duration(milliseconds: debounceMs.toInt()),
            maxSuggestions: maxSuggestions,
            onSelected: (value) {
              debugPrint('Selected: $value');
            },
            onChanged: (value) {
              debugPrint('Changed: $value');
            },
          ),
        ),
      ),
    ),
  );
}
