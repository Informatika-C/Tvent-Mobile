import 'dart:ui';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/widget/drawer.dart';
import 'package:tvent/app/widget/overlay.dart';
import '../../../routes/app_nav.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  MainView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    Get.put(HomeController());
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Obx(() {
          final int currentIndex = controller.selctedIndex.value;
          return Text(NavPages.titles[currentIndex]);
        }),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.diceD20),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return CustomPopupMenu(
                currentIndex: controller.selctedIndex.value,
                controller: controller,
              );
            },
          ),
        ],
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
        padding: const EdgeInsets.only(bottom: 1.2),
        child: CrystalNavigationBar(
          backgroundColor: const Color(0xfff2f2f2).withOpacity(0.3),
          splashBorderRadius: 18,
          borderRadius: 26,
          paddingR: const EdgeInsets.all(2),
          outlineBorderColor: const Color(0xfff2f2f2),
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
