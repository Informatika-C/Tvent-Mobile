import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/routes/app_pages.dart';
import 'package:tvent/services/auth_services.dart';

class GuestFieldBottomSheet extends StatelessWidget {
  final authServices = Get.find<AuthServices>();

  GuestFieldBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Please Login First",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "You must login first to join this competition",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (authServices.user.value == null) {
              Get.toNamed(Routes.AUTH);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text("Login"),
        ),
      ],
    );
  }
}
