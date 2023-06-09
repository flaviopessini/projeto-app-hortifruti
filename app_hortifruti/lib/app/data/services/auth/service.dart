import 'package:app_hortifruti/app/data/models/user.dart';
import 'package:app_hortifruti/app/data/models/user_login_request.dart';
import 'package:app_hortifruti/app/data/services/auth/repository.dart';
import 'package:app_hortifruti/app/data/services/storage/service.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final _storageService = Get.find<StorageService>();
  final user = Rxn<UserModel>();
  final AuthRepository _repository;

  bool get isLogged => user.value != null;

  AuthService(this._repository);

  @override
  void onInit() async {
    if (_storageService.token != null) {
      await _getUser();
    }
    super.onInit();
  }

  Future<void> login(UserLoginRequestModel data) async {
    final response = await _repository.login(data);
    await _storageService.saveToken(response.token);
    await _getUser();
  }

  Future<void> logout() async {
    await _storageService.destroyToken();
    user.value = null;
  }

  Future _getUser() {
    return _repository.getUser().then((value) {
      user.value = value;
    });
  }
}
