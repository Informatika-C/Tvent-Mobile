import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/routes/app_nav.dart';
import 'package:tvent/app/routes/app_pages.dart';

import '../../../../services/auth_services.dart';

class MainController extends GetxController {
  final pageController = PageController().obs;
  final selctedIndex = 0.obs;

  final widgetOption = NavPages.route;
  final navBar = NavPages.navBar;
  final user = Get.find<AuthServices>().user;
  final borderRadius = const BorderRadius.only(
    topRight: Radius.circular(24),
    topLeft: Radius.circular(24),
  );
  final iconSize = 40.0;

  void onItemTapped(int index) {
    pageController.value.jumpToPage(index);
    selctedIndex.value = index;
  }

  Future<void> logout(String username) async {
    bool? confirmLogout = await Get.dialog<bool?>(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
          decoration: BoxDecoration(
            color: Colors.white,
            image: const DecorationImage(
              image: AssetImage("assets/images/polygons.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Konfirmasi Logout",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Is $username sure want to logout?",
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10.0),
              const Center(
                child: Icon(
                  FontAwesomeIcons.faceSadTear,
                  color: Colors.black,
                  size: 60,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await performLogout();
                      Get.back(result: true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFFE67E22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                    ),
                    child: const Text(
                      "Batal",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmLogout ?? false) {
      await performLogout();
    } else {
      // Get.back(result: false);
    }
  }

  Future<void> performLogout() async {
    // resetUserData();
    // removeToken();
    await Get.offAllNamed(Routes.AUTH);
  }

  void resetUserData() {
    //  reset data user
  }

  void removeToken() {
    // delete token
  }
  void onPageChanged(int index) {
    print('Current Index: $index');
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
