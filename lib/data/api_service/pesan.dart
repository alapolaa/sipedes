import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> kirimPengajuanSurat(Map<String, dynamic> data) async {
  final url = Uri.parse('http://192.168.20.202/slampang/api/layanan_publik/pengajuan_surat.php');

  try {
    var request = http.MultipartRequest('POST', url);

    // Tambahkan data teks
    data.forEach((key, value) {
      if (value != null) {
        request.fields[key] = value.toString();
      }
    });

    // Tambahkan file (jika ada)
    if (data['file_pendukung'] != null) {
      request.files.add(await http.MultipartFile.fromPath('file_pendukung', data['file_pendukung']));
    }

    if (data['bukti_kepemilikan'] != null) {
      request.files.add(await http.MultipartFile.fromPath('bukti_kepemilikan', data['bukti_kepemilikan']));
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final decodedResponse = json.decode(responseBody);

    if (response.statusCode == 200) {
      print('Pengajuan berhasil: ${decodedResponse['message']}');
    } else {
      print('Gagal mengirim pengajuan: ${decodedResponse['message']}');
    }
  } catch (e) {
    print('Error: $e');
  }
}