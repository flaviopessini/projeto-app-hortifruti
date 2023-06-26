import 'package:app_painel_hortifruti/app/data/models/category_request.dart';
import 'package:app_painel_hortifruti/app/modules/category_list/controller.dart';
import 'package:app_painel_hortifruti/app/modules/product/controller.dart';
import 'package:app_painel_hortifruti/app/modules/product/widgets/new_category/new_category_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCategoryController extends GetxController {
  final NewCategoryRepository _repository;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final isLoading = RxBool(false);

  NewCategoryController(this._repository);

  void onSubmit() {
    Get.focusScope!.unfocus();
    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      return;
    }

    final categoryRequest = CategoryRequestModel(
      name: nameController.text,
    );

    _repository.postCategory(categoryRequest).then((category) async {
      final productController = Get.find<ProductController>();
      await productController.fetchCategories();
      productController.changeCategory(category.id);

      final categoryListController = Get.find<CategoryListController>();
      await categoryListController.fetchCategories();

      Get.back();
    }, onError: (error) {
      Get.dialog(
        AlertDialog(
          title: Text(
            error.toString(),
          ),
        ),
      );
    }).whenComplete(
      () => isLoading.value = false,
    );
  }
}
