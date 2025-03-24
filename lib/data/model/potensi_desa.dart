import '../api_service/api_service.dart';

class PotensiDesaModel {
  final String id;
  final String gambar;
  final String keterangan;
  final String idAdmin;

  PotensiDesaModel({
    required this.id,
    required this.gambar,
    required this.keterangan,
    required this.idAdmin,
  });

  factory PotensiDesaModel.fromJson(Map<String, dynamic> json) {
    return PotensiDesaModel(
      id: json['id'],
      gambar: "${ApiService.baseUrl}/uploads/${json['gambar']}",
      keterangan: json['keterangan'],
      idAdmin: json['id_admin'],
    );
  }
}
