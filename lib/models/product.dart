import 'dart:convert';

class Product {
  final String id;
  final String vendorId;
  final String fullName;
  final String productName;
  final int productPrice;
  final int quantity;
  final String description;
  final String category;
  final String subCategory;
  final List<String> images;
  Product({
    required this.id,
    required this.vendorId,
    required this.fullName,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vendorId': vendorId,
      'fullName': fullName,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'description': description,
      'category': category,
      'subCategory': subCategory,
      'images': images,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String? ?? '',
      vendorId: map['vendorId'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      productName: map['productName'] as String? ?? '',
      productPrice: map['productPrice'] as int? ?? 0,
      quantity: map['quantity'] as int? ?? 0,
      description: map['description'] as String? ?? '',
      category: map['category'] as String? ?? '',
      subCategory: map['subCategory'] as String? ?? '',
      images: List<String>.from(map['images'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
