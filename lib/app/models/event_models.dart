import 'package:tvent/app/constant_variable.dart';

class DataKategoriEvent {
  int id;
  String namaEvent;
  String deskripsi;
  String banner;
  Map<String, dynamic> penyelenggara;
  String tempat;
  DateTime tanggalPendaftaran;
  DateTime tanggalPenutupanPendaftaran;
  DateTime tanggalPelaksanaan;
  int kapasitas;
  List<String> kategoriPeserta;

  DataKategoriEvent({
    required this.id,
    required this.namaEvent,
    required this.deskripsi,
    required this.banner,
    required this.penyelenggara,
    required this.tempat,
    required this.tanggalPendaftaran,
    required this.tanggalPenutupanPendaftaran,
    required this.tanggalPelaksanaan,
    required this.kapasitas,
    required this.kategoriPeserta,
  });

  factory DataKategoriEvent.fromJson(Map<String, dynamic> json) {
    return DataKategoriEvent(
      id: json['id'] ?? 0,
      namaEvent: json['nama_event'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      banner: json['banner'] ?? '',
      penyelenggara: json['penyelenggara'] ?? {},
      tempat: json['tempat'] ?? '',
      tanggalPendaftaran: DateTime.parse(json['tanggal_pendaftaran'] ?? ''),
      tanggalPenutupanPendaftaran:
          DateTime.parse(json['tanggal_penutupan_pendaftaran'] ?? ''),
      tanggalPelaksanaan: DateTime.parse(json['tanggal_pelaksanaan'] ?? ''),
      kapasitas: json['kapasitas'] ?? 0,
      kategoriPeserta: List<String>.from(json['kategori_peserta'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_event': namaEvent,
        'deskripsi': deskripsi,
        'banner': banner,
        'penyelenggara': penyelenggara,
        'tempat': tempat,
        'tanggal_pendaftaran': tanggalPendaftaran.toIso8601String(),
        'tanggal_penutupan_pendaftaran':
            tanggalPenutupanPendaftaran.toIso8601String(),
        'tanggal_pelaksanaan': tanggalPelaksanaan.toIso8601String(),
        'kapasitas': kapasitas,
        'kategori_peserta': kategoriPeserta,
      };

  String getBannerUrl() {
    return '$HOST_SERVER/storage/banner/$id/$banner';
  }

  String getPenyelenggaraLogoUrl() {
    return '$HOST_SERVER/storage/penyelenggara/logo/${penyelenggara['id']}/${penyelenggara['logo']}';
  }
}
