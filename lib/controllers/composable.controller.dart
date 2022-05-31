import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymix/models/bookmark.dart';
import 'package:gymix/models/exercise.dart';

import '../services/firebase.dart';
import '../theme/color.dart';

class ComposableController extends GetxController {

  final FirebaseAuth auth = FirebaseAuth.instance;

  RxBool ready = RxBool(false);
  Rx<Exercise?> exercise = Rx<Exercise?>(null);
  RxInt currentStep = RxInt(0);

  Rx<Bookmark?> bookmark = Rx<Bookmark?>(null);
  bool get $bookmarked {
    return bookmark.value != null;
  }
  RxBool bookmarking = RxBool(false);

  TimeOfDay initialTime = TimeOfDay.now();

  RxBool started = RxBool(false);
  RxInt countTime = RxInt(0);
  Timer? timer;

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

      DataSnapshot data = await bookmarksRef.child(auth.currentUser!.uid).child(Get.arguments["id"]).get();

      if(data.exists) {
        final values = jsonDecode(jsonEncode(data.value)) as Map<String, dynamic>;
        bookmark.value = Bookmark.fromJson(values);
      } else {
        bookmark.value = null;
      }

      bookmark.refresh();

    } catch (_) {}
  }

  Future<void> toogleBookmark() async {
    if(bookmarking.isTrue) {
      return;
    }
    bookmarking.value = true;
    if($bookmarked) {
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

      await bookmarksRef.child(auth.currentUser!.uid).child(Get.arguments["id"]).set(
        {
          /*"exercise": exercise.value?.toJson(),*/
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
      await bookmarksRef.child(auth.currentUser!.uid).child(Get.arguments["id"]).remove();
      Get.rawSnackbar(message: "Tạo thao tác", animationDuration: const Duration(milliseconds: 300), backgroundColor: kPrimaryColor);
      await checkBookmark();
    } catch (_) {}
  }

  void clearTimer() {
    started.value = false;
    timer?.cancel();
    countTime.value = 0;
  }

  void startTimer() {
    if(started.value) {
      return;
    }
    // runs every 1 second
    started.value = true;
    countTime.value = 0;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      countTime.value = timer.tick;
    });

  }

  Future<void> doneAction() async {
    await bookmarksRef.child(auth.currentUser!.uid).child(Get.arguments["id"]).set(
        {
          "time": bookmark.value!.time,
          "done": true
        }
    );

    Get.rawSnackbar(message: "Đã hoàn thành bài tập", animationDuration: const Duration(milliseconds: 300), backgroundColor: kPrimaryColor);

    await checkBookmark();
  }

}