// SPDX-FileCopyrightText: 2025 hexaTune LLC
// SPDX-License-Identifier: MIT

/// Product type enum representing different kinds of in-app purchase products.
enum ProductType {
  /// Consumable products that can be purchased multiple times (e.g., coins, credits).
  consumable,

  /// Non-consumable products that are purchased once and don't expire (e.g., premium features).
  nonConsumable,

  /// Subscription products that require recurring payments (e.g., monthly premium).
  subscription,
}

/// Immutable data model representing an in-app purchase product.
///
/// Contains all necessary metadata, pricing information, localization support,
/// and platform-specific identifiers needed for purchase flows.
class Product {
  /// Unique identifier for the product.
  final String id;

  /// Type of the product (consumable, non-consumable, or subscription).
  final ProductType type;

  /// Display title of the product.
  final String title;

  /// Detailed description of the product.
  final String description;

  /// Formatted price string for display (e.g., "$9.99").
  final String price;

  /// Numeric price amount.
  final double priceAmount;

  /// Currency code (e.g., "USD", "EUR").
  final String currencyCode;

  /// Platform-specific product identifier for iOS App Store.
  final String? iosProductId;

  /// Platform-specific product identifier for Android Play Store.
  final String? androidProductId;

  const Product({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.price,
    required this.priceAmount,
    required this.currencyCode,
    this.iosProductId,
    this.androidProductId,
  });

  /// Creates a [Product] from a JSON map.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      type: ProductType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ProductType.nonConsumable,
      ),
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      priceAmount: (json['priceAmount'] as num).toDouble(),
      currencyCode: json['currencyCode'] as String,
      iosProductId: json['iosProductId'] as String?,
      androidProductId: json['androidProductId'] as String?,
    );
  }

  /// Converts this [Product] to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'title': title,
      'description': description,
      'price': price,
      'priceAmount': priceAmount,
      'currencyCode': currencyCode,
      'iosProductId': iosProductId,
      'androidProductId': androidProductId,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Product(id: $id, type: $type, title: $title, price: $price)';
  }

  /// Creates a copy of this [Product] with the given fields replaced.
  Product copyWith({
    String? id,
    ProductType? type,
    String? title,
    String? description,
    String? price,
    double? priceAmount,
    String? currencyCode,
    String? iosProductId,
    String? androidProductId,
  }) {
    return Product(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      priceAmount: priceAmount ?? this.priceAmount,
      currencyCode: currencyCode ?? this.currencyCode,
      iosProductId: iosProductId ?? this.iosProductId,
      androidProductId: androidProductId ?? this.androidProductId,
    );
  }
}
