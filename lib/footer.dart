import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';

class FooterScreen extends StatelessWidget {
  const FooterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      width: double.infinity,
      color: AppColor.footer,
      child: Column(
        children: [
          10.0.height,
          Text(
            "Desa Larangan Slampar",
            style: AppFont.duapuluhbold,
          ),
          4.0.height,
          Text(
            "Kecamatan Tlanakan, Kabupaten Pamekasan, Jawa Timur",
            style: AppFont.duabelas,
          ),
          10.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("fb"),
              Text("fb"),
              Text("fb"),
              Text("fb"),
            ],
          ),
          6.0.height,
          Divider(
            height: 2.h,
            color: AppColor.black,
          ),
          10.0.height,
          Text(
            "Copyright Riyan.a_w All Rights Reserved",style: AppFont.sepuluhbold,
            textAlign: TextAlign.center,
          ),
          Text(
            "Designed by Riyan.a_w",style: AppFont.sepuluhbold,
            textAlign: TextAlign.center,
          ),
          20.0.height,
        ],
      ),
    );
  }
}
