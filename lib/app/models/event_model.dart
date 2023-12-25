import 'package:tvent/app/constant_variable.dart';

class EventModel {
  int? id;
  String? name;
  String? description;
  String? bannerUrl;
  String? posterUrl;
  String? location;
  DateTime? registerDate;
  DateTime? closeRegisterDate;
  DateTime? startDate;
  int? organizerId;
  String? organizerName;
  String? organizerImg;

  EventModel({
    this.id,
    this.name,
    this.description,
    this.bannerUrl,
    this.posterUrl,
    this.location,
    this.registerDate,
    this.closeRegisterDate,
    this.startDate,
    this.organizerId,
    this.organizerName,
    this.organizerImg,
  }) {
    if (bannerUrl != null && id != null) {
      bannerUrl = "$HOST_SERVER/storage/banner/$id/$bannerUrl";
    }
    if (organizerImg != null && organizerId != null) {
      organizerImg =
          "$HOST_SERVER/storage/penyelenggara/logo/$organizerId/$organizerImg";
    }
  }
}
