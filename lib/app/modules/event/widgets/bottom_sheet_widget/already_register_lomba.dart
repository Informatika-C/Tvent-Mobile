import 'package:dio/dio.dart' as D;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
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
                          await quitLomba(id);
                          Get.back();
                        } catch (e) {
                          Get.snackbar(
                            "Error",
                            e.toString(),
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          Get.back();
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
    throw Exception(e.response?.data);
  }
}
