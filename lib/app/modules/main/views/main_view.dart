import 'dart:ui';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import 'package:get/get.dart';
import 'package:tvent/app/widget/drawer.dart';

import '../../../routes/app_nav.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // void _openSideMenu() {
  //   _scaffoldKey.currentState?.openDrawer();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Obx(() {
          final int currentIndex = controller.selctedIndex.value;
          return Text(NavPages.titles[currentIndex]);
        }),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(IconlyBold.filter),
        //   onPressed: () {
        //     _openSideMenu();
        //   },
        // ),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 20),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      // body: Obx(() => controller.widgetOption.elementAt(controller.selctedIndex.value)),
      body: createPageView(controller),
      bottomNavigationBar: createBottombar(controller, context),
      drawerEnableOpenDragGesture: true,
      drawer: AppDrawer(),
      extendBody: true,
    );
  }
}

Obx createPageView(MainController controller) {
  return Obx(
    () => PageView.builder(
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

Obx createBottombar(MainController controller, BuildContext context) {
  return Obx(
    () => ClipRRect(
      borderRadius: controller.borderRadius,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: CrystalNavigationBar(
          backgroundColor: Colors.black.withOpacity(0.1),
          currentIndex: controller.selctedIndex.value,
          onTap: controller.onItemTapped,
          items: NavPages.navBar,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    ),
  );
}
