import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:snapchat/api/model/product_model.dart';

class ProductView extends StatefulWidget {
  final Product product;
  const ProductView({super.key, required this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  void initState() {
    log(widget.product.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
