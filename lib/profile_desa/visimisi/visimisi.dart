import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/api_service/api_service.dart';
import 'package:sipedes/data/model/visi_misi.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';

class VisiMisiView extends StatefulWidget {
  const VisiMisiView({super.key});

  @override
  _VisiMisiViewState createState() => _VisiMisiViewState();
}

class _VisiMisiViewState extends State<VisiMisiView> {
  late Future<VisiMisiModel> futureVisiMisi;

  @override
  void initState() {
    super.initState();
    futureVisiMisi = ApiService().fetchVisiMisi();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<VisiMisiModel>(
            future: futureVisiMisi,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}", style: AppFont.duabelas));
              } else if (!snapshot.hasData) {
                return const Center(child: Text("Data tidak tersedia", style: AppFont.duabelas));
              }

              final visiMisi = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      6.0.height,
                      Text("Visi", style: AppFont.nambelasbold),
                      6.0.height,
                      Text(visiMisi.visi, style: AppFont.duabelas),
                      20.0.height,
                      Text("Misi", style: AppFont.nambelasbold),
                      6.0.height,
                      ...visiMisi.misi.map((misi) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Text("• $misi", style: AppFont.duabelas),
                      )),
                      20.0.height,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const FooterScreen(), // Tetap di bawah layar
      ],
    );
  }
}
