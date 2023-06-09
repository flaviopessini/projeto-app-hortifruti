import 'package:app_hortifruti/app/modules/register/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Registre-se'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                        ),
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Informe seu nome';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                        ),
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Informe seu e-mail';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller.phoneController,
                        decoration: const InputDecoration(
                          labelText: 'Telefone',
                        ),
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          controller.phoneMask,
                        ],
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Informe seu telefone';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller.passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                        ),
                        maxLines: 1,
                        obscureText: true,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value != null && value.trim().length < 8) {
                            return 'Senha deve conter pelo menos 8 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32.0),
                      ElevatedButton.icon(
                        onPressed: controller.submit,
                        icon: const Icon(Icons.check_rounded),
                        label: const Text('Salvar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
