import 'package:get/get.dart';
import 'package:tvent/app/models/lomba_model.dart';
import 'package:tvent/app/models/user_model.dart';
import 'package:tvent/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ProfileController extends GetxController {
  AuthServices authServices = Get.find<AuthServices>();
  final user = Get.find<AuthServices>().user;
  final lomba = Get.find<AuthServices>().lomba;
  final userEdit = User(-1, '', '', '', '').obs;
  final password = ''.obs;
  final passwordConfirmation = ''.obs;

  final editLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    setUpUserEdit();
    getLomba();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setUpUserEdit() {
    if (user.value != null) {
      userEdit.value = User(
        user.value?.id ?? userEdit.value.id,
        user.value?.name ?? userEdit.value.name,
        user.value?.email ?? userEdit.value.email,
        user.value?.npm ?? userEdit.value.npm,
        user.value?.phone ?? userEdit.value.phone,
      );
    }
    return;
  }

  void getLomba() async {
    try {
      final response = await Lomba.fetchUserListLomba();
      List<dynamic> lombaJson = response.data;

      List<Lomba> lomba = lombaJson
          .map(
            (e) => Lomba(
              e['id'],
              e['nama_lomba'].toString(),
              e['keterangan'].toString(),
              e['pelaksanaan_lomba'].toString(),
              e['poster'].toString(),
              e['biaya_registrasi'],
              e['kuota_lomba'],
              e['max_anggota'],
              e['ruangan_lomba'].toString(),
            ),
          )
          .toList();

      authServices.setUserLomba(lomba);
    } catch (e) {
      print(e);
    }
  }

  void updateProfile() async {
    if (userEdit.value.id == -1) {
      return;
    }

    if (user.value == null) {
      return;
    }

    if (password.value != passwordConfirmation.value) {
      Get.defaultDialog(
        title: "Failed to update user data",
        middleText: "Password and password confirmation is not same",
        confirm: TextButton(
          onPressed: () => Get.back(),
          child: const Text("OK"),
        ),
      );
      return;
    }

    if (User.isSame(userEdit.value, user.value!) &&
        (password.value.isEmpty && passwordConfirmation.value.isEmpty)) {
      return;
    }

    try {
      editLoading.value = true;
      User? user = await User.updateUserData(
          user: userEdit.value,
          password: password.value,
          passwordConfirmation: passwordConfirmation.value);
      if (user == null) {
        return;
      }
      authServices.setUser(user);
      Get.defaultDialog(
        title: "Success",
        middleText: "User data updated",
        confirm: TextButton(
          onPressed: () => Get.back(),
          child: const Text("OK"),
        ),
      );
    } on DioException catch (e) {
      setUpUserEdit();
      Get.defaultDialog(
        title: "Failed to update user data",
        middleText: e.response?.data['message'] ?? "Unknown error",
        confirm: TextButton(
          onPressed: () => Get.back(),
          child: const Text("OK"),
        ),
      );
    } finally {
      editLoading.value = false;
    }
  }
}
