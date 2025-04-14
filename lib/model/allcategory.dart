class Category {
  final String id;
  final String name;
  final String iconUrl;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      iconUrl: json['icon']['url'],
      imageUrl: json['image']['url'],
    );
  }
}
