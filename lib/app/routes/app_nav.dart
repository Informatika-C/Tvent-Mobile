import 'package:flutter/material.dart';
import 'package:tvent/app/modules/event/views/event_view.dart';
import 'package:tvent/app/modules/home/views/home_view.dart';
import 'package:tvent/app/modules/profile/views/profile_view.dart';

class NavPages {
  NavPages._();

  static final route = <Widget>[
    const HomeView(),
    const EventView(),
    const ProfileView(),
  ];

  static final navBar = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.event),
      label: 'Event',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];
}