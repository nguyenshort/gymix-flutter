import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymix/controllers/home.controller.dart';
import 'package:gymix/view/composable_view.dart';

class HomeExercises extends StatelessWidget {
  HomeExercises({Key? key}) : super(key: key);

  final HomeController c = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => Get.toNamed(ComposableView.route, arguments: { "id": c.exercises[index].path }),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            color: Colors.lightBlueAccent.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        c.exercises[index].name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                    ),
                    const SizedBox(height: 10),
                    Text(c.exercises[index].level, style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 10),
                    Text("${c.exercises[index].count} Bài Tập", style: const TextStyle(fontSize: 14, color: Colors.grey))
                  ],
                ),

                const Spacer(),

                CachedNetworkImage(imageUrl: "https://i.imgur.com/W7oZwHy.png", height: 100)
              ],
            ),
          ),
        ),
      ),
      itemCount: c.exercises.length,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 25),
    ));
  }
}
