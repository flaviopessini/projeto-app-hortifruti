import 'package:app_painel_hortifruti/app/data/models/category.dart';
import 'package:app_painel_hortifruti/app/data/models/product.dart';
import 'package:app_painel_hortifruti/app/data/models/product_request.dart';
import 'package:app_painel_hortifruti/app/modules/product/repository.dart';
import 'package:app_painel_hortifruti/app/modules/product/widgets/delete_product_image/delete_product_image_widget.dart';
import 'package:app_painel_hortifruti/app/modules/product/widgets/new_category/new_category_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductRepository _repository;
  final product = Rxn<ProductModel>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final image = Rxn<PlatformFile>();
  final categoryList = RxList<CategoryModel>.empty();
  final categoryId = RxnInt();
  final unitOfMeasure = RxString('UN');
  final currentImage = RxnString();
  final formKey = GlobalKey<FormState>();
  final isLoading = RxBool(false);
  final isEditing = RxBool(false);

  ProductController(this._repository);

  @override
  void onInit() {
    fetchCategories();

    if (Get.arguments != null) {
      product.value = Get.arguments['product'];
      isEditing.value = true;

      nameController.text = product.value!.name;
      descriptionController.text = product.value!.description ?? '';
      priceController.text = product.value!.price.toString();
      unitOfMeasure.value = product.value!.unitOfMeasure;
      categoryId.value = product.value!.categoryId;
      currentImage.value = product.value!.image;
    } else if (Get.parameters['categoryId'] != null &&
        Get.parameters['categoryId']!.isNotEmpty) {
      categoryId.value = int.parse(Get.parameters['categoryId']!);
    }

    super.onInit();
  }

  Future<void> fetchCategories() async {
    isLoading.value = true;
    await _repository.getCategories().then((data) {
      categoryList.assignAll(data);
    }).whenComplete(
      () => isLoading.value = false,
    );
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

  Future<void> onDeleteImage() async {
    final result = await Get.dialog(
      DeleteProductImageWidget(),
      arguments: product.value,
    );

    if (result is bool && result == true) {
      currentImage.value = '';
    }
  }

  Future<void> onAdd() async {
    Get.focusScope!.unfocus();
    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      return;
    }

    var rawPrice = priceController.text.trim().replaceAll('.', '');
    rawPrice = rawPrice.replaceFirst(',', '.');

    final productRequest = ProductRequestModel(
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      price: num.parse(rawPrice),
      unitOfMeasure: unitOfMeasure.value,
      categoryId: categoryId.value!,
      image: image.value,
    );

    _repository.postProduct(productRequest).then((data) async {
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

  Future<void> onUpdate() async {
    Get.focusScope!.unfocus();
    isLoading.value = true;

    if (!formKey.currentState!.validate()) {
      return;
    }

    var rawPrice = priceController.text.trim().replaceAll('.', '');
    rawPrice = rawPrice.replaceFirst(',', '.');

    final productRequest = ProductRequestModel(
      id: product.value!.id,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      price: num.parse(rawPrice),
      unitOfMeasure: unitOfMeasure.value,
      categoryId: categoryId.value!,
      image: image.value,
    );

    _repository.putProduct(productRequest).then((data) async {
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

  void changeUnitOfMeasure(String? unit) {
    unitOfMeasure.value = unit?.trim().toUpperCase() ?? 'UN';
  }

  void changeCategory(int? id) {
    categoryId.value = id;
  }

  goToNewCategory() {
    Get.dialog(NewCategoryWidget());
  }
}
