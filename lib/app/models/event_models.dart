import 'package:tvent/app/constant_variable.dart';

class DataKategoriEvent {
  int id;
  String namaEvent;
  String deskripsi;
  String banner;
  Map<String, dynamic> penyelenggara;
  String tempat;
  String getBannerUrl() {
    return '$HOST_SERVER/storage/banner/$id/$banner';
  }

  String getPenyelenggaraLogoUrl() {
    return '$HOST_SERVER/storage/penyelenggara/logo/${penyelenggara['id']}/${penyelenggara['logo']}';
  }

  DataKategoriEvent({
    required this.id,
    required this.namaEvent,
    required this.deskripsi,
    required this.banner,
    required this.penyelenggara,
    required this.tempat,
  });

  factory DataKategoriEvent.fromJson(Map<String, dynamic> json) {
    return DataKategoriEvent(
      id: json['id'] ?? 0,
      namaEvent: json['nama_event'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      banner: json['banner'] ?? '',
      penyelenggara: json['penyelenggara'] ?? {},
      tempat: json['tempat'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_event': namaEvent,
        'deskripsi': deskripsi,
        'banner': banner,
        'penyelenggara': penyelenggara,
        'tempat': tempat,
      };
}
