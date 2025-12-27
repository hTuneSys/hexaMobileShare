// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  group('AppAppBar', () {
    group('Standard Variant', () {
      testWidgets('renders with string title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(appBar: AppAppBar(title: 'Test Title')),
          ),
        );

        expect(find.text('Test Title'), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
      });

      testWidgets('renders with widget title', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppAppBar(
                title: Row(
                  children: const [
                    Icon(Icons.home),
                    SizedBox(width: 8),
                    Text('Home'),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.home), findsOneWidget);
        expect(find.text('Home'), findsOneWidget);
      });

      testWidgets('displays leading widget when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppAppBar(
                title: 'Test',
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.menu), findsOneWidget);
      });

      testWidgets('displays action icons', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppAppBar(
                title: 'Test',
                actions: [
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.more_vert), findsOneWidget);
      });

      testWidgets('supports up to 4 action items', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppAppBar(
                title: 'Test',
                actions: [
                  IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {},
                  ),
                  IconButton(icon: const Icon(Icons.share), onPressed: () {}),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byIcon(Icons.share), findsOneWidget);
        expect(find.byIcon(Icons.more_vert), findsOneWidget);
      });

      testWidgets('applies custom background color', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              appBar: AppAppBar(title: 'Test', backgroundColor: Colors.blue),
            ),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.backgroundColor, Colors.blue);
      });

      testWidgets('applies custom foreground color', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              appBar: AppAppBar(title: 'Test', foregroundColor: Colors.white),
            ),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.foregroundColor, Colors.white);
      });

      testWidgets('centers title when centerTitle is true', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(appBar: AppAppBar(title: 'Test', centerTitle: true)),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.centerTitle, true);
      });

      testWidgets('applies custom elevation', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(appBar: AppAppBar(title: 'Test', elevation: 4.0)),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.elevation, 4.0);
      });

      testWidgets('applies default elevation of 0', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(appBar: AppAppBar(title: 'Test')),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.elevation, 0.0);
      });

      testWidgets('applies scrolledUnderElevation', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              appBar: AppAppBar(title: 'Test', scrolledUnderElevation: 3.0),
            ),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.scrolledUnderElevation, 3.0);
      });

      testWidgets('displays TabBar in bottom when provided', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppAppBar(
                  title: 'Test',
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Tab 1'),
                      Tab(text: 'Tab 2'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );

        expect(find.text('Tab 1'), findsOneWidget);
        expect(find.text('Tab 2'), findsOneWidget);
        expect(find.byType(TabBar), findsOneWidget);
      });

      testWidgets('action callbacks trigger correctly', (tester) async {
        var searchPressed = false;
        var morePressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppAppBar(
                title: 'Test',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => searchPressed = true,
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => morePressed = true,
                  ),
                ],
              ),
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.search));
        await tester.tap(find.byIcon(Icons.more_vert));
        await tester.pump();

        expect(searchPressed, isTrue);
        expect(morePressed, isTrue);
      });
    });

    group('Large Variant', () {
      testWidgets('renders as SliverAppBar', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [const AppAppBar.large(title: 'Large Title')],
              ),
            ),
          ),
        );

        expect(find.byType(SliverAppBar), findsOneWidget);
      });

      testWidgets('displays large title', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [const AppAppBar.large(title: 'Large Title')],
              ),
            ),
          ),
        );

        expect(find.text('Large Title'), findsWidgets);
      });

      testWidgets('has default expanded height of 128', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [const AppAppBar.large(title: 'Test')],
              ),
            ),
          ),
        );

        final appBar = tester.widget<SliverAppBar>(find.byType(SliverAppBar));
        expect(appBar.expandedHeight, 128.0);
      });

      testWidgets('supports custom expanded height', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  const AppAppBar.large(title: 'Test', expandedHeight: 200.0),
                ],
              ),
            ),
          ),
        );

        final appBar = tester.widget<SliverAppBar>(find.byType(SliverAppBar));
        expect(appBar.expandedHeight, 200.0);
      });

      testWidgets('is pinned by default', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [const AppAppBar.large(title: 'Test')],
              ),
            ),
          ),
        );

        final appBar = tester.widget<SliverAppBar>(find.byType(SliverAppBar));
        expect(appBar.pinned, true);
      });

      testWidgets('supports floating behavior', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [const AppAppBar.large(title: 'Test', floating: true)],
              ),
            ),
          ),
        );

        final appBar = tester.widget<SliverAppBar>(find.byType(SliverAppBar));
        expect(appBar.floating, true);
      });

      testWidgets('supports snap behavior', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  const AppAppBar.large(
                    title: 'Test',
                    floating: true,
                    snap: true,
                  ),
                ],
              ),
            ),
          ),
        );

        final appBar = tester.widget<SliverAppBar>(find.byType(SliverAppBar));
        expect(appBar.snap, true);
      });

      testWidgets('displays actions in large variant', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  const AppAppBar.large(
                    title: 'Test',
                    actions: [Icon(Icons.search), Icon(Icons.more_vert)],
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.more_vert), findsOneWidget);
      });
    });

    group('PreferredSize', () {
      testWidgets('has correct preferred size for standard variant', (
        tester,
      ) async {
        const appBar = AppAppBar(title: 'Test');
        expect(appBar.preferredSize.height, kToolbarHeight);
      });

      testWidgets('has correct preferred size with bottom', (tester) async {
        const appBar = AppAppBar(
          title: 'Test',
          bottom: TabBar(
            tabs: [
              Tab(text: 'Tab 1'),
              Tab(text: 'Tab 2'),
            ],
          ),
        );
        expect(appBar.preferredSize.height, kToolbarHeight + kTextTabBarHeight);
      });

      testWidgets('has correct preferred size for large variant', (
        tester,
      ) async {
        const appBar = AppAppBar.large(title: 'Test');
        expect(appBar.preferredSize.height, 128.0);
      });

      testWidgets(
        'has correct preferred size for large variant with custom height',
        (tester) async {
          const appBar = AppAppBar.large(title: 'Test', expandedHeight: 200.0);
          expect(appBar.preferredSize.height, 200.0);
        },
      );
    });

    group('Accessibility', () {
      testWidgets('has semantic label for title', (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(appBar: AppAppBar(title: 'Accessible Title')),
          ),
        );

        expect(find.text('Accessible Title'), findsOneWidget);
      });

      testWidgets('action buttons have semantic labels', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              appBar: AppAppBar(
                title: 'Test',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                    tooltip: 'Search',
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.byTooltip('Search'), findsOneWidget);
      });
    });

    group('Theme Integration', () {
      testWidgets('uses theme colors when not specified', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
            ),
            home: const Scaffold(appBar: AppAppBar(title: 'Test')),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.backgroundColor, isNotNull);
        expect(appBar.foregroundColor, isNotNull);
      });
    });
  });
}
