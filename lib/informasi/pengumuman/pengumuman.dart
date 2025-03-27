import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sipedes/data/extension/extension.dart';
import 'package:sipedes/data/theme/theme.dart';
import 'package:sipedes/footer.dart';
import 'package:sipedes/informasi/pengumuman/detail_pengumuman.dart';
import '../../data/api_service/api_service.dart';
import '../../data/model/pengumuman.dart';

class Pengumuman extends StatefulWidget {
  @override
  _PengumumanState createState() => _PengumumanState();
}

class _PengumumanState extends State<Pengumuman> {
  late Future<List<PengumumanModel>> futurePengumuman;

  @override
  void initState() {
    super.initState();
    futurePengumuman = ApiService().fetchPengumuman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Pengumuman",
                style: AppFont.duaempat,
              ),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.sp),
              child: Text(
                'Menyajikan informasi terbaru tentang peristiwa dan Pengumuman terkini dari Desa Larangan Slampar.',
                style: AppFont.nambelas,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.h),
            FutureBuilder<List<PengumumanModel>>(
              future: futurePengumuman,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text("Terjadi kesalahan: \${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Tidak ada pengumuman"));
                }

                final pengumumanList = snapshot.data!;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showCheckboxColumn: false,
                    columnSpacing: 10,
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Judul')),
                      DataColumn(label: Text('Keterangan')),
                      DataColumn(label: Text('Tanggal')),
                    ],
                    rows: pengumumanList
                        .asMap()
                        .entries
                        .map(
                          (entry) => DataRow(
                            onSelectChanged: (selected) {
                              if (selected != null && selected) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPengumumanPage(
                                        pengumuman: entry.value),
                                  ),
                                );
                              }
                            },
                            cells: [
                              DataCell(Text((entry.key + 1).toString())),
                              DataCell(Text(
                                  truncateText(entry.value.judul, 4),
                                  style: AppFont.nambelas)),
                              DataCell(Text(
                                  truncateText(entry.value.keterangan, 4),
                                  style: AppFont.nambelas)),
                              DataCell(Text(entry.value.tanggal,
                                  style: AppFont.nambelas)),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
            100.0.height,
            FooterScreen(),
          ],
        ),
      ),
    );
  }

  String truncateText(String text, int maxWords) {
    List<String> words = text.split(' ');
    if (words.length > maxWords) {
      return words.sublist(0, maxWords).join(' ') + '...';
    }
    return text;
  }
}
