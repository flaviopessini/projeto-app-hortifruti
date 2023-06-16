import 'package:app_hortifruti/app/data/models/address.dart';
import 'package:app_hortifruti/app/data/models/city.dart';
import 'package:app_hortifruti/app/data/models/user_address_request.dart';
import 'package:app_hortifruti/app/modules/user_address/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressController extends GetxController
    with StateMixin<List<CityModel>> {
  final UserAddressRepository _repository;

  final cityId = RxnInt();

  final formKey = GlobalKey<FormState>();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final neighborhoodController = TextEditingController();
  final referencePointController = TextEditingController();
  final complementController = TextEditingController();
  final cepController = TextEditingController();
  final _addressToEdit = Rxn<AddressModel>();
  final isEditing = RxBool(false);

  UserAddressController(this._repository);

  @override
  void onInit() {
    if (Get.arguments != null) {
      isEditing(true);
      _addressToEdit.value = Get.arguments;

      streetController.text = _addressToEdit.value!.street;
      numberController.text = _addressToEdit.value!.number;
      neighborhoodController.text = _addressToEdit.value!.neighborhood;
      referencePointController.text = _addressToEdit.value!.referencePoint;
      complementController.text = _addressToEdit.value!.complement ?? '';
      cityId.value = _addressToEdit.value!.city!.id;
      //cepController.text = _addressToEdit.value!
      //cityId.value = _addressToEdit.value!.cityId;
    }

    _repository.getCities().then((data) {
      if (data.isEmpty) {
        change(null, status: RxStatus.empty());
      }
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

    final address = UserAddressRequestModel(
      id: isEditing.isTrue ? _addressToEdit.value!.id : null,
      street: streetController.text.trim(),
      number: numberController.text.trim(),
      neighborhood: neighborhoodController.text.trim(),
      referencePoint: referencePointController.text.trim(),
      complement: complementController.text.trim(),
      cep: cepController.text.trim(),
      cityId: cityId.value!,
    );

    // Novo
    if (isEditing.isFalse) {
      _add(address);
    } else {
      // Editando
      return _edit(address);
    }
  }

  void _add(UserAddressRequestModel address) {
    _repository.postAddress(address).then(
      (value) {
        ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
            const SnackBar(content: Text('Novo endereço cadastrado')));

        Get.back(result: true);
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

  void _edit(UserAddressRequestModel address) {
    _repository.putAddress(address).then(
      (value) {
        ScaffoldMessenger.of(Get.overlayContext!)
            .showSnackBar(const SnackBar(content: Text('Endereço atualizado')));

        Get.back(result: true);
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
