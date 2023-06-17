import 'package:app_hortifruti/app/data/models/address.dart';
import 'package:app_hortifruti/app/modules/user_address_list/repository.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressListController extends GetxController
    with StateMixin<List<AddressModel>> {
  final UserAddressListRepository _repository;

  UserAddressListController(this._repository);

  @override
  void onInit() {
    fetchAddresses();
    super.onInit();
  }

  Future<void> fetchAddresses() {
    return _repository.getUserAddress().then((value) {
      change(value, status: RxStatus.success());
    }, onError: (error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void goToNewAddress() async {
    final result = await Get.toNamed(Routes.userAddress);
    if (result is bool && result) {
      fetchAddresses();
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        if (Get.isDialogOpen != null && Get.isDialogOpen!) {
          Get.until((route) => !Get.isDialogOpen!);
        }
      });
    }
  }

  void goToEditAddress(AddressModel address) async {
    final result = await Get.toNamed(Routes.userAddress, arguments: address);
    if (result is bool && result) {
      fetchAddresses();
      Future.delayed(const Duration(milliseconds: 500)).then((_) {
        if (Get.isDialogOpen != null && Get.isDialogOpen!) {
          Get.until((route) => !Get.isDialogOpen!);
        }
      });
    }
  }

  void deleteAddress(AddressModel address) async {
    try {
      await _repository.deleteAddress(address.id);
      await fetchAddresses();
      ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
        const SnackBar(
          content: Text('Endereço apagado.'),
        ),
      );
    } catch (error) {
      Get.dialog(
        AlertDialog(
          title: Text(error.toString()),
        ),
      );
    }
  }
}
