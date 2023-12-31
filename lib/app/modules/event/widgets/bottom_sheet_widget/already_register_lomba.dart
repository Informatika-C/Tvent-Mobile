import 'package:dio/dio.dart' as D;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/app/models/lomba_model.dart';
import 'package:tvent/app/modules/event/controllers/lomba_controller.dart';
import 'package:tvent/app/modules/profile/controllers/profile_controller.dart';
import 'package:tvent/services/auth_services.dart';

class AlreadyRegisBottomSheet extends StatelessWidget {
  final int id;
  RxBool isLoading = false.obs;

  AlreadyRegisBottomSheet({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Column(
          children: [
            const Text("Already registered to this lomba"),
            const SizedBox(height: 10),
            const Text("Are you sure want to quit from this lomba?"),
            const SizedBox(height: 20),
            Obx(
              () => ElevatedButton(
                onPressed: isLoading.value
                    ? null
                    : () async {
                        try {
                          isLoading.value = true;
                          String respone = await quitLomba(id);
                          Get.snackbar(
                            "Success",
                            respone,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          _setToUnregistered();
                          _updateProfie();
                        } catch (e) {
                          Get.snackbar(
                            "Error",
                            e.toString(),
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } finally {
                          isLoading.value = false;
                        }
                      },
                child: const Text("Quit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> quitLomba(int id) async {
  D.Dio dio = D.Dio();

  String? token = await Get.find<AuthServices>().getToken();

  if (token == null) {
    throw Exception('Token is null');
  }

  dio.options.headers['Authorization'] = 'Bearer $token';

  try {
    final response = await dio.delete(
      '$HOST_SERVER/api/lomba/unregister',
      data: {
        'lomba_id': id,
      },
    );

    if (response.statusCode == 200) {
      return response.data['message'];
    } else {
      throw Exception(response.data);
    }
  } on D.DioException catch (e) {
    if (e.response?.statusCode == 422) {
      throw Exception(e.response?.data['message']);
    }
    throw Exception(e.response?.data);
  }
}

void _updateProfie() async {
  try {
    final profileController = Get.find<ProfileController>();
    await profileController.getLomba();
  } catch (e) {
    return;
  }
}

void _setToUnregistered() {
  try {
    final LombaController lombaController = Get.find<LombaController>();

    LombaModel lomba = lombaController.lomba.value;
    lomba.isRegistered = false;

    lombaController.lomba.update((val) {
      val = lomba;
    });
  } catch (e) {
    return;
  }
}
