import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../router/router_x.dart';
import '../logic/crud_op.dart';
import '../model/product_model.dart';
import '../../pact.dart';

class ProductList extends StatefulWidget {
  final String cat;
  const ProductList({super.key, required this.cat});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> catProducts = [];
  String abx = "hdhdhdhhd";
  bool iso = true;
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
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: CustomPaint(
                painter: PainterBrushBar(),
                child: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text('Products'),
                  leading: IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(CupertinoIcons.left_chevron)),
                ))),
        body: GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemCount: catProducts.length,
          itemBuilder: (context, index) {
            final data = catProducts[index];
            return InkWell(
              onTap: () => RouterX.router
                  .pushNamed(RouteName.productView.name, extra: data),
              child: Column(
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
              ),
            );
          },
        ));
  }
}
