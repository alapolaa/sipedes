import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/api_service/api_service.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/model/berita.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';
import 'detail_berita.dart';

class Berita extends StatefulWidget {
  @override
  _BeritaState createState() => _BeritaState();
}

class _BeritaState extends State<Berita> {
  late Future<List<BeritaModel>> _futureBerita;

  @override
  void initState() {
    super.initState();
    _futureBerita = ApiService().fetchBerita();
  }

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
              child: FutureBuilder<List<BeritaModel>>(
                future: _futureBerita,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Gagal mengambil data"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("Tidak ada berita"));
                  }

                  final beritaList = snapshot.data!;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: beritaList.length,
                    itemBuilder: (context, index) {
                      final berita = beritaList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailBerita(
                                news: {
                                  "image": berita
                                      .gambar, // Sesuaikan dengan data berita
                                  "title": berita.judul,
                                  "date": berita.tanggal,
                                  "description": berita.keterangan,
                                },
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.sp),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.sp),
                                ),
                                child: Image.network(
                                  "${ApiService.baseUrl}/${berita.gambar}",
                                  height: 140.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimen.w8),
                                child: Column(
                                  children: [
                                    6.0.height,
                                    Text(
                                      berita.judul,
                                      textAlign: TextAlign.center,
                                      style: AppFont.nambelasbold,
                                    ),
                                    4.0.height,
                                    Text(
                                      berita.tanggal,
                                      textAlign: TextAlign.center,
                                      style: AppFont.sepuluh,
                                    ),
                                    4.0.height,
                                    Text(
                                      berita.keterangan,
                                      textAlign: TextAlign.center,
                                      style: AppFont.duabelas,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
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
                  );
                },
              ),
            ),
            50.0.height,
            FooterScreen()
          ],
        ),
      ),
    );
  }
}
