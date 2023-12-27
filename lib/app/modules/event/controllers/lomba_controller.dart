import 'package:dio/dio.dart' as D;
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/app/models/lomba_model.dart';
import 'package:tvent/app/modules/event/controllers/event_detail_controller.dart';
import 'package:tvent/services/auth_services.dart';

class LombaController extends GetxController {
  final authService = Get.find<AuthServices>();
  Rx<LombaModel> lomba = LombaModel().obs;
  D.CancelToken cancelToken = D.CancelToken();

  Future<void> getLombaDetail(int id) async {
    getLombaFromLocal(id);
    // getLombaFromServer(id);
  }

  void getLombaFromLocal(int id) {
    try {
      final eventDetailController = Get.find<EventDetailController>();
      final lomba =
          eventDetailController.lombas.firstWhere((lomba) => lomba.id == id);
      this.lomba.value = lomba;
    } catch (e) {
      return;
    }
  }

  Future<void> getLombaFromServer(int id) async {
    try {
      var response = await _fetchLomba(id);
      if (response.statusCode == 200) {
        lomba.value = _processResponse(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<D.Response> _fetchLomba(int id) async {
    D.Dio dio = D.Dio();

    String? token = await authService.getToken();

    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    final response = dio.get(
      '$HOST_SERVER/api/lomba/detail/$id',
      cancelToken: cancelToken,
    );

    return response;
  }

  LombaModel _processResponse(D.Response response) {
    final data = response.data;
    List<dynamic> dataCategories = data['kategori'];

    print(data['anggota_terdaftar']);

    final lomba = LombaModel(
      id: data['id'],
      name: data['nama_lomba'],
      description: data['deskripsi'],
      startDate: DateTime.parse(data['pelaksanaan_lomba']),
      poster: data['poster'],
      location: data['ruangan_lomba'],
      price: data['biaya_registrasi'],
      kuota: data['kuota_lomba'],
      maxParticipantPerTeam: data['max_anggota'],
      currentParticipant: data["anggota_terdaftar"],
    );

    lomba.categories = List<CategoryModel>.from(
      dataCategories.map(
        (category) => CategoryModel(
          id: category['id'],
          name: category['nama_kategori'],
        ),
      ),
    );

    return lomba;
  }

  void resetData() {
    try {
      if (cancelToken.isCancelled) {
        cancelToken.cancel();
      }
      lomba.value = LombaModel();
    } catch (e) {
      return;
    }
  }
}
