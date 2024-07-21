import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class CrudOperationsController extends GetxController {
  final products = <Product>[].obs;
  final categories = <String>[].obs;
  final isLoaded = false.obs;

  Future<List<Product>> fetchProducts(String? category) async {
    final apiKey = dotenv.env['apiKey'];
    log('apiKey -->> $apiKey');
    try {
      var url = Uri.parse(
          "https://fakestoreapi.com/products${category == null ? '' : '/category/$category'}");

      var response = await http.get(url);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        products.value =
            List.from(body).map((e) => Product.fromJson(e)).toList();

        final uniqueCategories =
            products.map((e) => e.category as String).toSet().toList();
        categories.addAll(uniqueCategories);

        log('categories -->> $categories');

        isLoaded.value = true;
        return products;
      } else {
        log('er -->> ${response.reasonPhrase}');
      }
    } catch (e) {
      log('catch -->> ${e.toString()}');
    }
    return [];
  }
}
