import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/theme/app_color.dart';
import '../data/theme/app_font.dart';
import '../data/theme/img_string.dart';

class LayananPublik extends StatelessWidget {
  const LayananPublik({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDevelopmentDialog(context);
    });

    return Scaffold(

    );
  }

  void _showDevelopmentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Image.asset(ImgString.oops),
          content: const Text("Fitur ini masih dalam tahap pengembangan. Mohon tunggu update selanjutnya.",textAlign: TextAlign.center,),
          actions: [
            SizedBox(
              width: double.infinity,
              height: 45.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.batal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Tutup',
                  style: AppFont.empatbelas.copyWith(color: AppColor.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),

          ],
        );
      },
    );
  }
}
