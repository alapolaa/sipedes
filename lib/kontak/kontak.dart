import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';
import 'package:sipedes/kontak/pesan_terkirim.dart';

class Kontak extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        title: Text('Kontak',
            style: AppFont.duapuluhbold.copyWith(color: AppColor.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              'Jika Anda memiliki saran, kritik, atau masukan terkait Desa Larangan Slampar, '
              'silakan sampaikan melalui kontak resmi desa. Masukan Anda sangat berarti untuk '
              'mendukung pengembangan dan kemajuan desa secara bersama-sama.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppDimen.h20, vertical: AppDimen.w20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField('Nama Lengkap'),
                    15.0.height,
                    _buildTextField('Email'),
                    15.0.height,
                    _buildTextField('Subjek'),
                    15.0.height,
                    _buildTextField('Pesan', maxLines: 4),
                    50.0.height,
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PesanTerkirim()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.sukses,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                        ),
                        child: Text('Kirim Pesan',
                            style: AppFont.empatbelas
                                .copyWith(color: AppColor.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            50.0.height,
            FooterScreen()
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFont.empatbelas),
        5.0.height,
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Harap isi $label';
            }
            return null;
          },
        ),
      ],
    );
  }
}
