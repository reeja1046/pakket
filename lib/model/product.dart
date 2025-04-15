// lib/model/product.dart

class Product {
  final String id;
  final String title;
  final String thumbnail;
  final List<ProductOption> options;

  Product({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.options,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var optionsJson = json['options'] as List? ?? [];
    List<ProductOption> optionsList = optionsJson.map((optionJson) => ProductOption.fromJson(optionJson)).toList();

    return Product(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      options: optionsList,
    );
  }
}

class ProductOption {
  final String unit;
  final double offerPrice;

  ProductOption({
    required this.unit,
    required this.offerPrice,
  });

  factory ProductOption.fromJson(Map<String, dynamic> json) {
    return ProductOption(
      unit: json['unit'] ?? '',
      offerPrice: (json['offer_price'] ?? 0).toDouble(),
    );
  }
}
