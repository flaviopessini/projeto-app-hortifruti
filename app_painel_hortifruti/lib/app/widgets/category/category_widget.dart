import 'package:app_painel_hortifruti/app/routes/routes.dart';
import 'package:app_painel_hortifruti/app/widgets/category/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryController controller;

  CategoryWidget({String? tag, super.key})
      : controller = Get.find<CategoryController>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ListView(
        shrinkWrap: true,
        children: [
          for (var product in state!)
            ListTile(
              leading: product.image != null && product.image!.isNotEmpty
                  ? SizedBox(
                      width: 56.0,
                      height: 56.0,
                      child: ClipRRect(
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: product.image!,
                          imageErrorBuilder: (context, error, stackTrace) =>
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
              }),
            ),
        ],
      ),
      onEmpty: const Center(
        child: Text('Nenhum produto cadastrado na categoria.'),
      ),
      onError: (error) => Center(
        child: Text(
          error.toString(),
        ),
      ),
      onLoading: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
