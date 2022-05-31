import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gymix/services/auth_service.dart';
import 'package:gymix/theme/color.dart';
import 'package:gymix/view/home_view.dart';

import '../services/firebase.dart';

class AuthController extends GetxController {
  RxBool isLogin = RxBool(true);

  RxString name = RxString('');
  RxString email = RxString('');
  RxString password = RxString('');

  RxBool loading = RxBool(false);

  AuthService auth = Get.find<AuthService>();

  Future<void> authAction() async {

    if(loading.isTrue) {
      return;
    }

    if(isLogin.isTrue) {
      await signInWithEmailAndPassword();
    } else {
      await createUserWithEmailAndPassword();
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      // Gi thông tin tên credential.user.uid
      await userRef.child(credential.user!.uid).set({
        "name": name.value
      });
      Get.rawSnackbar(message: "Tạo tài khoản thành công", animationDuration: const Duration(milliseconds: 300), backgroundColor: kPrimaryColor);

      await auth.getUser();
      Get.offNamed(HomeView.route);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.rawSnackbar(message: "Mật khẩu quá yếu", animationDuration: const Duration(milliseconds: 300));
      } else if (e.code == 'email-already-in-use') {
        Get.rawSnackbar(message: "Email đã được sử dụng", animationDuration: const Duration(milliseconds: 300));
      }
    } catch (e) {
      Get.rawSnackbar(message: "Đăng nhập thất bại", animationDuration: const Duration(milliseconds: 300));
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      await auth.getUser();
      Get.offNamed(HomeView.route);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.rawSnackbar(message: "Email không tồn tại", animationDuration: const Duration(milliseconds: 300));
      } else if (e.code == 'wrong-password') {
        Get.rawSnackbar(message: "Mật khẩu không đúng", animationDuration: const Duration(milliseconds: 300));
      }
    }
  }

}