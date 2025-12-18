// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Basic search field with debouncing
@widgetbook.UseCase(name: 'Basic', type: AppSearchField)
Widget basicSearchField(BuildContext context) {
  return const _BasicSearchDemo();
}

class _BasicSearchDemo extends StatefulWidget {
  const _BasicSearchDemo();

  @override
  State<_BasicSearchDemo> createState() => _BasicSearchDemoState();
}

class _BasicSearchDemoState extends State<_BasicSearchDemo> {
  final List<String> _debouncedQueries = [];
  final List<String> _submittedQueries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Basic Search with Debouncing',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            AppSearchField(
              hint: 'Type to search...',
              onSearchChanged: (query) {
                setState(() {
                  _debouncedQueries.insert(0, query);
                  if (_debouncedQueries.length > 3) {
                    _debouncedQueries.removeLast();
                  }
                });
                debugPrint('🔍 Search changed (debounced after 300ms): $query');
              },
              onSearchSubmitted: (query) {
                setState(() {
                  _submittedQueries.insert(0, query);
                  if (_submittedQueries.length > 3) {
                    _submittedQueries.removeLast();
                  }
                });
                debugPrint('⚡ Search submitted (immediate): $query');
              },
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Debounced (300ms)',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: _debouncedQueries.isEmpty
                            ? Text(
                                'Start typing to see debounced queries',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(fontStyle: FontStyle.italic),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _debouncedQueries.asMap().entries.map(
                                  (entry) {
                                    final index = entry.key;
                                    final query = entry.value;
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom:
                                            index < _debouncedQueries.length - 1
                                            ? 4
                                            : 0,
                                      ),
                                      child: Text(
                                        query.isEmpty
                                            ? '(cleared)'
                                            : '"$query"',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.send,
                            size: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Submitted (Enter)',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondaryContainer
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.secondary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: _submittedQueries.isEmpty
                            ? Text(
                                'Press Enter to submit',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(fontStyle: FontStyle.italic),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _submittedQueries.asMap().entries.map(
                                  (entry) {
                                    final index = entry.key;
                                    final query = entry.value;
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        bottom:
                                            index < _submittedQueries.length - 1
                                            ? 4
                                            : 0,
                                      ),
                                      child: Text(
                                        query.isEmpty ? '(empty)' : '"$query"',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Debounced: Triggered 300ms after you stop typing\nSubmitted: Triggered immediately when you press Enter',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Search field with custom hint text
@widgetbook.UseCase(name: 'Custom Hint', type: AppSearchField)
Widget customHintSearchField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product Search', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        AppSearchField(
          hint: 'Search products...',
          onSearchChanged: (query) {
            debugPrint('Product search: $query');
          },
        ),
        const SizedBox(height: 16),
        Text('User Search', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        AppSearchField(
          hint: 'Search users by name or email...',
          onSearchChanged: (query) {
            debugPrint('User search: $query');
          },
        ),
      ],
    ),
  );
}

/// Search field with clear button interaction
@widgetbook.UseCase(name: 'With Clear Button', type: AppSearchField)
Widget searchFieldWithClearButton(BuildContext context) {
  final controller = TextEditingController(text: 'Initial search query');

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Clear button appears when text is entered',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        AppSearchField(
          controller: controller,
          hint: 'Search...',
          onSearchChanged: (query) {
            debugPrint('Search: $query');
          },
        ),
      ],
    ),
  );
}

/// Search field with loading indicator
@widgetbook.UseCase(name: 'Loading State', type: AppSearchField)
Widget loadingSearchField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Searching...', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        const AppSearchField(hint: 'Search products...', isLoading: true),
      ],
    ),
  );
}

/// Search field with auto-focus enabled
@widgetbook.UseCase(name: 'Auto Focus', type: AppSearchField)
Widget autoFocusSearchField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Field automatically focused on mount',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        AppSearchField(
          hint: 'Start typing...',
          autofocus: true,
          onSearchChanged: (query) {
            debugPrint('Search: $query');
          },
        ),
      ],
    ),
  );
}

/// Search field with immediate submit action
@widgetbook.UseCase(name: 'Submit Action', type: AppSearchField)
Widget submitActionSearchField(BuildContext context) {
  return const _SubmitActionDemo();
}

class _SubmitActionDemo extends StatefulWidget {
  const _SubmitActionDemo();

  @override
  State<_SubmitActionDemo> createState() => _SubmitActionDemoState();
}

class _SubmitActionDemoState extends State<_SubmitActionDemo> {
  final List<String> _submittedQueries = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Press Enter/Search button to submit',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            AppSearchField(
              hint: 'Search and press Enter...',
              clearOnSubmit: true,
              onSearchSubmitted: (query) {
                setState(() {
                  _submittedQueries.insert(0, query);
                  if (_submittedQueries.length > 5) {
                    _submittedQueries.removeLast();
                  }
                });
                debugPrint('⚡ Search submitted immediately: $query');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Submitted: $query'),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Submitted Searches (last 5):',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            if (_submittedQueries.isEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'No searches submitted yet. Type and press Enter.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _submittedQueries.asMap().entries.map((entry) {
                    final index = entry.key;
                    final query = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < _submittedQueries.length - 1 ? 4 : 0,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.history,
                            size: 16,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              query.isEmpty ? '(empty query)' : query,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Field clears automatically after submit (clearOnSubmit: true)',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Disabled search field state
@widgetbook.UseCase(name: 'Disabled', type: AppSearchField)
Widget disabledSearchField(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Disabled search field',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        const AppSearchField(hint: 'Search disabled...', enabled: false),
      ],
    ),
  );
}

/// Search field integrated with results list
@widgetbook.UseCase(name: 'With Results', type: AppSearchField)
Widget searchFieldWithResults(BuildContext context) {
  return const _SearchWithResultsDemo();
}

/// Demo widget showing search integration with results
class _SearchWithResultsDemo extends StatefulWidget {
  const _SearchWithResultsDemo();

  @override
  State<_SearchWithResultsDemo> createState() => _SearchWithResultsDemoState();
}

class _SearchWithResultsDemoState extends State<_SearchWithResultsDemo> {
  final List<String> _allItems = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grape',
    'Honeydew',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Papaya',
    'Quince',
    'Raspberry',
    'Strawberry',
    'Tangerine',
    'Watermelon',
  ];

  List<String> _filteredItems = [];
  bool _isLoading = false;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
  }

  void _performSearch(String query) {
    setState(() {
      _isLoading = true;
      _currentQuery = query;
    });

    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        if (query.isEmpty) {
          _filteredItems = _allItems;
        } else {
          _filteredItems = _allItems
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppSearchField(
            hint: 'Search fruits...',
            isLoading: _isLoading,
            onSearchChanged: _performSearch,
          ),
        ),
        Expanded(child: _buildResults()),
      ],
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_filteredItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No results found for "$_currentQuery"',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return ListTile(
          leading: const Icon(Icons.fastfood),
          title: Text(item),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected: $item'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}
