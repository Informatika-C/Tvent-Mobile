import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tvent/services/auth_services.dart';
import 'package:tvent/services/theme.dart';
import 'package:tvent/services/theme_services.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  Get.put(AuthServices());
  Get.put(ThemeService());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
    ),
  );
}
