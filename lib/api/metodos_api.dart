import 'dart:convert';
import 'package:http/http.dart' as http;
import 'products.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }

  static Future<void> deleteProduct(int id) async {
    final response =
        await http.delete(Uri.parse('https://fakestoreapi.com/products/$id'));
    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
  }

  static Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('https://fakestoreapi.com/products/${product.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': product.title,
        'price': product.price,
        'imageUrl': product.imageUrl,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
