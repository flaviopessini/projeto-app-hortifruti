import 'package:app_hortifruti/app/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Hortifruti'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: controller.obx(
            (state) => ListView(
              shrinkWrap: true,
              children: [
                for (var store in state!)
                  ListTile(
                    leading: FlutterLogo(),
                    title: Text(store.name),
                    trailing: Text(store.isOnline ? 'Aberto' : 'Fechado'),
                  ),
              ],
            ),
            onEmpty: Center(
              child: Text(
                'No momento não há estabelecimentos disponíveis para sua cidade.',
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyMedium!,
              ),
            ),
            onError: (error) => Center(
              child: Text(
                error!,
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyMedium!.copyWith(
                  color: Get.theme.colorScheme.error,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
