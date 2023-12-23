import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';

class TopWidget extends StatelessWidget {
  final List<String> textItems;
  final HomeController homeController = Get.find();

  TopWidget({super.key, required this.textItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          buildAppBar(context),
          TopWidgetSlider(textItems: textItems),
          Divider(
            thickness: 2,
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    String formattedDate = DateFormat("MMM, d EEEE").format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Expanded(
                flex: 1,
                child: Text.rich(
                  TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: "Hi! Welcome ",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: homeController.user.value?.name ?? "Guest",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      TextSpan(
                        text: "\n$formattedDate",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 104, 102, 102),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}

class TopWidgetSlider extends StatelessWidget {
  final List<String> textItems;

  TopWidgetSlider({required this.textItems});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      disableGesture: true,
      options: CarouselOptions(
        height: 30,
        viewportFraction: 1.0,
        scrollDirection: Axis.vertical,
        autoPlay: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
      itemCount: textItems.length,
      itemBuilder: (context, index, realIndex) {
        final textItem = textItems[index];
        return buildTextItem(textItem, context);
      },
    );
  }

  Widget buildTextItem(String text, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Text(
        text,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 14.0,
            fontWeight: FontWeight.w200),
      ),
    );
  }
}
