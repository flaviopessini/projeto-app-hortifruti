import 'package:app_hortifruti/app/data/models/city.dart';
import 'package:app_hortifruti/app/data/models/user_address_request.dart';
import 'package:app_hortifruti/app/data/services/auth/service.dart';
import 'package:app_hortifruti/app/modules/user_address/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressController extends GetxController
    with StateMixin<List<CityModel>> {
  final UserAddressRepository _repository;
  final _authService = Get.find<AuthService>();

  final cityId = RxnInt();

  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final referencePointController = TextEditingController();
  final complementController = TextEditingController();
  final cepController = TextEditingController();

  UserAddressController(this._repository);

  @override
  void onInit() {
    _repository.getCities().then((data) {
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
    final address = UserAddressRequestModel(
      street: streetController.text.trim(),
      number: numberController.text.trim(),
      neighborhood: neighborhoodController.text.trim(),
      referencePoint: referencePointController.text.trim(),
      complement: complementController.text.trim(),
      cep: cepController.text.trim(),
      cityId: cityId.value!,
    );

    _repository.postAddress(address).then(
      (value) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
            const SnackBar(content: Text('Novo endereço cadastrado')));
      },
      onError: (error) => Get.dialog(
        AlertDialog(
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Fechar'),
            ),
          ],
          title: const Text('Erro'),
          content: Text(error.toString()),
        ),
      ),
    );
  }
}
