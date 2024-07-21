part of 'api_cubit.dart';

class ApiState {
  final List<Product> products;
  const ApiState({required this.products});

  ApiState copyWith({List<Product>? products}) {
    return ApiState(products: products ?? this.products);
  }
}
