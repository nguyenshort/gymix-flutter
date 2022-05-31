import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymix/models/exercise.dart';

import '../services/firebase.dart';
import '../theme/color.dart';

class ComposableController extends GetxController {

  RxBool ready = RxBool(false);
  Rx<Exercise?> exercise = Rx<Exercise?>(null);
  RxInt currentStep = RxInt(0);

  RxBool bookmarked = RxBool(false);
  RxBool bookmarking = RxBool(false);

  TimeOfDay initialTime = TimeOfDay.now();

  @override
  void onInit() {
    getExercise();
    super.onInit();
  }


  @override
  void onReady() {
    checkBookmark();
    super.onReady();
  }

  Future<void> getExercise() async {
    try {
      final data = await exercisesRef.child(Get.arguments["id"]).get();

     if(data.exists) {

       final values = jsonDecode(jsonEncode(data.value)) as Map<String, dynamic>;
       exercise.value = Exercise.fromJson(values);

       exercise.refresh();
       ready.value = true;

     }

    } catch (_) {}
  }

  Future<void> checkBookmark() async {
    try {

      DataSnapshot data = await bookmarksRef.child(Get.arguments["id"]).get();

      bookmarked.value = data.exists;
      bookmarked.refresh();

    } catch (_) {}
  }

  Future<void> toogleBookmark() async {
    if(bookmarking.isTrue) {
      return;
    }
    bookmarking.value = true;
    if(bookmarked.isTrue) {
      removeBookmark();
    } else {
      // addBookmark();

      DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
      );
      if(pickedDate != null) {

        TimeOfDay? pickedTime = await showTimePicker(
          context: Get.context!,
          initialTime: TimeOfDay.now()
        );

        if(pickedTime != null) {

          final time = pickedDate.toString().split(' ').first + ' ';

          final hour = pickedTime.hour < 10 ? '0${pickedTime.hour}' : '${pickedTime.hour}';
          final minute = pickedTime.minute < 10 ? '0${pickedTime.minute}' : '${pickedTime.minute}';

          await addBookmark(time + '$hour:$minute');
          await checkBookmark();

        }

      }
    }
    bookmarking.value = false;
  }

  Future<void> addBookmark(String time) async {
    try {

      await bookmarksRef.child(Get.arguments["id"]).set(
        {
          "exercise": exercise.value?.toJson(),
          "time": time,
          "done": false
        }
      );

      Get.rawSnackbar(message: "Tạo thao tác", animationDuration: const Duration(milliseconds: 300), backgroundColor: kPrimaryColor);

      await checkBookmark();

    } catch (_) {
      print(_);
    }
  }

  Future<void> removeBookmark() async {
    try {
      await bookmarksRef.child(Get.arguments["id"]).remove();
      Get.rawSnackbar(message: "Tạo thao tác", animationDuration: const Duration(milliseconds: 300), backgroundColor: kPrimaryColor);
      await checkBookmark();
    } catch (_) {}
  }

}