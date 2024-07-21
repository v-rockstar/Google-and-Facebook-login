import 'package:flutter/material.dart';
import '../model/model.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel model;
  const ProductDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.sizeOf(context);
    const style = TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
        ),
        body: Stack(
          children: [
            // image
            Image.network(
              model.images[0],
              height: mq.height * .4,
              width: double.maxFinite,
              fit: BoxFit.cover,
            ),

            // details
            Container(
              margin: EdgeInsets.only(top: mq.height * .37),
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(27),
                      topRight: Radius.circular(27))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mq.width * .04, vertical: mq.height * .04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: style,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "Price : ${model.price}",
                        style: style,
                      ),
                    ),
                    Text(
                      model.description,
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
