import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            style: AppFont.duabelas.copyWith(fontStyle: FontStyle.italic),
          ),
          10.0.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue, size: 20.sp,),
                onPressed: () {},
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.youtube, color: Colors.red, size: 20.sp,),
                onPressed: () {},
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.twitter, color: Colors.blue, size: 20.sp,),
                onPressed: () {},
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.purple, size: 20.sp,),
                onPressed: () {},
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.telegram, color: Colors.blueAccent, size: 20.sp,),
                onPressed: () {},
              ),
            ],
          ),
          6.0.height,
          Divider(
            height: 2.h,
            color: AppColor.black,
          ),
          10.0.height,
          Text(
            "Copyright Riyan.a_w All Rights Reserved",
            style: AppFont.sepuluhbold,
            textAlign: TextAlign.center,
          ),
          Text(
            "Designed by Riyan.a_w",
            style: AppFont.sepuluhbold,
            textAlign: TextAlign.center,
          ),
          10.0.height,
          Text(
            "Version 1.0",
            style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          10.0.height,
        ],
      ),
    );
  }
}