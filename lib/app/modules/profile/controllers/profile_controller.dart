import 'package:get/get.dart';
import 'package:tvent/app/models/lomba_model.dart';
import 'package:tvent/services/auth_services.dart';

class ProfileController extends GetxController {
  AuthServices authServices = Get.find<AuthServices>();

  @override
  void onInit() {
    super.onInit();
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
}
