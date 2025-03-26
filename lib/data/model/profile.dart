class Profile {
  final String id;
  final String nama;
  final String nik;
  final String tanggalLahir;
  final String alamat;
  final String noHp;
  final String? email;

  Profile({
    required this.id,
    required this.nama,
    required this.nik,
    required this.tanggalLahir,
    required this.alamat,
    required this.noHp,
    this.email,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      nama: json['nama'],
      nik: json['nik'],
      tanggalLahir: json['tanggal_lahir'],
      alamat: json['alamat'],
      noHp: json['no_hp'],
      email: json['email'],
    );
  }
}
