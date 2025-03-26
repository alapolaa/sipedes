import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/navbar/navbar.dart';

import '../data/theme/app_color.dart';
import '../data/theme/app_dimen.dart';
import '../data/theme/app_font.dart';
import '../data/theme/img_string.dart';

class PesanTerkirim extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppDimen.w20),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(ImgString.sukses, height: 225.h, width: 225.w),
              Text(
                'Pesan Anda berhasil dikirim!',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              80.0.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (conte) => MenuNavbar()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.sukses,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text('Ok',
                      style: AppFont.nambelas.copyWith(color: AppColor.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PesanError extends StatelessWidget {
  final String message;

  PesanError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: AppDimen.w20),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 225.h, color: Colors.red),
              Text(
                message,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              80.0.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text('Ok',
                      style: AppFont.nambelas.copyWith(color: AppColor.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
