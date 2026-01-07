// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:core_kit/core_kit.dart';

/// Widgetbook stories for [AppCard] component.
///
/// Material Design 3 card widget with consistent styling supporting
/// various styles including flat, elevated, and outlined variants.

// ============================================================================
// Interactive Playground - MUST BE FIRST
// ============================================================================

@widgetbook.UseCase(name: 'Interactive Playground', type: AppCard)
Widget appCardPlayground(BuildContext context) {
  final elevation = context.knobs.double.slider(
    label: 'Elevation',
    initialValue: 1.0,
    min: 0,
    max: 8,
  );
  final padding = context.knobs.double.slider(
    label: 'Padding',
    initialValue: 16.0,
    min: 0,
    max: 32,
  );
  final isInteractive = context.knobs.boolean(
    label: 'Interactive (onTap)',
    initialValue: false,
  );
  final hasMargin = context.knobs.boolean(
    label: 'Has Margin',
    initialValue: true,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard(
        elevation: elevation,
        padding: EdgeInsets.all(padding),
        margin: hasMargin ? const EdgeInsets.all(16.0) : null,
        onTap: isInteractive ? () => debugPrint('Card tapped') : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Card Title', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'This is the card content. Cards are surfaces that display content and actions on a single topic.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 2: Basic Card
// ============================================================================

@widgetbook.UseCase(name: 'Basic', type: AppCard)
Widget basicCard(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Basic Card', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'A simple card with default elevation (1dp).',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 3: Flat Card
// ============================================================================

@widgetbook.UseCase(name: 'Flat', type: AppCard)
Widget flatCard(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard.flat(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flat Card', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(
              'No elevation (0dp), useful for grouping content.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 4: Elevated Card
// ============================================================================

@widgetbook.UseCase(name: 'Elevated', type: AppCard)
Widget elevatedCard(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard.elevated(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Elevated Card',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Higher elevation (3dp) for more emphasis.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 5: Outlined Card
// ============================================================================

@widgetbook.UseCase(name: 'Outlined', type: AppCard)
Widget outlinedCard(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard.outlined(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Outlined Card',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Border with no elevation for clear separation.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 6: Interactive Card
// ============================================================================

@widgetbook.UseCase(name: 'Interactive', type: AppCard)
Widget interactiveCard(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard(
        padding: const EdgeInsets.all(16.0),
        onTap: () => debugPrint('Card tapped'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.touch_app),
                const SizedBox(width: 8),
                Text(
                  'Interactive Card',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Tap this card to trigger an action.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 7: Card with Image
// ============================================================================

@widgetbook.UseCase(name: 'With Image', type: AppCard)
Widget cardWithImage(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 160,
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 64,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card with Image',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cards can contain images, text, and actions.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 8: Card with Actions
// ============================================================================

@widgetbook.UseCase(name: 'With Actions', type: AppCard)
Widget cardWithActions(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Card with Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'This card includes action buttons.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => debugPrint('Cancel'),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () => debugPrint('Confirm'),
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 9: Custom Color Card
// ============================================================================

@widgetbook.UseCase(name: 'Custom Color', type: AppCard)
Widget customColorCard(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard(
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Custom Color Card',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cards can use custom background colors.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// Variant 10: Compact Card
// ============================================================================

@widgetbook.UseCase(name: 'Compact', type: AppCard)
Widget compactCard(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: AppCard(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text(
              'Compact information card',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    ),
  );
}
