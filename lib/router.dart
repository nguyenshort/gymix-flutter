import 'package:get/get.dart';
import 'package:gymix/controllers/auth.controller.dart';
import 'package:gymix/controllers/home.controller.dart';
import 'package:gymix/view/auth_view.dart';
import 'package:gymix/view/home_view.dart';
import 'package:gymix/view/composable_view.dart';

import 'controllers/composable.controller.dart';
import 'middlewares/auth.middleware.dart';

class RouteGenerator {
  static List<GetPage> routes = [
    GetPage(
        name: AuthView.route,
        page: () => AuthView(),
        binding: AuthBinding()
    ),
        // middlewares: [WelcomeMiddleware()])
    GetPage(name: HomeView.route, page: ()=> HomeView(), binding: HomeBinding(), middlewares: [AuthMiddleware()]),
    GetPage(name: ComposableView.route, page: ()=> ComposableView(), binding: ComposableBinding(), middlewares: [AuthMiddleware()]),
  ];
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
  }
}

class ComposableBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ComposableController>(ComposableController(), tag: 'composable-${Get.arguments["id"]}');
  }
}