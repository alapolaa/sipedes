import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/app_dimen.dart';
import 'package:sipedes/home/component/semua_galery.dart';
import '../../data/api_service/api_service.dart';
import '../../data/model/galeri.dart';
import '../../data/theme/app_color.dart';
import '../../data/theme/app_font.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List<GalleryModel> galleries = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final galleryData = await apiService.fetchGallery();
      setState(() {
        galleries = galleryData;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimen.w20),
      child: Column(

        children: [
          Text(
            "Gallery",textAlign: TextAlign.center,
            style: AppFont.duapuluhbold,
          ),   5.0.height,
          Text(
            "Desa Larangan Slampar memiliki galeri visual yang menampilkan keindahan alam, kegiatan masyarakat, serta produk lokal unggulan melalui kumpulan gambar yang dapat menggambarkan identitas dan potensi desa secara visual.",
            style: AppFont.duabelas,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SemuaGalery()));
                },
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
          galleries.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: galleries.length > 4 ? 4 : galleries.length,
            itemBuilder: (context, index) {
              final gallery = galleries[index];
              return Image.network(
                gallery.gambar,
                width: 360.w,
                fit: BoxFit.cover,
              );
            },
          ),

          100.0.height,
        ],
      ),
    );
  }
}
