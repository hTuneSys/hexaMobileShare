// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/chips/app_filter_chip.dart';

// 1. Basic Filter Chip - Unselected State
@widgetbook.UseCase(name: 'Basic Unselected', type: AppFilterChip)
Widget basicFilterChip(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Shoes');

  return Center(
    child: AppFilterChip(
      label: label,
      selected: false,
      onSelected: (selected) {
        debugPrint('Filter chip selected: $selected');
      },
    ),
  );
}

// 2. Selected Filter Chip with Checkmark
@widgetbook.UseCase(name: 'Selected State', type: AppFilterChip)
Widget selectedFilterChip(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Electronics',
  );

  return Center(
    child: AppFilterChip(
      label: label,
      selected: true,
      onSelected: (selected) {
        debugPrint('Filter chip selected: $selected');
      },
    ),
  );
}

// 3. Filter Chip with Custom Icon
@widgetbook.UseCase(name: 'With Icon', type: AppFilterChip)
Widget filterChipWithIcon(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'New Arrivals',
  );

  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );

  final iconType = context.knobs.list(
    label: 'Icon',
    options: ['fiber_new', 'local_offer', 'star', 'favorite', 'category'],
    labelBuilder: (option) => option,
  );

  IconData getIcon(String name) {
    switch (name) {
      case 'fiber_new':
        return Icons.fiber_new;
      case 'local_offer':
        return Icons.local_offer;
      case 'star':
        return Icons.star;
      case 'favorite':
        return Icons.favorite;
      case 'category':
        return Icons.category;
      default:
        return Icons.filter_alt;
    }
  }

  return Center(
    child: AppFilterChip(
      label: label,
      icon: getIcon(iconType),
      selected: selected,
      onSelected: (value) {
        debugPrint('Filter chip selected: $value');
      },
    ),
  );
}

// 4. Disabled Filter Chip
@widgetbook.UseCase(name: 'Disabled State', type: AppFilterChip)
Widget disabledFilterChip(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Disabled');

  final selected = context.knobs.boolean(
    label: 'Selected (Visual Only)',
    initialValue: false,
  );

  return Center(
    child: AppFilterChip(
      label: label,
      selected: selected,
      enabled: false,
      onSelected: (value) {
        debugPrint('This should not print');
      },
    ),
  );
}

// 5. Filter Chip Group - Interactive multi-selection demo
@widgetbook.UseCase(name: 'Filter Group Demo', type: AppFilterChip)
Widget filterChipGroup(BuildContext context) {
  return const _FilterGroupDemo();
}

class _FilterGroupDemo extends StatefulWidget {
  const _FilterGroupDemo();

  @override
  State<_FilterGroupDemo> createState() => _FilterGroupDemoState();
}

class _FilterGroupDemoState extends State<_FilterGroupDemo> {
  final Set<String> _selectedFilters = {};

