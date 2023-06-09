import 'package:app_hortifruti/app/data/models/user.dart';
import 'package:app_hortifruti/app/data/models/user_profile_request.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/modules/user_profile/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserProfileController extends GetxController with StateMixin<UserModel> {
  final UserProfileRepository _repository;
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

  UserProfileController(this._repository);

  @override
  void onInit() {
    _repository.getUser().then((data) {
      nameController.text = data.name;
      emailController.text = data.email;
      phoneController.text = data.phone;

      change(data, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error());
    });
    super.onInit();
  }

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

    _repository.putUser(userProfileRequest).then(
      (value) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
          const SnackBar(content: Text('Dados do perfil atualizado')),
        );
        passwordController.text = '';
      },
      onError: (error) => Get.dialog(
        AlertDialog(
          title: Text(error.toString()),
        ),
      ),
    );
  }

  void logout() async {
    await _authService.logout();
    Get.offAllNamed(Routes.dashboard);
  }
}
