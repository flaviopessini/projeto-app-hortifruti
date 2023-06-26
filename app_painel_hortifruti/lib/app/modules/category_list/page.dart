import 'package:app_painel_hortifruti/app/modules/category_list/controller.dart';
import 'package:app_painel_hortifruti/app/modules/category_list/widgets/category_details_widget.dart';
import 'package:app_painel_hortifruti/app/modules/category_list/widgets/category_list_widget.dart';
import 'package:app_painel_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListPage extends GetResponsiveView<CategoryListController> {
  static const _pageTitle = 'Meus produtos';

  CategoryListPage({super.key});

  @override
  Widget desktop() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text(_pageTitle),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 400.0,
                ),
                child: CategoryListWidget(controller.changeCategory),
              ),
            ),
            Flexible(
              flex: 3,
              child: CategoryDetailsWidget(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget phone() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text(_pageTitle),
      ),
      body: SafeArea(
        child: CategoryListWidget(
          (category) => Get.toNamed(
            Routes.category.replaceFirst(':id', category.id.toString()),
          ),
        ),
      ),
    );
  }
}
