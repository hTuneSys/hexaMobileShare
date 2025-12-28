// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// 1. Assist Chips - Quick actions with elevation
@widgetbook.UseCase(name: 'Assist Chips', type: AppChip)
Widget assistChips(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Assist Chips',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Help users take quick contextual actions',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppChip.assist(
              label: 'Add to calendar',
              icon: Icons.event,
              onTap: () => debugPrint('Add to calendar tapped'),
            ),
            AppChip.assist(
              label: 'Set reminder',
              icon: Icons.alarm,
              onTap: () => debugPrint('Set reminder tapped'),
            ),
            AppChip.assist(
              label: 'Share',
              icon: Icons.share,
              onTap: () => debugPrint('Share tapped'),
            ),
            AppChip.assist(
              label: 'Navigate',
              icon: Icons.directions,
              onTap: () => debugPrint('Navigate tapped'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Without Icons',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppChip.assist(
              label: 'Call',
              onTap: () => debugPrint('Call tapped'),
            ),
            AppChip.assist(
              label: 'Message',
              onTap: () => debugPrint('Message tapped'),
            ),
          ],
        ),
      ],
    ),
  );
}

// 2. Filter Chips - Selectable options
@widgetbook.UseCase(name: 'Filter Chips', type: AppChip)
Widget filterChips(BuildContext context) {
  return _FilterChipsDemo();
}

class _FilterChipsDemo extends StatefulWidget {
  @override
  State<_FilterChipsDemo> createState() => _FilterChipsDemoState();
}

