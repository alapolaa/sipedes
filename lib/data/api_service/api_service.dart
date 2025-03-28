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
import '../model/surat.dart';
import '../model/umkm.dart';
import '../model/visi_misi.dart';
import 'dart:io';


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
      print("Decoded JSON: $data");

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
      print("Decoded JSON: $data");

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
      print("Decoded JSON: $data");

      if (data['status'] == 'success') {
        return VisiMisiModel.fromJson(data);
      }
    }
    throw Exception('Gagal mengambil data visi misi');
  }

  // Fungsi Login

  Future<Map<String, dynamic>> login(String nik, String tanggalLahir) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/login.php"),
      body: {"nik": nik, "tanggal_lahir": tanggalLahir},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal menghubungi server!');
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
  //kontak
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
  // Ambil data profil pengguna
  Future<Map<String, dynamic>?> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id_user');

    if (userId == null) {
      return null;
    }

    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/api/profile/profile.php?id_user=$userId'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> result = json.decode(response.body);
        if (result['status'] == 'success') {
          return result['data'];
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }
  // Kirim formulir pengajuan surat domisili
  Future<bool> submitDomisiliForm(
      {required int idPengguna,
        required String namaLengkap,
        required String nik,
        required String alamat,
        required String agama,
        required String pekerjaan,
        required String keperluan,
        required String tempatLahir,
        required String tanggalLahir,
        File? filePendukung}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/api/domisili.php"),
    );

    request.fields['id_pengguna'] = idPengguna.toString();
    request.fields['nama_lengkap'] = namaLengkap;
    request.fields['nik'] = nik;
    request.fields['alamat'] = alamat;
    request.fields['agama'] = agama;
    request.fields['pekerjaan'] = pekerjaan;
    request.fields['keperluan'] = keperluan;
    request.fields['tempat_lahir'] = tempatLahir;
    request.fields['tanggal_lahir'] = tanggalLahir;

    if (filePendukung != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
            'file_pendukung', filePendukung.path),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  // Ambil data surat berdasarkan ID pengguna
  Future<List<Surat>> fetchSuratByUserId(String idPengguna) async {
    final String url = "$baseUrl/api/layanan_publik/surat.php?id_pengguna=$idPengguna";

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
  // Kirim pesan kontak
  Future<Map<String, dynamic>> kirimPesan(String name, String email, String subjek, String message) async {
    final url = Uri.parse("$baseUrl/api/kontak/kontak.php");
    final response = await http.post(
      url,
      body: {
        'name': name,
        'email': email,
        'subjeck': subjek,
        'message': message,
      },
    );

    final responseData = json.decode(response.body);
    return responseData;
  }

  // Kirim formulir pengajuan surat SKTM
  Future<bool> submitSktmForm(
      {required int idPengguna,
        required String namaLengkap,
        required String nik,
        required String alamat,
        required String agama,
        required String pekerjaan,
        required String keperluan,
        required String tempatLahir,
        required String tanggalLahir,
        File? filePendukung}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/api/sktm.php"), // Sesuaikan dengan nama file API SKTM Anda
    );

    request.fields['id_pengguna'] = idPengguna.toString();
    request.fields['nama_lengkap'] = namaLengkap;
    request.fields['nik'] = nik;
    request.fields['alamat'] = alamat;
    request.fields['agama'] = agama;
    request.fields['pekerjaan'] = pekerjaan;
    request.fields['keperluan'] = keperluan;
    request.fields['tempat_lahir'] = tempatLahir;
    request.fields['tanggal_lahir'] = tanggalLahir;

    if (filePendukung != null) {
      request.files.add(
        await http.MultipartFile.fromPath('file_pendukung', filePendukung.path),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Kirim formulir pengajuan surat usaha
  Future<bool> submitUsahaForm(
      {required int idPengguna,
        required String namaLengkap,
        required String nik,
        required String alamat,
        required String agama,
        required String pekerjaan,
        required String keperluan,
        required String tempatLahir,
        required String tanggalLahir,
        required String jenisUsaha,
        File? filePendukung}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/api/usaha.php"), // Sesuaikan dengan nama file API usaha Anda
    );

    request.fields['id_pengguna'] = idPengguna.toString();
    request.fields['nama_lengkap'] = namaLengkap;
    request.fields['nik'] = nik;
    request.fields['alamat'] = alamat;
    request.fields['agama'] = agama;
    request.fields['pekerjaan'] = pekerjaan;
    request.fields['keperluan'] = keperluan;
    request.fields['tempat_lahir'] = tempatLahir;
    request.fields['tanggal_lahir'] = tanggalLahir;
    request.fields['jenis_usaha'] = jenisUsaha;

    if (filePendukung != null) {
      request.files.add(
        await http.MultipartFile.fromPath('file_pendukung', filePendukung.path),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  // Kirim formulir pengajuan surat keterangan belum menikah
  Future<bool> submitBelumMenikahForm(
      {required int idPengguna,
        required String namaLengkap,
        required String nik,
        required String alamat,
        required String agama,
        required String pekerjaan,
        required String keperluan,
        required String tempatLahir,
        required String tanggalLahir,
        required String statusPernikahan,
        File? filePendukung}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/api/nikah.php"), // Sesuaikan dengan nama file API belum menikah Anda
    );

    request.fields['id_pengguna'] = idPengguna.toString();
    request.fields['nama_lengkap'] = namaLengkap;
    request.fields['nik'] = nik;
    request.fields['alamat'] = alamat;
    request.fields['agama'] = agama;
    request.fields['pekerjaan'] = pekerjaan;
    request.fields['keperluan'] = keperluan;
    request.fields['tempat_lahir'] = tempatLahir;
    request.fields['tanggal_lahir'] = tanggalLahir;
    request.fields['status_pernikahan'] = statusPernikahan;

    if (filePendukung != null) {
      request.files.add(
        await http.MultipartFile.fromPath('file_pendukung', filePendukung.path),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  // Kirim formulir pengajuan surat tanah
  Future<http.Response> submitTanahForm(
      {required int idPengguna,
        required String namaLengkap,
        required String nik,
        required String alamat,
        required String agama,
        required String pekerjaan,
        required String keperluan,
        required String tempatLahir,
        required String tanggalLahir,
        required String statusTanah,
        required String luasTanah,
        required String letakTanah,
        required String statusKepemilikan,
        required String batasUtara,
        required String batasSelatan,
        required String batasTimur,
        required String batasBarat,
        File? filePendukung,
        File? buktiKepemilikan}) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("$baseUrl/api/tanah.php"), // Sesuaikan URL API
    );

    request.fields['id_pengguna'] = idPengguna.toString();
    request.fields['nama_lengkap'] = namaLengkap;
    request.fields['nik'] = nik;
    request.fields['alamat'] = alamat;
    request.fields['agama'] = agama;
    request.fields['pekerjaan'] = pekerjaan;
    request.fields['keperluan'] = keperluan;
    request.fields['tempat_lahir'] = tempatLahir;
    request.fields['tanggal_lahir'] = tanggalLahir;
    request.fields['status_tanah'] = statusTanah;
    request.fields['luas_tanah'] = luasTanah;
    request.fields['letak_tanah'] = letakTanah;
    request.fields['status_kepemilikan'] = statusKepemilikan;
    request.fields['batas_utara'] = batasUtara;
    request.fields['batas_selatan'] = batasSelatan;
    request.fields['batas_timur'] = batasTimur;
    request.fields['batas_barat'] = batasBarat;

    if (filePendukung != null) {
      request.files.add(
        await http.MultipartFile.fromPath('file_pendukung', filePendukung.path),
      );
    }

    if (buktiKepemilikan != null) {
      request.files.add(
        await http.MultipartFile.fromPath('bukti_kepemilikan', buktiKepemilikan.path),
      );
    }

    var response = await request.send();
    return http.Response.fromStream(response); // Mengembalikan http.Response
  }
}
