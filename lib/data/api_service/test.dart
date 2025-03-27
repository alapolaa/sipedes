import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/surat.dart';

class ApiService {
  static const String baseUrl =
      'http://192.168.20.202/slampang/api/layanan_publik/surat.php';

  Future<List<Surat>> fetchSurat(String sessionId) async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Cookie': 'PHPSESSID=$sessionId',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return Surat.fromJsonList(data['pengajuan_surat']);
      }
    }
    throw Exception('Gagal mengambil data surat');
  }
}
