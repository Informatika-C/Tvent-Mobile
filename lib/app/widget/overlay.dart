import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/home/controllers/home_controller.dart';
import 'package:tvent/app/modules/main/controllers/main_controller.dart';
import 'dart:ui';
import '../modules/profile/views/profile_edit_view.dart';

class CustomPopupMenu extends StatelessWidget {
  final int currentIndex;
  final MainController controller;

  const CustomPopupMenu(
      {Key? key, required this.currentIndex, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    Get.put(HomeController());
    return PopupMenuButton<String>(
      onSelected: (value) {
        handleMenuItemSelection(controller.selctedIndex.value, value);
      },
      itemBuilder: (BuildContext context) {
        return buildPopupMenuItems(context, controller.selctedIndex.value);
      },
      offset: const Offset(0, 60),
      icon: const Icon(
        FontAwesomeIcons.ellipsisVertical,
        color: Color(0xfff2f2f2),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Theme.of(context).colorScheme.background,
    );
  }

  List<PopupMenuEntry<String>> buildPopupMenuItems(
      BuildContext context, int currentIndex) {
    switch (currentIndex) {
      case 0:
        return [
          const PopupMenuItem<String>(
            value: 'Page 1',
            child: Text('Page 1'),
          ),
          const PopupMenuItem<String>(
            value: 'Page 1',
            child: Text('Page 1'),
          ),
        ];
      case 1:
        return [
          const PopupMenuItem<String>(
            value: 'Page 2',
            child: Text('Page 2'),
          ),
          const PopupMenuItem<String>(
            value: 'Page 2',
            child: Text('Page 2'),
          ),
        ];
      case 2:
        return [
          const PopupMenuItem<String>(
            value: 'Page 3',
            child: Text('Page 3'),
          ),
          const PopupMenuItem<String>(
            value: 'Page 3',
            child: Text('Page 3'),
          ),
        ];
      case 3:
        return [
          const PopupMenuItem<String>(
            value: 'editProfile',
            child: Text('Edit Profile'),
          ),
          const PopupMenuItem<String>(
            value: 'logOut',
            child: Text('LogOut'),
          ),
        ];
      default:
        return [];
    }
  }

  void handleMenuItemSelection(int currentIndex, String value) {
    switch (currentIndex) {
      case 3:
        handlePage4MenuSelection(value);
        break;
      default:
        print('Selected menu for page $currentIndex: $value');
    }
  }

  void handlePage4MenuSelection(String value) {
    switch (value) {
      case 'editProfile':
        Get.dialog(ProfileEdit());
        break;
      case 'logOut':
        controller.logout(
          controller.user.value?.name ?? '',
        );
        break;
      default:
        print('Selected menu for Page 4: $value');
    }
  }
}
