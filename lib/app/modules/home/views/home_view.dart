import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';
import 'package:tvent/app/modules/home/widgets/carrousel_event.dart';
import 'package:tvent/app/modules/home/widgets/category_list.dart';
import 'package:tvent/app/modules/home/widgets/countdown.dart';
import 'package:tvent/app/modules/home/widgets/event_carousel.dart';
import 'package:tvent/app/modules/home/widgets/new_event.dart';
import 'package:tvent/app/modules/home/widgets/top_widget.dart';
import 'package:tvent/app/widget/global_refresh.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  @override
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: GlobalRefreshWidget(
        child: ListView(
          children: [
            TopWidget(textItems: controller.textItems),
            CardList(),
            CategoryWidget(),
            CountdownTimerWidget(
              targetDate: DateTime.now().add(const Duration(days: 0)),
            ),
            CarouselImageWidget(),
            EventCarousel(),
            const SizedBox(height: 100.0),
            const Center(
              child: Text(
                "©2023 CONST - All Right Reserved",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
