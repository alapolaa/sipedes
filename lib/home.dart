import 'package:flutter/material.dart';

import 'data/api_service/api_service.dart';
import 'data/model/banner.dart';
import 'data/model/galeri.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BannerModel> banners = [];
  List<GalleryModel> galleries = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final bannerData = await apiService.fetchBanners();
      final galleryData = await apiService.fetchGallery();
      setState(() {
        banners = bannerData;
        galleries = galleryData;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Section
            banners.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: banners.length,
              itemBuilder: (context, index) {
                final banner = banners[index];
                return Image.network(banner.gambar);
              },
            ),

            // Gallery Section
            galleries.isEmpty
                ? Center(child: CircularProgressIndicator())
                : GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: galleries.length,
              itemBuilder: (context, index) {
                final gallery = galleries[index];
                return Image.network(gallery.gambar);
              },
            ),
          ],
        ),
      ),
    );
  }
}
