import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';
  static const Duration timeoutDuration = Duration(seconds: 10);

  Future<List<Product>> fetchProducts() async {
    final response = await http
        .get(Uri.parse('$baseUrl/products?limit=20'))
        .timeout(timeoutDuration);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['products'];
      return list.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat produk (Error: ${response.statusCode})');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    final uri = Uri.parse('$baseUrl/products/search').replace(
      queryParameters: {'q': query},
    );
    final response = await http.get(uri).timeout(timeoutDuration);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['products'];
      return list.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mencari produk (Error: ${response.statusCode})');
    }
  }

  Future<Product> fetchProduct(int id) async {
    final response = await http
        .get(Uri.parse('$baseUrl/products/$id'))
        .timeout(timeoutDuration);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Product.fromJson(data);
    } else {
      throw Exception('Gagal memuat detail produk (Error: ${response.statusCode})');
    }
  }
}
