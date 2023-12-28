import 'package:get/get.dart';
import 'package:tvent/app/models/user_model.dart';
import 'package:tvent/services/auth_services.dart';

class GrupLombaController extends GetxController {
  AuthServices authServices = Get.find<AuthServices>();
  RxList<User> listUser = <User>[].obs;

  Future<void> registerLomba() async {}
}