  @override
  Widget build(BuildContext context) {
    final categories = {
      'electronics': 'Electronics',
      'clothing': 'Clothing',
      'books': 'Books',
      'home': 'Home & Garden',
      'sports': 'Sports',
    };

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Product Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Multi-selection enabled - tap to toggle',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.entries.map((entry) {
              return AppFilterChip(
                label: entry.value,
                selected: _selectedFilters.contains(entry.key),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedFilters.add(entry.key);
                    } else {
                      _selectedFilters.remove(entry.key);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Text(
            'Selected: ${_selectedFilters.isEmpty ? 'None' : _selectedFilters.map((key) => categories[key]).join(', ')}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// 6. Filter Chip with Avatar - Single component showing avatar behavior
@widgetbook.UseCase(name: 'With Avatar', type: AppFilterChip)
Widget filterChipWithAvatar(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'John Doe');

  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );

  final avatarText = context.knobs.string(
    label: 'Avatar Text',
    initialValue: 'JD',
  );

  final avatarColorOption = context.knobs.list(
    label: 'Avatar Color',
    options: ['Blue', 'Purple', 'Green', 'Orange', 'Pink'],
    labelBuilder: (option) => option,
  );

  Color getAvatarColor(String color) {
    switch (color) {
      case 'Blue':
        return Colors.blue.shade100;
      case 'Purple':
        return Colors.purple.shade100;
      case 'Green':
        return Colors.green.shade100;
      case 'Orange':
        return Colors.orange.shade100;
      case 'Pink':
        return Colors.pink.shade100;
      default:
        return Colors.blue.shade100;
    }
  }

  Color getAvatarTextColor(String color) {
    switch (color) {
      case 'Blue':
        return Colors.blue.shade900;
      case 'Purple':
        return Colors.purple.shade900;
      case 'Green':
        return Colors.green.shade900;
      case 'Orange':
        return Colors.orange.shade900;
      case 'Pink':
        return Colors.pink.shade900;
      default:
        return Colors.blue.shade900;
    }
  }

  return Center(
    child: AppFilterChip(
      label: label,
      avatar: CircleAvatar(
        backgroundColor: getAvatarColor(avatarColorOption),
        radius: 12,
        child: Text(
          avatarText,
          style: TextStyle(
            color: getAvatarTextColor(avatarColorOption),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      selected: selected,
      onSelected: (value) {
        debugPrint('Filter chip selected: $value');
      },
    ),
  );
}

// 6. Filter Chip with Custom Colors - Single component
@widgetbook.UseCase(name: 'Custom Colors', type: AppFilterChip)
Widget filterChipCustomColors(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Custom Theme',
  );

  final selected = context.knobs.boolean(label: 'Selected', initialValue: true);

  final colorScheme = context.knobs.list(
    label: 'Color Scheme',
    options: ['Purple', 'Green', 'Orange', 'Blue', 'Pink', 'Teal'],
    labelBuilder: (option) => option,
  );

  Color getSelectedColor(String scheme) {
    switch (scheme) {
      case 'Purple':
        return Colors.purple.shade100;
      case 'Green':
        return Colors.green.shade100;
      case 'Orange':
        return Colors.orange.shade100;
      case 'Blue':
        return Colors.blue.shade100;
      case 'Pink':
        return Colors.pink.shade100;
      case 'Teal':
        return Colors.teal.shade100;
      default:
        return Colors.purple.shade100;
    }
  }

  Color getCheckmarkColor(String scheme) {
    switch (scheme) {
      case 'Purple':
        return Colors.purple.shade900;
      case 'Green':
        return Colors.green.shade900;
      case 'Orange':
        return Colors.orange.shade900;
      case 'Blue':
        return Colors.blue.shade900;
      case 'Pink':
        return Colors.pink.shade900;
      case 'Teal':
        return Colors.teal.shade900;
      default:
        return Colors.purple.shade900;
    }
  }

  return Center(
    child: AppFilterChip(
      label: label,
      selected: selected,
      selectedColor: getSelectedColor(colorScheme),
      checkmarkColor: getCheckmarkColor(colorScheme),
      onSelected: (value) {
        debugPrint('Filter chip selected: $value');
      },
    ),
  );
}

// 7. Filter Chip with Tooltip - Single component
@widgetbook.UseCase(name: 'With Tooltip', type: AppFilterChip)
Widget withTooltipChip(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Hover Me');

  final tooltipText = context.knobs.string(
    label: 'Tooltip Text',
    initialValue: 'Tap to filter by this category',
  );

  final selected = context.knobs.boolean(
    label: 'Selected',
    initialValue: false,
  );

  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Long-press or hover to see tooltip',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        const SizedBox(height: 16),
        AppFilterChip(
          label: label,
          tooltip: tooltipText,
          selected: selected,
          onSelected: (value) {
            debugPrint('Filter chip selected: $value');
          },
        ),
      ],
    ),
  );
}

// 8. Interactive Playground - Full Customization with Knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppFilterChip)
Widget filterChipPlayground(BuildContext context) {
  // ========== Text Content ==========
  final label = context.knobs.string(
    label: 'Label Text',
    initialValue: 'Filter Chip',
  );

  final showTooltip = context.knobs.boolean(
    label: 'Show Tooltip',
    initialValue: false,
  );

  final tooltipText = context.knobs.string(
    label: 'Tooltip Text',
    initialValue: 'Tap to filter by this category',
  );

  // ========== State Management ==========
  final selected = context.knobs.boolean(
    label: 'Selected State',
    initialValue: false,
  );

  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);

  // ========== Leading Widget Options ==========
  final leadingType = context.knobs.list(
    label: 'Leading Widget',
    options: ['None', 'Icon', 'Avatar'],
    labelBuilder: (option) => option,
  );

  final iconType = context.knobs.list(
    label: 'Icon Type',
    options: [
      'fiber_new',
      'local_offer',
      'star',
      'favorite',
      'category',
      'label',
      'sell',
      'shopping_bag',
    ],
    labelBuilder: (option) => option,
  );

  final avatarText = context.knobs.string(
    label: 'Avatar Text',
    initialValue: 'AB',
  );

  // ========== Color Customization ==========
  final useCustomColors = context.knobs.boolean(
    label: 'Custom Colors',
    initialValue: false,
  );

  final selectedColorOption = context.knobs.list(
    label: 'Selected BG',
    options: ['Default', 'Purple', 'Green', 'Orange', 'Blue', 'Pink', 'Teal'],
    labelBuilder: (option) => option,
  );

  final checkmarkColorOption = context.knobs.list(
    label: 'Checkmark',
    options: [
      'Default',
      'Purple',
      'Green',
      'Orange',
      'Blue',
      'Pink',
      'Teal',
      'White',
      'Black',
    ],
    labelBuilder: (option) => option,
  );

  // ========== Advanced Styling ==========
  final elevation = context.knobs.double.slider(
    label: 'Elevation',
    initialValue: 0.0,
    min: 0.0,
    max: 8.0,
  );

