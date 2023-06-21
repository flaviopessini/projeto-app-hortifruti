import 'package:app_painel_hortifruti/app/data/providers/api.dart';
import 'package:app_painel_hortifruti/app/modules/dashboard/controller.dart';
import 'package:app_painel_hortifruti/app/modules/home/controller.dart';
import 'package:app_painel_hortifruti/app/modules/home/repository.dart';
import 'package:app_painel_hortifruti/app/modules/order_list/controller.dart';
import 'package:app_painel_hortifruti/app/modules/order_list/repository.dart';
import 'package:app_painel_hortifruti/app/modules/user_profile/controller.dart';
import 'package:app_painel_hortifruti/app/modules/user_profile/repository.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        HomeRepository(Get.find<Api>()),
      ),
    );
    Get.lazyPut<UserProfileController>(
      () => UserProfileController(
        UserProfileRepository(Get.find<Api>()),
      ),
    );
    Get.lazyPut<OrderListController>(
      () => OrderListController(
        OrderListRepository(Get.find<Api>()),
      ),
    );
  }
}
