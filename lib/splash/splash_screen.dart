import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/app_color.dart';
import 'package:sipedes/data/theme/app_font.dart';
import 'package:sipedes/data/theme/img_string.dart';

import '../login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appbar,
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImgString.logo,
                  width: 316.w,
                  height: 296.h,
                ),
                14.0.height,
                Text(
                  'Sistem Pelayanan Desa',
                  style: AppFont.duaempat,
                ),
                50.0.height,
                SpinKitCircle(
                  color: Colors.orange,
                  size: 100.0.sp,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                'LARANGAN SLAMPAR',
                style: AppFont.tigapuluh,
              ),
              12.0.height,
              Text(
                'PAMEKASAN',
                style: AppFont.empatpuluh,
              ),
              30.0.height, // Beri sedikit ruang dari bawah layar
            ],
          ),
        ],
      ),
    );
  }
}
