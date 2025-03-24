import 'package:sipedes/data/api_service/api_service.dart';

class BannerModel {
  final String id;
  final String gambar;
  final String judul;
  final String keterangan;

  BannerModel({
    required this.id,
    required this.gambar,
    required this.judul,
    required this.keterangan,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id_banner'],
      gambar: "${ApiService.baseUrl}/${json['gambar']}",
      judul: json['judul'],
      keterangan: json['keterangan'],
    );
  }
}
