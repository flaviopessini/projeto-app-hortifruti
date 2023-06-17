import 'package:app_hortifruti/app/modules/select_city/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCityPage extends GetView<SelectCityController> {
  const SelectCityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Selecione a cidade'),
      ),
      body: SafeArea(
        child: controller.obx(
          (state) => SingleChildScrollView(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (var c in state!)
                  ListTile(
                    title: Text('${c.name} - ${c.uf}'),
                    onTap: () => controller.onSelected(c),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
