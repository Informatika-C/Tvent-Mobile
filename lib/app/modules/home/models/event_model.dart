import 'package:tvent/app/constant_variable.dart';

class EventModel {
  int? id;
  int? organizerId;
  String? name;
  String? organizer;
  String? description;
  String? imageUrl;
  String? authorsImg;
  String? location;

  EventModel({
    this.id,
    this.name,
    this.organizerId,
    this.organizer,
    this.description,
    this.imageUrl,
    this.authorsImg,
    this.location,
  }) {
    if (imageUrl != null && id != null) {
      imageUrl = "$HOST_SERVER$imageUrl";
    }
    if (authorsImg != null && organizerId != null) {
      authorsImg =
          "$HOST_SERVER/storage/penyelenggara/logo/$organizerId/$authorsImg";
    }
  }
}
