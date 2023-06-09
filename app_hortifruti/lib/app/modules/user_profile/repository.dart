import 'package:app_hortifruti/app/data/models/user.dart';
import 'package:app_hortifruti/app/data/models/user_profile_request.dart';
import 'package:app_hortifruti/app/data/providers/api.dart';

class UserProfileRepository {
  final Api _api;

  UserProfileRepository(this._api);

  Future<UserModel> getUser() => _api.getUser();

  Future<UserModel> putUser(UserProfileRequestModel data) => _api.putUser(data);
}
