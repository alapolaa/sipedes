import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/navbar/navbar.dart';

import '../login/login.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: AppFont.duapuluhbold.copyWith(color: AppColor.white),
        ),
        centerTitle: true,
        backgroundColor: AppColor.appbar,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama Lengkap",
              style: AppFont.duabelasbold,
            ),
            4.0.height,
            SizedBox(
              height: 50.h,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                ),
              ),
            ),
            10.0.height,
            Text(
              "Tanggal Lahir",
              style: AppFont.duabelasbold,
            ),
            4.0.height,
            SizedBox(
              height: 50.h,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                ),
              ),
            ),
            10.0.height,
            Text(
              "Alamat",
              style: AppFont.duabelasbold,
            ),
            4.0.height,
            SizedBox(
              height: 50.h,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                ),
              ),
            ),
            10.0.height,
            Text(
              "No. HP",
              style: AppFont.duabelasbold,
            ),
            4.0.height,
            SizedBox(
              height: 50.h,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                ),
              ),
            ),
            10.0.height,
            Text(
              "Email",
              style: AppFont.duabelasbold,
            ),
            4.0.height,
            SizedBox(
              height: 50.h,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.sp),
                    ),
                  ),
                ),
              ),
            ),
            10.0.height,
            SizedBox(
              height: 45.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MenuNavbar()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Simpan',
                  style: AppFont.empatbelas.copyWith(color: AppColor.white),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 45.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MenuNavbar()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Batal',
                  style: AppFont.empatbelas.copyWith(color: AppColor.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
