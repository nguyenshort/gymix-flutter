import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicator/progress_indicator.dart';

import '../../controllers/composable.controller.dart';
import '../../theme/color.dart';

class ComposableSlide extends StatefulWidget {
  const ComposableSlide({Key? key}) : super(key: key);

  @override
  State<ComposableSlide> createState() => _ComposableSlideState();
}

class _ComposableSlideState extends State<ComposableSlide> {

  final ComposableController c = Get.find<ComposableController>(tag: 'composable-${Get.arguments["id"]}');

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Obx(() => c.ready.isFalse ? Container() : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: c.exercise.value!.composables.asMap().map((key, value) => MapEntry(key,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                        width: 10,
                        height: 10,
                        color: c.currentStep.value == key ? kPrimaryColor : Colors.grey
                    ),
                  ),
                )
            )).values.toList()
        )),

        const SizedBox(height: 100),

        Obx(() => c.ready.isFalse ? Container() : CarouselSlider(
          options: CarouselOptions(
              enlargeCenterPage: true,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              initialPage: c.currentStep.value,
              onPageChanged: (int index, CarouselPageChangedReason reason) {
                if (kDebugMode) {
                  c.currentStep.value = index;
                }
              }
          ),
          carouselController: _controller,
          items: c.exercise.value?.composables.asMap().map(
                  (key, value) => MapEntry(key, Column(
                children: [
                  CachedNetworkImage(imageUrl: "https://i.imgur.com/W7oZwHy.png", height: 200)
                ],
              ))).values.toList(),
        )),

        const SizedBox(height: 20),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() => c.ready.isFalse ? Container() : Column(
            children: [

              Text(c.exercise.value!.composables[c.currentStep.value].name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),

              const SizedBox(height: 5),

              Text(c.exercise.value!.composables[c.currentStep.value].time, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),

              const SizedBox(height: 5),

              Text(
                  c.exercise.value!.composables[c.currentStep.value].content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(height: 1.5, color: Colors.grey)
              ),


              Obx(() => c.$bookmarked ? _ComposableCounter(controller: _controller) : Container())

            ],
          )),
        )

      ],
    );
  }
}

class _ComposableCounter extends StatelessWidget {
  _ComposableCounter({Key? key, required this.controller}) : super(key: key);


  final ComposableController c = Get.find<ComposableController>(tag: 'composable-${Get.arguments["id"]}');

  final CarouselController controller;


  String formatedTime(int secTime) {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int min = secTime ~/ 60;
    int sec = secTime % 60;

    String parsedTime =
        getParsedTime(min.toString()) + " : " + getParsedTime(sec.toString());

    return parsedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Obx(() => AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: c.started.isFalse ? 1 : 0.5,
              child: ClipRRect(
                child: GestureDetector(
                  child: Container(
                    color: kPrimaryColor,
                    child: const Text('B???t ?????u', style: TextStyle(color: Colors.white)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                  onTap: () {

                    if(c.$bookmarked && c.started.isFalse) {

                      c.startTimer();

                    }

                  },
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            )),


            Stack(
              children: [

                SizedBox(
                  height: 50,
                  width: 100,
                  child: Center(
                    child: Obx(() => c.started.isTrue ? Text('${formatedTime(c.countTime.value)}s') : const Text('') ),
                  ),
                )

              ],
            ),

            Obx(
                    () => AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: c.started.isTrue ? 1 : 0.5,
                  child: ClipRRect(
                    child: GestureDetector(
                      onTap: () {
                        if(c.started.isTrue && c.$bookmarked) {
                          c.clearTimer();
                          c.doneAction();
                        }
                      },
                      child: Container(
                        color: kPrimaryColor,
                        child: const Text('Ho??n Th??nh', style: TextStyle(color: Colors.white)),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
            )

          ],
        ),


        SizedBox(
            width: 170,
            height: 170,
            child: Stack(
              children: [

                Obx(() => CircularProgress(
                  percentage: (c.currentStep.value / (c.exercise.value!.composables.length - 1)) * 100,
                  color: Colors.amber,
                  backColor: Colors.grey.withOpacity(0.5),
                  gradient: LinearGradient(colors: [kPrimaryColor.withOpacity(0.9), kPrimaryColor.withOpacity(0.9)]),
                  showPercentage: false,
                  stroke: 7,
                  round: true,
                )),

                Center(
                    child: Obx(() => c.currentStep.value + 1 == c.exercise.value?.composables.length
                        ? const Icon(Icons.check, color: kPrimaryColor, size: 35)
                        : IconButton(
                        onPressed: () {
                          controller.nextPage();
                        },
                        icon: const Icon(Icons.arrow_forward, color: kPrimaryColor, size: 35)
                    )
                    )
                )

              ],
            )
        )
      ],
    );
  }
}
