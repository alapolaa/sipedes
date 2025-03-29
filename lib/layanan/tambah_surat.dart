import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class TambahSurat extends StatefulWidget {
  @override
  _TambahSuratState createState() => _TambahSuratState();
}

class _TambahSuratState extends State<TambahSurat> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController agamaController = TextEditingController();
  final TextEditingController pekerjaanController = TextEditingController();
  final TextEditingController keperluanController = TextEditingController();

  File? _file;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    var uri = Uri.parse("http://192.168.20.202/slampang/api/domisili.php");
    var request = http.MultipartRequest("POST", uri);

    request.fields['nama_lengkap'] = namaController.text;
    request.fields['tempat_lahir'] = tempatLahirController.text;
    request.fields['tanggal_lahir'] = tanggalLahirController.text;
    request.fields['nik'] = nikController.text;
    request.fields['alamat'] = alamatController.text;
    request.fields['agama'] = agamaController.text;
    request.fields['pekerjaan'] = pekerjaanController.text;
    request.fields['keperluan'] = keperluanController.text;

    if (_file != null) {
      request.files.add(await http.MultipartFile.fromPath("file_pendukung", _file!.path));
    }

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(responseData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(jsonResponse['message'])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pengajuan Surat Domisili")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: namaController, decoration: InputDecoration(labelText: "Nama Lengkap"), validator: (value) => value!.isEmpty ? "Harap isi nama" : null),
              TextFormField(controller: tempatLahirController, decoration: InputDecoration(labelText: "Tempat Lahir")),
              TextFormField(controller: tanggalLahirController, decoration: InputDecoration(labelText: "Tanggal Lahir")),
              TextFormField(controller: nikController, decoration: InputDecoration(labelText: "NIK")),
              TextFormField(controller: alamatController, decoration: InputDecoration(labelText: "Alamat")),
              TextFormField(controller: agamaController, decoration: InputDecoration(labelText: "Agama")),
              TextFormField(controller: pekerjaanController, decoration: InputDecoration(labelText: "Pekerjaan")),
              TextFormField(controller: keperluanController, decoration: InputDecoration(labelText: "Keperluan")),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text("Pilih File Pendukung"),
              ),
              SizedBox(height: 10),
              _file != null ? Text("File: ${_file!.path.split('/').last}") : Text("Tidak ada file dipilih"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Kirim Pengajuan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
