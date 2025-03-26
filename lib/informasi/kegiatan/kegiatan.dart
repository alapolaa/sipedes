import 'package:flutter/material.dart';
import 'package:sipedes/data/extension/extension.dart';
import '../../data/api_service/api_service.dart';
import '../../data/model/kegiatan.dart';
import '../../footer.dart';
import 'detail_kegiatan.dart';

class Kegiatan extends StatefulWidget {
  @override
  _KegiatanState createState() => _KegiatanState();
}

class _KegiatanState extends State<Kegiatan> {
  late Future<List<KegiatanModel>> _kegiatanList;

  @override
  void initState() {
    super.initState();
    _kegiatanList = ApiService().fetchKegiatan();
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
                "Kegiatan Desa",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Menyajikan informasi terbaru tentang peristiwa dan kegiatan terkini dari desa.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder<List<KegiatanModel>>(
              future: _kegiatanList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Terjadi kesalahan!'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Tidak ada kegiatan tersedia'));
                }

                final kegiatan = snapshot.data!;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    showCheckboxColumn: false,
                    columnSpacing: 10,
                    columns: [
                      DataColumn(label: Text('No')),
                      DataColumn(label: Text('Gambar')),
                      DataColumn(label: Text('Kegiatan')),
                      DataColumn(label: Text('Keterangan')),
                      DataColumn(label: Text('Tanggal Mulai')),
                      DataColumn(label: Text('Tanggal Selesai')),
                      DataColumn(label: Text('Lokasi')),
                    ],
                    rows: kegiatan
                        .asMap()
                        .entries
                        .map(
                          (entry) => DataRow(
                            onSelectChanged: (selected) {
                              if (selected != null && selected) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailKegiatanScreen(
                                      data: {
                                        "gambar": "${ApiService.baseUrl}/${entry.value.gambar}",
                                        "kegiatan": entry.value.namaKegiatan,
                                        "mulai": entry.value.tanggalMulai,
                                        "selesai": entry.value.tanggalSelesai,
                                        "lokasi": entry.value.lokasi,
                                        "keterangan": entry.value.keterangan,
                                      },
                                    ),
                                  ),
                                );
                              }
                            },

                            cells: [
                              DataCell(Text((entry.key + 1).toString())),
                              DataCell(
                                Image.network(
                                  "${ApiService.baseUrl}/${entry.value.gambar}",
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.broken_image, size: 50);
                                  },
                                ),
                              ),
                              DataCell(Text(entry.value.namaKegiatan)),
                              DataCell(Text(
                                entry.value.keterangan.length > 50
                                    ? '${entry.value.keterangan.substring(0, 20)}...'
                                    : entry.value.keterangan,
                              )),
                              DataCell(Text(entry.value.tanggalMulai)),
                              DataCell(Text(entry.value.tanggalSelesai)),
                              DataCell(Text(entry.value.lokasi)),
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
}
