import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendMessage(String name, String email, String subjeck, String message) async {
  final url = Uri.parse('http://192.168.20.202/slampang/api/kontak/kontak.php'); // Ganti dengan URL API

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "name": name,
      "email": email,
      "subjeck": subjeck,
      "message": message,
    }),
  );

  final responseData = jsonDecode(response.body);
  if (responseData['success']) {
    print("Pesan berhasil dikirim: ${responseData['message']}");
  } else {
    print("Gagal mengirim pesan: ${responseData['message']}");
  }
}
