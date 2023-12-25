import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/app/models/event_models.dart';

class EventController extends GetxController {
  final dio = Dio();
  RxString choseKategori = "Sport".obs;
  RxList<DataKategoriEvent> dataKategoriEvents = <DataKategoriEvent>[].obs;
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[
    {'value': 'Sport', 'icon': FontAwesomeIcons.trophy, 'label': 'Sports'},
    {
      'value': 'Akademik',
      'icon': FontAwesomeIcons.bookOpenReader,
      'label': 'Akademik'
    },
    {
      'value': 'Programming',
      'icon': FontAwesomeIcons.bug,
      'label': 'Programming'
    },
    {'value': 'Art', 'icon': FontAwesomeIcons.palette, 'label': 'Art'},
  ].obs;

  String getBannerUrl(int id, String banner) {
    return '$HOST_SERVER/storage/banner/$id/$banner';
  }

  String getPenyelenggaraLogoUrl(int penyelenggaraId, String logo) {
    return '$HOST_SERVER/storage/penyelenggara/logo/$penyelenggaraId/$logo';
  }

  Future<void> GetEvent(String? uri) async {
    try {
      isLoading.value = true;

      if (uri != null) {
        final response =
            await dio.get("$HOST_SERVER/api/event/kategori/" + uri);
        List<dynamic> responseData = response.data;

        dataKategoriEvents.assignAll(
          responseData.map((item) => DataKategoriEvent.fromJson(item)).toList(),
        );

        choseKategori.value = uri;
        print("GetEvent: Kategori telah diubah menjadi $uri");
      } else {
        print("GetEvent Error: uri is null");
      }
    } catch (error) {
      print("GetEvent Error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  var DataDetailEvents = {};
  Future GetDetailEvent(String uri) async {
    final response = await dio.get(
      "$HOST_SERVER/api/event/detail/" + uri,
    );
    DataDetailEvents = response.data;
    return print("GetDetailEvent");
  }

  // var DetailLomba = {};
  // Future GetDetailLomba(String uri) async {
  //   final response = await dio.get(
  //     "$HOST_SERVER/api/lomba/detail/" + uri,
  //   );
  //   DetailLomba = response.data;
  //   return print(DetailLomba);
  // }
  var DetailLomba = {};
  Future<void> GetDetailLomba(String uri) async {
    try {
      final response = await dio.get(
        "$HOST_SERVER/api/lomba/detail/$uri",
      );

      if (response.statusCode == 200) {
        DetailLomba = response.data;
        print(DetailLomba);
      } else {
        print("Failed to get data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error during API call: $error");
    }
  }

  final namaGroup = TextEditingController();
  final cariKetua = TextEditingController();
  final cariAnggota = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<TextEditingController> cariAnggotaControllers = [];
  RxList<dynamic> ketuaCombox = [].obs;
  RxList<dynamic> PesertaCombox = [].obs;
  void clearSet() {
    ketuaCombox.clear();
    PesertaCombox.clear();
    cariKetua.clear();
    cariAnggota.clear();
    namaGroup.clear();
  }

  Future GetUsers(String search) async {
    final response = await dio.get(
      "$HOST_SERVER/api/peserta/search?q=${search}",
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
