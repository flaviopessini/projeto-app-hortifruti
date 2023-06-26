import 'package:app_painel_hortifruti/app/data/models/category.dart';
import 'package:app_painel_hortifruti/app/data/services/auth/service.dart';
import 'package:app_painel_hortifruti/app/modules/category_list/repository.dart';
import 'package:app_painel_hortifruti/app/widgets/category/category_controller.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController
    with StateMixin<List<CategoryModel>> {
  final CategoryListRepository _repository;
  final _authService = Get.find<AuthService>();
  final categorySelected = RxnInt();

  CategoryListController(this._repository);

  @override
  void onInit() {
    ever(_authService.user, (_) => fetchCategories());

    fetchCategories();

    super.onInit();
  }

  Future<void> fetchCategories() async {
    await _repository.getCategories().then((data) {
      if (data.isEmpty) {
        change(null, status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void changeCategory(CategoryModel category) {
    categorySelected.value = category.id;
    Get.find<CategoryController>(tag: 'detail').categoryId.value =
        categorySelected.value;
  }
}
