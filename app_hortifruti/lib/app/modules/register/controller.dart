import 'package:app_hortifruti/app/data/models/user.dart';
import 'package:app_hortifruti/app/data/models/user_login_request.dart';
import 'package:app_hortifruti/app/data/models/user_profile_request.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/modules/register/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterController extends GetxController {
  final RegisterRepository _repository;
  final _authService = Get.find<AuthService>();

  final cityId = RxnInt();

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  RegisterController(this._repository);

  void changeCity(int? selectedId) {
    cityId.value = selectedId;
  }

  void submit() {
    Get.focusScope!.unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    final userProfileRequest = UserProfileRequestModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    _repository.register(userProfileRequest).then(
      (value) {
        passwordController.text = '';
        // ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
        //   const SnackBar(content: Text('Registrado com sucesso.')),
        // );

        _authService
            .login(
          UserLoginRequestModel(
            email: userProfileRequest.email,
            password: userProfileRequest.password!,
          ),
        )
            .then(
          (_) async {
            await Get.dialog(
              AlertDialog(
                title: const Text('Registrado'),
                content: const Text(
                    'Sua conta foi criada com sucesso e agora você será direcionado para a página inicial.'),
                actions: [
                  TextButton(
                    onPressed: () => Get.offAllNamed(Routes.dashboard),
                    child: const Text('Ok'),
                  ),
                ],
              ),
              barrierDismissible: false,
            );
          },
        );
      },
      onError: (error) => Get.dialog(
        AlertDialog(
          title: Text(error.toString()),
        ),
      ),
    );
  }
}
