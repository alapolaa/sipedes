import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';

class VisiMisiView extends StatelessWidget {
  const VisiMisiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  6.0.height,
                  Text("Visi", style: AppFont.nambelasbold),
                  6.0.height,
                  Text(
                    "Visi visi Visi visi Visi visi Visi visi Visi visi Visi visi Visi visi Visi visi Visi visi Visi visi...",
                    style: AppFont.duabelas,
                  ),
                  20.0.height,
                  Text("Misi", style: AppFont.nambelasbold),
                  6.0.height,
                  Text(
                    "Misi misi Misi misi Misi misi Misi misi Misi misi Misi misi Misi misi Misi misi...",
                    style: AppFont.duabelas,
                  ),
                  20.0.height,

                ],
              ),
            ),
          ),
        ),
        FooterScreen(), // Tetap di bawah layar
      ],
    );
  }
}
