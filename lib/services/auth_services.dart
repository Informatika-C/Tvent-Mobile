import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvent/app/models/lomba_model.dart';
import 'package:tvent/app/models/user_model.dart';

class AuthServices extends GetxService {
  Rx<User?> user = Rx<User?>(null);
  RxList<Lomba?> lomba = RxList<Lomba?>.empty(growable: true);
  Rx<String?> token = Rx<String?>(null);

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

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    return token;
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);

    this.token.value = token;
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('token');

    token.value = null;
  }

  Future<void> setUserLomba(List<Lomba> lomba) async {
    this.lomba.value = lomba;
  }

  @override
  void onInit() async {
    super.onInit();
    user.value = await getUser();
    token.value = await getToken();
  }
}
