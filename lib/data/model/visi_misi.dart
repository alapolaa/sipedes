class VisiMisiModel {
  final String visi;
  final List<String> misi;

  VisiMisiModel({required this.visi, required this.misi});

  factory VisiMisiModel.fromJson(Map<String, dynamic> json) {
    return VisiMisiModel(
      visi: json['visi'],
      misi: List<String>.from(json['misi']),
    );
  }
}
