import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/banner.dart';
import '../model/galeri.dart';
import '../model/potensi_desa.dart';
import '../model/sejarah.dart';
import '../model/umkm.dart';
import '../model/visi_misi.dart';

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

  // Ambil data galeri
  Future<List<GalleryModel>> fetchGallery() async {
    final response = await http.get(Uri.parse("$baseUrl/api/home/galeri.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return (data['data'] as List)
            .map((e) => GalleryModel.fromJson(e))
            .toList();
      }
    }
    throw Exception('Gagal mengambil data galeri');
  }

  // Ambil data potensi desa
  Future<List<PotensiDesaModel>> fetchPotensiDesa() async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/home/potensi_desa.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return (data['data'] as List)
            .map((e) => PotensiDesaModel.fromJson(e))
            .toList();
      }
    }
    throw Exception('Gagal mengambil data potensi desa');
  }

  // Ambil data UMKM Desa
  Future<List<UmkmDesaModel>> fetchUmkmDesa() async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/home/umkm_desa.php"));

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Decoded JSON: $data"); // Debug JSON

      if (data['status'] == 'success') {
        return (data['data'] as List)
            .map((e) => UmkmDesaModel.fromJson(e))
            .toList();
      }
    }
    throw Exception('Gagal mengambil data UMKM Desa');
  }

  // Ambil data sejarah desa
  Future<List<SejarahDesaModel>> fetchSejarahDesa() async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/profile_desa/sejarah.php"));

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Decoded JSON: $data"); // Debug JSON

      if (data['status'] == 'success') {
        return (data['data'] as List)
            .map((e) => SejarahDesaModel.fromJson(e))
            .toList();
      }
    }
    throw Exception('Gagal mengambil data sejarah desa');
  }

  Future<VisiMisiModel> fetchVisiMisi() async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/profile_desa/visi_misi.php"));

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Decoded JSON: $data"); // Debug JSON

      if (data['status'] == 'success') {
        return VisiMisiModel.fromJson(data);
      }
    }
    throw Exception('Gagal mengambil data visi misi');
  }
}
