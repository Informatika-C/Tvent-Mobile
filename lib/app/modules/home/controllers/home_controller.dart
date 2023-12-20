import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/home/models/category_model.dart';
import 'package:tvent/app/modules/home/models/event_model.dart';
import 'package:tvent/services/auth_services.dart';
import '../../../models/user_model.dart';

class HomeController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxBool isTitleVisible = true.obs;
  var selectedIndex = 0.obs;
  var itemCount = 10.obs;
  AuthServices authServices = Get.find<AuthServices>();

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
      // Sesuaikan logika berdasarkan posisi scroll yang diinginkan
      isTitleVisible.value = offset < 100.0;
    });

    authServices.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
