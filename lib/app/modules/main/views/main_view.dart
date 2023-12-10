import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Obx(() => controller.widgetOption.elementAt(controller.selctedIndex.value)),
      body: createPageView(controller),
      bottomNavigationBar: createBottombar(controller),
    );
  }
}

Obx createPageView(MainController controller) {
    return Obx(() =>
      PageView.builder(
        clipBehavior: Clip.none,
        controller: controller.pageController.value,
        onPageChanged: controller.onPageChanged,
        itemCount: controller.widgetOption.length,
        itemBuilder: (context, index) {
          final item = controller.widgetOption[index];
          return item();
        },
      ),
    );
  }

Obx createBottombar(MainController controller) {
    return Obx(() =>
      ClipRRect(
        borderRadius: controller.borderRadius,
        child: BottomNavigationBar(
          backgroundColor: controller.backgroundColor,
          items: controller.navBar,
          iconSize: controller.iconSize,
          selectedItemColor: controller.selectedItemColor,
          unselectedItemColor: controller.unselectedItemColor,
          currentIndex: controller.selctedIndex.value,
          onTap: controller.onItemTapped,
        ),
      ),
    );
  }
