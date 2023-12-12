import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tvent/app/modules/about/views/about_view.dart';
import 'package:tvent/app/modules/event/views/event_view.dart';
import 'package:tvent/app/modules/home/views/home_view.dart';
import 'package:tvent/app/modules/profile/views/profile_view.dart';

class NavPages {
  NavPages._();

  static final route = [
    () => HomeView(),
    () => EventView(),
    () => AboutView(),
    () => ProfileView(),
  ];

  static final navBar = [
    CrystalNavigationBarItem(
      icon: IconlyBold.home,
      unselectedIcon: IconlyLight.home,
    ),

    /// Favourite
    CrystalNavigationBarItem(
      icon: IconlyBold.heart,
      unselectedIcon: IconlyLight.heart,
    ),
    CrystalNavigationBarItem(
      icon: IconlyBold.paper,
      unselectedIcon: IconlyLight.paper,
    ),

    /// Add
    CrystalNavigationBarItem(
      icon: IconlyBold.plus,
      unselectedIcon: IconlyLight.plus,
    ),
  ];

  static final List<String> titles = const [
    'Home',
    'Event',
    'About',
    'Profile',
  ];
}
