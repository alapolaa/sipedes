import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/app_color.dart';
import 'package:sipedes/data/theme/app_dimen.dart';
import 'package:sipedes/data/theme/app_font.dart';
import 'package:sipedes/data/theme/img_string.dart';

import '../data/api_service/api_service.dart';
import '../navbar/navbar.dart';
import 'package:intl/intl.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController nikController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  bool isLoading = false;
  final ApiService _apiService = ApiService();

  Future<void> _login() async {
    String nik = nikController.text.trim();
    String tanggalLahir = tanggalLahirController.text.trim();

    if (nik.isEmpty || tanggalLahir.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("NIK dan Tanggal Lahir wajib diisi!")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final data = await _apiService.login(nik, tanggalLahir);

      if (data['status'] == 'success') {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setInt('id_user', data['data']['id']);
        await prefs.setString('nik', nik);
        await prefs.setString('nama', data['data']['nama']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MenuNavbar()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      tanggalLahirController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimen.w20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                120.0.height,
                Image.asset(
                  ImgString.logo,
                  width: 250.w,
                ),
                50.0.height,
                TextField(
                  controller: nikController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "NIK",
                    labelStyle:
                    TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),

                  ),
                  style: TextStyle(fontSize: 16.0.sp),
                  maxLines: 1,
                  minLines: 1,
                ),
                20.0.height,
                TextField(
                  controller: tanggalLahirController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Tanggal Lahir (Tahun-Bulan-Tanggal)",
                    labelStyle:
                    TextStyle(fontSize: 14.sp, fontStyle: FontStyle.italic),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today, size: 22.sp),
                      onPressed: () => _selectDate(context),
                    ),

                  ),
                  style: TextStyle(fontSize: 16.0.sp),
                  maxLines: 1,
                  minLines: 1,
                ),
                50.0.height,
                SizedBox(
                  width: double.infinity,
                  height: 50.0.h,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.appbar,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text("Masuk",
                        style: AppFont.tombolteks
                            .copyWith(color: AppColor.white)),
                  ),
                ),
                20.0.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}