class _FilterChipsDemoState extends State<_FilterChipsDemo> {
  final Set<String> _selectedCategories = {'Photos'};
  final Set<String> _selectedSizes = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter Chips',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Select options from a set to filter content',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Text(
            'Content Types',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppChip.filter(
                label: 'All',
                selected: _selectedCategories.contains('All'),
                onTap: () => setState(() {
                  if (_selectedCategories.contains('All')) {
                    _selectedCategories.remove('All');
                  } else {
                    _selectedCategories.add('All');
                  }
                }),
              ),
              AppChip.filter(
                label: 'Photos',
                icon: Icons.photo,
                selected: _selectedCategories.contains('Photos'),
                onTap: () => setState(() {
                  if (_selectedCategories.contains('Photos')) {
                    _selectedCategories.remove('Photos');
                  } else {
                    _selectedCategories.add('Photos');
                  }
                }),
              ),
              AppChip.filter(
                label: 'Videos',
                icon: Icons.videocam,
                selected: _selectedCategories.contains('Videos'),
                onTap: () => setState(() {
                  if (_selectedCategories.contains('Videos')) {
                    _selectedCategories.remove('Videos');
                  } else {
                    _selectedCategories.add('Videos');
                  }
                }),
              ),
              AppChip.filter(
                label: 'Documents',
                icon: Icons.description,
                selected: _selectedCategories.contains('Documents'),
                onTap: () => setState(() {
                  if (_selectedCategories.contains('Documents')) {
                    _selectedCategories.remove('Documents');
                  } else {
                    _selectedCategories.add('Documents');
                  }
                }),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Sizes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppChip.filter(
                label: 'Small',
                selected: _selectedSizes.contains('Small'),
                onTap: () => setState(() {
                  if (_selectedSizes.contains('Small')) {
                    _selectedSizes.remove('Small');
                  } else {
                    _selectedSizes.add('Small');
                  }
                }),
              ),
              AppChip.filter(
                label: 'Medium',
                selected: _selectedSizes.contains('Medium'),
                onTap: () => setState(() {
                  if (_selectedSizes.contains('Medium')) {
                    _selectedSizes.remove('Medium');
                  } else {
                    _selectedSizes.add('Medium');
                  }
                }),
              ),
              AppChip.filter(
                label: 'Large',
                selected: _selectedSizes.contains('Large'),
                onTap: () => setState(() {
                  if (_selectedSizes.contains('Large')) {
                    _selectedSizes.remove('Large');
                  } else {
                    _selectedSizes.add('Large');
                  }
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 3. Input Chips - Complex info with avatars
@widgetbook.UseCase(name: 'Input Chips', type: AppChip)
Widget inputChips(BuildContext context) {
  return _InputChipsDemo();
}

class _InputChipsDemo extends StatefulWidget {
  @override
  State<_InputChipsDemo> createState() => _InputChipsDemoState();
}

class _InputChipsDemoState extends State<_InputChipsDemo> {
  final List<String> _contacts = [
    'Alice Johnson',
    'Bob Smith',
    'Charlie Brown',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Input Chips',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Represent complex user input with avatars',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Text(
            'Recipients',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _contacts.map((contact) {
              return AppChip.input(
                label: contact,
                avatar: CircleAvatar(child: Text(contact[0])),
                onDelete: () {
                  setState(() {
                    _contacts.remove(contact);
                  });
                  debugPrint('Deleted: $contact');
                },
                onTap: () => debugPrint('Tapped: $contact'),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Tags',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              AppChip.input(
                label: 'Flutter',
                onDelete: () => debugPrint('Deleted: Flutter'),
              ),
              AppChip.input(
                label: 'Dart',
                onDelete: () => debugPrint('Deleted: Dart'),
              ),
              AppChip.input(
                label: 'Mobile Dev',
                onDelete: () => debugPrint('Deleted: Mobile Dev'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 4. Suggestion Chips - Flat recommendations
@widgetbook.UseCase(name: 'Suggestion Chips', type: AppChip)
Widget suggestionChips(BuildContext context) {
  return _SuggestionChipsDemo();
}

class _SuggestionChipsDemo extends StatefulWidget {
  @override
  State<_SuggestionChipsDemo> createState() => _SuggestionChipsDemoState();
}

class _SuggestionChipsDemoState extends State<_SuggestionChipsDemo> {
  String? _selectedSuggestion;

  final List<String> _searchSuggestions = [
    'Coffee shops nearby',
    'Best restaurants',
    'Hotels in Paris',
    'Things to do',
  ];

  final List<String> _smartReplies = [
    'Thanks!',
    'Sounds good',
    'On my way',
    'Let me check',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Suggestion Chips',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Help users discover actions and complete tasks',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          const Text(
            'Search Suggestions',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _searchSuggestions.map((suggestion) {
              return AppChip.suggestion(
                label: suggestion,
                icon: Icons.search,
                onTap: () {
                  setState(() {
                    _selectedSuggestion = suggestion;
                  });
                  debugPrint('Search: $suggestion');
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text(
            'Smart Replies',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _smartReplies.map((reply) {
              return AppChip.suggestion(
                label: reply,
                onTap: () {
                  setState(() {
                    _selectedSuggestion = reply;
                  });
                  debugPrint('Reply: $reply');
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          if (_selectedSuggestion != null)
            Card(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    Text('Selected: $_selectedSuggestion'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// 5. Custom Colors - Themed chips
@widgetbook.UseCase(name: 'Custom Colors', type: AppChip)
Widget customColorChips(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Custom Colors',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Chips with custom colors for status and categories',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        const Text(
          'Status Chips',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppChip.assist(
              label: 'Active',
              icon: Icons.check_circle,
              backgroundColor: Colors.green.shade100,
              labelColor: Colors.green.shade900,
              onTap: () => debugPrint('Active'),
            ),
            AppChip.assist(
              label: 'Pending',
              icon: Icons.schedule,
              backgroundColor: Colors.orange.shade100,
              labelColor: Colors.orange.shade900,
              onTap: () => debugPrint('Pending'),
            ),
            AppChip.assist(
              label: 'Error',
              icon: Icons.error,
              backgroundColor: Colors.red.shade100,
              labelColor: Colors.red.shade900,
              onTap: () => debugPrint('Error'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'Priority Tags',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppChip.input(
              label: 'High Priority',
              backgroundColor: Colors.red.shade50,
              labelColor: Colors.red.shade700,
              deleteIconColor: Colors.red.shade700,
              onDelete: () => debugPrint('Delete high priority'),
            ),
            AppChip.input(
              label: 'Medium Priority',
              backgroundColor: Colors.yellow.shade50,
              labelColor: Colors.yellow.shade900,
              deleteIconColor: Colors.yellow.shade900,
              onDelete: () => debugPrint('Delete medium priority'),
            ),
            AppChip.input(
              label: 'Low Priority',
              backgroundColor: Colors.blue.shade50,
              labelColor: Colors.blue.shade700,
              deleteIconColor: Colors.blue.shade700,
              onDelete: () => debugPrint('Delete low priority'),
            ),
          ],
        ),
      ],
    ),
  );
}

// 6. Disabled State - All types disabled
@widgetbook.UseCase(name: 'Disabled State', type: AppChip)
Widget disabledChips(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Disabled Chips',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'All chip types in disabled state',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        const Text('Assist Chip'),
        const SizedBox(height: 8),
        Row(
          children: [
            AppChip.assist(
              label: 'Enabled',
              icon: Icons.add,
              onTap: () => debugPrint('Enabled'),
            ),
            const SizedBox(width: 8),
            AppChip.assist(
              label: 'Disabled',
              icon: Icons.add,
              enabled: false,
              onTap: () => debugPrint('Should not print'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Filter Chip'),
        const SizedBox(height: 8),
        Row(
          children: [
            AppChip.filter(
              label: 'Enabled',
              selected: true,
              onTap: () => debugPrint('Enabled'),
            ),
            const SizedBox(width: 8),
            AppChip.filter(
              label: 'Disabled',
              selected: true,
              enabled: false,
              onTap: () => debugPrint('Should not print'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Input Chip'),
        const SizedBox(height: 8),
        Row(
          children: [
            AppChip.input(
              label: 'Enabled',
              onDelete: () => debugPrint('Deleted'),
            ),
            const SizedBox(width: 8),
            AppChip.input(
              label: 'Disabled',
              enabled: false,
              onDelete: () => debugPrint('Should not print'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Suggestion Chip'),
        const SizedBox(height: 8),
        Row(
          children: [
            AppChip.suggestion(
              label: 'Enabled',
              onTap: () => debugPrint('Enabled'),
            ),
            const SizedBox(width: 8),
            AppChip.suggestion(
              label: 'Disabled',
              enabled: false,
              onTap: () => debugPrint('Should not print'),
            ),
          ],
        ),
      ],
    ),
  );
}

// 7. Chip Group - Scrollable horizontal list
@widgetbook.UseCase(name: 'Chip Group', type: AppChip)
Widget chipGroup(BuildContext context) {
  return _ChipGroupDemo();
}

class _ChipGroupDemo extends StatefulWidget {
  @override
  State<_ChipGroupDemo> createState() => _ChipGroupDemoState();
}

class _ChipGroupDemoState extends State<_ChipGroupDemo> {
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Technology',
    'Design',
    'Business',
    'Health',
    'Science',
    'Entertainment',
    'Sports',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chip Group',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Scrollable horizontal chip group for categories',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: _categories.map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: AppChip.filter(
                  label: category,
                  selected: _selectedCategory == category,
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                    debugPrint('Selected: $category');
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Category',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _selectedCategory,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 8. Interactive Playground - WITH KNOBS!
@widgetbook.UseCase(name: 'Interactive Playground', type: AppChip)
Widget interactivePlayground(BuildContext context) {
  // Get knobs values
  final chipType = context.knobs.object.dropdown(
    label: 'Chip Type',
    options: ['assist', 'filter', 'input', 'suggestion'],
    initialOption: 'assist',
  );

  final label = context.knobs.string(label: 'Label', initialValue: 'My Chip');

  final withIcon = context.knobs.boolean(
    label: 'With Icon',
    initialValue: true,
  );

  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  final selected = context.knobs.boolean(
    label: 'Selected (Filter only)',
    initialValue: false,
  );

  final withAvatar = context.knobs.boolean(
    label: 'With Avatar (Input only)',
    initialValue: true,
  );

  final withDelete = context.knobs.boolean(
    label: 'With Delete (Input only)',
    initialValue: true,
  );

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Interactive Playground',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Use the knobs panel to customize the chip',
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 32),
        Center(
          child: Builder(
            builder: (context) {
              switch (chipType) {
                case 'assist':
                  return AppChip.assist(
                    label: label,
                    icon: withIcon ? Icons.add : null,
                    enabled: enabled,
                    onTap: () => debugPrint('Assist chip tapped'),
                  );
                case 'filter':
                  return AppChip.filter(
                    label: label,
                    icon: withIcon ? Icons.category : null,
                    selected: selected,
                    enabled: enabled,
                    onTap: () => debugPrint('Filter chip tapped'),
                  );
                case 'input':
                  return AppChip.input(
                    label: label,
                    avatar: withAvatar
                        ? CircleAvatar(child: Text(label[0].toUpperCase()))
                        : null,
                    enabled: enabled,
                    onDelete: withDelete
                        ? () => debugPrint('Delete tapped')
                        : null,
                    onTap: () => debugPrint('Input chip tapped'),
                  );
                case 'suggestion':
                  return AppChip.suggestion(
                    label: label,
                    icon: withIcon ? Icons.lightbulb : null,
                    enabled: enabled,
                    onTap: () => debugPrint('Suggestion chip tapped'),
                  );
                default:
                  return AppChip.assist(
                    label: label,
                    enabled: enabled,
                    onTap: () => debugPrint('Chip tapped'),
                  );
              }
            },
          ),
        ),
        const SizedBox(height: 32),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Current Configuration',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text('Type: $chipType'),
                Text('Label: $label'),
                Text('Enabled: $enabled'),
                if (chipType == 'filter') Text('Selected: $selected'),
                if (chipType == 'assist' ||
                    chipType == 'filter' ||
                    chipType == 'suggestion')
                  Text('Icon: $withIcon'),
                if (chipType == 'input') Text('Avatar: $withAvatar'),
                if (chipType == 'input') Text('Delete: $withDelete'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
