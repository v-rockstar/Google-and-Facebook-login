import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../logic/logic.dart';
import '../model/model.dart';
import 'products.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  //
  void initState() {
    catC.getCategories();
    super.initState();
  }

  final catC = Get.put(APIController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('API Screen'),
        ),
        body: Obx(
          () => Center(
            child: catC.categoryModel.isNotEmpty
                ? ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    children: [
                      const SizedBox(height: 100),
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          ...catC.categoryModel
                              .map((e) => CategoryCards(categoryModel: e))
                        ],
                      )
                    ],
                  )
                : const CircularProgressIndicator(),
          ),
        ));
  }
}

class CategoryCards extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryCards({
    super.key,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ProductsScreen(
            id: categoryModel.id,
            title: categoryModel.name,
          )),
      child: Container(
        alignment: Alignment.center,
        height: 200,
        width: 130,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(categoryModel.image))),
        child: Text(
          categoryModel.name,
          style: const TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
