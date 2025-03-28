import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';

class DetailKegiatanScreen extends StatelessWidget {
  final Map<String, String> data;

  DetailKegiatanScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Kegiatan",
          style: AppFont.duaempat.copyWith(color: AppColor.white),
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
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.sp),
                            topRight: Radius.circular(10.sp),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.sp),
                            topRight: Radius.circular(10.sp),
                          ),
                          child: Image.network(
                            data["gambar"]!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image, size: 50);
                            },
                          ),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['kegiatan']!,
                              style: AppFont.tombolteks,
                            ),
                            SizedBox(height: 5.0.h),
                            Text("Tanggal Mulai: ${data['mulai']}",
                                style: AppFont.duabelas),
                            SizedBox(height: 2.0.h),
                            Text(
                              "Tanggal Selesai: ${data['selesai']}",
                              style: AppFont.duabelas,
                            ),
                            SizedBox(height: 2.0.h),
                            Text("Lokasi: ${data['lokasi']}",
                                style: AppFont.duabelas),
                            SizedBox(height: 5.0.h),
                            Text(data['keterangan']!,style: AppFont.nambelas,),
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
                              style: AppFont.empatbelas
                                  .copyWith(color: AppColor.white),
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
