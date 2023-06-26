import 'package:app_painel_hortifruti/app/data/providers/api.dart';
import 'package:app_painel_hortifruti/app/widgets/category/category_controller.dart';
import 'package:app_painel_hortifruti/app/widgets/category/category_repository.dart';
import 'package:app_painel_hortifruti/app/widgets/category/category_widget.dart';
import 'package:app_painel_hortifruti/app/modules/category_list/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailsWidget extends StatelessWidget {
  final categoryListController = Get.find<CategoryListController>();
  final controller = Get.put(
    CategoryController(CategoryRepository(Get.find<Api>())),
    tag: 'detail',
    permanent: true,
  );

  CategoryDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (categorySelected) {
        if (categorySelected.value == null) {
          return const Center(
            child:
                Text('Clique em uma categoria ao lado para ver os produtos.'),
          );
        } else {
          return controller.obx(
            (state) => CategoryWidget(tag: 'detail'),
          );
        }
      },
      categoryListController.categorySelected,
    );
  }
}
