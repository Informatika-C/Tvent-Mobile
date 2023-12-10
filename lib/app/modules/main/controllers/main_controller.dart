import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/routes/app_nav.dart';

class MainController extends GetxController {
  final pageController = PageController().obs;
  final selctedIndex = 0.obs;

  final widgetOption = NavPages.route;
  final navBar = NavPages.navBar;

  final borderRadius = const BorderRadius.only(
    topRight: Radius.circular(24),
    topLeft: Radius.circular(24),
  );
  final iconSize = 40.0;
  final backgroundColor = Colors.white;
  final selectedItemColor = Colors.yellow[800];
  final unselectedItemColor = Colors.grey[800];

  void onItemTapped(int index) {
    pageController.value.jumpToPage(index);
    selctedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
