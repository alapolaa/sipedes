import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.20.202/slampang";
  static const String baseImageUrl = "$baseUrl/uploads";

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
}
