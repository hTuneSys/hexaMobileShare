// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

import 'dart:convert';
import 'package:flutter/widgets.dart';

/// Defines the style variants for icons in the application.
/// Based on Material Design 3 specifications.
enum AppIconVariant {
  outlined, // Default M3 style (400 weight)
  filled, // Solid style (700 weight)
  rounded, // Rounded corners style
  sharp, // Sharp corners style
  twoTone, // Two-tone color style
}

/// Defines semantic categories for icons to aid in organization and search.
enum AppIconCategory {
  navigation,
  actions,
  content,
  communication,
  status,
  other,
}

/// A definition for a registered icon, containing its variants and metadata.
class AppIconDefinition {
  final Map<AppIconVariant, IconData> variants;
  final IconData defaultIcon;
  final String name;
  final AppIconCategory category;
  final List<String> tags;
  final double? defaultSize;

  const AppIconDefinition({
    required this.name,
    required this.defaultIcon,
    this.variants = const {},
    this.category = AppIconCategory.other,
    this.tags = const [],
    this.defaultSize,
  });

  /// Retrieves the icon for a specific variant, falling back to the default icon if not found.
  IconData getVariant(AppIconVariant variant) {
    return variants[variant] ?? defaultIcon;
  }
}

/// A centralized registry for managing application icons.
///
/// Supports semantic lookup, variants, custom icons, and aliasing.
class AppIconRegistry {
  // Singleton instance
  static final AppIconRegistry _instance = AppIconRegistry._internal();
  static AppIconRegistry get instance => _instance;

  factory AppIconRegistry() {
    return _instance;
  }

  AppIconRegistry._internal();

  final Map<String, AppIconDefinition> _icons = {};
  final Map<String, String> _aliases = {};

  // Default fallback icon (usually something visible like a question mark or box)
  // Can be configured by the user.
  IconData _fallbackIcon = const IconData(
    0xe000,
    fontFamily: 'MaterialIcons',
  ); // Default generic icon (e.g. error/help)

  /// Configures the global fallback icon to be used when a requested icon is not found.
  void setFallbackIcon(IconData icon) {
    _fallbackIcon = icon;
  }

  /// Registers a new icon definition.
  void registerIcon(AppIconDefinition definition) {
    _icons[definition.name] = definition;
  }

  /// Registers a standard Material icon with optional variants.
  ///
  /// [name]: Semantic name (e.g., 'home', 'profile').
  /// [defaultIcon]: The main icon to use.
  /// [variants]: Optional map of specific variants.
  void registerMaterialIcon({
    required String name,
    required IconData defaultIcon,
    Map<AppIconVariant, IconData>? variants,
    AppIconCategory category = AppIconCategory.other,
    List<String> tags = const [],
  }) {
    registerIcon(
      AppIconDefinition(
        name: name,
        defaultIcon: defaultIcon,
        variants: variants ?? {},
        category: category,
        tags: tags,
      ),
    );
  }

  /// Registers an alias for an existing icon.
  ///
  /// [alias]: The new name (e.g., 'trash').
  /// [target]: The existing registered name (e.g., 'delete').
  void registerAlias(String alias, String target) {
    if (_icons.containsKey(target) || _aliases.containsKey(target)) {
      _aliases[alias] = target;
    } else {
      debugPrint(
        'AppIconRegistry: Warning - Trying to alias "$alias" to non-existent icon "$target"',
      );
    }
  }

  /// Registers a custom icon from a font family.
  void registerCustomIcon({
    required String name,
    required int codePoint,
    required String fontFamily,
    String? fontPackage,
    Map<AppIconVariant, int>? variantCodePoints,
    AppIconCategory category = AppIconCategory.other,
  }) {
    final defaultIcon = IconData(
      codePoint,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
    );

    final variants = <AppIconVariant, IconData>{};
    if (variantCodePoints != null) {
      variantCodePoints.forEach((variant, cp) {
        variants[variant] = IconData(
          cp,
          fontFamily: fontFamily,
          fontPackage: fontPackage,
        );
      });
    }

    registerIcon(
      AppIconDefinition(
        name: name,
        defaultIcon: defaultIcon,
        variants: variants,
        category: category,
      ),
    );
  }

