import 'package:pakket/model/orderdetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<OrderDetail> fetchOrderDetail(String orderId) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  final url = 'https://pakket-dev.vercel.app/api/app/order/$orderId';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return OrderDetail.fromJson(data['order']);
  } else {
    throw Exception('Failed to load order');
  }
}
