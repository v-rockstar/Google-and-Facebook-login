import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../router/router_x.dart';
import '../logic/crud_op.dart';
import '../../pact.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final crudC = Get.put(CrudOperationsController());

  @override
  void initState() {
    crudC.fetchProducts(null);
    super.initState();
  }

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
              title: const Text("Home"),
            ),
          ),
        ),
        body: Obx(
          () => crudC.isLoaded.value
              ? Center(
                  child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 70,
                      runSpacing: 20,
                      children: [
                        ...List.generate(4, (index) {
                          final data = crudC.products[index];
                          final text = crudC.categories[index];
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height * .34,
                            width: MediaQuery.sizeOf(context).width * .3,
                            child: InkWell(
                              onTap: () => RouterX.router.pushNamed(
                                  RouteName.productList.name,
                                  extra: text),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: data.image!,
                                    placeholder: (context, url) =>
                                        Image.asset('assets/images/ph.png'),
                                    errorWidget: (context, url, error) =>
                                        const CircularProgressIndicator(),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(text)
                                ],
                              ),
                            ),
                          );
                        })
                      ]),
                )
              : const Center(child: CircularProgressIndicator()),
        ));
  }
}
