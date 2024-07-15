import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:snapchat/api/model/product_model.dart';

class CrudOperationsController extends GetxController {
  final products = <Product>[].obs;
  final categories = <String>[].obs;
  final isLoaded = false.obs;

  Future<List<Product>> fetchProducts(String? category) async {
    try {
      var url =
          "https://fakestoreapi.com/products${category == null ? '' : '/category/$category?limit=5'}";

      var request = http.Request('GET', Uri.parse(url));

      log("url -->> $url");

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final stream = await response.stream.bytesToString();
        final List data = jsonDecode(stream);

        final dataToAdd = data.map((e) => Product.fromJson(e)).toList();

        products.addAll(dataToAdd);

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
