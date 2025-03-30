import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/navbar/navbar.dart';
import '../data/api_service/api_service.dart';

class Sktm extends StatefulWidget {
  @override
  _SktmState createState() => _SktmState();
}

class _SktmState extends State<Sktm> {
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

    bool success = await apiService.submitSktmForm(
      idPengguna: idPengguna,
      namaLengkap: namaController.text,
      nik: nikController.text,
      alamat: alamatController.text,
      agama: agama ?? '',
      pekerjaan: pekerjaanController.text,
      keperluan: keperluanController.text,
      tempatLahir: tempatLahirController.text,
      tanggalLahir: tanggalLahirController.text,
      filePendukung: filePendukung,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pengajuan SKTM berhasil!')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuNavbar(initialIndex: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengajukan SKTM!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        title: Text(
          'Pengajuan SKTM',
          style: AppFont.duaempat.copyWith(color: AppColor.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0.sp),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(namaController, 'Nama Lengkap'),
              SizedBox(height: 12.h),
              _buildTextField(nikController, 'NIK', keyboardType: TextInputType.number),
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
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: Icon(Icons.attach_file),
                label: Text('Pilih File Pendukung KTP / KK'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.abu2,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r), // Ubah radius menjadi 10
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Kirim', style: TextStyle(fontSize: 20.sp,color: AppColor.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.appbar,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r), // Ubah radius menjadi 10
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType? keyboardType}) {
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