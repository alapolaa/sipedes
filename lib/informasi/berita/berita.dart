import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';
import 'package:sipedes/informasi/berita/detail_berita.dart';

import '../../data/theme/img_string.dart';

class Berita extends StatelessWidget {
  final List<Map<String, String>> newsList = [
    {
      "image": ImgString.berita1,
      'title': 'Judul Berita 1',
      'date': '12 Maret 2025',
      'description': 'DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4'
    },
    {
      "image": ImgString.berita2,
      'title': 'Judul Berita 2',
      'date': '11 Maret 2025',
      'description': 'DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4'
    },
    {
      "image": ImgString.berita3,
      'title': 'Judul Berita 3',
      'date': '10 Maret 2025',
      'description': 'DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4'
    },
    {
      "image": ImgString.berita4,
      'title': 'Judul Berita 4',
      'date': '9 Maret 2025',
      'description': 'DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4DeskripsiDeskripsi sdsd beritajkdhf dhfsdhfhf dfhdshfdjfhdsf dfhsjfhdsjfh 4'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.0.height,
            Text(
              "Berita",
              style: AppFont.duapuluhbold,
            ),
            10.0.height,
            Text(
              'Menyajikan informasi terbaru tentang peristiwa dan berita terkini dari Desa Larangan Slampar.',
              style: AppFont.duabelas,
              textAlign: TextAlign.center,
            ),
            8.0.height,
            Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  final news = newsList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBerita(news: news),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 150.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(10.sp),
                              ),
                              child: Image.asset(
                                news["image"]!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: AppDimen.w8),
                            child: Column(
                              children: [
                                6.0.height,
                                Text(
                                  news['title']!,
                                  textAlign: TextAlign.center,
                                  style: AppFont.nambelasbold,
                                ),
                                4.0.height,
                                Text(
                                  news['date']!,
                                  textAlign: TextAlign.center,
                                  style: AppFont.sepuluh,
                                ),
                                4.0.height,
                                Text(
                                  news['description']!,
                                  textAlign: TextAlign.center,
                                  style: AppFont.duabelas,
                                  maxLines: 2,
                                  overflow: TextOverflow
                                      .ellipsis,
                                ),
                                10.0.height,
                                Text(
                                  'Lihat selengkapnya',
                                  style: AppFont.duabelas.copyWith(
                                    color: AppColor.sukses,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            FooterScreen()
          ],
        ),
      ),
    );
  }
}
