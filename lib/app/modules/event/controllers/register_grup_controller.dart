import 'dart:convert';

import 'package:dio/dio.dart' as D;
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/app/models/user_model.dart';
import 'package:tvent/app/modules/event/controllers/lomba_controller.dart';
import 'package:tvent/services/auth_services.dart';

class RegisterGrupController extends GetxController {
  AuthServices authServices = Get.find<AuthServices>();
  LombaController lombaController = Get.find<LombaController>();
  RxInt lombaId = RxInt(-1);
  Rx<String?> groupName = Rx<String?>(null);
  RxList<User> members = <User>[].obs;
  Rx<String?> passwordConfirmation = Rx<String?>(null);

  Future<String> registerGrup(int id) async {
    lombaId.value = id;

    if (lombaId.value == -1) {
      throw Exception('Lomba id cannot be empty');
    }

    try {
      validateInput();
      if (passwordConfirmation.value == null) {
        throw Exception('Password confirmation cannot be empty');
      }
      return sendRequest();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> sendRequest() async {
    D.Dio dio = D.Dio();

    if (authServices.token.value == null) {
      throw Exception('User cannot be empty');
    }
    dio.options.headers['Authorization'] = 'Bearer ${authServices.token.value}';

    try {
      final formData = D.FormData.fromMap({
        'lomba_id': lombaId.value,
        'nama_grup': groupName.value,
        'password': passwordConfirmation.value,
      });

      for (int i = 0; i < members.length; i++) {
        formData.fields.add(MapEntry('anggota[$i]', members[i].id.toString()));
      }

      D.Response response = await dio.post(
        '$HOST_SERVER/api/lomba/register/grup',
        data: formData,
      );

      if (response.statusCode == 200) {
        resetData();
        return response.data['message'];
      } else {
        throw Exception(response.data);
      }
    } on D.DioException catch (e) {
      if (e.response?.statusCode == 422) {
        throw Exception(e.response?.data['message']);
      }
      throw Exception(e.response?.data);
    } catch (e) {
      rethrow;
    }
  }

  void validateInput() {
    checkEmpty();
    checkUserLength();
    checkUserInMembers();
    checkDuplicateMembers();
  }

  void checkEmpty() {
    if (groupName.value == null) {
      throw Exception('Group name cannot be empty');
    }
    if (members.isEmpty) {
      throw Exception('Members cannot be empty');
    }
  }

  void checkUserLength() {
    for (User user in members) {
      if (user.id == null) {
        throw Exception('Members name cannot be empty');
      }
    }
  }

  void checkUserInMembers() {
    for (User user in members) {
      if (user.id == authServices.user.value?.id) {
        return;
      }
    }
    throw Exception('you are not in members');
  }

  void checkDuplicateMembers() {
    for (int i = 0; i < members.length; i++) {
      for (int j = i + 1; j < members.length; j++) {
        if (members[i].id == members[j].id) {
          throw Exception('duplicate members in ${i + 1} and ${j + 1}');
        }
      }
    }
  }

  Future<List<User>> findUser(String name) async {
    try {
      if (name == '') {
        return [];
      }

      D.Dio dio = D.Dio();
      D.Response response = await dio.get(
        '$HOST_SERVER/api/peserta/search?q=$name',
      );

      List<dynamic> data = response.data;

      List<User> users = data
          .map((u) => User(
                id: u['id'],
                name: u['name'],
              ))
          .toList();

      return users;
    } catch (e) {
      rethrow;
    }
  }

  void resetData() {
    groupName.value = null;
    members.value = [];
    passwordConfirmation.value = null;
  }
}
