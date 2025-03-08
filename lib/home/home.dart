import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sipedes/data/theme/theme.dart';

import 'component/slider_corousel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'LARANGAN SLAMPAR',
            style: AppFont.duapuluhbold.copyWith(color: AppColor.white),
          ),
        ),
        backgroundColor: AppColor.appbar,
      ),
      body: Column(
        children: [
          CorouselSlider(),

        ],
      ),
    );
  }
}
