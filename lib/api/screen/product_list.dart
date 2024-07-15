import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:snapchat/api/logic/crud_op.dart';
import 'package:snapchat/api/model/product_model.dart';

class ProductList extends StatefulWidget {
  final String cat;
  const ProductList({super.key, required this.cat});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> catProducts = [];
  @override
  void initState() {
    log('cat -->> ${widget.cat}');
    catProducts = c.products.where((e) => e.category == widget.cat).toList();
    super.initState();
  }

  final c = Get.find<CrudOperationsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Products')),
        body: Obx(
          () => c.isLoaded.value
              ? GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: catProducts.length,
                  itemBuilder: (context, index) {
                    final data = catProducts[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * .2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: CachedNetworkImageProvider(
                                        data.image ?? ""))),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.title ?? '',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                )
              : const Center(child: CircularProgressIndicator()),
        ));
  }
}
