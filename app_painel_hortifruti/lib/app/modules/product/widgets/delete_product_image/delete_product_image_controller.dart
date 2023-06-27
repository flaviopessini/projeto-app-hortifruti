import 'package:app_painel_hortifruti/app/data/models/product.dart';
import 'package:app_painel_hortifruti/app/modules/product/widgets/delete_product_image/delete_product_image_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteProductImageController extends GetxController {
  final DeleteProductImageRepository _repository;
  final isLoading = RxBool(false);
  final product = Rxn<ProductModel>();

  DeleteProductImageController(this._repository);

  @override
  void onInit() {
    product.value = Get.arguments['product'];

    super.onInit();
  }

  void onSubmit() {
    isLoading.value = true;

    _repository.deleteProductImage(product.value!.id).then((_) {
      Get.back(result: true);
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
