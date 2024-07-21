import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snapchat/api/model/product_model.dart';
import 'package:snapchat/api/screen/home.dart';
import 'package:snapchat/api/screen/product_list.dart';
import 'package:snapchat/api/screen/product_view.dart';
import 'package:snapchat/main.dart';
part 'router_name.dart';

class RouterX {
  //build context
  static BuildContext get context =>
      router.routerDelegate.navigatorKey.currentState?.overlay?.context ??
      router.routerDelegate.navigatorKey.currentContext!;

  static final router = GoRouter(routes: [
    // splash screen

    GoRoute(
      path: "/",
      name: RouteName.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(path: "/", builder: (context, state) => const SizedBox(), routes: [
      // home screen
      GoRoute(
          path: 'home',
          name: RouteName.home.name,
          builder: (context, state) => const Home(),
          routes: [
            GoRoute(
                path: 'productList',
                name: RouteName.productList.name,
                builder: (context, state) {
                  final cat = state.extra as String;
                  return ProductList(
                    cat: cat,
                  );
                },
                routes: [
                  GoRoute(
                    path: 'productView',
                    name: RouteName.productView.name,
                    builder: (context, state) =>
                        ProductView(product: state.extra as Product),
                  )
                ]),
          ])
    ]),
  ]);
}
