import 'package:app_hortifruti/app/data/providers/api.dart';
import 'package:app_hortifruti/app/modules/dashboard/controller.dart';
import 'package:app_hortifruti/app/modules/home/controller.dart';
import 'package:app_hortifruti/app/modules/home/repository.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(
        () => HomeController(HomeRepository(Get.find<Api>())));
  }
}
