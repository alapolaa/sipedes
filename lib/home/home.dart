import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';
import 'package:sipedes/home/component/gallery.dart';
import 'package:sipedes/home/component/potensi_desa.dart';
import 'package:sipedes/home/component/umkm_desa.dart';

import 'component/banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'LARANGAN SLAMPAR',
            style: AppFont.duapuluhbold.copyWith(color: AppColor.white),
          ),
        ),
        backgroundColor: AppColor.appbar,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerPage(),
            PotensiDesa(),
            UmkmDesa(),
            GalleryPage(),
            FooterScreen(),
          ],
        ),
      ),
    );
  }
}
