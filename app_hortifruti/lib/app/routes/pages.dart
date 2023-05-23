import 'package:app_hortifruti/app/modules/dashboard/binding.dart';
import 'package:app_hortifruti/app/modules/dashboard/page.dart';
import 'package:app_hortifruti/app/routes/routes.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
  ];
}
