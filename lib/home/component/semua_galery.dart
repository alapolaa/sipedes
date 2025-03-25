import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/app_dimen.dart';
import '../../data/api_service/api_service.dart';
import '../../data/model/galeri.dart';
import '../../data/theme/app_color.dart';
import '../../data/theme/app_font.dart';

class SemuaGalery extends StatefulWidget {
  const SemuaGalery({super.key});

  @override
  _SemuaGaleryState createState() => _SemuaGaleryState();
}

class _SemuaGaleryState extends State<SemuaGalery> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Semua Galery",
          style: AppFont.duapuluhbold.copyWith(
            color: AppColor.white,
          ),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.appbar,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimen.w20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Desa Larangan Slampar memiliki galeri visual yang menampilkan keindahan alam, kegiatan masyarakat, serta produk lokal unggulan melalui kumpulan gambar yang dapat menggambarkan identitas dan potensi desa secara visual.",
                style: AppFont.duabelas,
              ),
              galleries.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: galleries.length,
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
        ),
      ),
    );
  }
}
