import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';

import '../../data/theme/app_dimen.dart';

class StrukturDesaView extends StatelessWidget {
   StrukturDesaView({super.key});

  // Daftar data orang
  final List<Map<String, String>> people = const [
    {
      "image":ImgString.kepdes,
      "name": "Rian Maulana",
      "position": "Kepala Desa",
    },
    {
      "image":ImgString.wakil,
      "name": "Siti Nurjamilah",
      "position": "Wakil Kepdes",
    },
    {
      "image":ImgString.sekretaris1,
      "name": "Wulandari",
      "position": "Sekretaris 1",
    },
    {
      "image":ImgString.sekretaris2,
      "name": "Maulidia",
      "position": "Sekretaris 2",
    },
    {
      "image":ImgString.bendahara1,
      "name": "Kagura",
      "position": "Bendahara1",
    },
    {
      "image":ImgString.bendahara2,
      "name": "Selena",
      "position": "Bendahara2",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimen.w10,
              vertical: AppDimen.h4,
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.7,
              ),
              itemCount: people.length,
              itemBuilder: (context, index) {
                final person = people[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.sp),
                          ),
                          child: Image.asset(
                            person["image"]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(10.sp),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                person["name"]!,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                person["position"]!,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          50.0.height,
          FooterScreen()
        ],
      ),
    );
  }
}
