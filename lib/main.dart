import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gymix/router.dart';
import 'package:gymix/services/auth_service.dart';
import 'package:gymix/view/home_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  // Int App, Dio,...
  await Get.putAsync<AuthService>(() => AuthService.init());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      getPages: RouteGenerator.routes,
      initialRoute: HomeView.route
    );
  }
}
