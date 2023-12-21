import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/main/controllers/main_controller.dart';
import 'package:tvent/app/routes/app_nav.dart';
import 'package:tvent/services/theme_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modules/home/controllers/home_controller.dart';

class AppDrawer extends StatelessWidget {
  final MainController controller = Get.find<MainController>();
  final HomeController homeController = Get.find<HomeController>();

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri(scheme: "https", host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              homeController.user.value.name,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            accountEmail: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(
                homeController.user.value.email,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            currentAccountPicture: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                'https://avatars.githubusercontent.com/u/101344946?v=4',
                width: 52.0,
                height: 52.0,
                fit: BoxFit.cover,
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          for (int i = 0; i < NavPages.titles.length; i++)
            ListTile(
              title: Text(NavPages.titles[i]),
              onTap: () {
                controller.pageController.value.jumpToPage(i);
                controller.selctedIndex.value = i;
                Get.back();
              },
            ),
          ListTile(
            leading: const Icon(IconlyLight.discovery),
            title: const Text('Tvent'),
            onTap: () async {
              try {
                await _launchUrl('https://tvent.azurewebsites.net/');
              } catch (e) {
                print('Error: $e');
              }
            },
          ),
          ListTile(
            leading: const Icon(IconlyLight.show),
            title: const Text('Dark Mode'),
            trailing: CupertinoSwitch(
              value: ThemeService().isDarkMode,
              onChanged: (value) {
                ThemeService().switchTheme();
              },
            ),
            onTap: () {
              ThemeService().switchTheme();
            },
          ),
          ListTile(
            leading: const Icon(IconlyLight.logout),
            title: const Text('Logout'),
            onTap: () {
              homeController.logout(
                homeController.user.value.name,
              );
            },
          ),
          const Divider(),
          Text(
            "©2023 CONST - All Rights Reserved",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 10,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
