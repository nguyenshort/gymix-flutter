import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gymix/models/user_data.dart';

import 'firebase.dart';

class AuthService extends GetxService {

  Rx<User?> user = Rx<User?>(null);
  bool get $auth {
    return user.value != null;
  }

  Rx<UserData?> info  = Rx<UserData?>(null);
  Rx<UserData?> formData  = Rx<UserData?>(null);

  final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<AuthService> init() async {
    AuthService _auth = AuthService();
    _auth.getUser();
    return _auth;
  }

  Future<void> getUser() async {

    // FirebaseAuth.instance.signOut();

    user.value = auth.currentUser;

    user.refresh();

    if($auth) {
      getUserInfo();
    }

  }

  Future<void> getUserInfo() async {
    final _data = await userRef.child(auth.currentUser!.uid).get();
    if(_data.exists) {
      final values = jsonDecode(jsonEncode(_data.value)) as Map<String, dynamic>;
      info.value = UserData.fromJson(values);
      formData.value = UserData.fromJson(values);
    }
    //info.value = UserData.fromJson(_data);
  }


  Future<void> updateUserInfo() async {

    if(!$auth) {
      return;
    }

    try {

      userRef.child(FirebaseAuth.instance.currentUser!.uid).set(formData.value!.toJson());

      Get.rawSnackbar(message: "Cập nhật thành công", animationDuration: const Duration(milliseconds: 300));
    } catch (e) {
      Get.rawSnackbar(message: "Cập nhật thất bại", animationDuration: const Duration(milliseconds: 300));
    }
  }

}