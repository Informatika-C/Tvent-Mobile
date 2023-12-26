import 'package:dio/dio.dart' as D;
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/app/models/event_model.dart';
import 'package:tvent/app/modules/event/controllers/event_controller.dart';
import 'package:tvent/app/modules/event/model/category_model.dart';

class CategoryController extends GetxController {
  EventController eventController = Get.find();
  RxInt choseKategori = 0.obs;
  RxList<CategoryModel> categories = [
    CategoryModel(
      name: 'Sport',
      icon: FontAwesomeIcons.trophy,
      label: 'Sports',
    ),
    CategoryModel(
      name: 'Akademik',
      icon: FontAwesomeIcons.bookOpenReader,
      label: 'Akademik',
    ),
    CategoryModel(
      name: 'Programming',
      icon: FontAwesomeIcons.laptopCode,
      label: 'Programming',
    ),
    CategoryModel(
      name: 'Art',
      icon: FontAwesomeIcons.palette,
      label: 'Art',
    ),
  ].obs;

  Future<bool> chageCategory(int index) async {
    try {
      eventController.isLoading.value = true;
      choseKategori.value = index;
      final respone = await fecthEventsByCategoryIndex(index);
      List<EventModel> events = processResponse(respone);
      eventController.events.value = events;

      return true;
    } catch (e) {
      throw Exception(e.toString());
    } finally {
      eventController.isLoading.value = false;
    }
  }

  Future<D.Response<dynamic>> fecthEventsByCategoryIndex(int index) async {
    try {
      D.Dio dio = D.Dio();

      String category = categories[index].name.toLowerCase();
      return await dio.get("$HOST_SERVER/api/event/kategori/$category");
    } on D.DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  List<EventModel> processResponse(D.Response response) {
    List<dynamic> data = response.data;

    List<EventModel> events = data.map<EventModel>((event) {
      return EventModel(
        id: event["id"],
        name: event["nama_event"],
        description: event["deskripsi"],
        bannerUrl: event["banner"],
        posterUrl: event["poster"],
        organizerId: event["penyelenggara"]["id"],
        organizerName: event["penyelenggara"]["nama_penyelenggara"],
        organizerImg: event["penyelenggara"]["logo"],
        location: event["tempat"],
        registerDate: DateTime.parse(event["tanggal_pendaftaran"]),
        closeRegisterDate:
            DateTime.parse(event["tanggal_penutupan_pendaftaran"]),
        startDate: DateTime.parse(event["tanggal_pelaksanaan"]),
      );
    }).toList();

    return events;
  }

  @override
  void onInit() {
    super.onInit();
    chageCategory(0);
  }
}
