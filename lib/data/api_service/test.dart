import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/surat.dart';


class ApiService {
  Future<List<Surat>> fetchSuratByUserId(String idPengguna) async {
    final String url = "http://192.168.20.202/slampang/api/layanan_publik/surat.php?id_pengguna=$idPengguna";

    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        List<dynamic> suratList = data['pengajuan_surat'];
        return suratList.map((json) => Surat.fromJson(json)).toList();
      } else {
        throw Exception("Gagal mengambil data");
      }
    } else {
      throw Exception("Gagal terhubung ke server");
    }
  }
}
