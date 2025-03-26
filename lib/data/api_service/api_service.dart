import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/banner.dart';
import '../model/berita.dart';
import '../model/galeri.dart';
import '../model/kegiatan.dart';
import '../model/kontak.dart';
import '../model/pengumuman.dart';
import '../model/potensi_desa.dart';
import '../model/sejarah.dart';
import '../model/struktur.dart';
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

  // Fungsi Login
  Future<Map<String, dynamic>> login(String nik, String tanggalLahir) async {
    final String url = "$baseUrl/api/login.php";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'nik': nik,
          'tanggal_lahir': tanggalLahir,
        },
      );

      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('user_nik', nik);
      }

      return data;
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // Ambil data struktur desa
  Future<List<StrukturDesaModel>> fetchStrukturDesa() async {
    final response = await http
        .get(Uri.parse("$baseUrl/api/profile_desa/struktur_desa.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List)
          .map((e) => StrukturDesaModel.fromJson(e))
          .toList();
    }
    throw Exception('Gagal mengambil data struktur desa');
  }

  // Ambil data berita
  Future<List<BeritaModel>> fetchBerita() async {
    final response =
        await http.get(Uri.parse("$baseUrl/api/informasi_desa/berita.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['data'] != null) {
        return (data['data'] as List)
            .map((e) => BeritaModel.fromJson(e))
            .toList();
      }
    }
    throw Exception('Gagal mengambil data berita');
  }
  // Ambil data kegiatan
  Future<List<KegiatanModel>> fetchKegiatan() async {
    final response = await http.get(Uri.parse("$baseUrl/api/informasi_desa/kegiatan.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('data')) {
        return (data['data'] as List)
            .map((e) => KegiatanModel.fromJson(e))
            .toList();
      }
    }
    throw Exception('Gagal mengambil data kegiatan');
  }
  // Ambil data pengumuman
  Future<List<PengumumanModel>> fetchPengumuman() async {
    final response =
    await http.get(Uri.parse("$baseUrl/api/informasi_desa/pengumuman.php"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List)
          .map((e) => PengumumanModel.fromJson(e))
          .toList();
    }
    throw Exception('Gagal mengambil data pengumuman');
  }
  Future<List<Kontak>> fetchKontak() async {
    final response = await http.get(Uri.parse("$baseUrl/api/kontak.php"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        return (data['data'] as List)
            .map((json) => Kontak.fromJson(json))
            .toList();
      }
    }
    throw Exception("Gagal mengambil data kontak");
  }
}
