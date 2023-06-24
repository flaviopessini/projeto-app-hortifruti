import 'package:app_painel_hortifruti/app/modules/login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.inversePrimary,
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 400.0,
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                        ),
                        controller: controller.emailController,
                        validator: (value) {
                          if (value != null && !GetUtils.isEmail(value)) {
                            return 'E-mail não é válido!';
                          } else {
                            return null;
                          }
                        },
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                        controller: controller.passwordController,
                        obscureText: true,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 32.0),
                      Obx(() => controller.isLoading.isFalse
                          ? ElevatedButton(
                              onPressed: controller.login,
                              child: const Text('Entrar'))
                          : const Center(
                              child: CircularProgressIndicator(),
                            )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
