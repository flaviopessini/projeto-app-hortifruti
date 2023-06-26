import 'package:app_painel_hortifruti/app/data/models/product.dart';
import 'package:app_painel_hortifruti/app/routes/routes.dart';
import 'package:app_painel_hortifruti/app/widgets/category/category_repository.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController
    with StateMixin<List<ProductModel>> {
  final CategoryRepository _repository;
  final categoryId = RxnInt();

  CategoryController(this._repository);

  @override
  void onInit() {
    ever(categoryId, (_) => loadProducts());

    if (Get.currentRoute != Routes.dashboard &&
        Get.parameters.containsKey('id')) {
      categoryId.value = int.parse(Get.parameters['id']!);
    }

    super.onInit();
  }

  Future<void> loadProducts() async {
    change(state, status: RxStatus.loading());

    await _repository.getProducts(categoryId.value!).then((data) {
      if (data.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }
}
