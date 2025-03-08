import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/app_color.dart';
import 'package:sipedes/data/theme/app_font.dart';
import 'package:sipedes/data/theme/img_string.dart';

import '../home/home.dart';

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
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appbar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  100.0.height,
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
                ],
              ),
            ),
            SpinKitCircle(
              color: Colors.orange,
              size: 100.0.sp,
            ),
            100.0.height,
            Text(
              'LARANGAN SLAMPAR',
              style: AppFont.tigapuluh,
            ),
            12.0.height,
            Text(
              'PAMEKASAN',
              style: AppFont.empatpuluh,
            ),
          ],
        ),
      ),
    );
  }
}
