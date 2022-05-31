import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymix/controllers/home.controller.dart';
import 'package:gymix/theme/color.dart';

class HomeBottomBar extends StatelessWidget {
  HomeBottomBar({Key? key}) : super(key: key);

  final HomeController c = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      backgroundColor: Colors.white,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
        ),
      ],
      currentIndex: c.currentTab.value,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.grey,
      onTap: (int index) => c.currentTab.value = index,
    ));
  }
}
