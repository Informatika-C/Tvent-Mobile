import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/app/models/user_model.dart';
import 'package:tvent/app/routes/app_pages.dart';
import 'package:tvent/services/auth_services.dart';

class AuthController extends GetxController {
  final dio = Dio();
  AuthServices authServices = Get.find<AuthServices>();
  final user = Get.find<AuthServices>().user;
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

  Future<void> logout(String username) async {
    bool? confirmLogout = await Get.dialog<bool?>(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
          decoration: BoxDecoration(
            color: Colors.white,
            image: const DecorationImage(
              image: AssetImage("assets/images/polygons.png"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Konfirmasi Logout",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Is $username sure want to logout?",
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 10.0),
              const Center(
                child: Icon(
                  FontAwesomeIcons.faceSadTear,
                  color: Colors.black,
                  size: 60,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await performLogout();
                      Get.back(result: true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFFE67E22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                    ),
                    child: const Text(
                      "Batal",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmLogout ?? false) {
      await performLogout();
    } else {
      // Get.back(result: false);
    }
  }

  Future<void> performLogout() async {
    try {
      await authServices.clearUser();

      print("succes logout");
      Get.offAllNamed(Routes.AUTH);
    } catch (error) {
      print('An error occurred during logout: $error');
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
