import 'package:app_hortifruti/app/modules/cart/binding.dart';
import 'package:app_hortifruti/app/modules/cart/page.dart';
import 'package:app_hortifruti/app/modules/checkout/binding.dart';
import 'package:app_hortifruti/app/modules/checkout/page.dart';
import 'package:app_hortifruti/app/modules/dashboard/binding.dart';
import 'package:app_hortifruti/app/modules/dashboard/page.dart';
import 'package:app_hortifruti/app/modules/login/binding.dart';
import 'package:app_hortifruti/app/modules/login/page.dart';
import 'package:app_hortifruti/app/modules/order/binding.dart';
import 'package:app_hortifruti/app/modules/order/page.dart';
import 'package:app_hortifruti/app/modules/product/binding.dart';
import 'package:app_hortifruti/app/modules/product/page.dart';
import 'package:app_hortifruti/app/modules/store/binding.dart';
import 'package:app_hortifruti/app/modules/store/page.dart';
import 'package:app_hortifruti/app/modules/user_address/binding.dart';
import 'package:app_hortifruti/app/modules/user_address/page.dart';
import 'package:app_hortifruti/app/modules/user_address_list/binding.dart';
import 'package:app_hortifruti/app/modules/user_address_list/controller.dart';
import 'package:app_hortifruti/app/modules/user_address_list/page.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
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
      name: Routes.cart,
      page: () => const CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: Routes.checkout,
      page: () => const CheckoutPage(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.userAddress,
      page: () => const UserAddressPage(),
      binding: UserAddressBinding(),
    ),
    GetPage(
      name: Routes.userAddressList,
      page: () => const UserAddressListPage(),
      binding: UserAddressListBinding(),
    ),
    GetPage(
      name: Routes.order,
      page: () => const OrderPage(),
      binding: OrderBinding(),
    ),
  ];
}
