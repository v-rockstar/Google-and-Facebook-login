import 'package:bloc/bloc.dart';
import '../logic/crud_op.dart';
import '../model/product_model.dart';

part 'api_state.dart';

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(const ApiState(products: []));

  Future<void> fetchProducts(String? category) async {
    final data = await CrudOperationsController().fetchProducts(category);

    emit(state.copyWith(products: data));
  }
}
