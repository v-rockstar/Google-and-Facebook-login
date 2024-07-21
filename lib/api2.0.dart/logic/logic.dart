import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/model.dart';

class APIController extends GetxController {
  final categoryModel = <CategoryModel>[].obs;
  final productModel = <ProductModel>[].obs;

  Future<List<CategoryModel>?> getCategories() async {
    try {
      var url = Uri.parse(
          'https://api.escuelajs.co/api/v1/categories?offset=0&limit=4');
      var response = await http.get(url);

      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        categoryModel.value =
            List.from(body).map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        log('${response.reasonPhrase}');
      }
      return categoryModel;
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future<List<ProductModel>?> getCatProducts(
      {required int id, required int pageKey}) async {
    try {
      var url = Uri.parse(
          'https://api.escuelajs.co/api/v1/categories/$id/products?offset=${pageKey * 5}&limit=5');
      var response = await http.get(url);

      final body = jsonDecode(response.body);

      return List.from(body).map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log('$e');
      return null;
    }
  }

  Future getSingleProduct() async {
    var url = Uri.parse('https://api.escuelajs.co/api/v1/products');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      log(response.body);
    } else {
      log('${response.reasonPhrase}');
    }
  }
}
