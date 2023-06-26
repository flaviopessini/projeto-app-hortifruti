import 'package:app_painel_hortifruti/app/data/models/category.dart';
import 'package:app_painel_hortifruti/app/modules/category_list/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

typedef ItemSelectedCallback = void Function(CategoryModel);

class CategoryListWidget extends StatelessWidget {
  final controller = Get.find<CategoryListController>();
  final ItemSelectedCallback onItemSelected;

  CategoryListWidget(this.onItemSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ListView(
        shrinkWrap: true,
        children: [
          for (var category in state!)
            Obx(() => ListTile(
                  title: Text(category.name),
                  // trailing: Chip(
                  //   label: Text(category.statusList.last.name),
                  //   elevation: 5.0,
                  // ),
                  onTap: () => onItemSelected(category),
                  selected: controller.categorySelected.value == category.id
                      ? true
                      : false,
                )),
        ],
      ),
      onEmpty: const Center(
        child: Text('Você não criou nenhuma categoria ainda.'),
      ),
    );
  }
}
