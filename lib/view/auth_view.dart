import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymix/components/auth/SocialLogin.dart';

import '../components/auth/auth_form.dart';
import '../controllers/auth.controller.dart';
import '../theme/color.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);

  final AuthController c = Get.find<AuthController>();

  static String route = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                    height: 100
                ),
                Obx(() => Text(c.isLogin.isTrue ? 'Đăng Nhập' : 'Đăng Ký', style: const TextStyle(color: kTextColor, fontWeight: FontWeight.w600, fontSize: 25))),

                const SizedBox(
                  height: 30,
                ),

                AuthForm(),

                const SizedBox( height: 5),

                const Text('Quên mật khẩu?', style: TextStyle(color: kTextColor)),


                const SizedBox(
                    height: 100
                ),


                const SocialLogin(),

                const SizedBox(
                    height: 100
                ),


                GestureDetector(
                  onTap: () => c.isLogin.value = !c.isLogin.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Chưa có tài khoản? ', style: TextStyle(color: kTextColor)),
                      Text('Đăng ký', style: TextStyle(color: kTextColor, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),

              ],
            ),
          )
      )
    );
  }
}
