import 'dart:convert';

import 'package:get/get.dart';

import '../models/composable.dart';
import '../models/exercise.dart';
import '../services/firebase.dart';

class HomeController extends GetxController {

  RxList<Exercise> exercises = RxList<Exercise>([]);

  RxInt currentTab = RxInt(0);

  @override
  void onInit() {
    // addExample();
    getExercise();
    super.onInit();
  }


  Future<void> getExercise() async {

    final snapshot = await exercisesRef.get();
    if (snapshot.exists) {
      for (var element in snapshot.children) {
        final values = jsonDecode(jsonEncode(element.value)) as Map<String, dynamic>;

        Exercise exercise = Exercise.fromJson(values);
        exercise.path = element.key;

        exercises.add(exercise);
      }
      exercises.refresh();
    }
  }

  Future<void> addExample() async {

    Composable composable1 = Composable(name: "Khởi Động", content: "Version 3.0.x has breaking changes, please review changelog and documentation. UuidValue is still Experimental and the API for it is in flux, please pay attention to changelogs and versions.", avatar: "", time: "20 M");
    Composable composable2 = Composable(name: "Đẩy Tạ Sau Gáy", content: "Version 3.0.x has breaking changes, please review changelog and documentation. UuidValue is still Experimental and the API for it is in flux, please pay attention to changelogs and versions.", avatar: "", time: "20 M");
    Composable composable3 = Composable(name: "Nâng Tạ", content: "Version 3.0.x has breaking changes, please review changelog and documentation. UuidValue is still Experimental and the API for it is in flux, please pay attention to changelogs and versions.", avatar: "", time: "20 M");
    Composable composable4 = Composable(name: "Múa Quạt", content: "Version 3.0.x has breaking changes, please review changelog and documentation. UuidValue is still Experimental and the API for it is in flux, please pay attention to changelogs and versions.", avatar: "", time: "20 M");
    Composable composable5 = Composable(name: "Sờ Quoát", content: "Version 3.0.x has breaking changes, please review changelog and documentation. UuidValue is still Experimental and the API for it is in flux, please pay attention to changelogs and versions.", avatar: "", time: "20 M");


    Exercise exercise = Exercise(name: "Tập Tạ", level: "Khó Thực Hiện", content: "content", avatar: "", composables: [composable1, composable2, composable3, composable4, composable5]);

    exercisesRef.push().set(exercise.toJson());
  }
}