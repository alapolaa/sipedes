class BeritaModel {
  final String id;
  final String judul;
  final String tanggal;
  final String keterangan;
  final String gambar;

  BeritaModel({
    required this.id,
    required this.judul,
    required this.tanggal,
    required this.keterangan,
    required this.gambar,
  });

  factory BeritaModel.fromJson(Map<String, dynamic> json) {
    return BeritaModel(
      id: json['id_berita'],
      judul: json['judul'],
      tanggal: json['tanggal'],
      keterangan: json['keterangan'],
      gambar: json['gambar'],
    );
  }
}
