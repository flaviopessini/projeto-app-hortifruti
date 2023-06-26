import 'package:app_painel_hortifruti/app/data/providers/api.dart';
import 'package:app_painel_hortifruti/app/modules/product/controller.dart';
import 'package:app_painel_hortifruti/app/modules/product/repository.dart';
import 'package:get/get.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(
      () => ProductController(ProductRepository(Get.find<Api>())),
    );
  }
}
