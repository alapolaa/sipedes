import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipedes/login/login.dart';
import 'package:sipedes/navbar/navbar.dart';

import 'package:sipedes/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Aplikasi Desa',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder<bool?>(
            future: _checkFirstLaunchAndLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SplashScreen();
              } else if (snapshot.hasError) {
                return LoginPage();
              } else {
                bool result = snapshot.data ?? false;
                if (result == null){
                  return SplashScreen();
                }
                if (result) {
                  return MenuNavbar();
                } else {
                  return LoginPage();
                }
              }
            },
          ),
        );
      },
    );
  }

  Future<bool?> _checkFirstLaunchAndLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isFirstLaunch) {
      await prefs.setBool('firstLaunch', false);
      return null;
    }

    return isLoggedIn;
  }
}