class PengumumanModel {
  final String id;
  final String judul;
  final String keterangan;
  final String tanggal;
  final String detailUrl;

  PengumumanModel({
    required this.id,
    required this.judul,
    required this.keterangan,
    required this.tanggal,
    required this.detailUrl,
  });

  factory PengumumanModel.fromJson(Map<String, dynamic> json) {
    return PengumumanModel(
      id: json['id_pengumuman'],
      judul: json['judul'],
      keterangan: json['keterangan'],
      tanggal: json['tanggal'],
      detailUrl: json['detail_url'],
    );
  }
}