  /// Loads icon definitions and aliases from a JSON string.
  ///
  /// The JSON should have the following structure:
  /// ```json
  /// {
  ///   "icons": [
  ///     {
  ///       "name": "example",
  ///       "codePoint": 50000,
  ///       "fontFamily": "MaterialIcons",
  ///       "variants": {
  ///         "filled": 50001
  ///       }
  ///     }
  ///   ],
  ///   "aliases": {
  ///     "alias": "target"
  ///   }
  /// }
  /// ```
  void loadFromJson(String jsonString) {
    try {
      final Map<String, dynamic> data = json.decode(jsonString);

      if (data.containsKey('icons')) {
        final List<dynamic> icons = data['icons'];
        for (final iconData in icons) {
          if (iconData is Map<String, dynamic>) {
            _registerFromJson(iconData);
          }
        }
      }

      if (data.containsKey('aliases')) {
        final Map<String, dynamic> aliases = data['aliases'];
        aliases.forEach((key, value) {
          if (value is String) {
            registerAlias(key, value);
          }
        });
      }
    } catch (e, stackTrace) {
      debugPrint('AppIconRegistry: Error loading JSON: $e\n$stackTrace');
    }
  }

  void _registerFromJson(Map<String, dynamic> data) {
    final name = data['name'] as String?;
    final codePoint = data['codePoint'] as int?;
    final fontFamily = data['fontFamily'] as String?;
    final fontPackage = data['fontPackage'] as String?;
    final rawVariants = data['variants'] as Map<String, dynamic>?;

    if (name == null || codePoint == null || fontFamily == null) {
      debugPrint('AppIconRegistry: Invalid icon definition in JSON: $data');
      return;
    }

    final variants = <AppIconVariant, IconData>{};
    if (rawVariants != null) {
      for (final entry in rawVariants.entries) {
        final variantEnum = AppIconVariant.values.firstWhere(
          (e) => e.toString().split('.').last == entry.key,
          orElse: () => AppIconVariant.outlined,
        );

        if (entry.value is int) {
          variants[variantEnum] = IconData(
            entry.value,
            fontFamily: fontFamily,
            fontPackage: fontPackage,
          );
        }
      }
    }

    final defaultIcon = IconData(
      codePoint,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
    );

    registerIcon(
      AppIconDefinition(
        name: name,
        defaultIcon: defaultIcon,
        variants: variants,
        // Category parsing could be added here
      ),
    );
  }

  /// Retrieves an icon by its semantic name.
  ///
  /// [name]: The semantic name of the icon.
  /// [variant]: The desired style variant.
  ///
  /// Returns the requested [IconData] or the fallback icon if not found.
  IconData getIcon(
    String name, {
    AppIconVariant variant = AppIconVariant.outlined,
  }) {
    final resolvedName = _resolveName(name);
    final definition = _icons[resolvedName];

    if (definition == null) {
      debugPrint(
        'AppIconRegistry: Check - Icon "$name" not found. Using fallback.',
      );
      return _fallbackIcon;
    }

    return definition.getVariant(variant);
  }

  /// Resolves aliases recursively to find the actual icon name.
  String _resolveName(String name) {
    if (_icons.containsKey(name)) {
      return name;
    }
    if (_aliases.containsKey(name)) {
      return _resolveName(_aliases[name]!); // Recursive resolution
    }
    return name;
  }

  /// Clears all registered icons and aliases.
  void clear() {
    _icons.clear();
    _aliases.clear();
  }

  /// Returns a list of all registered icon definitions.
  List<AppIconDefinition> getAllIcons() {
    return _icons.values.toList();
  }
}
