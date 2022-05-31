import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymix/components/composable/composable_alert.dart';

import '../components/composable/composable_slide.dart';
import '../controllers/composable.controller.dart';
import '../theme/color.dart';

class ComposableView extends StatelessWidget {
  ComposableView({Key? key}) : super(key: key);

  static String route = '/composable';

  final ComposableController c = Get.find<ComposableController>(tag: 'composable-${Get.arguments["id"]}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text( c.ready.isTrue ? c.exercise.value!.name : "")),
          centerTitle: false,
          elevation: 0,
          backgroundColor: kPrimaryColor,

          leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back)),

          actions: [

            IconButton(onPressed: () => c.toogleBookmark(), icon: Obx(() => c.$bookmarked ? const Icon(Icons.check) : const Icon(Icons.bookmark)))

          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height: 20),

                ComposableAlert(),

                const SizedBox(height: 50),

                const ComposableSlide()

              ],
            ),
          ),
        )
    );
  }
}
