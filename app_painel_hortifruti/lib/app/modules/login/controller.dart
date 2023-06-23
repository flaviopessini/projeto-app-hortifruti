import 'package:app_painel_hortifruti/app/data/models/user_login_request.dart';
import 'package:app_painel_hortifruti/app/data/services/auth/service.dart';
import 'package:app_painel_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final isLoading = RxBool(false);
  final _authService = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();
  var emailController =
      TextEditingController(text: 'pastelaria_catanduva@email.com');
  var passwordController = TextEditingController(text: '12345678');

  void login() {
    isLoading.value = true;
    Get.focusScope!.unfocus();
    if (!formKey.currentState!.validate()) {
      return;
    }
    final userLogin = UserLoginRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    _authService.login(userLogin).then((value) {
      isLoading.value = false;
      Get.offAllNamed(Routes.dashboard);
    }, onError: (error) {
      isLoading.value = false;
      Get.dialog(
        AlertDialog(
          title: const Text('Ocorreu um erro'),
          content: Text(error.toString()),
        ),
      );
    });
  }
}
