import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/api_service/api_service.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/model/potensi_desa.dart';
import 'package:sipedes/data/theme/theme.dart';

class PotensiDesa extends StatefulWidget {
  const PotensiDesa({super.key});

  @override
  State<PotensiDesa> createState() => _PotensiDesaState();
}

class _PotensiDesaState extends State<PotensiDesa> {
  final ApiService apiService = ApiService();
  late Future<List<PotensiDesaModel>> futurePotensiDesa;

  @override
  void initState() {
    super.initState();
    futurePotensiDesa = apiService.fetchPotensiDesa();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.sp),
      child: Column(
        children: [
          Text(
            "Potensi Desa",
            textAlign: TextAlign.center,
            style: AppFont.duadua,
          ),
          10.0.height,
          FutureBuilder<List<PotensiDesaModel>>(
            future: futurePotensiDesa,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CupertinoActivityIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text("Terjadi kesalahan", style: AppFont.duabelas));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                    child: Text("Data kosong", style: AppFont.duabelas));
              }

              var potensiDesa = snapshot.data!.first;

              return Column(
                children: [
                  Image.network(
                    potensiDesa.gambar,
                    width: 360.w,
                    fit: BoxFit.cover,
                  ),
                  10.0.height,
                  Text(
                    potensiDesa.keterangan,
                    style: AppFont.nambelas,
                  ),

                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
