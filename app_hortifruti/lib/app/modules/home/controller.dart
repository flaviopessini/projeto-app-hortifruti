import 'package:app_hortifruti/app/data/models/store.dart';
import 'package:app_hortifruti/app/modules/home/repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<List<StoreModel>> {
  final HomeRepository _repository;

  HomeController(this._repository);

  @override
  void onInit() {
    _repository.getStores().then((data) {
      if (data.isNotEmpty) {
        change(data, status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
      }
    }).onError((error, stackTrace) {
      change(null, status: RxStatus.error());
    });

    super.onInit();
  }
}
