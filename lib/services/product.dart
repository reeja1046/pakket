// lib/services/product_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product.dart';

class ProductService {
  static const String baseUrl = 'https://pakket-dev.vercel.app/api/app/product';

  static Future<List<Product>> fetchAllProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Product>> fetchProductsByCategory(
      String categoryId) async {
    final response = await http.get(Uri.parse('$baseUrl?category=$categoryId'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products for category $categoryId');
    }
  }
}
