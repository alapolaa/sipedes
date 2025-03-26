import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import '../../data/model/pengumuman.dart';


class DetailPengumumanPage extends StatelessWidget {
  final PengumumanModel pengumuman;

  DetailPengumumanPage({required this.pengumuman});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Kegiatan",
          style: AppFont.duapuluhbold.copyWith(color: AppColor.white),
        ),
        backgroundColor: AppColor.appbar,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10.0.sp),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pengumuman.judul,
                              style: AppFont.nambelas,
                            ),
                            2.0.height,
                            Text(
                              pengumuman.tanggal,
                              style: AppFont.nambelas,
                            ),
                            2.0.height,
                            Text(
                              pengumuman.keterangan,
                              style: AppFont.nambelas,
                            ),
                            5.0.height,
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: SizedBox(
                          height: 45.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.sukses,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              elevation: 6,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Kembali',
                              style: AppFont.empatbelas.copyWith(color: AppColor.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
