import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/banner.dart';

class ApiService {
  static const String baseUrl = "http://192.168.20.202/slampang";
  static const String baseImageUrl = "$baseUrl/uploads";

  // Ambil data banner
  Future<List<BannerModel>> fetchBanners() async {
    final response = await http.get(Uri.parse("$baseUrl/api/home/banner.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return (data['data'] as List)
            .map((e) => BannerModel.fromJson(e))
            .toList();
      }
    }
    throw Exception('Gagal mengambil data banner');
  }



}
