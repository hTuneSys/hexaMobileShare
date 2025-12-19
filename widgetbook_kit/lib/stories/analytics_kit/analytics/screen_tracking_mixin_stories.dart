// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:analytics_kit/analytics/screen_tracking_mixin.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Widgetbook stories for [ScreenTrackingMixin].
///
/// Demonstrates various usage patterns of the ScreenTrackingMixin
/// for automatic screen view tracking.

// ============================================================================
// Basic Usage Example
// ============================================================================

/// A simple screen demonstrating basic [ScreenTrackingMixin] usage.
///
/// Screen name is automatically detected from the widget type.
class BasicTrackingScreen extends StatefulWidget {
  const BasicTrackingScreen({super.key});

  @override
  State<BasicTrackingScreen> createState() => _BasicTrackingScreenState();
}

class _BasicTrackingScreenState extends State<BasicTrackingScreen>
    with ScreenTrackingMixin {
  @override
  bool get enableDebugLogging => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Screen Tracking'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.analytics_outlined, size: 80, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'Basic Screen Tracking',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'This screen uses ScreenTrackingMixin for automatic tracking. '
                'Check the console for tracking logs.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Screen name: ${runtimeType.toString()}',
              style: TextStyle(
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Custom Screen Name Example
// ============================================================================

/// A screen demonstrating custom screen name override.
class CustomNameScreen extends StatefulWidget {
  const CustomNameScreen({super.key});

  @override
  State<CustomNameScreen> createState() => _CustomNameScreenState();
}

class _CustomNameScreenState extends State<CustomNameScreen>
    with ScreenTrackingMixin {
  @override
  String get screenName => 'custom_home_screen';

  @override
  bool get enableDebugLogging => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Screen Name'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.edit_note, size: 80, color: Colors.orange),
            const SizedBox(height: 24),
            const Text(
              'Custom Screen Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'This screen overrides the screenName getter to provide '
                'a custom name for analytics tracking.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Text(
                'Screen name: $screenName',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Screen Parameters Example
// ============================================================================

/// A screen demonstrating screen parameters tracking.
class ParametersTrackingScreen extends StatefulWidget {
  const ParametersTrackingScreen({
    super.key,
    required this.userId,
    this.category = 'general',
  });

  final String userId;
  final String category;

  @override
  State<ParametersTrackingScreen> createState() =>
      _ParametersTrackingScreenState();
}

class _ParametersTrackingScreenState extends State<ParametersTrackingScreen>
    with ScreenTrackingMixin {
  String _selectedFilter = 'all';

  @override
  String get screenName => 'product_list';

  @override
  Map<String, dynamic> get screenParameters => {
    'user_id': widget.userId,
    'category': widget.category,
    'filter': _selectedFilter,
    'timestamp': DateTime.now().toIso8601String(),
  };

  @override
  bool get enableDebugLogging => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parameters Tracking'),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        foregroundColor: Theme.of(context).colorScheme.onTertiary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.tune, size: 80, color: Colors.purple),
            const SizedBox(height: 24),
            const Text(
              'Screen Parameters Tracking',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'This screen tracks additional parameters like user ID, '
                'category, and filter settings.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Parameters:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('• User ID: ${widget.userId}'),
                  Text('• Category: ${widget.category}'),
                  Text('• Filter: $_selectedFilter'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'all', label: Text('All')),
                ButtonSegment(value: 'new', label: Text('New')),
                ButtonSegment(value: 'popular', label: Text('Popular')),
              ],
              selected: {_selectedFilter},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  _selectedFilter = newSelection.first;
                });
                // Re-track with updated parameters
                trackScreenView();
              },
            ),
            const SizedBox(height: 8),
            Text(
              'Change filter to update tracked parameters',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Multiple Screens Navigation Example
// ============================================================================

/// A navigation demo showing multiple screens with tracking.
class NavigationDemoScreen extends StatefulWidget {
  const NavigationDemoScreen({super.key});

  @override
  State<NavigationDemoScreen> createState() => _NavigationDemoScreenState();
}

class _NavigationDemoScreenState extends State<NavigationDemoScreen>
    with ScreenTrackingMixin {
  int _visitCount = 0;

  @override
  String get screenName => 'navigation_demo';

  @override
  Map<String, dynamic> get screenParameters => {'visit_count': _visitCount};

  @override
  bool get enableDebugLogging => true;

  @override
  void initState() {
    super.initState();
    _visitCount++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Demo'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.navigation, size: 80, color: Colors.blue),
            const SizedBox(height: 24),
            const Text(
              'Navigation Demo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Navigate between screens to see automatic tracking in action. '
                'Check the console for screen view and exit events.',
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const BasicTrackingScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.analytics),
                  label: const Text('Basic Tracking'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const CustomNameScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_note),
                  label: const Text('Custom Name'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const ParametersTrackingScreen(
                          userId: 'user_123',
                          category: 'electronics',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.tune),
                  label: const Text('With Parameters'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Visit count: $_visitCount',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Widgetbook Use Cases
// ============================================================================

@widgetbook.UseCase(name: 'Basic Usage', type: BasicTrackingScreen)
Widget basicUsageUseCase(BuildContext context) {
  return const BasicTrackingScreen();
}

@widgetbook.UseCase(name: 'Custom Screen Name', type: CustomNameScreen)
Widget customNameUseCase(BuildContext context) {
  return const CustomNameScreen();
}

@widgetbook.UseCase(name: 'With Parameters', type: ParametersTrackingScreen)
Widget parametersUseCase(BuildContext context) {
  return const ParametersTrackingScreen(
    userId: 'demo_user_456',
    category: 'technology',
  );
}

@widgetbook.UseCase(name: 'Navigation Demo', type: NavigationDemoScreen)
Widget navigationDemoUseCase(BuildContext context) {
  return const NavigationDemoScreen();
}
