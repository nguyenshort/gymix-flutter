import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymix/controllers/composable.controller.dart';
import 'package:gymix/theme/color.dart';

class ComposableAlert extends StatelessWidget {
  ComposableAlert({Key? key}) : super(key: key);

  final ComposableController c = Get.find<ComposableController>(tag: 'composable-${Get.arguments["id"]}');

  @override
  Widget build(BuildContext context) {
    return Obx(() => c.$bookmarked ? Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: double.infinity,
          color: kPrimaryColor,
          child: Text('Bạn có bài tập vào ngày ${c.bookmark.value?.time}', style: const TextStyle(color: Colors.white)),
        ),
      ),
    ) : Container());
  }
}
