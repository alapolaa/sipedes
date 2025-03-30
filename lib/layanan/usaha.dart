import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipedes/navbar/navbar.dart';
import '../data/api_service/api_service.dart';

class Usaha extends StatefulWidget {
  @override
  _UsahaState createState() => _UsahaState();
}

class _UsahaState extends State<Usaha> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController pekerjaanController = TextEditingController();
  TextEditingController keperluanController = TextEditingController();
  TextEditingController tempatLahirController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController jenisUsahaController = TextEditingController();

  String? agama;
  File? filePendukung;
  ApiService apiService = ApiService();

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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idPengguna = prefs.getInt('id_user');

    if (idPengguna == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ID Pengguna tidak ditemukan. Silakan login kembali.')),
      );
      return;
    }

    bool success = await apiService.submitUsahaForm(
      idPengguna: idPengguna,
      namaLengkap: namaController.text,
      nik: nikController.text,
      alamat: alamatController.text,
      agama: agama ?? '',
      pekerjaan: pekerjaanController.text,
      keperluan: keperluanController.text,
      tempatLahir: tempatLahirController.text,
      tanggalLahir: tanggalLahirController.text,
      jenisUsaha: jenisUsahaController.text,
      filePendukung: filePendukung,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pengajuan surat usaha berhasil!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuNavbar(initialIndex: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengajukan surat usaha!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Pengajuan Surat Usaha')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: namaController,
                  decoration: InputDecoration(labelText: 'Nama Lengkap')),
              TextFormField(
                  controller: nikController,
                  decoration: InputDecoration(labelText: 'NIK'),
                  keyboardType: TextInputType.number),
              TextFormField(
                  controller: alamatController,
                  decoration: InputDecoration(labelText: 'Alamat')),
              DropdownButtonFormField<String>(
                value: agama,
                items: ['Islam', 'Kristen', 'Hindu', 'Budha']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => agama = val),
                decoration: InputDecoration(labelText: 'Agama'),
              ),
              TextFormField(
                  controller: pekerjaanController,
                  decoration: InputDecoration(labelText: 'Pekerjaan')),
              TextFormField(
                  controller: keperluanController,
                  decoration: InputDecoration(labelText: 'Keperluan')),
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
                    setState(() => tanggalLahirController.text =
                        DateFormat('yyyy-MM-dd').format(picked));
                  }
                },
              ),
              TextFormField(
                  controller: tempatLahirController,
                  decoration: InputDecoration(labelText: 'Tempat Lahir')),
              TextFormField(
                  controller: jenisUsahaController,
                  decoration: InputDecoration(labelText: 'Jenis Usaha')),
              ElevatedButton(
                  onPressed: _pickFile, child: Text('Pilih File Pendukung')),
              SizedBox(height: 16),
              ElevatedButton(onPressed: _submitForm, child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}