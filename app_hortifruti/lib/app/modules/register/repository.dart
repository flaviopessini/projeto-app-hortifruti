import 'package:app_hortifruti/app/data/models/user.dart';
import 'package:app_hortifruti/app/data/models/user_profile_request.dart';
import 'package:app_hortifruti/app/data/providers/api.dart';

class RegisterRepository {
  final Api _api;

  RegisterRepository(this._api);

  Future<UserModel> getUser() => _api.getUser();

  Future<UserModel> register(UserProfileRequestModel data) =>
      _api.register(data);
}
