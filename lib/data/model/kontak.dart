class Kontak {
  final int id;
  final String name;
  final String email;
  final String subjeck;
  final String message;

  Kontak({
    required this.id,
    required this.name,
    required this.email,
    required this.subjeck,
    required this.message,
  });

  factory Kontak.fromJson(Map<String, dynamic> json) {
    return Kontak(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      subjeck: json['subjeck'],
      message: json['message'],
    );
  }
}
