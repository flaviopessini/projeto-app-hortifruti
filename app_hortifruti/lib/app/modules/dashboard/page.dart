import 'package:app_hortifruti/app/modules/dashboard/controller.dart';
import 'package:app_hortifruti/app/modules/home/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentPageIndex.value,
          children: [
            HomePage(),
            Text('Meu Perfil'),
            Text('Meus Pedidos'),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: controller.currentPageIndex,
          selectedIndex: controller.currentPageIndex.value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Início',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: 'Meu Perfil',
            ),
            NavigationDestination(
              icon: Icon(Icons.view_list_outlined),
              selectedIcon: Icon(Icons.view_list),
              label: 'Meus Pedidos',
            ),
          ],
        ),
      ),
    );
  }
}
