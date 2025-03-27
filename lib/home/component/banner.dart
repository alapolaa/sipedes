import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/app_font.dart';
import '../../data/api_service/api_service.dart';
import '../../data/model/banner.dart';


class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {
  List<BannerModel> banners = [];
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final bannerData = await apiService.fetchBanners();
      setState(() {
        banners = bannerData;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return banners.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 300.h,
              autoPlay: true,
              enlargeCenterPage: false,
              viewportFraction: 1.0,
            ),
            items: banners.map((banner) {
              return Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(banner.gambar),
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
                  Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Column(
                      children: [
                        Text(
                          banner.judul,
                          textAlign: TextAlign.center,
                          style: AppFont.duadua.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        10.0.height,
                        Text(
                          banner.keterangan,
                          textAlign: TextAlign.center,
                          style: AppFont.empatbelas.copyWith(
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