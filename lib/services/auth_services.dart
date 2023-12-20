import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvent/app/models/user_model.dart';

class AuthServices extends GetxService {
  Rx<User?> user = Rx<User?>(null);

  Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userStringJson = prefs.getString('user');

    if (userStringJson == null) {
      return null;
    }

    Map<String, dynamic> userJson = json.decode(userStringJson.toString());

    return User.fromJson(userJson);
  }

  Future<void> setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userStringJson = json.encode(user.toJson());

    await prefs.setString('user', userStringJson);

    this.user.value = user;
  }

  @override
  void onInit() async {
    super.onInit();
    user.value = await getUser();
  }
}
