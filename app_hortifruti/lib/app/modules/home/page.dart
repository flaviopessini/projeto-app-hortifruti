import 'package:app_hortifruti/app/modules/home/controller.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:app_hortifruti/app/widgets/store_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

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
        child: controller.obx(
          (state) => ListView(
            shrinkWrap: true,
            children: [
              for (var store in state!)
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  leading: ClipRRect(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: store.image,
                    ),
                  ),
                  title: Text(
                    store.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  trailing: StoreStatus(store.isOnline),
                  onTap: () => Get.toNamed(
                      Routes.store.replaceFirst(':id', store.id.toString())),
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
    );
  }
}
