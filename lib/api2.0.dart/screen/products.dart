import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../logic/logic.dart';
import '../model/model.dart';
import 'product_details.dart';

class ProductsScreen extends StatefulWidget {
  final int id;
  final String title;
  const ProductsScreen({super.key, required this.id, required this.title});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final _c = PagingController<int, ProductModel>(firstPageKey: 0)
    ..addPageRequestListener((pageKey) async {
      _fetchData(pageKey);
    });

  Future<void> _fetchData(int pageKey) async {
    final list = await Get.find<APIController>()
        .getCatProducts(id: widget.id, pageKey: pageKey);

    if (list != null) {
      if (list.isEmpty) {
        _c.appendLastPage([]);
        return;
      }
      _c.appendPage(list, pageKey + 1);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PagedGridView<int, ProductModel>(
        pagingController: _c,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .5,
        ),
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) =>
              ProductCard(productsModel: item),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel productsModel;
  const ProductCard({
    super.key,
    required this.productsModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ProductDetails(model: productsModel)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17)),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(productsModel.images[0]),
                  onError: (exception, stackTrace) =>
                      const CircularProgressIndicator(),
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(productsModel.title)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('\$ ${productsModel.price}')),
          )
        ],
      ),
    );
  }
}
