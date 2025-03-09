import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';

class SejarahView extends StatelessWidget {
  const SejarahView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            ImgString.gallery1,
            fit: BoxFit.cover,
            width: 360.w,
            height: 270.h,
          ),
          6.0.height,
          Text(
            'Slampar adalah desa yang benar ase kajs asjh dfjhjhdf jdsfjh dsfhdsfhj... (isi teks sejarah di sini)',
            textAlign: TextAlign.justify,style: AppFont.duabelas,
          ),
        ],
      ),
    );
  }
}
