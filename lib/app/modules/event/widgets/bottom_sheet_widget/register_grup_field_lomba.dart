import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/models/user_model.dart';
import 'package:async_searchable_dropdown/async_searchable_dropdown.dart';
import 'package:tvent/app/modules/event/controllers/register_grup_controller.dart';
import 'package:tvent/app/modules/profile/controllers/profile_controller.dart';

class RegisterGrupFieldLombaBottomSheet extends StatelessWidget {
  final int id;
  final int numberOfTeamMembers;
  final RegisterGrupController registerGrupController;

  RegisterGrupFieldLombaBottomSheet(
      {super.key,
      required this.id,
      required this.numberOfTeamMembers,
      required this.registerGrupController});

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
          "Register your team to join this competition",
          textAlign: TextAlign.center,
        ),
        // make text field for group name
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Group Name",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          child: TextFormField(
            onChanged: (value) {
              registerGrupController.groupName.value = value;
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Enter your group name",
            ),
          ),
        ),

        const SizedBox(height: 20),
        for (int i = 0; i < numberOfTeamMembers; i++) memberField(i),
        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                try {
                  registerGrupController.validateInput();
                  confirmDialog(id);
                } on Exception catch (e) {
                  Get.snackbar(
                    "Error",
                    e.toString(),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[700],
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Join"),
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
        const SizedBox(height: 10),
      ],
    );
  }
}

Widget memberField(int index) {
  final registerGrupController = Get.find<RegisterGrupController>();
  return Column(
    children: [
      const SizedBox(height: 20),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          index == 0
              ? "Member 1 Name (Team Leader Name)"
              : "Member ${index + 1} Name",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const SizedBox(height: 10),
      Obx(
        () => SearchableDropdown<User>(
          remoteItems: (search) =>
              registerGrupController.findUser(search ?? ""),
          itemLabelFormatter: (value) => value.name ?? "",
          value: registerGrupController.members[index],
          onChanged: (value) {
            registerGrupController.members[index] = value ?? User();
            registerGrupController.members.refresh();
          },
          inputDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1,
              ),
            ),
            hintText: "Enter your name",
            hintStyle: const TextStyle(
              fontSize: 12,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          ),
        ),
      ),
    ],
  );
}

Future<dynamic> confirmDialog(int id) {
  RxBool isLoading = false.obs;
  final registerGrupController = Get.find<RegisterGrupController>();

  return Get.dialog(
    AlertDialog(
      title: const Text("Password Confirmation"),
      content: TextFormField(
        onChanged: (value) {
          registerGrupController.passwordConfirmation.value = value;
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
                          await registerGrupController.registerGrup(id);
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
