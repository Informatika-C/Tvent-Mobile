import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/app/models/user_model.dart';
import 'package:tvent/app/routes/app_pages.dart';
import 'package:tvent/services/auth_services.dart';

class AuthController extends GetxController {
  final dio = Dio();
  AuthServices authServices = Get.find<AuthServices>();

  RxBool isLoading = false.obs;

  Future<bool> login(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await dio.post(
        '$HOST_SERVER/api/login',
        data: {'email': email, 'password': password},
      );

      final userRes = response.data['user'];
      final token = response.data['token'];

      User user = User(
        userRes['id'],
        userRes['name'],
        userRes['email'],
        userRes['npm'],
        userRes['phone'],
      );

      await authServices.setUser(user);
      await authServices.setToken(token);

      isLoading.value = false;

      Get.offAllNamed(Routes.MAIN);
      return true;
    } catch (error) {
      isLoading.value = false;
      print(error);

      Get.defaultDialog(
        title: "Login Failed",
        middleText: "Invalid email or password",
        confirm: TextButton(
          onPressed: () => Get.back(),
          child: const Text("OK"),
        ),
      );
      return false;
    }
  }

  Future<void> register(String name, String email, String npm, String phone,
      String password) async {
    try {
      isLoading.value = true;

      await dio.post(
        '$HOST_SERVER/api/register',
        data: {
          'name': name,
          'npm': npm,
          'phone': phone,
          'email': email,
          'password': password,
          'password_confirmation': password,
        },
      );

      isLoading.value = false;

      Get.defaultDialog(
        title: "Registration Success",
        middleText: "Please login to continue",
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("OK"),
        ),
      );
    } catch (error) {
      isLoading.value = false;

      Get.defaultDialog(
        title: "Registration Failed",
        middleText: "An error occurred during registration",
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text("OK"),
        ),
      );

      print('An error occurred during registration: $error');
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
