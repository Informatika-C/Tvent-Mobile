

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  final dio = Dio();
  RxString choseKategori = "Sport".obs;


  RxList<dynamic> DataKategoriEvents = [].obs;
  Future<void> GetEvent(String uri) async {
    final response = await dio
        .get("https://tvent.azurewebsites.net/api/event/kategori/" + uri);
    DataKategoriEvents.value = response.data;
    return print("GetEvent");
  }

  var DataDetailEvents = {};
  Future GetDetailEvent(String uri) async {
    final response = await dio.get(
      "https://tvent.azurewebsites.net/api/event/detail/" + uri,
    );
    DataDetailEvents = response.data;
    return print("GetDetailEvent");
  }

  var DetailLomba = {};
  Future GetDetailLomba(String uri) async {
    final response = await dio.get(
      "https://tvent.azurewebsites.net/api/lomba/detail/" + uri,
    );
    DetailLomba = response.data;
    return print(DetailLomba);
  }

  final namaGroup = TextEditingController();
  final cariKetua = TextEditingController();
  final cariAnggota = TextEditingController();
  RxList<dynamic> ketuaCombox = [].obs;
  RxList<dynamic> PesertaCombox = [].obs;
  void clearSet(){
    ketuaCombox.clear();
    PesertaCombox.clear();
    cariKetua.clear();
    cariAnggota.clear();
    namaGroup.clear();
  }
  Future GetUsers(String search) async {
    final response = await dio.get(
      "https://tvent.azurewebsites.net/api/peserta/search?q=${search}",
    );
    return response.data;
  }


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    print('Event Init');
    GetEvent("Sport");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
