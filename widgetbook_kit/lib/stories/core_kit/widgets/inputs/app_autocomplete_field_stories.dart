// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppAutocompleteField] component.
///
/// Material Design 3 autocomplete text field component that displays
/// intelligent suggestions as users type.

// ============================================================================
// Interactive Playground - MUST BE FIRST
// ============================================================================

@widgetbook.UseCase(name: 'Interactive Playground', type: AppAutocompleteField)
Widget appAutocompleteFieldPlayground(BuildContext context) {
  final label = context.knobs.stringOrNull(
    label: 'Label',
    initialValue: 'Select Fruit',
  );
  final hint = context.knobs.stringOrNull(
    label: 'Hint',
    initialValue: 'Type to search...',
  );
  final helperText = context.knobs.stringOrNull(
    label: 'Helper Text',
    initialValue: 'Start typing to see suggestions',
  );
  final errorText = context.knobs.stringOrNull(label: 'Error Text');
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final allowFreeText = context.knobs.boolean(
    label: 'Allow Free Text',
    initialValue: true,
  );
  final highlightMatching = context.knobs.boolean(
    label: 'Highlight Matching',
    initialValue: true,
  );
  final filterStrategy = context.knobs.string(
    label: 'Filter Strategy',
    initialValue: 'startsWith',
    description: 'Options: startsWith, contains, fuzzy',
  );
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
    'Blueberry',
    'Cherry',
    'Date',
    'Fig',
    'Grape',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Pear',
  ];

  FilterStrategy strategy;
  switch (filterStrategy) {
    case 'contains':
      strategy = FilterStrategy.contains;
      break;
    case 'fuzzy':
      strategy = FilterStrategy.fuzzy;
      break;
    default:
      strategy = FilterStrategy.startsWith;
  }

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 350,
        child: AppAutocompleteField<String>(
          suggestions: suggestions,
          label: label,
          hint: hint,
          helperText: helperText,
          errorText: errorText,
          enabled: enabled,
          allowFreeText: allowFreeText,
          highlightMatching: highlightMatching,
          filterStrategy: strategy,
          maxSuggestions: maxSuggestions,
          prefixIcon: Icons.search,
          onSelected: (value) {
            debugPrint('Selected: $value');
          },
          onChanged: (value) {
            debugPrint('Text changed: $value');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 2: Basic Autocomplete
// ============================================================================

@widgetbook.UseCase(name: 'Basic', type: AppAutocompleteField)
Widget basicAutocomplete(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 350,
        child: AppAutocompleteField<String>(
          suggestions: const [
            'Apple',
            'Banana',
            'Cherry',
            'Date',
            'Elderberry',
            'Fig',
            'Grape',
            'Kiwi',
          ],
          label: 'Select Fruit',
          hint: 'Type to search...',
          helperText: 'Start typing to see suggestions',
          prefixIcon: Icons.search,
          onSelected: (value) {
            debugPrint('Selected: $value');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 3: With Error State
// ============================================================================

@widgetbook.UseCase(name: 'With Error', type: AppAutocompleteField)
Widget autocompleteWithError(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 350,
        child: AppAutocompleteField<String>(
          suggestions: const [
            'New York',
            'Los Angeles',
            'Chicago',
            'Houston',
            'Phoenix',
            'Philadelphia',
            'San Antonio',
            'San Diego',
          ],
          label: 'Select City',
          hint: 'Type to search cities...',
          errorText: 'City selection is required',
          prefixIcon: Icons.location_city,
          onSelected: (value) {
            debugPrint('Selected: $value');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 4: Disabled State
// ============================================================================

@widgetbook.UseCase(name: 'Disabled', type: AppAutocompleteField)
Widget disabledAutocomplete(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 350,
        child: AppAutocompleteField<String>(
          suggestions: const ['Option 1', 'Option 2', 'Option 3'],
          label: 'Select Option',
          hint: 'This field is disabled',
          enabled: false,
          prefixIcon: Icons.block,
          onSelected: (value) {
            debugPrint('Selected: $value');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 5: Email Domain Autocomplete
// ============================================================================

@widgetbook.UseCase(name: 'Email Domains', type: AppAutocompleteField)
Widget emailDomainAutocomplete(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 350,
        child: AppAutocompleteField<String>(
          suggestions: const [
            '@gmail.com',
            '@yahoo.com',
            '@outlook.com',
            '@hotmail.com',
            '@icloud.com',
            '@protonmail.com',
          ],
          label: 'Email',
          hint: 'Enter your email',
          helperText: 'Common domains will be suggested',
          filterStrategy: FilterStrategy.contains,
          allowFreeText: true,
          prefixIcon: Icons.email,
          onSelected: (value) {
            debugPrint('Selected: $value');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 6: Custom Objects (Countries)
// ============================================================================

class _Country {
  final String code;
  final String name;
  final String flag;

  const _Country(this.code, this.name, this.flag);

  @override
  String toString() => '$flag $name';
}

@widgetbook.UseCase(name: 'Custom Objects', type: AppAutocompleteField)
Widget customObjectsAutocomplete(BuildContext context) {
  const countries = [
    _Country('us', 'United States', '🇺🇸'),
    _Country('uk', 'United Kingdom', '🇬🇧'),
    _Country('ca', 'Canada', '🇨🇦'),
    _Country('de', 'Germany', '🇩🇪'),
    _Country('fr', 'France', '🇫🇷'),
    _Country('jp', 'Japan', '🇯🇵'),
    _Country('tr', 'Turkey', '🇹🇷'),
    _Country('au', 'Australia', '🇦🇺'),
    _Country('br', 'Brazil', '🇧🇷'),
    _Country('in', 'India', '🇮🇳'),
  ];

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 350,
        child: AppAutocompleteField<_Country>(
          suggestions: countries,
          displayStringForOption: (country) => '$country',
          label: 'Select Country',
          hint: 'Type to search countries...',
          helperText: 'Search by country name',
          prefixIcon: Icons.public,
          onSelected: (value) {
            debugPrint('Selected: ${value.name}');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 7: Contains Filter Strategy
// ============================================================================

@widgetbook.UseCase(name: 'Contains Filter', type: AppAutocompleteField)
Widget containsFilterAutocomplete(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 350,
        child: AppAutocompleteField<String>(
          suggestions: const [
            'JavaScript',
            'TypeScript',
            'Python',
            'Java',
            'C++',
            'C#',
            'Ruby',
            'Go',
            'Rust',
            'Swift',
            'Kotlin',
          ],
          label: 'Programming Language',
          hint: 'Type to search...',
          helperText: 'Matches anywhere in text',
          filterStrategy: FilterStrategy.contains,
          prefixIcon: Icons.code,
          onSelected: (value) {
            debugPrint('Selected: $value');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 8: Fuzzy Match Filter
// ============================================================================

@widgetbook.UseCase(name: 'Fuzzy Match', type: AppAutocompleteField)
Widget fuzzyMatchAutocomplete(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 350,
        child: AppAutocompleteField<String>(
          suggestions: const [
            'Product Management',
            'Project Manager',
            'Software Engineer',
            'Data Scientist',
            'UX Designer',
            'DevOps Engineer',
            'QA Tester',
            'Business Analyst',
          ],
          label: 'Job Title',
          hint: 'Type to search...',
          helperText: 'Flexible character matching',
          filterStrategy: FilterStrategy.fuzzy,
          prefixIcon: Icons.work,
          onSelected: (value) {
            debugPrint('Selected: $value');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 9: Limited Suggestions
// ============================================================================

@widgetbook.UseCase(name: 'Limited Suggestions', type: AppAutocompleteField)
Widget limitedSuggestionsAutocomplete(BuildContext context) {
  final items = List.generate(50, (index) => 'Item ${index + 1}');

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 350,
        child: AppAutocompleteField<String>(
          suggestions: items,
          label: 'Select Item',
          hint: 'Type to search...',
          helperText: 'Max 5 suggestions shown',
          maxSuggestions: 5,
          prefixIcon: Icons.list,
          onSelected: (value) {
            debugPrint('Selected: $value');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 10: No Free Text
// ============================================================================

@widgetbook.UseCase(name: 'No Free Text', type: AppAutocompleteField)
Widget noFreeTextAutocomplete(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 350,
        child: AppAutocompleteField<String>(
          suggestions: const [
            'Extra Small',
            'Small',
            'Medium',
            'Large',
            'Extra Large',
          ],
          label: 'Select Size',
          hint: 'Must select from list',
          helperText: 'Only predefined sizes allowed',
          allowFreeText: false,
          prefixIcon: Icons.straighten,
          onSelected: (value) {
            debugPrint('Selected: $value');
          },
        ),
      ),
    ),
  );
}
