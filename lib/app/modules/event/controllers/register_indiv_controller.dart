import 'package:dio/dio.dart' as D;
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/services/auth_services.dart';

class RegisterIndivController extends GetxController {
  AuthServices authServices = Get.find<AuthServices>();
  RxInt lombaId = RxInt(-1);
  Rx<String?> passwordConfirmation = Rx<String?>(null);

  Future<String> registerIndiv(int id) async {
    lombaId.value = id;

    if (lombaId.value == -1) {
      throw Exception('Lomba id cannot be empty');
    }

    try {
      if (passwordConfirmation.value == null) {
        throw Exception('Password confirmation cannot be empty');
      }
      return sendRequest(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> sendRequest(int id) async {
    D.Dio dio = D.Dio();

    String? token = await authServices.getToken();

    if (token == null) {
      throw Exception('User cannot be empty');
    }

    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      final formData = D.FormData.fromMap({
        'lomba_id': id,
        'password': passwordConfirmation.value,
      });

      D.Response response = await dio.post(
        '$HOST_SERVER/api/lomba/register/solo',
        data: formData,
      );

      if (response.statusCode == 200) {
        resetData();
        return response.data['message'];
      } else {
        throw Exception('Something went wrong');
      }
    } on D.DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw Exception(e.response?.data['message']);
      }
      throw Exception(e.response?.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void resetData() {
    lombaId.value = -1;
    passwordConfirmation.value = null;
  }
}
