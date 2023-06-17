import 'package:app_hortifruti/app/data/models/city.dart';
import 'package:app_hortifruti/app/data/services/storage/service.dart';
import 'package:app_hortifruti/app/modules/select_city/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:get/get.dart';

class SelectCityController extends GetxController
    with StateMixin<List<CityModel>> {
  final StorageService _storage = Get.find<StorageService>();

  final SelectCityRepository _repository;

  SelectCityController(this._repository);

  @override
  void onInit() {
    _repository.getCities().then((data) {
      if (data.isEmpty) {
        change([], status: RxStatus.empty());
      } else {
        change(data, status: RxStatus.success());
      }
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
    super.onInit();
  }

  void onSelected(CityModel city) async {
    await _storage.saveCityId(city.id);
    Get.offAllNamed(Routes.dashboard);
  }
}