  final pressElevation = context.knobs.double.slider(
    label: 'Press Elevation',
    initialValue: 0.0,
    min: 0.0,
    max: 8.0,
  );

  final horizontalPadding = context.knobs.double.slider(
    label: 'H-Padding',
    initialValue: 16.0,
    min: 4.0,
    max: 32.0,
  );

  final verticalPadding = context.knobs.double.slider(
    label: 'V-Padding',
    initialValue: 0.0,
    min: 0.0,
    max: 16.0,
  );

  final fontSize = context.knobs.double.slider(
    label: 'Font Size',
    initialValue: 14.0,
    min: 10.0,
    max: 20.0,
  );

  final fontWeightOption = context.knobs.list(
    label: 'Font Weight',
    options: ['Normal', 'Medium', 'Semibold', 'Bold'],
    labelBuilder: (option) => option,
  );

  FontWeight getFontWeight(String option) {
    switch (option) {
      case 'Medium':
        return FontWeight.w500;
      case 'Semibold':
        return FontWeight.w600;
      case 'Bold':
        return FontWeight.bold;
      default:
        return FontWeight.normal;
    }
  }

  final borderRadius = context.knobs.double.slider(
    label: 'Border Radius',
    initialValue: 16.0,
    min: 0.0,
    max: 32.0,
  );

  final visualDensityOption = context.knobs.list(
    label: 'Visual Density',
    options: ['Standard', 'Comfortable', 'Compact', 'Adaptive'],
    labelBuilder: (option) => option,
  );

  VisualDensity getVisualDensity(String option) {
    switch (option) {
      case 'Comfortable':
        return VisualDensity.comfortable;
      case 'Compact':
        return VisualDensity.compact;
      case 'Adaptive':
        return VisualDensity.adaptivePlatformDensity;
      default:
        return VisualDensity.standard;
    }
  }

  // ========== Build Leading Widget ==========
  IconData? icon;
  Widget? avatar;

  if (leadingType == 'Icon') {
    icon = _getIconData(iconType);
  } else if (leadingType == 'Avatar') {
    avatar = CircleAvatar(
      backgroundColor: _getAvatarColor(avatarText),
      radius: 12,
      child: Text(
        avatarText.isNotEmpty ? avatarText.substring(0, 2).toUpperCase() : 'AB',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // ========== Build Color Values ==========
  Color? selectedColor;
  Color? checkmarkColor;

  if (useCustomColors && selectedColorOption != 'Default') {
    selectedColor = _getColorFromOption(selectedColorOption, isLight: true);
  }

  if (useCustomColors && checkmarkColorOption != 'Default') {
    checkmarkColor = _getColorFromOption(checkmarkColorOption, isLight: false);
  }

  return Center(
    child: AppFilterChip(
      label: label,
      selected: selected,
      enabled: enabled,
      icon: icon,
      avatar: avatar,
      selectedColor: selectedColor,
      checkmarkColor: checkmarkColor,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      elevation: elevation,
      pressElevation: pressElevation,
      visualDensity: getVisualDensity(visualDensityOption),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      tooltip: showTooltip ? tooltipText : null,
      labelStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: getFontWeight(fontWeightOption),
      ),
      onSelected: enabled
          ? (value) {
              debugPrint('Filter chip selected: $value');
            }
          : null,
    ),
  );
}

// Helper function to get IconData from string
IconData _getIconData(String iconName) {
  switch (iconName) {
    case 'fiber_new':
      return Icons.fiber_new;
    case 'local_offer':
      return Icons.local_offer;
    case 'star':
      return Icons.star;
    case 'favorite':
      return Icons.favorite;
    case 'category':
      return Icons.category;
    case 'label':
      return Icons.label;
    case 'sell':
      return Icons.sell;
    case 'shopping_bag':
      return Icons.shopping_bag;
    default:
      return Icons.filter_alt;
  }
}

// Helper function to get avatar color based on text
Color _getAvatarColor(String text) {
  final colors = [
    Colors.blue,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.teal,
  ];
  final index = text.isNotEmpty ? text.codeUnitAt(0) % colors.length : 0;
  return colors[index];
}

// Helper function to get color from option
Color? _getColorFromOption(String option, {required bool isLight}) {
  switch (option) {
    case 'Purple':
      return isLight ? Colors.purple.shade100 : Colors.purple.shade900;
    case 'Green':
      return isLight ? Colors.green.shade100 : Colors.green.shade900;
    case 'Orange':
      return isLight ? Colors.orange.shade100 : Colors.orange.shade900;
    case 'Blue':
      return isLight ? Colors.blue.shade100 : Colors.blue.shade900;
    case 'Pink':
      return isLight ? Colors.pink.shade100 : Colors.pink.shade900;
    case 'Teal':
      return isLight ? Colors.teal.shade100 : Colors.teal.shade900;
    case 'White':
      return Colors.white;
    case 'Black':
      return Colors.black;
    default:
      return null;
  }
}
