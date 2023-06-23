import 'package:app_painel_hortifruti/app/modules/dashboard/controller.dart';
import 'package:app_painel_hortifruti/app/modules/home/page.dart';
import 'package:app_painel_hortifruti/app/modules/order_list/page.dart';
import 'package:app_painel_hortifruti/app/modules/user_profile/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetResponsiveView<DashboardController> {
  DashboardPage({super.key});

  @override
  Widget desktop() {
    return Scaffold(
      body: Obx(
        () => Row(
          children: <Widget>[
            NavigationRail(
              onDestinationSelected: controller.currentPageIndex,
              selectedIndex: controller.currentPageIndex.value,
              groupAlignment: -1,
              labelType: NavigationRailLabelType.all,
              leading: FlutterLogo(
                size: 48,
                style: FlutterLogoStyle.stacked,
              ),
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore),
                  label: Text('Início'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.view_list_outlined),
                  selectedIcon: Icon(Icons.view_list),
                  label: Text('Produtos'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('Configurar'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  @override
  Widget phone() {
    return Scaffold(
      body: Obx(
        () => _buildBody(),
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
              label: 'Produtos',
            ),
            NavigationDestination(
              icon: Icon(Icons.view_list_outlined),
              selectedIcon: Icon(Icons.view_list),
              label: 'Configurar',
            ),
          ],
        ),
      ),
    );
  }

  IndexedStack _buildBody() {
    return IndexedStack(
      index: controller.currentPageIndex.value,
      children: const [
        OrderListPage(),
        HomePage(),
        UserProfilePage(),
      ],
    );
  }
}
