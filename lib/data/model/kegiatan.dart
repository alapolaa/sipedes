class KegiatanModel {
  final String idKegiatan;
  final String gambar;
  final String namaKegiatan;
  final String keterangan;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String lokasi;

  KegiatanModel({
    required this.idKegiatan,
    required this.gambar,
    required this.namaKegiatan,
    required this.keterangan,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.lokasi,
  });

  factory KegiatanModel.fromJson(Map<String, dynamic> json) {
    return KegiatanModel(
      idKegiatan: json['id_kegiatan'],
      gambar: json['gambar'],
      namaKegiatan: json['nama_kegiatan'],
      keterangan: json['keterangan'],
      tanggalMulai: json['tanggal_mulai'],
      tanggalSelesai: json['tanggal_selesai'],
      lokasi: json['lokasi'],
    );
  }
}
