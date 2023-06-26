import 'package:app_painel_hortifruti/app/widgets/category/category_controller.dart';
import 'package:app_painel_hortifruti/app/widgets/category/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends GetView<CategoryController> {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Produtos da categoria'),
      ),
      body: SafeArea(
        child: controller.obx(
          (state) => SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: CategoryWidget(),
          ),
        ),
      ),
    );
  }
}
