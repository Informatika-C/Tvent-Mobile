import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:tvent/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final dio = Dio();

  void login(email, password) async {
    try {
      final response = await dio.post(
        'https://tvent.azurewebsites.net/api/login',
        data: {'email': email, 'password': password},
      );
      Get.offAllNamed(Routes.MAIN);
    } catch (error) {
      Get.defaultDialog(
        title: "Login Failed",
        middleText: "invalid email or password",
        confirm: TextButton(onPressed: () => Get.back(), child: Text("OK")),
      );
    }
  }

  void register(name, email, npm, phone, password) async {
    try {
      final response = await dio.post(
        'https://tvent.azurewebsites.net/api/register',
        data: {
          'name': name,
          'npm': npm,
          'phone': phone,
          'email': email,
          'password': password,
          'password_confirmation': password
        },
      );
      Get.defaultDialog(
        title: "Registration Success",
        middleText: "Please login to continue",
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("OK"),
        ),
      );
    } catch (error) {
      print('An error occurred: ${error}');
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
