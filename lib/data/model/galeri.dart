

import '../api_service/api_service.dart';



class GalleryModel {
  final String id;
  final String gambar;
  final String idAdmin;

  GalleryModel({
    required this.id,
    required this.gambar,
    required this.idAdmin,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['id_galery'],
      gambar: "${ApiService.baseUrl}/uploads/${json['gambar']}", // Pastikan gambar dari folder uploads
      idAdmin: json['id_admin'],
    );
  }
}

