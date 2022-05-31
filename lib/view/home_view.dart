import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymix/components/home/home_bottom_bar.dart';
import 'package:gymix/components/home/home_exercises.dart';
import 'package:gymix/controllers/home.controller.dart';

import '../components/home/setting_tab.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  static String route = '/';

  final HomeController c = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() => c.currentTab.value == 0 ? const _HomeTab() : SettingTab()),
      ),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Hi Yuan", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                  SizedBox(height: 5),
                  Text("Don't Miss The Fitness!")
                ],
              ),

              const Spacer(),

              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CachedNetworkImage(
                    imageUrl: "https://avatars.githubusercontent.com/u/909802",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              )

            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: const [
                      Text("Paractice", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                      Spacer()
                    ],
                  ),

                  const SizedBox(height: 20),

                  HomeExercises(),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _BookmarkTab extends StatelessWidget {
  const _BookmarkTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


