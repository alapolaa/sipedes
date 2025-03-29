import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

import 'package:intl/intl.dart';


class TambahSurat extends StatefulWidget {
  @override
  _TambahSuratState createState() => _TambahSuratState();
}

class _TambahSuratState extends State<TambahSurat> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController pekerjaanController = TextEditingController();
  TextEditingController keperluanController = TextEditingController();
  TextEditingController tempatLahirController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();

  String? agama;
  File? filePendukung;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePendukung = File(result.files.single.path!);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.20.202/slampang/api/domisili.php'),
    );

    request.fields['id_pengguna'] = '13';
    request.fields['nama_lengkap'] = namaController.text;
    request.fields['nik'] = nikController.text;
    request.fields['alamat'] = alamatController.text;
    request.fields['agama'] = agama ?? '';
    request.fields['pekerjaan'] = pekerjaanController.text;
    request.fields['keperluan'] = keperluanController.text;
    request.fields['tempat_lahir'] = tempatLahirController.text;
    request.fields['tanggal_lahir'] = tanggalLahirController.text;

    if (filePendukung != null) {
      request.files.add(
        await http.MultipartFile.fromPath('file_pendukung', filePendukung!.path),
      );
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pengajuan berhasil!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengajukan surat!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Pengajuan Domisili')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: namaController, decoration: InputDecoration(labelText: 'Nama Lengkap')),
              TextFormField(controller: nikController, decoration: InputDecoration(labelText: 'NIK'), keyboardType: TextInputType.number),
              TextFormField(controller: alamatController, decoration: InputDecoration(labelText: 'Alamat')),
              DropdownButtonFormField<String>(
                value: agama,
                items: ['Islam', 'Kristen', 'Hindu', 'Budha'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (val) => setState(() => agama = val),
                decoration: InputDecoration(labelText: 'Agama'),
              ),
              TextFormField(controller: pekerjaanController, decoration: InputDecoration(labelText: 'Pekerjaan')),
              TextFormField(controller: keperluanController, decoration: InputDecoration(labelText: 'Keperluan')),
              TextFormField(
                controller: tanggalLahirController,
                decoration: InputDecoration(labelText: 'Tanggal Lahir'),
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => tanggalLahirController.text = DateFormat('yyyy-MM-dd').format(picked));
                  }
                },
              ),
              TextFormField(controller: tempatLahirController, decoration: InputDecoration(labelText: 'Tempat Lahir')),
              ElevatedButton(onPressed: _pickFile, child: Text('Pilih File Pendukung')),
              SizedBox(height: 16),
              ElevatedButton(onPressed: _submitForm, child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}