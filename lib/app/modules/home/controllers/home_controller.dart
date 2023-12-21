import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/home/models/category_model.dart';
import 'package:tvent/app/modules/home/models/event_model.dart';
import '../../../routes/app_pages.dart';
import '../../../../services/auth_services.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxBool isTitleVisible = true.obs;
  var selectedIndex = 0.obs;
  var itemCount = 10.obs;
  final user = Get.find<AuthServices>().user;

  final List<String> textItems = [
    'Unlock Your Potential!',
    'Discover New Possibilities',
    'Become a Winner',
  ];

  var carouselImages = <String>[
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPWmWrK2Dg1yLToSExBaoHVfztrx131etuZA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPKALbf7w7ejN7njlOstHMOd7fWuguriCssA&usqp=CAU'
  ].obs;

  final List<CategoryModel> categories = [
    CategoryModel("Sport", FontAwesomeIcons.trophy),
    CategoryModel("Academic", FontAwesomeIcons.bookOpenReader),
    CategoryModel("Programming", FontAwesomeIcons.laptopCode),
    CategoryModel("Art", FontAwesomeIcons.palette),
  ].obs;

  final List<EventModel> events = [
    EventModel(
        name: 'Event 1',
        organizer: 'Organizer A',
        description: 'Description for Event 1',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPWmWrK2Dg1yLToSExBaoHVfztrx131etuZA&usqp=CAU',
        authorsImg:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/UNIVERSITASTEKNOKRAT.png/900px-UNIVERSITASTEKNOKRAT.png'),
    EventModel(
        name: 'Event 2',
        organizer: 'Organizer B',
        description: 'Description for Event 2',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQ-996-p95RXfnM6lNcGz-DFl2kIGBn8A2Cw&usqp=CAU',
        authorsImg:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/UNIVERSITASTEKNOKRAT.png/900px-UNIVERSITASTEKNOKRAT.png'),
  ];
  void updateImages(List<String> newImages) {
    carouselImages.assignAll(newImages);
  }

  void setItemCount(int count) {
    itemCount.value = count;
  }

  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(() {
      final double offset = scrollController.offset;
      isTitleVisible.value = offset < 100.0;
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
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
}
