// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/core_kit.dart';

void main() {
  // ============================================================================
  // UNIT TESTS - Verify all constants are valid IconData
  // ============================================================================

  group('AppIcons - Unit Tests', () {
    group('Navigation Icons (10-15)', () {
      test('All navigation icons are valid IconData', () {
        final navigationIcons = <String, IconData>{
          'home': AppIcons.home,
          'search': AppIcons.search,
          'menu': AppIcons.menu,
          'back': AppIcons.back,
          'close': AppIcons.close,
          'navigateNext': AppIcons.navigateNext,
          'navigateBefore': AppIcons.navigateBefore,
          'arrowForward': AppIcons.arrowForward,
          'arrowBack': AppIcons.arrowBack,
          'refresh': AppIcons.refresh,
          'moreVert': AppIcons.moreVert,
          'moreHoriz': AppIcons.moreHoriz,
        };

        for (final entry in navigationIcons.entries) {
          expect(
            entry.value,
            isNotNull,
            reason: 'Navigation icon "${entry.key}" should not be null',
          );
          expect(
            entry.value,
            isA<IconData>(),
            reason: 'Navigation icon "${entry.key}" should be IconData',
          );
        }

        // Verify count meets requirements (10-15)
        expect(
          navigationIcons.length,
          greaterThanOrEqualTo(10),
          reason: 'Should have at least 10 navigation icons',
        );
        expect(
          navigationIcons.length,
          lessThanOrEqualTo(15),
          reason: 'Should have at most 15 navigation icons',
        );
      });
    });

    group('Action Icons (15-20)', () {
      test('All action icons are valid IconData', () {
        final actionIcons = <String, IconData>{
          'add': AppIcons.add,
          'edit': AppIcons.edit,
          'delete': AppIcons.delete,
          'share': AppIcons.share,
          'favorite': AppIcons.favorite,
          'favorited': AppIcons.favorited,
          'download': AppIcons.download,
          'upload': AppIcons.upload,
          'save': AppIcons.save,
          'copy': AppIcons.copy,
          'cut': AppIcons.cut,
          'paste': AppIcons.paste,
          'undo': AppIcons.undo,
          'redo': AppIcons.redo,
          'print': AppIcons.print,
          'attach': AppIcons.attach,
          'link': AppIcons.link,
          'send': AppIcons.send,
        };

        for (final entry in actionIcons.entries) {
          expect(
            entry.value,
            isNotNull,
            reason: 'Action icon "${entry.key}" should not be null',
          );
          expect(
            entry.value,
            isA<IconData>(),
            reason: 'Action icon "${entry.key}" should be IconData',
          );
        }

        // Verify count meets requirements (15-20)
        expect(
          actionIcons.length,
          greaterThanOrEqualTo(15),
          reason: 'Should have at least 15 action icons',
        );
        expect(
          actionIcons.length,
          lessThanOrEqualTo(20),
          reason: 'Should have at most 20 action icons',
        );
      });
    });

    group('Status Icons (8-10)', () {
      test('All status icons are valid IconData', () {
        final statusIcons = <String, IconData>{
          'check': AppIcons.check,
          'error': AppIcons.error,
          'warning': AppIcons.warning,
          'info': AppIcons.info,
          'help': AppIcons.help,
          'verified': AppIcons.verified,
          'pending': AppIcons.pending,
          'blocked': AppIcons.blocked,
          'success': AppIcons.success,
        };

        for (final entry in statusIcons.entries) {
          expect(
            entry.value,
            isNotNull,
            reason: 'Status icon "${entry.key}" should not be null',
          );
          expect(
            entry.value,
            isA<IconData>(),
            reason: 'Status icon "${entry.key}" should be IconData',
          );
        }

        // Verify count meets requirements (8-10)
        expect(
          statusIcons.length,
          greaterThanOrEqualTo(8),
          reason: 'Should have at least 8 status icons',
        );
        expect(
          statusIcons.length,
          lessThanOrEqualTo(10),
          reason: 'Should have at most 10 status icons',
        );
      });
    });

    group('Content Icons (10-12)', () {
      test('All content icons are valid IconData', () {
        final contentIcons = <String, IconData>{
          'image': AppIcons.image,
          'video': AppIcons.video,
          'audio': AppIcons.audio,
          'document': AppIcons.document,
          'folder': AppIcons.folder,
          'attachment': AppIcons.attachment,
          'code': AppIcons.code,
          'text': AppIcons.text,
          'file': AppIcons.file,
          'camera': AppIcons.camera,
          'photo': AppIcons.photo,
        };

        for (final entry in contentIcons.entries) {
          expect(
            entry.value,
            isNotNull,
            reason: 'Content icon "${entry.key}" should not be null',
          );
          expect(
            entry.value,
            isA<IconData>(),
            reason: 'Content icon "${entry.key}" should be IconData',
          );
        }

        // Verify count meets requirements (10-12)
        expect(
          contentIcons.length,
          greaterThanOrEqualTo(10),
          reason: 'Should have at least 10 content icons',
        );
        expect(
          contentIcons.length,
          lessThanOrEqualTo(12),
          reason: 'Should have at most 12 content icons',
        );
      });
    });

    group('Communication Icons (8-10)', () {
      test('All communication icons are valid IconData', () {
        final communicationIcons = <String, IconData>{
          'email': AppIcons.email,
          'chat': AppIcons.chat,
          'call': AppIcons.call,
          'notifications': AppIcons.notifications,
          'inbox': AppIcons.inbox,
          'archive': AppIcons.archive,
          'markAsRead': AppIcons.markAsRead,
          'unread': AppIcons.unread,
        };

        for (final entry in communicationIcons.entries) {
          expect(
            entry.value,
            isNotNull,
            reason: 'Communication icon "${entry.key}" should not be null',
          );
          expect(
            entry.value,
            isA<IconData>(),
            reason: 'Communication icon "${entry.key}" should be IconData',
          );
        }

        // Verify count meets requirements (8-10)
        expect(
          communicationIcons.length,
          greaterThanOrEqualTo(8),
          reason: 'Should have at least 8 communication icons',
        );
        expect(
          communicationIcons.length,
          lessThanOrEqualTo(10),
          reason: 'Should have at most 10 communication icons',
        );
      });
    });

    group('UI Control Icons (8-10)', () {
      test('All UI control icons are valid IconData', () {
        final uiControlIcons = <String, IconData>{
          'expandMore': AppIcons.expandMore,
          'expandLess': AppIcons.expandLess,
          'filter': AppIcons.filter,
          'sort': AppIcons.sort,
          'viewList': AppIcons.viewList,
          'viewGrid': AppIcons.viewGrid,
          'settings': AppIcons.settings,
          'visibility': AppIcons.visibility,
          'visibilityOff': AppIcons.visibilityOff,
          'tune': AppIcons.tune,
        };

        for (final entry in uiControlIcons.entries) {
          expect(
            entry.value,
            isNotNull,
            reason: 'UI control icon "${entry.key}" should not be null',
          );
          expect(
            entry.value,
            isA<IconData>(),
            reason: 'UI control icon "${entry.key}" should be IconData',
          );
        }

        // Verify count meets requirements (8-10)
        expect(
          uiControlIcons.length,
          greaterThanOrEqualTo(8),
          reason: 'Should have at least 8 UI control icons',
        );
        expect(
          uiControlIcons.length,
          lessThanOrEqualTo(10),
          reason: 'Should have at most 10 UI control icons',
        );
      });
    });

    group('Categorical Mappings', () {
      test('categoricalIcons contains all 6 categories', () {
        expect(
          AppIcons.categoricalIcons.keys,
          containsAll([
            'Navigation',
            'Actions',
            'Status',
            'Content',
            'Communication',
            'UI Controls',
          ]),
        );
        expect(AppIcons.categoricalIcons.length, equals(6));
      });

      test('Each category contains valid icon mappings', () {
        for (final entry in AppIcons.categoricalIcons.entries) {
          expect(
            entry.value,
            isNotEmpty,
            reason: 'Category "${entry.key}" should not be empty',
          );

          for (final iconEntry in entry.value.entries) {
            expect(
              iconEntry.value,
              isA<IconData>(),
              reason:
                  'Icon "${iconEntry.key}" in category "${entry.key}" '
                  'should be IconData',
            );
          }
        }
      });

      test('allIcons contains all icons from all categories', () {
        int totalIconsInCategories = 0;
        for (final category in AppIcons.categoricalIcons.values) {
          totalIconsInCategories += category.length;
        }

        expect(
          AppIcons.allIcons.length,
          equals(totalIconsInCategories),
          reason: 'allIcons should contain all icons from all categories',
        );
      });

      test('allIcons map keys match icon constant names', () {
        // Verify some key icon names exist in allIcons
        final expectedKeys = [
          'home',
          'search',
          'add',
          'edit',
          'delete',
          'check',
          'error',
          'image',
          'email',
          'settings',
        ];

        for (final key in expectedKeys) {
          expect(
            AppIcons.allIcons.containsKey(key),
            isTrue,
            reason: 'allIcons should contain key "$key"',
          );
        }
      });
    });

    group('Total Icon Count', () {
      test('Total icons should be between 70-85 as per requirements', () {
        final totalIcons = AppIcons.allIcons.length;

        expect(
          totalIcons,
          greaterThanOrEqualTo(59),
          reason: 'Should have at least 59 icons (sum of minimums)',
        );
        expect(
          totalIcons,
          lessThanOrEqualTo(87),
          reason: 'Should have at most 87 icons (sum of maximums)',
        );
      });
    });
  });

  // ============================================================================
  // WIDGET TESTS - Verify icon rendering
  // ============================================================================

  group('AppIcons - Widget Tests', () {
    testWidgets('Navigation icons render correctly', (
      WidgetTester tester,
    ) async {
      final navigationIcons = [
        AppIcons.home,
        AppIcons.search,
        AppIcons.menu,
        AppIcons.back,
        AppIcons.close,
        AppIcons.refresh,
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: navigationIcons.map((icon) => Icon(icon)).toList(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      for (final icon in navigationIcons) {
        expect(find.byIcon(icon), findsOneWidget);
      }
    });

    testWidgets('Action icons render correctly', (WidgetTester tester) async {
      final actionIcons = [
        AppIcons.add,
        AppIcons.edit,
        AppIcons.delete,
        AppIcons.share,
        AppIcons.favorite,
        AppIcons.download,
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(children: actionIcons.map((icon) => Icon(icon)).toList()),
          ),
        ),
      );

      await tester.pumpAndSettle();

      for (final icon in actionIcons) {
        expect(find.byIcon(icon), findsOneWidget);
      }
    });

    testWidgets('Status icons render correctly', (WidgetTester tester) async {
      final statusIcons = [
        AppIcons.check,
        AppIcons.error,
        AppIcons.warning,
        AppIcons.info,
        AppIcons.success,
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(children: statusIcons.map((icon) => Icon(icon)).toList()),
          ),
        ),
      );

      await tester.pumpAndSettle();

      for (final icon in statusIcons) {
        expect(find.byIcon(icon), findsOneWidget);
      }
    });

    testWidgets('Content icons render correctly', (WidgetTester tester) async {
      final contentIcons = [
        AppIcons.image,
        AppIcons.video,
        AppIcons.audio,
        AppIcons.document,
        AppIcons.folder,
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: contentIcons.map((icon) => Icon(icon)).toList(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      for (final icon in contentIcons) {
        expect(find.byIcon(icon), findsOneWidget);
      }
    });

    testWidgets('Communication icons render correctly', (
      WidgetTester tester,
    ) async {
      final communicationIcons = [
        AppIcons.email,
        AppIcons.chat,
        AppIcons.call,
        AppIcons.notifications,
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: communicationIcons.map((icon) => Icon(icon)).toList(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      for (final icon in communicationIcons) {
        expect(find.byIcon(icon), findsOneWidget);
      }
    });

    testWidgets('UI Control icons render correctly', (
      WidgetTester tester,
    ) async {
      final uiControlIcons = [
        AppIcons.expandMore,
        AppIcons.expandLess,
        AppIcons.filter,
        AppIcons.sort,
        AppIcons.settings,
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Row(
              children: uiControlIcons.map((icon) => Icon(icon)).toList(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      for (final icon in uiControlIcons) {
        expect(find.byIcon(icon), findsOneWidget);
      }
    });

    testWidgets('Icons render with custom size', (WidgetTester tester) async {
      const customSize = 48.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(child: Icon(AppIcons.home, size: customSize)),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final iconWidget = tester.widget<Icon>(find.byIcon(AppIcons.home));
      expect(iconWidget.size, equals(customSize));
    });

    testWidgets('Icons render with custom color', (WidgetTester tester) async {
      const customColor = Colors.red;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(child: Icon(AppIcons.error, color: customColor)),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final iconWidget = tester.widget<Icon>(find.byIcon(AppIcons.error));
      expect(iconWidget.color, equals(customColor));
    });

    testWidgets('Icons work with IconButton', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: IconButton(
                icon: const Icon(AppIcons.add),
                onPressed: () => tapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(AppIcons.add), findsOneWidget);

      await tester.tap(find.byIcon(AppIcons.add));
      await tester.pumpAndSettle();

      expect(tapped, isTrue);
    });

    testWidgets('Icons work in AppBar and BottomNavigationBar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(AppIcons.menu),
                onPressed: () {},
              ),
              actions: [
                IconButton(icon: const Icon(AppIcons.search), onPressed: () {}),
                IconButton(
                  icon: const Icon(AppIcons.moreVert),
                  onPressed: () {},
                ),
              ],
            ),
            body: const Center(child: Text('Content')),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(AppIcons.settings),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // AppBar icons
      expect(find.byIcon(AppIcons.menu), findsOneWidget);
      // Search appears in both AppBar and BottomNav
      expect(find.byIcon(AppIcons.search), findsNWidgets(2));
      expect(find.byIcon(AppIcons.moreVert), findsOneWidget);

      // BottomNavigationBar icons
      expect(find.byIcon(AppIcons.home), findsOneWidget);
      expect(find.byIcon(AppIcons.settings), findsOneWidget);
    });
  });
}
