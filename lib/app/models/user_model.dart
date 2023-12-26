import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/services/auth_services.dart';

class User {
  int id;
  String name;
  String email;
  String npm;
  String phone;
  String? photoUrl;

  User(this.id, this.name, this.email, this.npm, this.phone);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        npm = json['npm'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'npm': npm,
        'phone': phone,
      };

  static Future<User?> updateUserData(
      {required User user,
      String? password,
      String? passwordConfirmation}) async {
    d.Dio dio = d.Dio();

    AuthServices authServices = Get.find();
    String? token = await authServices.getToken();

    if (token == null) {
      throw Exception('Token is null');
    }

    dio.options.headers['Authorization'] = 'Bearer $token';

    final fromData = d.FormData.fromMap({
      'name': user.name,
      'email': user.email,
      'npm': user.npm,
      'phone': user.phone,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    final response = await dio.post(
      '$HOST_SERVER/api/user',
      data: fromData,
    );

    if (response.statusCode == 200) {
      final userData = response.data['user'];
      final newUser = User(
        user.id,
        userData['name'],
        userData['email'],
        userData['npm'],
        userData['phone'],
      );

      return newUser;
    }

    throw Exception(response.data['message']);
  }

  static bool isSame(User user1, User user2) {
    return user1.id == user2.id &&
        user1.name == user2.name &&
        user1.email == user2.email &&
        user1.npm == user2.npm &&
        user1.phone == user2.phone;
  }
}
