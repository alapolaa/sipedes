import 'dart:convert';

class Surat {
  final String id;
  final String jenisSurat;
  final String status;
  final String tanggalPengajuan;
  final String tanggalSelesai;
  final String alasanPenolakan;

  Surat({
    required this.id,
    required this.jenisSurat,
    required this.status,
    required this.tanggalPengajuan,
    required this.tanggalSelesai,
    required this.alasanPenolakan,
  });

  factory Surat.fromJson(Map<String, dynamic> json) {
    return Surat(
      id: json['id'],
      jenisSurat: json['jenis_surat'],
      status: json['status'],
      tanggalPengajuan: json['tanggal_pengajuan'],
      tanggalSelesai: json['tanggal_selesai'],
      alasanPenolakan: json['alasan_penolakan'],
    );
  }

  static List<Surat> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => Surat.fromJson(e)).toList();
  }
}
