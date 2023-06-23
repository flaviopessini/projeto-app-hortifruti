import 'package:app_painel_hortifruti/app/data/services/storage/service.dart';
import 'package:app_painel_hortifruti/app/modules/dashboard/binding.dart';
import 'package:app_painel_hortifruti/app/modules/dashboard/page.dart';
import 'package:app_painel_hortifruti/app/modules/login/binding.dart';
import 'package:app_painel_hortifruti/app/modules/login/page.dart';
import 'package:app_painel_hortifruti/app/modules/order/binding.dart';
import 'package:app_painel_hortifruti/app/modules/order/page.dart';
import 'package:app_painel_hortifruti/app/modules/product/binding.dart';
import 'package:app_painel_hortifruti/app/modules/product/page.dart';
import 'package:app_painel_hortifruti/app/modules/store/binding.dart';
import 'package:app_painel_hortifruti/app/modules/store/page.dart';
import 'package:app_painel_hortifruti/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
      middlewares: [
        RedirectMiddleware(),
      ],
    ),
    GetPage(
      name: Routes.store,
      page: () => const StorePage(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: Routes.product,
      page: () => const ProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.order,
      page: () => const OrderPage(),
      binding: OrderBinding(),
    ),
  ];
}

class RedirectMiddleware extends GetMiddleware {
  /// Verifica na memória interna se o usuário já selecionou a cidade alguma vez.
  /// Se não houver a informação guardada na memória, então direciona o usuário
  /// para a tela de selecionar cidade antes de prosseguir.
  @override
  RouteSettings? redirect(String? route) {
    return Get.find<StorageService>().token != null
        ? null
        : const RouteSettings(name: Routes.login);
  }
}
