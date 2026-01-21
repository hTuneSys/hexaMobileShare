// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('Gap', () {
    group('Basic Rendering', () {
      testWidgets('renders correctly with custom size', (tester) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Gap(20),
          ),
        );

        expect(find.byType(Gap), findsOneWidget);
        expect(find.byType(SizedBox), findsOneWidget);

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(20.0));
        expect(sizedBox.height, equals(20.0));
      });

      testWidgets('creates SizedBox with correct dimensions', (tester) async {
        const testSize = 50.0;

        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Gap(testSize),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(testSize));
        expect(sizedBox.height, equals(testSize));
      });
    });

    group('Named Constructors', () {
      testWidgets('Gap.xs creates correct size (AppSpacing.xs)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Gap.xs(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.xs));
        expect(sizedBox.height, equals(AppSpacing.xs));
      });

      testWidgets('Gap.sm creates correct size (AppSpacing.sm)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Gap.sm(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.sm));
        expect(sizedBox.height, equals(AppSpacing.sm));
      });

      testWidgets('Gap.md creates correct size (AppSpacing.md)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Gap.md(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.md));
        expect(sizedBox.height, equals(AppSpacing.md));
      });

      testWidgets('Gap.lg creates correct size (AppSpacing.lg)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Gap.lg(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.lg));
        expect(sizedBox.height, equals(AppSpacing.lg));
      });

      testWidgets('Gap.xl creates correct size (AppSpacing.xl)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Gap.xl(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.xl));
        expect(sizedBox.height, equals(AppSpacing.xl));
      });

      testWidgets('Gap.xxl creates correct size (AppSpacing.xxl)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Gap.xxl(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.xxl));
        expect(sizedBox.height, equals(AppSpacing.xxl));
      });
    });

    group('Integration with Layouts', () {
      testWidgets('works correctly in Column', (tester) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Column(children: [Text('First'), Gap.md(), Text('Second')]),
          ),
        );

        expect(find.byType(Gap), findsOneWidget);
        expect(find.text('First'), findsOneWidget);
        expect(find.text('Second'), findsOneWidget);
      });

      testWidgets('works correctly in Row', (tester) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Row(children: [Text('Left'), Gap.md(), Text('Right')]),
          ),
        );

        expect(find.byType(Gap), findsOneWidget);
        expect(find.text('Left'), findsOneWidget);
        expect(find.text('Right'), findsOneWidget);
      });
    });
  });

  group('HGap', () {
    group('Basic Rendering', () {
      testWidgets('renders correctly with custom width', (tester) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: HGap(30),
          ),
        );

        expect(find.byType(HGap), findsOneWidget);
        expect(find.byType(SizedBox), findsOneWidget);

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(30.0));
        expect(sizedBox.height, isNull);
      });

      testWidgets('creates SizedBox with width only', (tester) async {
        const testWidth = 40.0;

        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: HGap(testWidth),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(testWidth));
        expect(sizedBox.height, isNull);
      });
    });

    group('Named Constructors', () {
      testWidgets('HGap.xs creates correct width (AppSpacing.xs)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: HGap.xs(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.xs));
      });

      testWidgets('HGap.sm creates correct width (AppSpacing.sm)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: HGap.sm(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.sm));
      });

      testWidgets('HGap.md creates correct width (AppSpacing.md)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: HGap.md(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.md));
      });

      testWidgets('HGap.lg creates correct width (AppSpacing.lg)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: HGap.lg(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.lg));
      });

      testWidgets('HGap.xl creates correct width (AppSpacing.xl)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: HGap.xl(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.width, equals(AppSpacing.xl));
      });
    });

    group('Integration with Row', () {
      testWidgets('works correctly in Row layout', (tester) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Row(children: [Text('Left'), HGap.md(), Text('Right')]),
          ),
        );

        expect(find.byType(HGap), findsOneWidget);
        expect(find.text('Left'), findsOneWidget);
        expect(find.text('Right'), findsOneWidget);
      });
    });
  });

  group('VGap', () {
    group('Basic Rendering', () {
      testWidgets('renders correctly with custom height', (tester) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: VGap(25),
          ),
        );

        expect(find.byType(VGap), findsOneWidget);
        expect(find.byType(SizedBox), findsOneWidget);

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, equals(25.0));
        expect(sizedBox.width, isNull);
      });

      testWidgets('creates SizedBox with height only', (tester) async {
        const testHeight = 35.0;

        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: VGap(testHeight),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, equals(testHeight));
        expect(sizedBox.width, isNull);
      });
    });

    group('Named Constructors', () {
      testWidgets('VGap.xs creates correct height (AppSpacing.xs)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: VGap.xs(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, equals(AppSpacing.xs));
      });

      testWidgets('VGap.sm creates correct height (AppSpacing.sm)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: VGap.sm(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, equals(AppSpacing.sm));
      });

      testWidgets('VGap.md creates correct height (AppSpacing.md)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: VGap.md(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, equals(AppSpacing.md));
      });

      testWidgets('VGap.lg creates correct height (AppSpacing.lg)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: VGap.lg(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, equals(AppSpacing.lg));
      });

      testWidgets('VGap.xl creates correct height (AppSpacing.xl)', (
        tester,
      ) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: VGap.xl(),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
        expect(sizedBox.height, equals(AppSpacing.xl));
      });
    });

    group('Integration with Column', () {
      testWidgets('works correctly in Column layout', (tester) async {
        await tester.pumpWidget(
          const Directionality(
            textDirection: TextDirection.ltr,
            child: Column(children: [Text('Top'), VGap.lg(), Text('Bottom')]),
          ),
        );

        expect(find.byType(VGap), findsOneWidget);
        expect(find.text('Top'), findsOneWidget);
        expect(find.text('Bottom'), findsOneWidget);
      });
    });
  });

  group('AppSpacing Integration', () {
    test('AppSpacing values match Gap named constructors', () {
      expect(const Gap.xs().size, equals(AppSpacing.xs));
      expect(const Gap.sm().size, equals(AppSpacing.sm));
      expect(const Gap.md().size, equals(AppSpacing.md));
      expect(const Gap.lg().size, equals(AppSpacing.lg));
      expect(const Gap.xl().size, equals(AppSpacing.xl));
      expect(const Gap.xxl().size, equals(AppSpacing.xxl));
    });

    test('AppSpacing values match HGap named constructors', () {
      expect(const HGap.xs().width, equals(AppSpacing.xs));
      expect(const HGap.sm().width, equals(AppSpacing.sm));
      expect(const HGap.md().width, equals(AppSpacing.md));
      expect(const HGap.lg().width, equals(AppSpacing.lg));
      expect(const HGap.xl().width, equals(AppSpacing.xl));
    });

    test('AppSpacing values match VGap named constructors', () {
      expect(const VGap.xs().height, equals(AppSpacing.xs));
      expect(const VGap.sm().height, equals(AppSpacing.sm));
      expect(const VGap.md().height, equals(AppSpacing.md));
      expect(const VGap.lg().height, equals(AppSpacing.lg));
      expect(const VGap.xl().height, equals(AppSpacing.xl));
    });
  });
}
