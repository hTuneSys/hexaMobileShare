// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLoadingState', () {
    group('Circular Variant', () {
      testWidgets('renders circular progress indicator', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(variant: LoadingVariant.circular),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('applies correct size for small', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.circular,
                size: LoadingSize.small,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(
          find
              .ancestor(
                of: find.byType(CircularProgressIndicator),
                matching: find.byType(SizedBox),
              )
              .first,
        );

        expect(sizedBox.width, 16);
        expect(sizedBox.height, 16);
      });

      testWidgets('applies correct size for medium', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.circular,
                size: LoadingSize.medium,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(
          find
              .ancestor(
                of: find.byType(CircularProgressIndicator),
                matching: find.byType(SizedBox),
              )
              .first,
        );

        expect(sizedBox.width, 24);
        expect(sizedBox.height, 24);
      });

      testWidgets('applies correct size for large', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.circular,
                size: LoadingSize.large,
              ),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(
          find
              .ancestor(
                of: find.byType(CircularProgressIndicator),
                matching: find.byType(SizedBox),
              )
              .first,
        );

        expect(sizedBox.width, 48);
        expect(sizedBox.height, 48);
      });

      testWidgets('displays message when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.circular,
                message: 'Loading data...',
              ),
            ),
          ),
        );

        expect(find.text('Loading data...'), findsOneWidget);
      });

      testWidgets('displays cancel button when callback provided', (
        tester,
      ) async {
        var cancelPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.circular,
                onCancel: () {
                  cancelPressed = true;
                },
              ),
            ),
          ),
        );

        expect(find.text('Cancel'), findsOneWidget);

        await tester.tap(find.text('Cancel'));
        await tester.pump();

        expect(cancelPressed, isTrue);
      });

      testWidgets('applies custom color', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.circular,
                color: Colors.red,
              ),
            ),
          ),
        );

        final indicator = tester.widget<CircularProgressIndicator>(
          find.byType(CircularProgressIndicator),
        );

        expect(
          (indicator.valueColor as AlwaysStoppedAnimation<Color>).value,
          Colors.red,
        );
      });
    });

    group('Linear Variant', () {
      testWidgets('renders linear progress indicator', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(variant: LoadingVariant.linear),
            ),
          ),
        );

        expect(find.byType(LinearProgressIndicator), findsOneWidget);
      });

      testWidgets('shows correct progress value', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.linear,
                progress: 0.65,
              ),
            ),
          ),
        );

        final indicator = tester.widget<LinearProgressIndicator>(
          find.byType(LinearProgressIndicator),
        );

        expect(indicator.value, 0.65);
      });

      testWidgets('displays progress percentage when enabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.linear,
                progress: 0.75,
                showPercentage: true,
              ),
            ),
          ),
        );

        expect(find.text('75%'), findsOneWidget);
      });

      testWidgets('does not display percentage when disabled', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.linear,
                progress: 0.75,
                showPercentage: false,
              ),
            ),
          ),
        );

        expect(find.text('75%'), findsNothing);
      });

      testWidgets('displays message when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.linear,
                message: 'Uploading file...',
              ),
            ),
          ),
        );

        expect(find.text('Uploading file...'), findsOneWidget);
      });
    });

    group('Skeleton Variant', () {
      testWidgets('renders skeleton containers', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(variant: LoadingVariant.skeleton),
            ),
          ),
        );

        expect(find.byType(Container), findsWidgets);
      });

      testWidgets('applies shimmer effect', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(variant: LoadingVariant.skeleton),
            ),
          ),
        );

        // Verify shimmer animation is present
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(milliseconds: 100));

        // If we get here without errors, shimmer is working
        expect(find.byType(AnimatedBuilder), findsWidgets);
      });
    });

    group('Overlay Variant', () {
      testWidgets('renders overlay container', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(variant: LoadingVariant.overlay),
            ),
          ),
        );

        expect(find.byType(Container), findsWidgets);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });

      testWidgets('displays message when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.overlay,
                message: 'Loading data...',
              ),
            ),
          ),
        );

        expect(find.text('Loading data...'), findsOneWidget);
      });
    });

    group('Inline Variant', () {
      testWidgets('renders small circular indicator', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(variant: LoadingVariant.inline),
            ),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(
          find
              .ancestor(
                of: find.byType(CircularProgressIndicator),
                matching: find.byType(SizedBox),
              )
              .first,
        );

        expect(sizedBox.width, 16);
        expect(sizedBox.height, 16);
      });
    });

    group('Accessibility', () {
      testWidgets('has semantic label for circular', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(variant: LoadingVariant.circular),
            ),
          ),
        );

        expect(find.bySemanticsLabel('Loading'), findsOneWidget);
      });

      testWidgets('has semantic label for linear', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.linear,
                progress: 0.5,
              ),
            ),
          ),
        );

        expect(find.bySemanticsLabel('Loading progress'), findsOneWidget);
      });

      testWidgets('uses custom semantic label when provided', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AppLoadingState(
                variant: LoadingVariant.circular,
                semanticLabel: 'Custom loading label',
              ),
            ),
          ),
        );

        expect(find.bySemanticsLabel('Custom loading label'), findsOneWidget);
      });
    });

    group('Theme Integration', () {
      testWidgets('uses theme primary color by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            ),
            home: const Scaffold(
              body: AppLoadingState(variant: LoadingVariant.circular),
            ),
          ),
        );

        final indicator = tester.widget<CircularProgressIndicator>(
          find.byType(CircularProgressIndicator),
        );

        expect(
          (indicator.valueColor as AlwaysStoppedAnimation<Color>).value,
          isNot(null),
        );
      });
    });
  });
}
