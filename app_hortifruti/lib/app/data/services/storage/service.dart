import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum StorageKey { token, cityId }

class StorageService extends GetxService {
  final box = GetStorage();
  final _token = RxnString();
  final _cityId = RxnInt();

  String? get token => _token.value;
  int? get cityId => _cityId.value;

  @override
  void onInit() {
    _token.value = box.read(StorageKey.token.name);
    box.listenKey(StorageKey.token.name, (value) => _token.value = value);

    _cityId.value = box.read(StorageKey.cityId.name);
    box.listenKey(StorageKey.cityId.name, (value) => _cityId.value = value);

    super.onInit();
  }

  Future<void> saveToken(String token) {
    _token.value = token;
    return box.write(StorageKey.token.name, token);
  }

  Future<void> destroyToken() async {
    _token.value = null;
    await box.remove(StorageKey.token.name);
  }

  Future<void> saveCityId(int cityId) {
    _cityId.value = cityId;
    return box.write(StorageKey.cityId.name, cityId);
  }

  Future<void> destroyCityId() async {
    _cityId.value = null;
    await box.remove(StorageKey.cityId.name);
  }
}
