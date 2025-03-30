import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipedes/navbar/navbar.dart';
import '../data/api_service/api_service.dart';

class Tanah extends StatefulWidget {
  @override
  _TanahState createState() => _TanahState();
}

class _TanahState extends State<Tanah> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController pekerjaanController = TextEditingController();
  TextEditingController keperluanController = TextEditingController();
  TextEditingController tempatLahirController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController statusTanahController = TextEditingController();
  TextEditingController luasTanahController = TextEditingController();
  TextEditingController letakTanahController = TextEditingController();
  TextEditingController statusKepemilikanController = TextEditingController();
  TextEditingController batasUtaraController = TextEditingController();
  TextEditingController batasSelatanController = TextEditingController();
  TextEditingController batasTimurController = TextEditingController();
  TextEditingController batasBaratController = TextEditingController();

  String? agama;
  File? filePendukung;
  File? buktiKepemilikan;
  ApiService apiService = ApiService();

  Future<void> _pickFile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      if (type == 'file_pendukung') {
        setState(() {
          filePendukung = File(result.files.single.path!);
        });
      } else if (type == 'bukti_kepemilikan') {
        setState(() {
          buktiKepemilikan = File(result.files.single.path!);
        });
      }
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

    try {
      var response = await apiService.submitTanahForm(
        idPengguna: idPengguna,
        namaLengkap: namaController.text,
        nik: nikController.text,
        alamat: alamatController.text,
        agama: agama ?? '',
        pekerjaan: pekerjaanController.text,
        keperluan: keperluanController.text,
        tempatLahir: tempatLahirController.text,
        tanggalLahir: tanggalLahirController.text,
        statusTanah: statusTanahController.text,
        luasTanah: luasTanahController.text,
        letakTanah: letakTanahController.text,
        statusKepemilikan: statusKepemilikanController.text,
        batasUtara: batasUtaraController.text,
        batasSelatan: batasSelatanController.text,
        batasTimur: batasTimurController.text,
        batasBarat: batasBaratController.text,
        filePendukung: filePendukung,
        buktiKepemilikan: buktiKepemilikan,
      );

      print('Status Kode: ${response.statusCode}');
      print('Isi Respons: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Pengajuan surat tanah berhasil!')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MenuNavbar(initialIndex: 3),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengajukan surat tanah!')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengajukan surat tanah!')),
        );
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Form Pengajuan Surat Tanah')),
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
                  controller: statusTanahController,
                  decoration: InputDecoration(labelText: 'Status Tanah')),
              TextFormField(
                  controller: luasTanahController,
                  decoration: InputDecoration(labelText: 'Luas Tanah')),
              TextFormField(
                  controller: letakTanahController,
                  decoration: InputDecoration(labelText: 'Letak Tanah')),
              TextFormField(
                  controller: statusKepemilikanController,
                  decoration: InputDecoration(labelText: 'Status Kepemilikan')),
              TextFormField(
                  controller: batasUtaraController,
                  decoration: InputDecoration(labelText: 'Batas Utara')),
              TextFormField(
                  controller: batasSelatanController,
                  decoration: InputDecoration(labelText: 'Batas Selatan')),
              TextFormField(
                  controller: batasTimurController,
                  decoration: InputDecoration(labelText: 'Batas Timur')),
              TextFormField(
                  controller: batasBaratController,
                  decoration: InputDecoration(labelText: 'Batas Barat')),
              ElevatedButton(
                  onPressed: () => _pickFile('file_pendukung'),
                  child: Text('Pilih File Pendukung')),
              ElevatedButton(
                  onPressed: () => _pickFile('bukti_kepemilikan'),
                  child: Text('Pilih Bukti Kepemilikan')),
              SizedBox(height: 16),
              ElevatedButton(onPressed: _submitForm, child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}