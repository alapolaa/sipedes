import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/api_service/api_service.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/model/sejarah.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';

class SejarahView extends StatefulWidget {
  const SejarahView({super.key});

  @override
  _SejarahViewState createState() => _SejarahViewState();
}

class _SejarahViewState extends State<SejarahView> {
  late Future<List<SejarahDesaModel>> _futureSejarah;

  @override
  void initState() {
    super.initState();
    _futureSejarah = ApiService().fetchSejarahDesa();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SejarahDesaModel>>(
      future: _futureSejarah,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Data sejarah desa tidak tersedia"));
        }

        var sejarah = snapshot.data![0];

        // Mengambil nama file dari path API (tanpa "admin/")
        String imageUrl =
            "${ApiService.baseImageUrl}/${sejarah.gambar.split('/').last}";

        return SingleChildScrollView(
          child: Column(
            children: [
              6.0.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 270.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              6.0.height,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  sejarah.keterangan,
                  style: AppFont.duabelas,
                ),
              ),
              100.0.height,
              FooterScreen()
            ],
          ),
        );
      },
    );
  }
}
