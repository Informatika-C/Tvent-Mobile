import 'package:dio/dio.dart' as D;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/app/modules/home/models/category_model.dart';
import 'package:tvent/app/modules/home/models/event_model.dart';
import 'package:tvent/app/modules/home/models/home_model.dart';
import 'package:tvent/app/routes/app_pages.dart';
import 'package:tvent/services/auth_services.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxBool isTitleVisible = true.obs;
  final user = Get.find<AuthServices>().user;
  Rx<HomeModel> homeModel = HomeModel().obs;

  final List<String> textItems = [
    'Unlock Your Potential!',
    'Discover New Possibilities',
    'Become a Winner',
  ];

  final List<CategoryModel> categories = [
    CategoryModel("Sport", FontAwesomeIcons.trophy),
    CategoryModel("Academic", FontAwesomeIcons.bookOpenReader),
    CategoryModel("Programming", FontAwesomeIcons.laptopCode),
    CategoryModel("Art", FontAwesomeIcons.palette),
  ].obs;

  @override
  void onInit() async {
    super.onInit();
    setUpScrollController();
    fetchHomeData();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void fetchHomeData() async {
    D.Dio dio = D.Dio();
    final response = await dio.get("$HOST_SERVER/api/home");
    if (response.statusCode == 200) {
      HomeModel homeModel = processResponse(response);
      print(homeModel.nearestEvent?.description);
      this.homeModel.value = homeModel;
      return;
    }
    throw Exception("Failed to load data");
  }

  HomeModel processResponse(D.Response response) {
    final data = response.data;

    List<dynamic> newEvents = data["events"];
    List<EventModel> newEventsFiltered = newEvents.map<EventModel>((event) {
      return EventModel(
        id: event["id"],
        name: event["nama_event"],
        organizer: event["penyelenggara"]["nama_penyelenggara"],
        description: event["deskripsi"],
        imageUrl: event["banner"],
        organizerId: event["penyelenggara"]["id"],
        authorsImg: event["penyelenggara"]["logo"],
        location: event["tempat"],
      );
    }).toList();

    EventModel nearestEvent = EventModel(
      id: data["nerest_event"]["id"],
      name: data["nerest_event"]["nama_event"],
      organizer: data["nerest_event"]["penyelenggara"]["nama_penyelenggara"],
      description: data["nerest_event"]["deskripsi"],
      imageUrl: data["nerest_event"]["banner"],
      organizerId: data["nerest_event"]["penyelenggara"]["id"],
      authorsImg: data["nerest_event"]["penyelenggara"]["logo"],
      location: data["nerest_event"]["tempat"],
    );

    int nearestEventTime = data["nerest_event"]["nerest_event_time"];

    final homeData = HomeModel(
      newEvents: newEventsFiltered,
      popularEvents: newEventsFiltered,
      nearestEvent: nearestEvent,
      nearestEventTime: nearestEventTime,
    );
    return homeData;
  }

  void setUpScrollController() {
    scrollController.addListener(() {
      final double offset = scrollController.offset;
      isTitleVisible.value = offset < 100.0;
    });
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
}
