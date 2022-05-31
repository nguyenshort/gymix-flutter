import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymix/services/auth_service.dart';
import 'package:gymix/view/auth_view.dart';

class AuthMiddleware extends GetMiddleware {

  AuthService appService = Get.find<AuthService>();

  @override
  redirect(String? route) {
    return !appService.$auth && route != AuthView.route ? RouteSettings(name: AuthView.route) : null;
  }
}