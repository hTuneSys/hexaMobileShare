// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppSearchField] component.

@widgetbook.UseCase(name: 'Interactive Playground', type: AppSearchField)
Widget appSearchFieldPlayground(BuildContext context) {
  final hasLoading = context.knobs.boolean(
    label: 'Is Loading',
    initialValue: false,
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final autofocus = context.knobs.boolean(
    label: 'Autofocus',
    initialValue: false,
  );
  final clearOnSubmit = context.knobs.boolean(
    label: 'Clear On Submit',
    initialValue: false,
  );
  final hint = context.knobs.string(label: 'Hint', initialValue: 'Search...');

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSearchField(
        hint: hint,
        isLoading: hasLoading,
        enabled: enabled,
        autofocus: autofocus,
        clearOnSubmit: clearOnSubmit,
        onSearchChanged: (_) {},
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Default', type: AppSearchField)
Widget appSearchFieldDefault(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppSearchField(hint: 'Search...'),
    ),
  );
}

@widgetbook.UseCase(name: 'With Loading', type: AppSearchField)
Widget appSearchFieldWithLoading(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppSearchField(hint: 'Searching...', isLoading: true),
    ),
  );
}

@widgetbook.UseCase(name: 'Disabled', type: AppSearchField)
Widget appSearchFieldDisabled(BuildContext context) {
  final controller = TextEditingController(text: 'Disabled search');
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSearchField(
        controller: controller,
        hint: 'Search...',
        enabled: false,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'With Autofocus', type: AppSearchField)
Widget appSearchFieldAutofocus(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppSearchField(hint: 'Start typing...', autofocus: true),
    ),
  );
}

@widgetbook.UseCase(name: 'Clear On Submit', type: AppSearchField)
Widget appSearchFieldClearOnSubmit(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppSearchField(
        hint: 'Search and press enter...',
        clearOnSubmit: true,
      ),
    ),
  );
}

@widgetbook.UseCase(name: 'Search Products', type: AppSearchField)
Widget appSearchFieldProducts(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppSearchField(hint: 'Search products...'),
    ),
  );
}

@widgetbook.UseCase(name: 'Search Users', type: AppSearchField)
Widget appSearchFieldUsers(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppSearchField(hint: 'Search users...'),
    ),
  );
}

@widgetbook.UseCase(name: 'Search Locations', type: AppSearchField)
Widget appSearchFieldLocations(BuildContext context) {
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: AppSearchField(hint: 'Search locations...'),
    ),
  );
}

@widgetbook.UseCase(name: 'With Text', type: AppSearchField)
Widget appSearchFieldWithText(BuildContext context) {
  final controller = TextEditingController(text: 'existing query');
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppSearchField(controller: controller, hint: 'Search...'),
    ),
  );
}
