import 'package:app_painel_hortifruti/app/data/models/user.dart';
import 'package:app_painel_hortifruti/app/data/models/user_login_request.dart';
import 'package:app_painel_hortifruti/app/data/models/user_login_response.dart';
import 'package:app_painel_hortifruti/app/data/providers/api.dart';

class AuthRepository {
  final Api _api;

  AuthRepository(this._api);

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) =>
      _api.login(data);

  Future<UserModel> getUser() => _api.getUser();
}
