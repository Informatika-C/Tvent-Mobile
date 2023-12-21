import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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
    CrystalNavigationBarItem(
      icon: IconlyBold.work,
      unselectedIcon: IconlyLight.work,
    ),
    CrystalNavigationBarItem(
      icon: IconlyBold.paper,
      unselectedIcon: IconlyLight.paper,
    ),
    CrystalNavigationBarItem(
      icon: IconlyBold.profile,
      unselectedIcon: IconlyLight.profile,
    ),
  ];

  static final List<String> titles = [
    'Tvent',
    'Event',
    'About',
    'Profile',
  ];
}
