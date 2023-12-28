import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:tvent/app/constant_variable.dart';
import 'package:tvent/services/auth_services.dart';

class LombaModel {
  int? id;
  String? name;
  String? description;
  String? date;
  DateTime? startDate;
  String? poster;
  int? price;
  int? kuota;
  int? maxParticipantPerTeam;
  int? currentParticipant;
  String? location;
  bool? isRegistered;
  List<CategoryModel>? categories;

  LombaModel({
    this.id,
    this.name,
    this.description,
    this.date,
    this.startDate,
    this.poster,
    this.price,
    this.kuota,
    this.maxParticipantPerTeam,
    this.location,
    this.categories,
    this.currentParticipant,
    this.isRegistered,
  }) {
    if (poster != null && id != null) {
      poster = '$HOST_SERVER/storage/lomba/poster/$id/$poster';
    }
  }

  LombaModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        date = json['date'],
        poster = json['poster'],
        price = json['price'],
        kuota = json['kuota'],
        maxParticipantPerTeam = json['maxParticipantPerTeam'],
        location = json['location'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'date': date,
        'poster': poster,
        'price': price,
        'kuota': kuota,
        'maxParticipantPerTeam': maxParticipantPerTeam,
        'location': location,
      };

  static Future<dynamic> fetchUserListLomba() {
    Dio dio = Dio();
    String? token = Get.find<AuthServices>().token.value;

    if (token == null) {
      return Future.error('Token is null');
    }

    dio.options.headers['Authorization'] = 'Bearer $token';

    return dio.get('$HOST_SERVER/api/user/list-lomba');
  }
}

class CategoryModel {
  int? id;
  String? name;

  CategoryModel({
    this.id,
    this.name,
  });
}
