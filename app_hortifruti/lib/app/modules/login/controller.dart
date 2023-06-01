import 'package:app_hortifruti/app/data/models/user_login_request.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void login() {
    Get.focusScope?.unfocus();
    final userLogin = UserLoginRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    _authService.login(userLogin).then((value) => null);
  }
}
