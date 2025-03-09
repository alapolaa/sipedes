import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';

class Gallery extends StatelessWidget {
  const Gallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: Column(
        children: [
          Text(
            "Gallery",
            style: AppFont.duapuluhbold,
          ),
          Text(
            "Desa Larangan Slampar memiliki galeri visual yang menampilkan keindahan alam, kegiatan masyarakat, serta produk lokal unggulan melalui kumpulan gambar yang dapat menggambarkan identitas dan potensi desa secara visual.",
            style: AppFont.duabelas,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: AppColor.sukses,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Image.asset(
            ImgString.gallery1,
            width: 360.w,
            fit: BoxFit.cover,
          ),
          10.0.height,
          Image.asset(
            ImgString.gallery2,
            width: 360.w,
            fit: BoxFit.cover,
          ),
          10.0.height,
          Image.asset(
            ImgString.gallery3,
            width: 360.w,
            fit: BoxFit.cover,
          ),
          10.0.height,
          Image.asset(
            ImgString.gallery4,
            width: 360.w,
            fit: BoxFit.cover,
          ),
          100.0.height,
        ],
      ),
    );
  }
}
