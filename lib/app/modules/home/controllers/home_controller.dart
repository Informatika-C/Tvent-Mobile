import 'package:dio/dio.dart' as D;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/app/models/event_model.dart';
import 'package:tvent/app/modules/home/models/category_model.dart';
import 'package:tvent/app/modules/home/models/home_model.dart';
import 'package:tvent/services/auth_services.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxBool isTitleVisible = true.obs;
  final user = Get.find<AuthServices>().user;
  Rx<HomeModel> homeModel = HomeModel().obs;
  RxBool isLoading = false.obs;

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

  Future<void> globalRefresh() async {
    try {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        isLoading.value = true;
      });

      D.Dio dio = D.Dio();
      final response = await dio.get("$HOST_SERVER/api/home");

      if (response.statusCode == 200) {
        HomeModel refreshedHomeModel = processResponse(response);
        print(refreshedHomeModel.nearestEvent?.description);

        homeModel.value = refreshedHomeModel;

        onGlobalRefreshComplete();
      } else {
        throw Exception("Failed to refresh data");
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        isLoading.value = false;
      });
    }
  }

  void onGlobalRefreshComplete() {
    Get.delete<HomeController>();

    Get.put(HomeController());
    print(
        "New events length after refresh: ${homeModel.value.newEvents?.length}");
    isLoading.value = false;
    fetchHomeData();
    return;
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
        organizerName: event["penyelenggara"]["nama_penyelenggara"],
        description: event["deskripsi"],
        bannerUrl: event["banner"],
        organizerId: event["penyelenggara"]["id"],
        organizerImg: event["penyelenggara"]["logo"],
        location: event["tempat"],
      );
    }).toList();

    EventModel nearestEvent = EventModel(
      id: data["nerest_event"]["id"],
      name: data["nerest_event"]["nama_event"],
      organizerName: data["nerest_event"]["penyelenggara"]
          ["nama_penyelenggara"],
      description: data["nerest_event"]["deskripsi"],
      bannerUrl: data["nerest_event"]["banner"],
      organizerId: data["nerest_event"]["penyelenggara"]["id"],
      organizerImg: data["nerest_event"]["penyelenggara"]["logo"],
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
}
