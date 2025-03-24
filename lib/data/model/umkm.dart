class UmkmDesaModel {
  final int idUmkm;
  final String title;
  final String keterangan;
  final int idAdmin;

  UmkmDesaModel({
    required this.idUmkm,
    required this.title,
    required this.keterangan,
    required this.idAdmin,
  });

  factory UmkmDesaModel.fromJson(Map<String, dynamic> json) {
    return UmkmDesaModel(
      idUmkm: int.parse(json['id_umkm']),
      title: json['title'],
      keterangan: json['keterangan'],
      idAdmin: int.parse(json['id_admin']),
    );
  }
}
