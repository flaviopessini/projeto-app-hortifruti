import 'package:app_hortifruti/app/modules/user_address_list/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddressListPage extends GetView<UserAddressListController> {
  const UserAddressListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.colorScheme.inversePrimary,
        title: const Text('Meus endereços'),
      ),
      body: SafeArea(
        child: controller.obx(
          (state) => SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: OutlinedButton(
                      onPressed: controller.goToNewAddress,
                      child: const Text('Cadastrar um endereço'),
                    ),
                  ),
                ),
                if (state!.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 32.0, horizontal: 16.0),
                      child:
                          Text('Você não possui nenhum endereço cadastrado.'),
                    ),
                  )
                else
                  for (var addr in state)
                    ListTile(
                      title: Text('${addr.street}, ${addr.number}'),
                      subtitle: Text(
                          '${addr.neighborhood}, ${addr.city!.name} - ${addr.city!.uf}'),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: const Text('Editar'),
                            onTap: () {},
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: const Text('Excluir'),
                            onTap: () {},
                          ),
                        ],
                        onSelected: (value) {
                          switch (value) {
                            case 'edit':
                              controller.goToEditAddress(addr);
                              break;
                            case 'delete':
                              controller.deleteAddress(addr);
                              break;
                            default:
                              break;
                          }
                        },
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
