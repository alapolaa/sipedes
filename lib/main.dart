import 'package:flutter/material.dart';
import 'package:sipedes/home/home.dart';
import 'package:sipedes/login/login.dart';
import 'package:sipedes/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(402, 874),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(

          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
        );
      },
    );
  }
}


