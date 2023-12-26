import 'package:dio/dio.dart' as D;
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/app/models/event_model.dart';
import 'package:tvent/app/models/lomba_model.dart';

class EventDetailController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<EventModel> event = EventModel().obs;
  RxList<LombaModel> lombas = <LombaModel>[].obs;

  Future<bool> getEventDetaill(int id) async {
    try {
      final response = await fecthEventDetail(id);
      final event = processEventResponse(response);
      final lombas = processLombaResponse(response);
      this.event.value = event;
      this.lombas.value = lombas;
    } catch (e) {
      throw Exception(e);
    }
    return true;
  }

  Future<D.Response> fecthEventDetail(int id) async {
    D.Dio dio = D.Dio();
    final response = await dio.get(
      "$HOST_SERVER/api/event/detail/$id",
    );
    return response;
  }

  EventModel processEventResponse(D.Response response) {
    final data = response.data;
    final event = EventModel(
      id: data["id"],
      name: data["nama_event"],
      description: data["deskripsi"],
      bannerUrl: data["banner"],
      posterUrl: data["poster"],
      organizerId: data["penyelenggara"]["id"],
      organizerName: data["penyelenggara"]["nama_penyelenggara"],
      organizerImg: data["penyelenggara"]["logo"],
      location: data["tempat"],
      registerDate: DateTime.parse(data["tanggal_pendaftaran"]),
      closeRegisterDate: DateTime.parse(data["tanggal_penutupan_pendaftaran"]),
      startDate: DateTime.parse(data["tanggal_pelaksanaan"]),
    );
    return event;
  }

  List<LombaModel> processLombaResponse(D.Response response) {
    List<dynamic> data = response.data["lomba"];
    final lombas = data.map<LombaModel>((lomba) {
      return LombaModel(
        id: lomba["id"],
        name: lomba["nama_lomba"],
        description: lomba["deskripsi"],
        startDate: DateTime.parse(lomba["pelaksanaan_lomba"]),
        poster: lomba["poster"],
        price: lomba["biaya_registrasi"],
        kuota: lomba["kuota_lomba"],
        maxParticipantPerTeam: lomba["max_anggota"],
      );
    }).toList();

    return lombas;
  }
}
