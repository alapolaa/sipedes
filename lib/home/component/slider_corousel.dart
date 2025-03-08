import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/theme/theme.dart';

class CorouselSlider extends StatelessWidget {
  CorouselSlider({super.key});

  final List<Map<String, String>> carouselItems = [
    {
      "image": ImgString.banner1,
      "title": "Selamat Datang di Desa Larangan Slampar",
      "description":
          "Slampar adalah desa yang penuh dengan semangat gotong royong dan kebersamaan."
    },
    {
      "image": ImgString.banner2,
      "title": "Musyawarah Desa",
      "description": "Perencanaan pembangunan desa untuk kesejahteraan bersama."
    },
    {
      "image": ImgString.banner3,
      "title": "Gotong Royong Warga",
      "description":
          "Warga desa bekerja bersama untuk kebersihan dan kemajuan desa."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 300.h,
            autoPlay: true,
            enlargeCenterPage: false,
            viewportFraction: 1.0,
          ),
          items: carouselItems.map((item) {
            return Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item["image"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.6),
                  ),
                ),
                // Teks di dalam gambar
                Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: [
                      Text(
                        item["title"]!,
                        textAlign: TextAlign.center,
                        style: AppFont.duapuluhbold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item["description"]!,
                        textAlign: TextAlign.center,
                        style: AppFont.duabelas.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
