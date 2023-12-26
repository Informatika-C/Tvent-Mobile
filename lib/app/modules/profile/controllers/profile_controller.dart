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
  RxBool isLoading = false.obs;
  RxMap<int, bool> expansionStates = RxMap<int, bool>();

  Future<void> toggleExpansion(bool value, int id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    expansionStates[id] = value;
  }

  void resetExpansionStates() {
    expansionStates.clear();
    print('clear');
  }

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

  Future<void> getLomba() async {
    try {
      isLoading.value = true;

      final response = await LombaModel.fetchUserListLomba();
      List<dynamic> lombaJson = response.data;

      List<LombaModel> lomba = lombaJson
          .map(
            (e) => LombaModel(
              id: e['id'],
              name: e['nama_lomba'].toString(),
              description: e['keterangan'].toString(),
              date: e['pelaksanaan_lomba'].toString(),
              poster: e['poster'].toString(),
              price: e['biaya_registrasi'],
              kuota: e['kuota_lomba'],
              maxParticipantPerTeam: e['max_anggota'],
              location: e['ruangan_lomba'].toString(),
            ),
          )
          .toList();

      authServices.setUserLomba(lomba);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
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
