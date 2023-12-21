import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/modules/profile/controllers/profile_controller.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({super.key});

  final controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding:
              const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 20),
          child: Center(
            child: Obx(
              () => Column(
                children: [
                  const Text("Edit Profile", style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.userEdit.value.name = value;
                    },
                    controller: TextEditingController(
                        text: controller.userEdit.value.name),
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.userEdit.value.email = value;
                    },
                    controller: TextEditingController(
                        text: controller.userEdit.value.email),
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.userEdit.value.npm = value;
                    },
                    controller: TextEditingController(
                        text: controller.userEdit.value.npm),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "NPM",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.userEdit.value.phone = value;
                    },
                    controller: TextEditingController(
                        text: controller.userEdit.value.phone),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.password.value = value;
                    },
                    controller: TextEditingController(text: ""),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.passwordConfirmation.value = value;
                    },
                    controller: TextEditingController(text: ""),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password Confirmation",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.editLoading.value
                          ? null
                          : () {
                              controller.updateProfile();
                            },
                      child: const Text("Save Changes"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
