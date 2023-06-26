import 'package:app_painel_hortifruti/app/modules/store/controller.dart';
import 'package:app_painel_hortifruti/app/routes/routes.dart';
import 'package:app_painel_hortifruti/app/widgets/store_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class StorePage extends GetView<StoreController> {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx(
        (state) => CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Get.theme.colorScheme.inversePrimary,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 8.0, right: 16.0, bottom: 32.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 96.0,
                      height: 96.0,
                      child: ClipRect(
                        child: state!.image != null
                            ? FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: state.image!,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            state.name,
                            style: Get.textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          StoreStatus(state.isOnline),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) {
                  final category = state.categories[index];

                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey[200],
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Text(
                                category.name,
                                style: Get.textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (var product in category.products)
                        ListTile(
                          leading: product.image.isNotEmpty
                              ? SizedBox(
                                  width: 56.0,
                                  height: 56.0,
                                  child: ClipRRect(
                                    child: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: product.image,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) =>
                                              const Placeholder(),
                                    ),
                                  ),
                                )
                              : null,
                          title: Text(
                            product.name,
                          ),
                          subtitle: Text(
                              '${NumberFormat.simpleCurrency().format(product.price)}${(product.unitOfMeasureIsByKg ? ' /kg' : '')}'),
                          onTap: () => Get.toNamed(Routes.product, arguments: {
                            'product': product,
                            'store': state,
                          }),
                        ),
                    ],
                  );
                }),
                childCount: state.categories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
