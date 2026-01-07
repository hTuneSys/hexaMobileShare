// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/widgets/chips/app_tag.dart';

/// Interactive Playground - Expose ALL AppTag properties as knobs
@widgetbook.UseCase(name: 'Interactive Playground', type: AppTag)
Widget appTagPlayground(BuildContext context) {
  final label = context.knobs.string(label: 'Label', initialValue: 'Tag Label');

  final hasIcon = context.knobs.boolean(label: 'Has Icon', initialValue: false);

  final icon = hasIcon
      ? context.knobs.object.dropdown(
          label: 'Icon',
          options: const [
            Icons.star,
            Icons.verified,
            Icons.check_circle,
            Icons.info,
            Icons.warning,
            Icons.error,
          ],
          labelBuilder: (icon) => icon.toString().split('.').last,
        )
      : null;

  final colorVariant = context.knobs.object.dropdown(
    label: 'Color Variant',
    options: AppTagColorVariant.values,
    labelBuilder: (variant) => variant.name,
  );

  final size = context.knobs.object.dropdown(
    label: 'Size',
    options: AppTagSize.values,
    labelBuilder: (size) => size.name,
  );

  final style = context.knobs.object.dropdown(
    label: 'Style',
    options: AppTagStyle.values,
    labelBuilder: (style) => style.name,
  );

  final hasCustomColors = context.knobs.boolean(
    label: 'Custom Colors',
    initialValue: false,
  );

  final backgroundColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Background Color',
          initialValue: Colors.purple,
        )
      : null;

  final textColor = hasCustomColors
      ? context.knobs.colorOrNull(
          label: 'Text Color',
          initialValue: Colors.white,
        )
      : null;

  final hasSemanticLabel = context.knobs.boolean(
    label: 'Custom Semantic Label',
    initialValue: false,
  );

  final semanticLabel = hasSemanticLabel
      ? context.knobs.string(
          label: 'Semantic Label',
          initialValue: 'Custom accessibility label',
        )
      : null;

  return Center(
    child: AppTag(
      label: label,
      icon: icon,
      colorVariant: colorVariant,
      size: size,
      style: style,
      backgroundColor: backgroundColor,
      textColor: textColor,
      semanticLabel: semanticLabel,
    ),
  );
}

/// Basic Tag - Simple tag with label only
@widgetbook.UseCase(name: 'Basic Tag', type: AppTag)
Widget appTagBasic(BuildContext context) {
  return const Center(child: AppTag(label: 'Featured'));
}

/// With Icon - Tag with leading icon
@widgetbook.UseCase(name: 'With Icon', type: AppTag)
Widget appTagWithIcon(BuildContext context) {
  return const Center(
    child: AppTag(label: 'Premium', icon: Icons.star),
  );
}

/// Success Variant - Green success state
@widgetbook.UseCase(name: 'Success Variant', type: AppTag)
Widget appTagSuccess(BuildContext context) {
  return const Center(
    child: AppTag(
      label: 'Approved',
      icon: Icons.check_circle,
      colorVariant: AppTagColorVariant.success,
    ),
  );
}

/// Warning Variant - Orange warning state
@widgetbook.UseCase(name: 'Warning Variant', type: AppTag)
Widget appTagWarning(BuildContext context) {
  return const Center(
    child: AppTag(
      label: 'Pending',
      icon: Icons.warning_amber,
      colorVariant: AppTagColorVariant.warning,
    ),
  );
}

/// Error Variant - Red error state
@widgetbook.UseCase(name: 'Error Variant', type: AppTag)
Widget appTagError(BuildContext context) {
  return const Center(
    child: AppTag(
      label: 'Failed',
      icon: Icons.error,
      colorVariant: AppTagColorVariant.error,
    ),
  );
}

/// Info Variant - Blue info state
@widgetbook.UseCase(name: 'Info Variant', type: AppTag)
Widget appTagInfo(BuildContext context) {
  return const Center(
    child: AppTag(
      label: 'Information',
      icon: Icons.info,
      colorVariant: AppTagColorVariant.info,
    ),
  );
}

/// Small Size - Compact tag for dense layouts
@widgetbook.UseCase(name: 'Small Size', type: AppTag)
Widget appTagSmall(BuildContext context) {
  return const Center(
    child: AppTag(label: 'Small', size: AppTagSize.small),
  );
}

/// Large Size - Prominent tag for emphasis
@widgetbook.UseCase(name: 'Large Size', type: AppTag)
Widget appTagLarge(BuildContext context) {
  return const Center(
    child: AppTag(label: 'Large', icon: Icons.star, size: AppTagSize.large),
  );
}

/// Outlined Style - Border style with transparent background
@widgetbook.UseCase(name: 'Outlined Style', type: AppTag)
Widget appTagOutlined(BuildContext context) {
  return const Center(
    child: AppTag(
      label: 'Outlined',
      style: AppTagStyle.outlined,
      colorVariant: AppTagColorVariant.info,
    ),
  );
}

/// Custom Colors - Tag with custom background and text colors
@widgetbook.UseCase(name: 'Custom Colors', type: AppTag)
Widget appTagCustomColors(BuildContext context) {
  return const Center(
    child: AppTag(
      label: 'Custom',
      icon: Icons.palette,
      backgroundColor: Colors.purple,
      textColor: Colors.white,
    ),
  );
}
