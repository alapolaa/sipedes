class SejarahDesaModel {
  final String idSejarah;
  final String gambar;
  final String keterangan;

  SejarahDesaModel({
    required this.idSejarah,
    required this.gambar,
    required this.keterangan,
  });

  factory SejarahDesaModel.fromJson(Map<String, dynamic> json) {
    return SejarahDesaModel(
      idSejarah: json['id_sejarah'],
      gambar: json['gambar'],
      keterangan: json['keterangan'],
    );
  }
}
