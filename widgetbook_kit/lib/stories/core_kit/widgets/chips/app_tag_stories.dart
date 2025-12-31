// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/chips/app_tag.dart';

// 1. Basic Tag - Focused on label and basic usage
@widgetbook.UseCase(name: 'Basic Tag', type: AppTag)
Widget appTagBasic(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Featured');

  return Center(child: AppTag(label: label));
}

// 2. With Icon - Focused on icon functionality
@widgetbook.UseCase(name: 'With Icon', type: AppTag)
Widget appTagWithIcon(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Premium');

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );

  final iconOptions = [
    Icons.star,
    Icons.verified,
    Icons.check_circle,
    Icons.info,
    Icons.warning,
    Icons.error,
    Icons.favorite,
    Icons.local_fire_department,
  ];

  final iconNames = [
    'Star',
    'Verified',
    'Check Circle',
    'Info',
    'Warning',
    'Error',
    'Favorite',
    'Fire',
  ];

  final iconIndex = context.knobs.object.dropdown(
    label: 'Icon',
    options: List.generate(iconOptions.length, (i) => i),
    labelBuilder: (index) => iconNames[index],
    initialOption: 0,
  );

  return Center(
    child: AppTag(label: label, icon: showIcon ? iconOptions[iconIndex] : null),
  );
}

// 3. Color Variants - Focused on semantic color options
@widgetbook.UseCase(name: 'Color Variants', type: AppTag)
Widget appTagColorVariants(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Status');

  final colorVariant = context.knobs.object.dropdown(
    label: 'Color Variant',
    options: AppTagColorVariant.values,
    labelBuilder: (variant) => variant.name,
    initialOption: AppTagColorVariant.success,
  );

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );

  IconData? getIconForVariant(AppTagColorVariant variant) {
    switch (variant) {
      case AppTagColorVariant.success:
        return showIcon ? Icons.check_circle : null;
      case AppTagColorVariant.warning:
        return showIcon ? Icons.warning_amber : null;
      case AppTagColorVariant.error:
        return showIcon ? Icons.error : null;
      case AppTagColorVariant.info:
        return showIcon ? Icons.info : null;
      case AppTagColorVariant.neutral:
        return showIcon ? Icons.label : null;
    }
  }

  return Center(
    child: AppTag(
      label: label,
      colorVariant: colorVariant,
      icon: getIconForVariant(colorVariant),
    ),
  );
}

// 4. Size Variants - Focused on tag sizes
@widgetbook.UseCase(name: 'Size Variants', type: AppTag)
Widget appTagSizeVariants(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Badge');

  final size = context.knobs.object.dropdown(
    label: 'Size',
    options: AppTagSize.values,
    labelBuilder: (size) => size.name,
    initialOption: AppTagSize.medium,
  );

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: false,
  );

  return Center(
    child: AppTag(label: label, size: size, icon: showIcon ? Icons.star : null),
  );
}

// 5. Style Variants - Focused on filled vs outlined
@widgetbook.UseCase(name: 'Style Variants', type: AppTag)
Widget appTagStyleVariants(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Design');

  final style = context.knobs.object.dropdown(
    label: 'Style',
    options: AppTagStyle.values,
    labelBuilder: (style) => style.name,
    initialOption: AppTagStyle.filled,
  );

  final colorVariant = context.knobs.object.dropdown(
    label: 'Color Variant',
    options: AppTagColorVariant.values,
    labelBuilder: (variant) => variant.name,
    initialOption: AppTagColorVariant.info,
  );

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: false,
  );

  return Center(
    child: AppTag(
      label: label,
      style: style,
      colorVariant: colorVariant,
      icon: showIcon ? Icons.code : null,
    ),
  );
}

// 6. Custom Colors - Focused on custom color customization
@widgetbook.UseCase(name: 'Custom Colors', type: AppTag)
Widget appTagCustomColors(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Custom');

  final useCustomColors = context.knobs.boolean(
    label: 'Use Custom Colors',
    initialValue: true,
  );

  final backgroundColorOptions = [
    Colors.purple,
    Colors.pink,
    Colors.indigo,
    Colors.teal,
    Colors.orange,
    Colors.deepPurple,
  ];

  final backgroundColorNames = [
    'Purple',
    'Pink',
    'Indigo',
    'Teal',
    'Orange',
    'Deep Purple',
  ];

  final textColorOptions = [
    Colors.white,
    Colors.black,
    Colors.yellow,
    Colors.lightGreen,
  ];

  final textColorNames = ['White', 'Black', 'Yellow', 'Light Green'];

  final bgColorIndex = context.knobs.object.dropdown(
    label: 'Background Color',
    options: List.generate(backgroundColorOptions.length, (i) => i),
    labelBuilder: (index) => backgroundColorNames[index],
    initialOption: 0,
  );

  final textColorIndex = context.knobs.object.dropdown(
    label: 'Text Color',
    options: List.generate(textColorOptions.length, (i) => i),
    labelBuilder: (index) => textColorNames[index],
    initialOption: 0,
  );

  return Center(
    child: AppTag(
      label: label,
      backgroundColor: useCustomColors
          ? backgroundColorOptions[bgColorIndex]
          : null,
      textColor: useCustomColors ? textColorOptions[textColorIndex] : null,
    ),
  );
}

// 7. Text Overflow - Focused on long text handling
@widgetbook.UseCase(name: 'Text Overflow', type: AppTag)
Widget appTagTextOverflow(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'This is a very long label that will truncate with ellipsis',
  );

  final constrainWidth = context.knobs.boolean(
    label: 'Constrain Width',
    initialValue: true,
  );

  final width = context.knobs.double.slider(
    label: 'Max Width',
    initialValue: 150,
    min: 50,
    max: 400,
  );

  final tag = AppTag(label: label);

  return Center(
    child: constrainWidth ? SizedBox(width: width, child: tag) : tag,
  );
}

// 8. Combined Features - Interactive playground with all features
@widgetbook.UseCase(name: 'Combined Features', type: AppTag)
Widget appTagCombinedFeatures(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Premium');

  final size = context.knobs.object.dropdown(
    label: 'Size',
    options: AppTagSize.values,
    labelBuilder: (size) => size.name,
    initialOption: AppTagSize.medium,
  );

  final style = context.knobs.object.dropdown(
    label: 'Style',
    options: AppTagStyle.values,
    labelBuilder: (style) => style.name,
    initialOption: AppTagStyle.filled,
  );

  final colorVariant = context.knobs.object.dropdown(
    label: 'Color Variant',
    options: AppTagColorVariant.values,
    labelBuilder: (variant) => variant.name,
    initialOption: AppTagColorVariant.warning,
  );

  final showIcon = context.knobs.boolean(
    label: 'Show Icon',
    initialValue: true,
  );

  final iconOptions = [
    Icons.star,
    Icons.verified,
    Icons.check_circle,
    Icons.warning,
    Icons.error,
    Icons.info,
  ];

  final iconNames = [
    'Star',
    'Verified',
    'Check Circle',
    'Warning',
    'Error',
    'Info',
  ];

  final iconIndex = context.knobs.object.dropdown(
    label: 'Icon',
    options: List.generate(iconOptions.length, (i) => i),
    labelBuilder: (index) => iconNames[index],
    initialOption: 0,
  );

  final semanticLabel = context.knobs.stringOrNull(
    label: 'Semantic Label (optional)',
    initialValue: null,
  );

  return Center(
    child: AppTag(
      label: label,
      size: size,
      style: style,
      colorVariant: colorVariant,
      icon: showIcon ? iconOptions[iconIndex] : null,
      semanticLabel: semanticLabel,
    ),
  );
}
