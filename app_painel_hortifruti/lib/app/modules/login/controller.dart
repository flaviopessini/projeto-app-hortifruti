import 'package:app_painel_hortifruti/app/data/models/user_login_request.dart';
import 'package:app_painel_hortifruti/app/data/services/auth/service.dart';
import 'package:app_painel_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final _authService = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void login() {
    Get.focusScope!.unfocus();
    if (!formKey.currentState!.validate()) {
      return;
    }
    final userLogin = UserLoginRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    _authService.login(userLogin).then((value) {
      // if (Get.routing.previous == Routes.checkout) {
      //   Get.back(result: true);
      // } else {
      //   Get.offAllNamed(Routes.dashboard, arguments: 1);
      // }
      Get.back();
    }, onError: (error) {
      Get.dialog(
        AlertDialog(
          title: const Text('Ocorreu um erro'),
          content: Text(error.toString()),
        ),
      );
    });
  }
}
