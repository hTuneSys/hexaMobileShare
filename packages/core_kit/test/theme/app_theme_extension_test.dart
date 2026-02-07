// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [AppThemeExtension].
///
/// Verifies the functionality of custom theme extensions including copyWith,
/// lerp, JSON serialization, and BuildContext extension methods.
void main() {
  group('AppThemeExtension', () {
    group('Factory Constructors', () {
      test('light() creates extension with light theme values', () {
        final extension = AppThemeExtension.light();

        expect(extension.successColor, const Color(0xFF2E7D32));
        expect(extension.warningColor, const Color(0xFFF57C00));
        expect(extension.infoColor, const Color(0xFF1976D2));
        expect(extension.accent2Color, const Color(0xFF6A1B9A));
        expect(extension.accent3Color, const Color(0xFF00838F));
        expect(extension.spacingMicro, 2.0);
        expect(extension.spacingXxs, 4.0);
        expect(extension.spacingXs, 8.0);
        expect(extension.radiusXxs, 2.0);
        expect(extension.radiusXxl, 32.0);
        expect(extension.shadowSoft, isNotNull);
        expect(extension.shadowHard, isNotNull);
        expect(extension.shadowColored, isNotNull);
        expect(extension.monoTextStyle, isNotNull);
        expect(extension.displayTextStyle, isNotNull);
      });

      test('dark() creates extension with dark theme values', () {
        final extension = AppThemeExtension.dark();

        expect(extension.successColor, const Color(0xFF66BB6A));
        expect(extension.warningColor, const Color(0xFFFFB74D));
        expect(extension.infoColor, const Color(0xFF42A5F5));
        expect(extension.accent2Color, const Color(0xFFAB47BC));
        expect(extension.accent3Color, const Color(0xFF26C6DA));
        expect(extension.spacingMicro, 2.0);
        expect(extension.spacingXxs, 4.0);
        expect(extension.spacingXs, 8.0);
        expect(extension.radiusXxs, 2.0);
        expect(extension.radiusXxl, 32.0);
        expect(extension.shadowSoft, isNotNull);
        expect(extension.shadowHard, isNotNull);
        expect(extension.shadowColored, isNotNull);
        expect(extension.monoTextStyle, isNotNull);
        expect(extension.displayTextStyle, isNotNull);
      });

      test('default constructor allows null values', () {
        const extension = AppThemeExtension();

        expect(extension.successColor, isNull);
        expect(extension.warningColor, isNull);
        expect(extension.infoColor, isNull);
        expect(extension.accent2Color, isNull);
        expect(extension.accent3Color, isNull);
        expect(extension.spacingMicro, isNull);
        expect(extension.spacingXxs, isNull);
        expect(extension.spacingXs, isNull);
        expect(extension.radiusXxs, isNull);
        expect(extension.radiusXxl, isNull);
        expect(extension.shadowSoft, isNull);
        expect(extension.shadowHard, isNull);
        expect(extension.shadowColored, isNull);
        expect(extension.monoTextStyle, isNull);
        expect(extension.displayTextStyle, isNull);
      });
    });

    group('copyWith', () {
      test('returns new instance with updated color properties', () {
        final original = AppThemeExtension.light();
        final updated = original.copyWith(
          successColor: const Color(0xFF00FF00),
          warningColor: const Color(0xFFFF0000),
        );

        expect(updated.successColor, const Color(0xFF00FF00));
        expect(updated.warningColor, const Color(0xFFFF0000));
        // Other properties unchanged
        expect(updated.infoColor, original.infoColor);
        expect(updated.spacingMicro, original.spacingMicro);
      });

      test('returns new instance with updated spacing properties', () {
        final original = AppThemeExtension.light();
        final updated = original.copyWith(
          spacingMicro: 4.0,
          spacingXxs: 8.0,
          spacingXs: 16.0,
        );

        expect(updated.spacingMicro, 4.0);
        expect(updated.spacingXxs, 8.0);
        expect(updated.spacingXs, 16.0);
        // Other properties unchanged
        expect(updated.successColor, original.successColor);
      });

      test('returns new instance with updated radius properties', () {
        final original = AppThemeExtension.light();
        final updated = original.copyWith(radiusXxs: 4.0, radiusXxl: 64.0);

        expect(updated.radiusXxs, 4.0);
        expect(updated.radiusXxl, 64.0);
        expect(updated.successColor, original.successColor);
      });

      test('returns new instance with updated shadow properties', () {
        final original = AppThemeExtension.light();
        final newShadow = BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 20,
          offset: const Offset(0, 10),
        );
        final updated = original.copyWith(shadowSoft: newShadow);

        expect(updated.shadowSoft, newShadow);
        expect(updated.shadowHard, original.shadowHard);
      });

      test('returns new instance with updated typography properties', () {
        final original = AppThemeExtension.light();
        const newMonoStyle = TextStyle(fontFamily: 'Courier', fontSize: 16);
        final updated = original.copyWith(monoTextStyle: newMonoStyle);

        expect(updated.monoTextStyle, newMonoStyle);
        expect(updated.displayTextStyle, original.displayTextStyle);
      });

      test('preserves original when no parameters provided', () {
        final original = AppThemeExtension.light();
        final updated = original.copyWith();

        expect(updated.successColor, original.successColor);
        expect(updated.warningColor, original.warningColor);
        expect(updated.spacingMicro, original.spacingMicro);
        expect(updated.radiusXxs, original.radiusXxs);
      });
    });

    group('lerp', () {
      test('interpolates colors correctly at t=0.5', () {
        final light = AppThemeExtension.light();
        final dark = AppThemeExtension.dark();
        final lerped = light.lerp(dark, 0.5);

        // Should be halfway between light and dark colors
        expect(lerped.successColor, isNotNull);
        // Verify interpolation occurred by checking color is different
        expect(lerped.successColor, isNot(equals(light.successColor)));
        expect(lerped.successColor, isNot(equals(dark.successColor)));
      });

      test('returns original theme at t=0', () {
        final light = AppThemeExtension.light();
        final dark = AppThemeExtension.dark();
        final lerped = light.lerp(dark, 0.0);

        expect(lerped.successColor, light.successColor);
        expect(lerped.warningColor, light.warningColor);
        expect(lerped.infoColor, light.infoColor);
      });

      test('returns target theme at t=1', () {
        final light = AppThemeExtension.light();
        final dark = AppThemeExtension.dark();
        final lerped = light.lerp(dark, 1.0);

        expect(lerped.successColor, dark.successColor);
        expect(lerped.warningColor, dark.warningColor);
        expect(lerped.infoColor, dark.infoColor);
      });

      test('interpolates spacing values correctly', () {
        final theme1 = AppThemeExtension(
          spacingMicro: 2.0,
          spacingXxs: 4.0,
          spacingXs: 8.0,
        );
        final theme2 = AppThemeExtension(
          spacingMicro: 6.0,
          spacingXxs: 12.0,
          spacingXs: 24.0,
        );
        final lerped = theme1.lerp(theme2, 0.5);

        expect(lerped.spacingMicro, 4.0);
        expect(lerped.spacingXxs, 8.0);
        expect(lerped.spacingXs, 16.0);
      });

      test('interpolates radius values correctly', () {
        final theme1 = AppThemeExtension(radiusXxs: 2.0, radiusXxl: 32.0);
        final theme2 = AppThemeExtension(radiusXxs: 6.0, radiusXxl: 64.0);
        final lerped = theme1.lerp(theme2, 0.5);

        expect(lerped.radiusXxs, 4.0);
        expect(lerped.radiusXxl, 48.0);
      });

      test('returns this when other is not AppThemeExtension', () {
        final theme = AppThemeExtension.light();
        final lerped = theme.lerp(null, 0.5);

        expect(lerped.successColor, theme.successColor);
        expect(lerped.warningColor, theme.warningColor);
      });

      test('handles null values in lerp', () {
        const theme1 = AppThemeExtension(successColor: Color(0xFF000000));
        const theme2 = AppThemeExtension();
        final lerped = theme1.lerp(theme2, 0.5);

        // Should handle null in theme2
        expect(lerped.successColor, isNotNull);
      });
    });

    group('JSON Serialization', () {
      test('toJson serializes color properties', () {
        const extension = AppThemeExtension(
          successColor: Color(0xFF2E7D32),
          warningColor: Color(0xFFF57C00),
          infoColor: Color(0xFF1976D2),
          accent2Color: Color(0xFF6A1B9A),
          accent3Color: Color(0xFF00838F),
        );

        final json = extension.toJson();

        expect(json['successColor'], 0xFF2E7D32);
        expect(json['warningColor'], 0xFFF57C00);
        expect(json['infoColor'], 0xFF1976D2);
        expect(json['accent2Color'], 0xFF6A1B9A);
        expect(json['accent3Color'], 0xFF00838F);
      });

      test('toJson serializes spacing properties', () {
        const extension = AppThemeExtension(
          spacingMicro: 2.0,
          spacingXxs: 4.0,
          spacingXs: 8.0,
        );

        final json = extension.toJson();

        expect(json['spacingMicro'], 2.0);
        expect(json['spacingXxs'], 4.0);
        expect(json['spacingXs'], 8.0);
      });

      test('toJson serializes radius properties', () {
        const extension = AppThemeExtension(radiusXxs: 2.0, radiusXxl: 32.0);

        final json = extension.toJson();

        expect(json['radiusXxs'], 2.0);
        expect(json['radiusXxl'], 32.0);
      });

      test('toJson handles null values', () {
        const extension = AppThemeExtension();

        final json = extension.toJson();

        expect(json['successColor'], isNull);
        expect(json['spacingMicro'], isNull);
        expect(json['radiusXxs'], isNull);
      });

      test('fromJson deserializes color properties', () {
        final json = {
          'successColor': 0xFF2E7D32,
          'warningColor': 0xFFF57C00,
          'infoColor': 0xFF1976D2,
          'accent2Color': 0xFF6A1B9A,
          'accent3Color': 0xFF00838F,
        };

        final extension = AppThemeExtension.fromJson(json);

        expect(extension.successColor, const Color(0xFF2E7D32));
        expect(extension.warningColor, const Color(0xFFF57C00));
        expect(extension.infoColor, const Color(0xFF1976D2));
        expect(extension.accent2Color, const Color(0xFF6A1B9A));
        expect(extension.accent3Color, const Color(0xFF00838F));
      });

      test('fromJson deserializes spacing properties', () {
        final json = {'spacingMicro': 2.0, 'spacingXxs': 4.0, 'spacingXs': 8.0};

        final extension = AppThemeExtension.fromJson(json);

        expect(extension.spacingMicro, 2.0);
        expect(extension.spacingXxs, 4.0);
        expect(extension.spacingXs, 8.0);
      });

      test('fromJson deserializes radius properties', () {
        final json = {'radiusXxs': 2.0, 'radiusXxl': 32.0};

        final extension = AppThemeExtension.fromJson(json);

        expect(extension.radiusXxs, 2.0);
        expect(extension.radiusXxl, 32.0);
      });

      test('fromJson handles missing values', () {
        final json = <String, dynamic>{};

        final extension = AppThemeExtension.fromJson(json);

        expect(extension.successColor, isNull);
        expect(extension.spacingMicro, isNull);
        expect(extension.radiusXxs, isNull);
      });

      test('toJson -> fromJson roundtrip preserves values', () {
        const original = AppThemeExtension(
          successColor: Color(0xFF2E7D32),
          warningColor: Color(0xFFF57C00),
          spacingMicro: 2.0,
          spacingXxs: 4.0,
          radiusXxs: 2.0,
          radiusXxl: 32.0,
        );

        final json = original.toJson();
        final restored = AppThemeExtension.fromJson(json);

        expect(restored.successColor, original.successColor);
        expect(restored.warningColor, original.warningColor);
        expect(restored.spacingMicro, original.spacingMicro);
        expect(restored.spacingXxs, original.spacingXxs);
        expect(restored.radiusXxs, original.radiusXxs);
        expect(restored.radiusXxl, original.radiusXxl);
      });
    });

    group('BuildContext Extension', () {
      testWidgets('appThemeExtension returns extension from theme', (
        tester,
      ) async {
        final extension = AppThemeExtension.light();

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(extensions: [extension]),
            home: Builder(
              builder: (context) {
                final retrieved = context.appThemeExtension;

                expect(retrieved.successColor, extension.successColor);
                expect(retrieved.warningColor, extension.warningColor);
                expect(retrieved.spacingMicro, extension.spacingMicro);

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('appThemeExtension returns default light when not in theme', (
        tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                final retrieved = context.appThemeExtension;

                // Should return default light theme
                expect(retrieved.successColor, const Color(0xFF2E7D32));
                expect(retrieved.warningColor, const Color(0xFFF57C00));

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });
    });

    group('Edge Cases', () {
      test('copyWith with all null parameters returns equivalent instance', () {
        final original = AppThemeExtension.light();
        final updated = original.copyWith();

        expect(updated.successColor, original.successColor);
        expect(updated.warningColor, original.warningColor);
        expect(updated.infoColor, original.infoColor);
        expect(updated.spacingMicro, original.spacingMicro);
        expect(updated.radiusXxs, original.radiusXxs);
      });

      test('lerp with extreme t values', () {
        final light = AppThemeExtension.light();
        final dark = AppThemeExtension.dark();

        // t = -1 (before start)
        final beforeStart = light.lerp(dark, -1.0);
        expect(beforeStart, isNotNull);

        // t = 2 (after end)
        final afterEnd = light.lerp(dark, 2.0);
        expect(afterEnd, isNotNull);
      });

      test('empty instance serialization', () {
        const empty = AppThemeExtension();
        final json = empty.toJson();

        expect(json.values.every((value) => value == null), isTrue);
      });
    });

    group('Theme Integration', () {
      testWidgets('extension works with MaterialApp theme', (tester) async {
        final extension = AppThemeExtension.light();

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(extensions: [extension]),
            home: Builder(
              builder: (context) {
                final theme = Theme.of(context);
                final retrieved = theme.extension<AppThemeExtension>();

                expect(retrieved, isNotNull);
                expect(retrieved?.successColor, extension.successColor);

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });

      testWidgets('extension works with dark theme', (tester) async {
        final extension = AppThemeExtension.dark();

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(
              useMaterial3: true,
            ).copyWith(extensions: [extension]),
            home: Builder(
              builder: (context) {
                final retrieved = context.appThemeExtension;

                expect(retrieved.successColor, const Color(0xFF66BB6A));
                expect(retrieved.warningColor, const Color(0xFFFFB74D));

                return const SizedBox.shrink();
              },
            ),
          ),
        );
      });
    });
  });
}
