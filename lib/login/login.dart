import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/navbar/navbar.dart';




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
        padding: EdgeInsets.symmetric(horizontal: AppDimen.w20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                100.0.height,
                Image.asset(
                  ImgString.logo,
                  height: 296.h,
                  width: 316.w,
                ),
                70.0.height,
                TextField(
                  controller: _nikController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'NIK',
                    hintText: 'Masukkan NIK anda...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.sp),
                      ),
                    ),
                  ),
                ),
                25.0.height,
                // Input Tanggal Lahir
                TextField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Lahir',
                    hintText: 'Masukkan tanggal lahir anda...',
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
                75.0.height,

                // Tombol Masuk
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.appbar,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', true); // Simpan status login

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MenuNavbar()),
                      );
                    },
                    child:  Text(
                      'Masuk',
                      style: AppFont.duapuluhbold.copyWith(color: AppColor.white)
                    ),
                  ),
                ),
                20.0.height
              ],
            ),
          ),
        ),
      ),
    );
  }
}
