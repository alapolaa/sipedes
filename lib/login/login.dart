import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import '../navbar/navbar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                100.0.height,
                Image.asset(
                  ImgString.logo,
                  height: 250.h,
                  width: 300.w,
                ),
                50.0.height,
                SizedBox(
                  height: 50.h,
                  child: TextField(
                    controller: _nikController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'NIK',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),
                      hintText: 'Masukkan NIK anda...',
                      hintStyle: AppFont.empatbelas.copyWith(color: Colors.grey, fontStyle: FontStyle.italic),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                      ),
                    ),
                  ),
                ),
                25.h.height,
                SizedBox(
                  height: 50.h,
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Tanggal Lahir',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),
                      hintText: 'Masukkan tanggal lahir anda...',
                      hintStyle: AppFont.empatbelas.copyWith(color: Colors.grey, fontStyle: FontStyle.italic),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _selectDate(context),
                      ),
                    ),
                  ),
                ),
                75.h.height,
                SizedBox(
                  width: double.infinity,
                  height: 45.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.appbar,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MenuNavbar()),
                      );
                    },
                    child: Text(
                      'Masuk',
                      style: AppFont.empatbelas.copyWith(color: AppColor.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                20.h.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
