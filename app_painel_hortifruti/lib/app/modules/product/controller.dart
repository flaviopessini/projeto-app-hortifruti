import 'package:app_painel_hortifruti/app/data/models/category.dart';
import 'package:app_painel_hortifruti/app/data/models/product.dart';
import 'package:app_painel_hortifruti/app/data/models/store.dart';
import 'package:app_painel_hortifruti/app/data/services/cart/service.dart';
import 'package:app_painel_hortifruti/app/modules/product/repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepository _repository;
  final product = Rxn<ProductModel>();
  final store = Rxn<StoreModel>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final image = Rxn<PlatformFile>();
  final categoryList = RxList<CategoryModel>.empty();
  final categoryId = RxnInt();

  ProductController(this._repository);

  @override
  void onInit() {
    // product.value = Get.arguments['product'];
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    await _repository.getCategories().then((data) {
      categoryList.assignAll(data);
    });
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

  void changeCategory(int? id) {
    categoryId.value = id;
  }
}
