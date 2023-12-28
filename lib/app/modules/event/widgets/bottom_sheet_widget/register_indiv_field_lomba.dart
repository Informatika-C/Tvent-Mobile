// make individual field lomba bottom sheet
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/event/controllers/register_indiv_controller.dart';
import 'package:tvent/app/modules/profile/controllers/profile_controller.dart';

class RegisterIndivFieldBottomShield extends StatelessWidget {
  final int id;
  const RegisterIndivFieldBottomShield({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          "Register",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Register yourself to join this competition",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                confirmDialog(id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Join"),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Close"),
            ),
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}

Future<dynamic> confirmDialog(int id) {
  RxBool isLoading = false.obs;
  final RegisterIndivController registerIndivController =
      Get.find<RegisterIndivController>();
  return Get.dialog(
    AlertDialog(
      title: const Text("Password Confirmation"),
      content: TextFormField(
        onChanged: (value) {
          registerIndivController.passwordConfirmation.value = value;
        },
        obscureText: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter your password",
        ),
      ),
      actions: [
        Obx(
          () => ElevatedButton(
            onPressed: isLoading.value == false
                ? () async {
                    try {
                      isLoading.value = true;
                      String massage =
                          await registerIndivController.registerIndiv(id);
                      Get.back();
                      Get.back();
                      Get.snackbar(
                        "Success",
                        massage,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    } catch (e) {
                      Get.snackbar(
                        "Error",
                        e.toString(),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      Get.back();
                      Get.back();
                    } finally {
                      isLoading.value = false;
                    }

                    try {
                      final profileController = Get.find<ProfileController>();
                      await profileController.getLomba();
                    } catch (e) {
                      return;
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow[700],
              textStyle: const TextStyle(
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Confirm"),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text("Close"),
        ),
      ],
    ),
  );
}
