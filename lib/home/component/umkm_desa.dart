import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';

import '../../data/api_service/api_service.dart';
import '../../data/model/umkm.dart';

class UmkmDesa extends StatefulWidget {
  @override
  _UmkmDesaState createState() => _UmkmDesaState();
}

class _UmkmDesaState extends State<UmkmDesa> {
  late Future<List<UmkmDesaModel>> futureUmkm;

  @override
  void initState() {
    super.initState();
    futureUmkm = ApiService().fetchUmkmDesa();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: Column(
        children: [
          Text(
            "UMKM Desa",
            textAlign: TextAlign.center,
            style: AppFont.duadua,
          ),
          5.0.height,
          FutureBuilder<List<UmkmDesaModel>>(
            future: futureUmkm,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Terjadi kesalahan: \${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("Data tidak tersedia"));
              }

              final umkmList = snapshot.data!;
              return Column(
                children: umkmList
                    .map((umkm) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                umkm.title,
                                style: AppFont.duapuluhbold,
                              ),
                              5.0.height,
                              Text(
                                umkm.keterangan,
                                style: AppFont.nambelas,
                              ),
                              10.0.height,
                            ],
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
