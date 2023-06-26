import 'package:app_painel_hortifruti/app/data/models/product.dart';
import 'package:app_painel_hortifruti/app/data/models/store.dart';
import 'package:app_painel_hortifruti/app/data/services/cart/service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final product = Rxn<ProductModel>();
  final store = Rxn<StoreModel>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final image = Rxn<PlatformFile>();

  @override
  void onInit() {
    // product.value = Get.arguments['product'];
    super.onInit();
  }

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      image.value = result.files.first;
    }
  }

  Future<void> onAdd() async {
    //
  }
}
