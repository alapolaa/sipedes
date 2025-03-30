import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipedes/data/theme/theme.dart';
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
        SnackBar(
            content:
                Text('ID Pengguna tidak ditemukan. Silakan login kembali.')),
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
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        title: Text(
          'Pengajuan Surat Tanah',
          style: AppFont.duaempat.copyWith(color: AppColor.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(namaController, 'Nama Lengkap'),
              SizedBox(height: 12.h),
              _buildTextField(nikController, 'NIK',
                  keyboardType: TextInputType.number),
              SizedBox(height: 12.h),
              _buildTextField(alamatController, 'Alamat'),
              SizedBox(height: 12.h),
              DropdownButtonFormField<String>(
                value: agama,
                items: ['Islam', 'Kristen', 'Hindu', 'Budha']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => agama = val),
                decoration: InputDecoration(
                  labelText: 'Agama',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12.h),
              _buildTextField(pekerjaanController, 'Pekerjaan'),
              SizedBox(height: 12.h),
              _buildTextField(keperluanController, 'Keperluan'),
              SizedBox(height: 12.h),
              TextFormField(
                controller: tanggalLahirController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
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
              SizedBox(height: 12.h),
              _buildTextField(tempatLahirController, 'Tempat Lahir'),
              SizedBox(height: 12.h),
              _buildTextField(statusTanahController, 'Status Tanah'),
              SizedBox(height: 12.h),
              TextFormField(
                controller: luasTanahController,
                decoration: InputDecoration(
                  labelText: 'Luas Tanah',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, // Perubahan di sini
              ),
              SizedBox(height: 12.h),
              _buildTextField(letakTanahController, 'Letak Tanah'),
              SizedBox(height: 12.h),
              _buildTextField(
                  statusKepemilikanController, 'Status Kepemilikan'),
              SizedBox(height: 12.h),
              _buildTextField(batasUtaraController, 'Batas Utara'),
              SizedBox(height: 12.h),
              _buildTextField(batasSelatanController, 'Batas Selatan'),
              SizedBox(height: 12.h),
              _buildTextField(batasTimurController, 'Batas Timur'),
              SizedBox(height: 12.h),
              _buildTextField(batasBaratController, 'Batas Barat'),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => _pickFile('file_pendukung'),
                icon: Icon(Icons.attach_file),
                label: Text('Pilih File Pendukung KTP / KK'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.abu2,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              ElevatedButton.icon(
                onPressed: () => _pickFile('bukti_kepemilikan'),
                icon: Icon(Icons.attach_file),
                label: Text('Upload Bukti Kepemilikan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.abu2,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Kirim',
                    style: TextStyle(fontSize: 20.sp, color: AppColor.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.appbar,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
    );
  }
}
