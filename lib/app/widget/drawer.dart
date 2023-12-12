// app_drawer.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/main/controllers/main_controller.dart';
import 'package:tvent/app/routes/app_nav.dart';
import 'package:tvent/services/theme_services.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  final MainController controller =
      Get.find<MainController>(); // Ambil instance controller

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
              'Your Name',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            accountEmail: Text(
              'your.email@example.com',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              child: FlutterLogo(size: 42.0),
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
        ],
      ),
    );
  }
}
