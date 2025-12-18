// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

// Model class for custom objects example
class Country {
  final String code;
  final String name;
  final String flag;

  const Country(this.code, this.name, this.flag);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;
}

// ============================================================================
// Story 1: Basic String Dropdown
// ============================================================================

@widgetbook.UseCase(name: 'Basic String Dropdown', type: AppDropdown)
Widget basicStringDropdown(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
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
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Story 2: Dropdown with Custom Objects
// ============================================================================

@widgetbook.UseCase(name: 'Custom Objects Dropdown', type: AppDropdown)
Widget customObjectsDropdown(BuildContext context) {
  const countries = [
    Country('us', 'United States', '🇺🇸'),
    Country('uk', 'United Kingdom', '🇬🇧'),
    Country('ca', 'Canada', '🇨🇦'),
    Country('de', 'Germany', '🇩🇪'),
    Country('fr', 'France', '🇫🇷'),
    Country('jp', 'Japan', '🇯🇵'),
    Country('tr', 'Turkey', '🇹🇷'),
  ];

  return Center(
    child: SizedBox(
      width: 300,
      child: AppDropdown<Country>(
        items: countries,
        itemLabelBuilder: (country) => '${country.flag} ${country.name}',
        label: 'Select Country',
        hint: 'Choose your country',
        onChanged: (value) {
          debugPrint('Selected: ${value?.name}');
        },
      ),
    ),
  );
}

// ============================================================================
// Story 3: Dropdown with Search
// ============================================================================

@widgetbook.UseCase(name: 'Dropdown with Search', type: AppDropdown)
Widget dropdownWithSearch(BuildContext context) {
  final cities = [
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
    'Austin',
    'Jacksonville',
    'Fort Worth',
    'Columbus',
    'Charlotte',
    'San Francisco',
    'Indianapolis',
    'Seattle',
    'Denver',
    'Washington',
    'Boston',
    'Nashville',
    'Baltimore',
    'Detroit',
    'Portland',
  ];

  return Center(
    child: SizedBox(
      width: 350,
      child: AppDropdown<String>.withSearch(
        items: cities,
        itemLabelBuilder: (city) => city,
        label: 'Select City',
        hint: 'Type to search cities...',
        helperText: 'Search functionality enabled',
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Story 4: Dropdown with Icons (using AppDropdownItem)
// ============================================================================

@widgetbook.UseCase(name: 'Dropdown with Icons', type: AppDropdown)
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
    const AppDropdownItem<String>(
      value: 'settings',
      label: 'Settings',
      icon: Icons.settings,
    ),
  ];

  return Center(
    child: SizedBox(
      width: 300,
      child: Builder(
        builder: (context) => AppDropdown<AppDropdownItem<String>>(
          items: items,
          itemLabelBuilder: (item) => item.label,
          customItemBuilder: (item) => item.buildWidget(context),
          label: 'Select Location',
          hint: 'Choose a location type',
          onChanged: (value) {
            debugPrint('Selected: ${value?.label}');
          },
        ),
      ),
    ),
  );
}

// ============================================================================
// Story 5: Dropdown with Validation Error
// ============================================================================

@widgetbook.UseCase(name: 'Dropdown with Error', type: AppDropdown)
Widget dropdownWithError(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: AppDropdown<String>(
        items: const ['Small', 'Medium', 'Large', 'Extra Large'],
        itemLabelBuilder: (item) => item,
        label: 'Select Size',
        hint: 'Choose a size',
        errorText: 'Size selection is required',
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Story 6: Disabled Dropdown
// ============================================================================

@widgetbook.UseCase(name: 'Disabled Dropdown', type: AppDropdown)
Widget disabledDropdown(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: AppDropdown<String>(
        items: const ['Option 1', 'Option 2', 'Option 3'],
        value: 'Option 2',
        itemLabelBuilder: (item) => item,
        label: 'Select an option',
        hint: 'This dropdown is disabled',
        enabled: false,
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Story 7: Dropdown with Placeholder (No Selection)
// ============================================================================

@widgetbook.UseCase(name: 'Dropdown with Placeholder', type: AppDropdown)
Widget dropdownWithPlaceholder(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: AppDropdown<String>(
        items: const ['Apple', 'Banana', 'Cherry', 'Date', 'Elderberry'],
        value: null,
        itemLabelBuilder: (item) => item,
        label: 'Select Fruit',
        hint: 'No fruit selected',
        helperText: 'Choose your favorite fruit',
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Story 8: Large List Dropdown (100+ items with search)
// ============================================================================

@widgetbook.UseCase(name: 'Large List Dropdown', type: AppDropdown)
Widget largeListDropdown(BuildContext context) {
  final items = List.generate(150, (index) => 'Item ${index + 1}');

  return Center(
    child: SizedBox(
      width: 350,
      child: AppDropdown<String>.withSearch(
        items: items,
        itemLabelBuilder: (item) => item,
        label: 'Select Item',
        hint: 'Search from 150 items...',
        helperText: 'Large scrollable list with search',
        onChanged: (value) {
          debugPrint('Selected: $value');
        },
      ),
    ),
  );
}

// ============================================================================
// Bonus Story: Dropdown with Rich Items (Icon + Subtitle)
// ============================================================================

@widgetbook.UseCase(name: 'Rich Items Dropdown', type: AppDropdown)
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
    child: SizedBox(
      width: 350,
      child: Builder(
        builder: (context) => AppDropdown<AppDropdownItem<String>>(
          items: items,
          itemLabelBuilder: (item) => item.label,
          customItemBuilder: (item) => item.buildWidget(context),
          label: 'Select Status',
          hint: 'Choose item status',
          helperText: 'Items with icons and subtitles',
          onChanged: (value) {
            debugPrint('Selected: ${value?.label}');
          },
        ),
      ),
    ),
  );
}
