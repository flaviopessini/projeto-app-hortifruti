import 'package:app_hortifruti/app/data/providers/api.dart';
import 'package:app_hortifruti/app/modules/user_address/controller.dart';
import 'package:app_hortifruti/app/modules/user_address/repository.dart';
import 'package:get/get.dart';

class UserAddressControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAddressController>(
        () => UserAddressController(UserAddressRepository(Get.find<Api>())));
  }
}
