// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_kit/icons/app_icon_registry.dart';

void main() {
  group('AppIconRegistry', () {
    late AppIconRegistry registry;

    setUp(() {
      registry = AppIconRegistry.instance;
      registry.clear();
      // Set a known fallback for testing
      registry.setFallbackIcon(const IconData(0x0000, fontFamily: 'Fallback'));
    });

    test('should return fallback icon when icon is not registered', () {
      final icon = registry.getIcon('non_existent_icon');
      expect(icon.codePoint, 0x0000);
      expect(icon.fontFamily, 'Fallback');
    });

    test('should register and retrieve a Material icon', () {
      const iconData = IconData(
        0xe88a,
        fontFamily: 'MaterialIcons',
      ); // Home icon
      registry.registerMaterialIcon(name: 'home', defaultIcon: iconData);

      final result = registry.getIcon('home');
      expect(result, iconData);
    });

    test('should resolve variants correctly', () {
      const outlined = IconData(0x1000, fontFamily: 'MaterialIcons');
      const filled = IconData(0x2000, fontFamily: 'MaterialIcons');

      registry.registerMaterialIcon(
        name: 'profile',
        defaultIcon: outlined,
        variants: {
          AppIconVariant.outlined: outlined,
          AppIconVariant.filled: filled,
        },
      );

      expect(
        registry.getIcon('profile', variant: AppIconVariant.outlined),
        outlined,
      );
      expect(
        registry.getIcon('profile', variant: AppIconVariant.filled),
        filled,
      );
    });

    test('should fall back to default icon if variant is missing', () {
      const defaultIcon = IconData(0x3000, fontFamily: 'MaterialIcons');

      registry.registerMaterialIcon(
        name: 'settings',
        defaultIcon: defaultIcon,
        variants: {AppIconVariant.outlined: defaultIcon},
      );

      // Requesting 'filled' which is not registered, should return default (outlined)
      expect(
        registry.getIcon('settings', variant: AppIconVariant.filled),
        defaultIcon,
      );
    });

    test('should resolve aliases', () {
      const iconData = IconData(0xe872, fontFamily: 'MaterialIcons'); // Delete

      registry.registerMaterialIcon(name: 'delete', defaultIcon: iconData);

      registry.registerAlias('trash', 'delete');
      registry.registerAlias('remove', 'trash'); // Chained alias

      expect(registry.getIcon('trash'), iconData);
      expect(registry.getIcon('remove'), iconData);
    });

    test('should register custom font icons', () {
      registry.registerCustomIcon(
        name: 'custom_pro',
        codePoint: 0xf100,
        fontFamily: 'MyCustomFont',
      );

      final icon = registry.getIcon('custom_pro');
      expect(icon.codePoint, 0xf100);
      expect(icon.fontFamily, 'MyCustomFont');
    });

    test('should load icons from JSON', () {
      const jsonString = '''
      {
        "icons": [
          {
            "name": "json_icon",
            "codePoint": 50000,
            "fontFamily": "MaterialIcons",
            "variants": {
              "filled": 50001
            }
          }
        ],
        "aliases": {
          "json_alias": "json_icon"
        }
      }
      ''';

      registry.loadFromJson(jsonString);

      expect(registry.getIcon('json_icon').codePoint, 50000);
      expect(
        registry.getIcon('json_icon', variant: AppIconVariant.filled).codePoint,
        50001,
      );
      expect(registry.getIcon('json_alias').codePoint, 50000);
    });
  });
}
