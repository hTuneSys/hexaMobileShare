// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppDropdown] component.
///
/// Material Design 3 dropdown menu component for selecting a single value
/// from a list of options with support for search, custom items, and validation.

// ============================================================================
// Interactive Playground - MUST BE FIRST
// ============================================================================

@widgetbook.UseCase(name: 'Interactive Playground', type: AppDropdown)
Widget appDropdownPlayground(BuildContext context) {
  final label = context.knobs.stringOrNull(
    label: 'Label',
    initialValue: 'Select an option',
  );
  final hint = context.knobs.stringOrNull(
    label: 'Hint',
    initialValue: 'Choose one...',
  );
  final helperText = context.knobs.stringOrNull(
    label: 'Helper Text',
    initialValue: 'Pick your preferred option',
  );
  final errorText = context.knobs.stringOrNull(label: 'Error Text');
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final enableSearch = context.knobs.boolean(
    label: 'Enable Search',
    initialValue: false,
  );
  final width = context.knobs.double.slider(
    label: 'Width',
    initialValue: 300,
    min: 200,
    max: 500,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppDropdown<String>(
        items: const [
          'Option 1',
          'Option 2',
          'Option 3',
          'Option 4',
          'Option 5',
        ],
        itemLabelBuilder: (item) => item,
        label: label,
        hint: hint,
        helperText: helperText,
        errorText: errorText,
        enabled: enabled,
        enableSearch: enableSearch,
        width: width,
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Variant 2: Basic Dropdown
// ============================================================================

@widgetbook.UseCase(name: 'Basic', type: AppDropdown)
Widget basicDropdown(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppDropdown<String>(
        items: const [
          'Option 1',
          'Option 2',
          'Option 3',
          'Option 4',
          'Option 5',
        ],
        itemLabelBuilder: (item) => item,
        label: 'Select an option',
        hint: 'Choose one...',
        helperText: 'Pick your preferred option',
        width: 300,
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Variant 3: With Search
// ============================================================================

@widgetbook.UseCase(name: 'With Search', type: AppDropdown)
Widget dropdownWithSearch(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppDropdown<String>.withSearch(
        items: const [
          'New York',
          'Los Angeles',
          'Chicago',
          'Houston',
          'Phoenix',
          'Philadelphia',
          'San Antonio',
          'San Diego',
          'Dallas',
          'San Jose',
        ],
        itemLabelBuilder: (city) => city,
        label: 'Select City',
        hint: 'Type to search cities...',
        helperText: 'Search functionality enabled',
        width: 350,
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Variant 4: With Error
// ============================================================================

@widgetbook.UseCase(name: 'With Error', type: AppDropdown)
Widget dropdownWithError(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppDropdown<String>(
        items: const ['Small', 'Medium', 'Large', 'Extra Large'],
        itemLabelBuilder: (item) => item,
        label: 'Select Size',
        hint: 'Choose a size',
        errorText: 'Size selection is required',
        width: 300,
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Variant 5: Disabled State
// ============================================================================

@widgetbook.UseCase(name: 'Disabled', type: AppDropdown)
Widget disabledDropdown(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppDropdown<String>(
        items: const ['Option 1', 'Option 2', 'Option 3'],
        value: 'Option 2',
        itemLabelBuilder: (item) => item,
        label: 'Select an option',
        hint: 'This dropdown is disabled',
        enabled: false,
        width: 300,
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Variant 6: With Leading Icon
// ============================================================================

@widgetbook.UseCase(name: 'With Leading Icon', type: AppDropdown)
Widget dropdownWithLeadingIcon(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppDropdown<String>(
        items: const ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'],
        itemLabelBuilder: (item) => item,
        label: 'Select Fruit',
        hint: 'Choose your favorite',
        leadingIcon: Icons.apple,
        helperText: 'Dropdown with leading icon',
        width: 300,
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Variant 7: Custom Objects (Countries)
// ============================================================================

class _Country {
  final String code;
  final String name;
  final String flag;

  const _Country(this.code, this.name, this.flag);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Country &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}

@widgetbook.UseCase(name: 'Custom Objects', type: AppDropdown)
Widget customObjectsDropdown(BuildContext context) {
  const countries = [
    _Country('us', 'United States', '🇺🇸'),
    _Country('uk', 'United Kingdom', '🇬🇧'),
    _Country('ca', 'Canada', '🇨🇦'),
    _Country('de', 'Germany', '🇩🇪'),
    _Country('fr', 'France', '🇫🇷'),
    _Country('jp', 'Japan', '🇯🇵'),
    _Country('tr', 'Turkey', '🇹🇷'),
  ];

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppDropdown<_Country>(
        items: countries,
        itemLabelBuilder: (country) => '${country.flag} ${country.name}',
        label: 'Select Country',
        hint: 'Choose your country',
        width: 300,
        onChanged: (value) {
          debugPrint('Selected: ${value?.name}');
        },
      ),
    ),
  );
}

// ============================================================================
// Variant 8: With Icons (Using AppDropdownItem)
// ============================================================================

@widgetbook.UseCase(name: 'With Icons', type: AppDropdown)
Widget dropdownWithIcons(BuildContext context) {
  final items = [
    const AppDropdownItem<String>(
      value: 'home',
      label: 'Home',
      icon: Icons.home,
    ),
    const AppDropdownItem<String>(
      value: 'work',
      label: 'Work',
      icon: Icons.work,
    ),
    const AppDropdownItem<String>(
      value: 'school',
      label: 'School',
      icon: Icons.school,
    ),
    const AppDropdownItem<String>(
      value: 'favorite',
      label: 'Favorite',
      icon: Icons.favorite,
    ),
  ];

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Builder(
        builder: (context) => AppDropdown<AppDropdownItem<String>>(
          items: items,
          itemLabelBuilder: (item) => item.label,
          customItemBuilder: (item) => item.buildWidget(context),
          label: 'Select Location',
          hint: 'Choose a location type',
          width: 300,
          onChanged: (value) {
            debugPrint('Selected: ${value?.label}');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 9: Rich Items (Icon + Subtitle)
// ============================================================================

@widgetbook.UseCase(name: 'Rich Items', type: AppDropdown)
Widget richItemsDropdown(BuildContext context) {
  final items = [
    const AppDropdownItem<String>(
      value: 'pending',
      label: 'Pending',
      icon: Icons.pending,
      subtitle: 'Awaiting review',
    ),
    const AppDropdownItem<String>(
      value: 'approved',
      label: 'Approved',
      icon: Icons.check_circle,
      subtitle: 'Ready to proceed',
    ),
    const AppDropdownItem<String>(
      value: 'rejected',
      label: 'Rejected',
      icon: Icons.cancel,
      subtitle: 'Needs revision',
    ),
    const AppDropdownItem<String>(
      value: 'archived',
      label: 'Archived',
      icon: Icons.archive,
      subtitle: 'No longer active',
    ),
  ];

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Builder(
        builder: (context) => AppDropdown<AppDropdownItem<String>>(
          items: items,
          itemLabelBuilder: (item) => item.label,
          customItemBuilder: (item) => item.buildWidget(context),
          label: 'Select Status',
          hint: 'Choose item status',
          helperText: 'Items with icons and subtitles',
          width: 350,
          onChanged: (value) {
            debugPrint('Selected: ${value?.label}');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 10: Large List with Search
// ============================================================================

@widgetbook.UseCase(name: 'Large List', type: AppDropdown)
Widget largeListDropdown(BuildContext context) {
  final items = List.generate(100, (index) => 'Item ${index + 1}');

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppDropdown<String>.withSearch(
        items: items,
        itemLabelBuilder: (item) => item,
        label: 'Select Item',
        hint: 'Search from 100 items...',
        helperText: 'Large scrollable list with search',
        width: 350,
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}
