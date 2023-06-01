import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum StorageKey { token }

class StorageService extends GetxService {
  final box = GetStorage();
  final _token = RxnString();

  String? get token => _token.value;

  @override
  void onInit() {
    _token.value = box.read(StorageKey.token.name);
    super.onInit();
  }

  Future<void> saveToken(String token) {
    _token.value = token;
    return box.write(StorageKey.token.name, token);
  }

  Future<void> detroyToken() async {
    _token.value = null;
    await box.remove(StorageKey.token.name);
  }
}
