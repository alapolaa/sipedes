

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipedes/data/theme/app_dimen.dart';
import 'package:sipedes/data/theme/app_font.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../data/theme/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Utama')),
      body:  Padding(
        padding:  EdgeInsets.all(AppDimen.h44),
        child: Column(
          children: [
            Text("data",style: TextStyle(color: AppColor.appbar),),
            Text("data",style: AppFont.duapuluhbold,),
            Text("data"),
          ],
        ),
      )
    );
  }
}
