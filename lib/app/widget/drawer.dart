import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/main/controllers/main_controller.dart';
import 'package:tvent/app/routes/app_nav.dart';
import 'package:tvent/app/routes/app_pages.dart';
import 'package:tvent/services/theme_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modules/auth/controllers/auth_controller.dart';
import '../modules/home/controllers/home_controller.dart';

class AppDrawer extends StatelessWidget {
  final MainController controller = Get.find<MainController>();
  final HomeController homeController = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Obx(() {
        return Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                homeController.user.value?.name ?? '',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              accountEmail: authController.user.value?.email != null
                  ? Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Text(
                        homeController.user.value?.email ?? '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    )
                  : null,
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: authController.user.value?.photoUrl != null
                    ? Image(
                        image: CachedNetworkImageProvider(
                            authController.user.value?.photoUrl ?? ''),
                        width: 52.0,
                        height: 52.0,
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                image: const DecorationImage(
                  image: AssetImage("assets/images/polygons.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.inverseSurface,
                    width: 0.8,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 111, 109, 109)
                        .withOpacity(0.25),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 1,
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                final tiles = authController.user.value != null
                    ? NavPages.titles
                    : NavPages.titles_guest;

                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    for (int i = 0; i < tiles.length; i++)
                      ListTile(
                        title: Text(tiles[i]),
                        onTap: () {
                          controller.pageController.value.jumpToPage(i);
                          controller.selctedIndex.value = i;
                          Get.back();
                        },
                      ),
                    ExpansionTile(
                      childrenPadding: const EdgeInsets.only(left: 25.0),
                      leading: const Icon(FontAwesomeIcons.codeBranch),
                      title: const Text('Find Us!'),
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(FontAwesomeIcons.github),
                          title: const Text('Github'),
                          onTap: () async {
                            const url =
                                'https://github.com/Informatika-C/Tvent-Mobile';
                            try {
                              await launch(url);
                            } catch (e) {
                              print('Error: $e');
                            }
                          },
                        ),
                        ListTile(
                          leading: const Icon(FontAwesomeIcons.instagram),
                          title: const Text('Instagram'),
                          onTap: () async {
                            const url =
                                'https://www.instagram.com/teknokrat_university/';
                            try {
                              await launch(url);
                            } catch (e) {
                              print('Error: $e');
                            }
                          },
                        ),
                      ],
                    ),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.compass),
                      title: const Text('Tvent'),
                      onTap: () async {
                        const url = 'https://tvent.azurewebsites.net/';
                        try {
                          await launch(url);
                        } catch (e) {
                          print('Error: $e');
                        }
                      },
                    ),
                    ListTile(
                      title: const Text('Dark Mode'),
                      leading: ThemeService().isDarkMode
                          ? const Icon(FontAwesomeIcons.solidMoon)
                          : const Icon(FontAwesomeIcons.moon),
                      trailing: CupertinoSwitch(
                        activeColor: const Color(0XFFFFA500),
                        trackColor: const Color(0XFF06142E),
                        value: ThemeService().isDarkMode,
                        onChanged: (value) {
                          ThemeService().switchTheme();
                        },
                      ),
                      onTap: () {
                        ThemeService().switchTheme();
                      },
                    ),
                    authController.user.value != null
                        ? const SizedBox(width: 0, height: 0)
                        : const Divider(),
                    ListTile(
                      title: authController.user.value != null
                          ? const Text('Logout')
                          : const Text(
                              'Login Require!',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                      leading: authController.user.value != null
                          ? const Icon(FontAwesomeIcons.powerOff)
                          : null,
                      onTap: () async {
                        if (authController.user.value != null) {
                          await authController
                              .logout(authController.user.value?.name ?? '');
                        } else {
                          Get.toNamed(Routes.AUTH);
                        }
                      },
                    ),
                    const Divider(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Image.asset(
                            Theme.of(context).brightness == Brightness.dark
                                ? "assets/images/tventLight.png"
                                : "assets/images/tventDark.png",
                            width: 120,
                            height: 120,
                          ),
                        ),
                        Text(
                          "©2023 CONST - All Rights Reserved",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ],
        );
      }),
    );
  }
}
