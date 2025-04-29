class ProductOption {
  final String unit;
  final double basePrice;
  final double offerPrice;

  ProductOption({required this.unit, required this.basePrice, required this.offerPrice});

  factory ProductOption.fromJson(Map<String, dynamic> json) {
    return ProductOption(
      unit: json['unit'],
      basePrice: json['basePrice'].toDouble(),
      offerPrice: json['offerPrice'].toDouble(),
    );
  }
}

class ProductDetail {
  final String title;
  final String description;
  final String thumbnail;
  final List<String> images;
  final List<ProductOption> options;

  ProductDetail({
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.images,
    required this.options,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      images: List<String>.from(json['images']),
      options: (json['options'] as List).map((e) => ProductOption.fromJson(e)).toList(),
    );
  }
}
