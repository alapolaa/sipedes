class StrukturDesaModel {
  final String? id;
  final String nama;
  final String jabatan;
  final String gambar;

  StrukturDesaModel({
    required this.id,
    required this.nama,
    required this.jabatan,
    required this.gambar,
  });

  factory StrukturDesaModel.fromJson(Map<String, dynamic> json) {
    return StrukturDesaModel(
      id: json['id'],
      nama: json['nama'],
      jabatan: json['jabatan'],
      gambar: json['gambar'],
    );
  }
}
